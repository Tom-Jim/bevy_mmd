#include <algorithm>
#include <cmath>
#include <cstdint>
#include <unordered_map>
#include <utility>
#include <vector>

#include <Jolt/Jolt.h>
#include <Jolt/Physics/Body/BodyInterface.h>
#include <Jolt/Physics/Body/BodyLock.h>
#include <Jolt/Physics/Body/BodyLockInterface.h>
#include <Jolt/Physics/PhysicsSystem.h>
#include <Jolt/Physics/SoftBody/SoftBodyCreationSettings.h>
#include <Jolt/Physics/SoftBody/SoftBodyMotionProperties.h>
#include <Jolt/Physics/SoftBody/SoftBodySharedSettings.h>

using namespace JPH;

static bool finite_vector(Vec3 v) {
  return std::isfinite(v.GetX()) && std::isfinite(v.GetY()) &&
         std::isfinite(v.GetZ());
}

struct CollisionGridKey {
  int x;
  int y;
  int z;

  bool operator==(const CollisionGridKey &other) const {
    return x == other.x && y == other.y && z == other.z;
  }
};

struct CollisionGridHash {
  size_t operator()(const CollisionGridKey &key) const {
    const uint64_t x = static_cast<uint32_t>(key.x) * 73856093ull;
    const uint64_t y = static_cast<uint32_t>(key.y) * 19349663ull;
    const uint64_t z = static_cast<uint32_t>(key.z) * 83492791ull;
    return static_cast<size_t>(x ^ y ^ z);
  }
};

static int collision_cell(float value, float cell_size) {
  return static_cast<int>(std::floor(value / cell_size));
}

static Vec3 closest_point_on_triangle(Vec3 p, Vec3 a, Vec3 b, Vec3 c) {
  Vec3 ab = b - a;
  Vec3 ac = c - a;
  Vec3 ap = p - a;
  float d1 = ab.Dot(ap);
  float d2 = ac.Dot(ap);
  if (d1 <= 0.0f && d2 <= 0.0f)
    return a;

  Vec3 bp = p - b;
  float d3 = ab.Dot(bp);
  float d4 = ac.Dot(bp);
  if (d3 >= 0.0f && d4 <= d3)
    return b;

  float vc = d1 * d4 - d3 * d2;
  if (vc <= 0.0f && d1 >= 0.0f && d3 <= 0.0f) {
    float v = d1 / (d1 - d3);
    return a + ab * v;
  }

  Vec3 cp = p - c;
  float d5 = ab.Dot(cp);
  float d6 = ac.Dot(cp);
  if (d6 >= 0.0f && d5 <= d6)
    return c;

  float vb = d5 * d2 - d1 * d6;
  if (vb <= 0.0f && d2 >= 0.0f && d6 <= 0.0f) {
    float w = d2 / (d2 - d6);
    return a + ac * w;
  }

  float va = d3 * d6 - d5 * d4;
  if (va <= 0.0f && (d4 - d3) >= 0.0f && (d5 - d6) >= 0.0f) {
    float w = (d4 - d3) / ((d4 - d3) + (d5 - d6));
    return b + (c - b) * w;
  }

  float denom = 1.0f / (va + vb + vc);
  float v = vb * denom;
  float w = vc * denom;
  return a + ab * v + ac * w;
}

