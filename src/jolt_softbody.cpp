#include <algorithm>
#include <cmath>
#include <utility>

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
  if (!system || !handle || !targets)
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
      v.mPosition = target + normal * max_distance;
      v.mVelocity -= normal * std::max(0.0f, v.mVelocity.Dot(normal));
    }
    for (int pass = 0; pass < 3; ++pass)
      for (int j = 0; j < count; ++j) {
        const float *c = capsules + j * 11;
        Vec3 center(c[0], c[1], c[2]);
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