extern "C" {

void *create_soft_body_from_mesh(const float *vertices, int num_vertices,
                                 const int *indices, int num_indices,
                                 const float *inv_masses,
                                 void *physics_system_ptr, float stretch,
                                 float shear, float bend, int iterations,
                                 float gravity) {
  if (!physics_system_ptr || !vertices || !indices || !inv_masses ||
      num_vertices <= 0 || num_indices <= 0)
    return nullptr;

  PhysicsSystem *sys = static_cast<PhysicsSystem *>(physics_system_ptr);

  Ref<SoftBodySharedSettings> shared_settings = new SoftBodySharedSettings();

  for (int i = 0; i < num_vertices; ++i) {
    SoftBodySharedSettings::Vertex v;
    v.mPosition =
        Float3(vertices[i * 3], vertices[i * 3 + 1], vertices[i * 3 + 2]);
    v.mVelocity = Float3(0, 0, 0); // Start at rest.
    v.mInvMass = inv_masses[i];    // Zero pins the vertex to the animation.
    shared_settings->mVertices.push_back(v);
  }

  for (int i = 0; i + 2 < num_indices; i += 3) {
    int v0 = indices[i];
    int v1 = indices[i + 1];
    int v2 = indices[i + 2];

    if (v0 < 0 || v0 >= num_vertices || v1 < 0 || v1 >= num_vertices ||
        v2 < 0 || v2 >= num_vertices) {
      continue; // Ignore invalid triangles.
    }

    if (v0 == v1 || v1 == v2 || v0 == v2)
      continue;
    Vec3 a(vertices[v0 * 3], vertices[v0 * 3 + 1], vertices[v0 * 3 + 2]);
    Vec3 b(vertices[v1 * 3], vertices[v1 * 3 + 1], vertices[v1 * 3 + 2]);
    Vec3 c(vertices[v2 * 3], vertices[v2 * 3 + 1], vertices[v2 * 3 + 2]);
    if ((b - a).Cross(c - a).LengthSq() < 1.0e-12f)
      continue;
    SoftBodySharedSettings::Face f;
    f.mVertex[0] = v0;
    f.mVertex[1] = v1;
    f.mVertex[2] = v2;
    shared_settings->mFaces.push_back(f);
  }

  SoftBodySharedSettings::VertexAttributes vertex_attributes;
  vertex_attributes.mCompliance =
      std::max(0.0f, stretch); // Stretch compliance.
  vertex_attributes.mShearCompliance = std::max(0.0f, shear); // Shear compliance.
  vertex_attributes.mBendCompliance =
      std::max(0.0f, bend); // Bend compliance.
  shared_settings->CreateConstraints(
      &vertex_attributes, 1, SoftBodySharedSettings::EBendType::Distance);

  shared_settings->CalculateEdgeLengths();
  shared_settings->Optimize();

  SoftBodyCreationSettings creation_settings(shared_settings, RVec3::sZero(),
                                             Quat::sIdentity(), 1);

  creation_settings.mNumIterations = std::clamp(iterations, 1, 128);
  creation_settings.mLinearDamping = 0.0f;
  creation_settings.mAllowSleeping = false;

  creation_settings.mUpdatePosition = false;

  creation_settings.mGravityFactor = std::clamp(gravity, 0.0f, 10.0f);

  BodyInterface &body_interface = sys->GetBodyInterface();
  Body *soft_body = body_interface.CreateSoftBody(creation_settings);

  if (soft_body) {
    body_interface.AddBody(soft_body->GetID(), EActivation::Activate);
    return reinterpret_cast<void *>(
        static_cast<uintptr_t>(soft_body->GetID().GetIndexAndSequenceNumber()) +
        1);
  }

  return nullptr;
}

void constrain_soft_body_triangles(void *system, void *handle,
                                   const float *triangles, int triangle_count,
                                   const float *targets, float max_distance,
                                   float thickness) {
  if (!system || !handle || !triangles || triangle_count <= 0 || !targets)
    return;

  auto *sys = static_cast<PhysicsSystem *>(system);
  BodyID id(static_cast<uint32>(reinterpret_cast<uintptr_t>(handle) - 1));
  BodyLockWrite lock(sys->GetBodyLockInterface(), id);
  if (!lock.Succeeded())
    return;

  auto *mp = static_cast<SoftBodyMotionProperties *>(
      lock.GetBody().GetMotionProperties());
  auto &vertices = mp->GetVertices();
  // A finer grid keeps each cloth vertex's candidate triangle list small.
  // The previous 1-unit cells made the body shell broad phase almost dense.
  constexpr float cell_size = 0.25f;
  std::unordered_map<CollisionGridKey, std::vector<int>, CollisionGridHash>
      grid;
  grid.reserve(static_cast<size_t>(triangle_count) * 2);
  std::vector<int> large_triangles;
  large_triangles.reserve(static_cast<size_t>(triangle_count) / 32 + 1);

  for (int i = 0; i < triangle_count; ++i) {
    const float *triangle = triangles + i * 9;
    Vec3 a(triangle[0], triangle[1], triangle[2]);
    Vec3 b(triangle[3], triangle[4], triangle[5]);
    Vec3 c(triangle[6], triangle[7], triangle[8]);
    if (!finite_vector(a) || !finite_vector(b) || !finite_vector(c))
      continue;

    Vec3 min_corner(std::min({a.GetX(), b.GetX(), c.GetX()}),
                    std::min({a.GetY(), b.GetY(), c.GetY()}),
                    std::min({a.GetZ(), b.GetZ(), c.GetZ()}));
    Vec3 max_corner(std::max({a.GetX(), b.GetX(), c.GetX()}),
                    std::max({a.GetY(), b.GetY(), c.GetY()}),
                    std::max({a.GetZ(), b.GetZ(), c.GetZ()}));
    int min_x = collision_cell(min_corner.GetX(), cell_size);
    int min_y = collision_cell(min_corner.GetY(), cell_size);
    int min_z = collision_cell(min_corner.GetZ(), cell_size);
    int max_x = collision_cell(max_corner.GetX(), cell_size);
    int max_y = collision_cell(max_corner.GetY(), cell_size);
    int max_z = collision_cell(max_corner.GetZ(), cell_size);
    int span_x = max_x - min_x + 1;
    int span_y = max_y - min_y + 1;
    int span_z = max_z - min_z + 1;
    if (span_x * span_y * span_z > 256) {
      large_triangles.push_back(i);
      continue;
    }
    for (int x = min_x; x <= max_x; ++x)
      for (int y = min_y; y <= max_y; ++y)
        for (int z = min_z; z <= max_z; ++z)
          grid[{x, y, z}].push_back(i);
  }

  const float collision_thickness = std::max(0.001f, thickness);
  const float thickness_sq = collision_thickness * collision_thickness;
  std::vector<int> visited(static_cast<size_t>(triangle_count), -1);
  for (size_t vertex_index = 0; vertex_index < vertices.size(); ++vertex_index) {
    auto &vertex = vertices[vertex_index];
    Vec3 target(targets[vertex_index * 3], targets[vertex_index * 3 + 1],
                targets[vertex_index * 3 + 2]);
    if (!finite_vector(target))
      continue;
    if (vertex.mInvMass == 0.0f) {
      vertex.mPosition = target;
      vertex.mPreviousPosition = target;
      vertex.mVelocity = Vec3::sZero();
      continue;
    }
    if (!finite_vector(vertex.mPosition) || !finite_vector(vertex.mVelocity)) {
      vertex.mPosition = target;
      vertex.mPreviousPosition = target;
      vertex.mVelocity = Vec3::sZero();
    }

    Vec3 displacement = vertex.mPosition - target;
    float distance = displacement.Length();
    if (distance > max_distance && distance > 1.0e-6f) {
      Vec3 normal = displacement / distance;
      float correction = std::min(distance - max_distance, max_distance * 0.35f);
      vertex.mPosition -= normal * correction;
      vertex.mVelocity -=
          normal * std::max(0.0f, vertex.mVelocity.Dot(normal)) * 0.35f;
    }

    int center_x = collision_cell(vertex.mPosition.GetX(), cell_size);
    int center_y = collision_cell(vertex.mPosition.GetY(), cell_size);
    int center_z = collision_cell(vertex.mPosition.GetZ(), cell_size);
    // Use the compact neighborhood for settled vertices. Fast vertices get a
    // wider query to prevent tunneling through a one-cell gap.
    const int query_radius =
        (vertex.mPosition - vertex.mPreviousPosition).LengthSq() > 0.0625f
            ? 2
            : 1;
    for (int x = center_x - query_radius; x <= center_x + query_radius; ++x)
      for (int y = center_y - query_radius; y <= center_y + query_radius; ++y)
        for (int z = center_z - query_radius; z <= center_z + query_radius; ++z) {
          auto cell = grid.find({x, y, z});
          if (cell == grid.end())
            continue;
          for (int triangle_index : cell->second) {
            if (visited[triangle_index] == static_cast<int>(vertex_index))
              continue;
            visited[triangle_index] = static_cast<int>(vertex_index);
            const float *triangle = triangles + triangle_index * 9;
            Vec3 a(triangle[0], triangle[1], triangle[2]);
            Vec3 b(triangle[3], triangle[4], triangle[5]);
            Vec3 c(triangle[6], triangle[7], triangle[8]);
            Vec3 closest =
                closest_point_on_triangle(vertex.mPosition, a, b, c);
            Vec3 delta = vertex.mPosition - closest;
            float distance_sq = delta.LengthSq();
            if (distance_sq >= thickness_sq)
              continue;
            float distance_to_surface = std::sqrt(std::max(0.0f, distance_sq));
            Vec3 normal;
            Vec3 face_normal =
                (b - a).Cross(c - a).NormalizedOr(Vec3::sAxisY());
            if (distance_to_surface > 1.0e-5f) {
              normal = delta / distance_to_surface;
              if (normal.Dot(face_normal) < 0.0f)
                normal = -normal;
            } else {
              normal = face_normal;
            }
            vertex.mPosition += normal * (collision_thickness - distance_to_surface);
            vertex.mVelocity -=
                normal * std::min(0.0f, vertex.mVelocity.Dot(normal));
          }
        }
    // Very large triangles cannot be inserted into every covered cell. Test
    // that small fallback list explicitly so broad faces never leave holes in
    // the collision shell.
    for (int triangle_index : large_triangles) {
      if (visited[triangle_index] == static_cast<int>(vertex_index))
        continue;
      visited[triangle_index] = static_cast<int>(vertex_index);
      const float *triangle = triangles + triangle_index * 9;
      Vec3 a(triangle[0], triangle[1], triangle[2]);
      Vec3 b(triangle[3], triangle[4], triangle[5]);
      Vec3 c(triangle[6], triangle[7], triangle[8]);
      Vec3 closest = closest_point_on_triangle(vertex.mPosition, a, b, c);
      Vec3 delta = vertex.mPosition - closest;
      float distance_sq = delta.LengthSq();
      if (distance_sq >= thickness_sq)
        continue;
      float distance_to_surface = std::sqrt(std::max(0.0f, distance_sq));
      Vec3 face_normal =
          (b - a).Cross(c - a).NormalizedOr(Vec3::sAxisY());
      Vec3 normal = distance_to_surface > 1.0e-5f
                        ? delta / distance_to_surface
                        : face_normal;
      if (normal.Dot(face_normal) < 0.0f)
        normal = -normal;
      vertex.mPosition += normal * (collision_thickness - distance_to_surface);
      vertex.mVelocity -=
          normal * std::min(0.0f, vertex.mVelocity.Dot(normal));
    }
    vertex.mPreviousPosition = vertex.mPosition;
  }
}

void get_soft_body_vertices(void *physics_system_ptr, void *body_id_ptr,
                            float *out_vertices, int max_vertices) {
  if (!physics_system_ptr || !body_id_ptr || !out_vertices || max_vertices <= 0)
    return;
  PhysicsSystem *sys = static_cast<PhysicsSystem *>(physics_system_ptr);
  BodyID body_id(
      static_cast<uint32>(reinterpret_cast<uintptr_t>(body_id_ptr) - 1));

  BodyLockRead lock(sys->GetBodyLockInterface(), body_id);
  if (lock.SucceededAndIsInBroadPhase()) {
    const Body &body = lock.GetBody();
    if (body.IsSoftBody()) {
      const SoftBodyMotionProperties *mp =
          static_cast<const SoftBodyMotionProperties *>(
              body.GetMotionProperties());
      const Array<SoftBodyVertex> &vertices = mp->GetVertices();
      size_t count =
          std::min(vertices.size(), static_cast<size_t>(max_vertices));
      for (size_t i = 0; i < count; ++i) {
        out_vertices[i * 3 + 0] = vertices[i].mPosition.GetX();
        out_vertices[i * 3 + 1] = vertices[i].mPosition.GetY();
        out_vertices[i * 3 + 2] = vertices[i].mPosition.GetZ();
      }
    }
  }
}

void update_soft_body_roots(void *physics_system_ptr, void *body_id_ptr,
                            const float *all_pos, const int *all_idx, int count,
                            int is_first_frame, float delta_time,
                            float position_pull, float velocity_pull,
                            float damping, float max_speed) {
  if (!physics_system_ptr || !body_id_ptr || !all_pos || !all_idx || count <= 0)
    return;

  PhysicsSystem *sys = static_cast<PhysicsSystem *>(physics_system_ptr);
  BodyID body_id(
      static_cast<uint32>(reinterpret_cast<uintptr_t>(body_id_ptr) - 1));

  sys->GetBodyInterface().ActivateBody(body_id);

  BodyLockWrite lock(sys->GetBodyLockInterface(), body_id);
  if (lock.SucceededAndIsInBroadPhase() || lock.Succeeded()) {
    Body &body = lock.GetBody();
    if (body.IsSoftBody()) {
      SoftBodyMotionProperties *mp =
          static_cast<SoftBodyMotionProperties *>(body.GetMotionProperties());
      auto &vertices = mp->GetVertices();
      int max_v = static_cast<int>(vertices.size());
      for (int i = 0; i < count; ++i) {
        int v_idx = all_idx[i];
        if (v_idx < 0 || v_idx >= max_v)
          continue; // Bounds check.

        Vec3 target_pos(all_pos[i * 3], all_pos[i * 3 + 1], all_pos[i * 3 + 2]);

        if (!finite_vector(target_pos))
          continue;
        if (is_first_frame || vertices[v_idx].mInvMass == 0.0f ||
            !finite_vector(vertices[v_idx].mPosition) ||
            (target_pos - vertices[v_idx].mPosition).LengthSq() > 25.0f) {
          vertices[v_idx].mPosition = target_pos;
          vertices[v_idx].mPreviousPosition = target_pos;
          vertices[v_idx].mVelocity = Vec3::sZero();
        } else {
          Vec3 diff = target_pos - vertices[v_idx].mPosition;

          vertices[v_idx].mPosition +=
              diff *
              (1.0f - std::pow(1.0f - std::clamp(position_pull, 0.0f, 1.0f),
                               delta_time * 60.0f));

          vertices[v_idx].mVelocity += diff * velocity_pull * delta_time;

          vertices[v_idx].mVelocity *=
              std::pow(std::clamp(damping, 0.0f, 1.0f), delta_time * 60.0f);

          float speed_sq = vertices[v_idx].mVelocity.LengthSq();
          if (speed_sq > max_speed * max_speed) {
            vertices[v_idx].mVelocity *= (max_speed / std::sqrt(speed_sq));
          }
        }
      }
    }
  }
}

// Apply material-specific forces before the shared Jolt integration step.
// Hair and cloth remain fully dynamic particles while using different
// gravity, damping and air drag profiles.
void apply_soft_body_vertex_params(
    void *physics_system_ptr, void *body_id_ptr, const uint8_t *groups,
    int count, float delta_time, float base_gravity, float hair_gravity,
    float cloth_gravity, float hair_damping, float cloth_damping,
    float hair_air_drag, float cloth_air_drag) {
  if (!physics_system_ptr || !body_id_ptr || !groups || count <= 0 ||
      !std::isfinite(delta_time) || delta_time <= 0.0f)
    return;

  PhysicsSystem *sys = static_cast<PhysicsSystem *>(physics_system_ptr);
  BodyID body_id(
      static_cast<uint32>(reinterpret_cast<uintptr_t>(body_id_ptr) - 1));
  BodyLockWrite lock(sys->GetBodyLockInterface(), body_id);
  if (!lock.Succeeded())
    return;
  Body &body = lock.GetBody();
  if (!body.IsSoftBody())
    return;
  auto *mp = static_cast<SoftBodyMotionProperties *>(body.GetMotionProperties());
  auto &vertices = mp->GetVertices();
  const int limit = std::min<int>(count, static_cast<int>(vertices.size()));
  const float dt60 = std::clamp(delta_time * 60.0f, 0.0f, 4.0f);
  const float base = std::isfinite(base_gravity) ? base_gravity : 1.0f;
  for (int i = 0; i < limit; ++i) {
    auto &vertex = vertices[i];
    if (vertex.mInvMass == 0.0f)
      continue;
    const bool is_hair = groups[i] != 0;
    const float gravity = std::clamp(is_hair ? hair_gravity : cloth_gravity,
                                     0.0f, 4.0f);
    const float damping = std::clamp(is_hair ? hair_damping : cloth_damping,
                                     0.0f, 1.0f);
    const float drag = std::clamp(is_hair ? hair_air_drag : cloth_air_drag,
                                  0.0f, 50.0f);
    // Jolt applies the configured base gravity during integration. Add only
    // the material delta so the global gravity remains the reference value.
    vertex.mVelocity += Vec3(0.0f, -9.81f * (gravity - base) * delta_time,
                             0.0f);
    vertex.mVelocity *= std::pow(damping, dt60);
    vertex.mVelocity *= std::exp(-drag * delta_time);
    if (!finite_vector(vertex.mVelocity))
      vertex.mVelocity = Vec3::sZero();
  }
}

void destroy_soft_body(void *system, void *handle) {
  if (!system || !handle)
    return;
  auto &interface = static_cast<PhysicsSystem *>(system)->GetBodyInterface();
  BodyID id(static_cast<uint32>(reinterpret_cast<uintptr_t>(handle) - 1));
  interface.RemoveBody(id);
  interface.DestroyBody(id);
}

// Each proxy is [center.xyz, rotation.xyzw, size.xyz, shape], in animated world
// space. Project after Jolt integration and remove inward velocity to avoid
// repeated contact bounce.
void constrain_soft_body(void *system, void *handle, const float *capsules,
                         int count, const float *targets, float max_distance) {
  if (!system || !handle || !targets || !capsules || count <= 0)
    return;
  auto *sys = static_cast<PhysicsSystem *>(system);
  BodyID id(static_cast<uint32>(reinterpret_cast<uintptr_t>(handle) - 1));
  BodyLockWrite lock(sys->GetBodyLockInterface(), id);
  if (!lock.Succeeded())
    return;
  auto *mp = static_cast<SoftBodyMotionProperties *>(
      lock.GetBody().GetMotionProperties());
  auto &vertices = mp->GetVertices();
  for (size_t i = 0; i < vertices.size(); ++i) {
    auto &v = vertices[i];
    Vec3 target(targets[i * 3], targets[i * 3 + 1], targets[i * 3 + 2]);
    if (v.mInvMass == 0.0f) {
      v.mPosition = target;
      v.mVelocity = Vec3::sZero();
      continue;
    }
    if (!finite_vector(v.mPosition) || !finite_vector(v.mVelocity)) {
      v.mPosition = target;
      v.mVelocity = Vec3::sZero();
    }
    Vec3 displacement = v.mPosition - target;
    float distance = displacement.Length();
    if (distance > max_distance) {
      Vec3 normal = displacement / distance;
      float correction = std::min(distance - max_distance, max_distance * 0.35f);
      v.mPosition -= normal * correction;
      v.mVelocity -=
          normal * std::max(0.0f, v.mVelocity.Dot(normal)) * 0.35f;
    }
    // Two projection passes are enough for overlapping proxies and avoid the
    // cubic cost of repeatedly testing every proxy three times.
    for (int pass = 0; pass < 2; ++pass)
      for (int j = 0; j < count; ++j) {
        const float *c = capsules + j * 11;
        Vec3 center(c[0], c[1], c[2]);
        Vec3 center_delta = v.mPosition - center;
        float bound_radius = c[7];
        if (c[10] == 1.0f)
          bound_radius = Vec3(c[7], c[8], c[9]).Length();
        else if (c[10] == 2.0f)
          bound_radius += 0.5f * c[8];
        bound_radius += 0.25f;
        if (center_delta.LengthSq() > bound_radius * bound_radius)
          continue;
        Quat rotation(c[3], c[4], c[5], c[6]);
        Vec3 local = rotation.Conjugated() * (v.mPosition - center);
        Vec3 normal;
        float penetration;
        if (c[10] == 1.0f) {
          Vec3 half(c[7], c[8], c[9]);
          Vec3 depth = half - local.Abs();
          if (depth.GetX() <= 0 || depth.GetY() <= 0 || depth.GetZ() <= 0)
            continue;
          uint axis = depth.GetLowestComponentIndex();
          normal = Vec3::sZero();
          normal.SetComponent(axis, local[axis] < 0 ? -1.0f : 1.0f);
          penetration = depth[axis];
        } else {
          Vec3 axis_point = Vec3::sZero();
          if (c[10] == 2.0f)
            axis_point.SetY(
                std::clamp(local.GetY(), -c[8] * 0.5f, c[8] * 0.5f));
          Vec3 delta = local - axis_point;
          float length = delta.Length();
          if (length >= c[7])
            continue;
          normal = length > 1.0e-6f ? delta / length : Vec3::sAxisZ();
          penetration = c[7] - length;
        }
        normal = rotation * normal;
        v.mPosition += normal * penetration;
        v.mVelocity -= normal * std::min(0.0f, v.mVelocity.Dot(normal));
      }
    v.mPreviousPosition = v.mPosition;
  }
}
}
