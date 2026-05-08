// 【新增】引入 set 和 algorithm 用于边去重
#include <set>
#include <algorithm>
#include <utility>

#include <Jolt/Jolt.h>
#include <Jolt/Physics/PhysicsSystem.h>
#include <Jolt/Physics/SoftBody/SoftBodyCreationSettings.h>
#include <Jolt/Physics/SoftBody/SoftBodySharedSettings.h>
#include <Jolt/Physics/Body/BodyInterface.h>
#include <Jolt/Physics/Body/BodyLock.h>
#include <Jolt/Physics/Body/BodyLockInterface.h>
#include <Jolt/Physics/SoftBody/SoftBodyMotionProperties.h>

using namespace JPH;

extern "C" {

    // 1. 从网格创建软体
    void* create_soft_body_from_mesh(
        const float* vertices, int num_vertices,
        const int* indices, int num_indices,
        const float* inv_masses,
        void* physics_system_ptr
    ) {
        PhysicsSystem* sys = static_cast<PhysicsSystem*>(physics_system_ptr);
        if (!sys) return nullptr;

        Ref<SoftBodySharedSettings> shared_settings = new SoftBodySharedSettings();

        // 填入顶点数据与质量逆
        for (int i = 0; i < num_vertices; ++i) {
            SoftBodySharedSettings::Vertex v;
            v.mPosition = Float3(vertices[i*3], vertices[i*3+1], vertices[i*3+2]);
            v.mVelocity = Float3(0, 0, 0);
            v.mInvMass = inv_masses[i];
            shared_settings->mVertices.push_back(v);
        }

        // 【关键修复】：使用 std::set 过滤重复的边
        std::set<std::pair<int, int>> unique_edges;

        for (int i = 0; i < num_indices; i += 3) {
            int v0 = indices[i];
            int v1 = indices[i+1];
            int v2 = indices[i+2];

            // 添加面用于碰撞
            SoftBodySharedSettings::Face f;
            f.mVertex[0] = v0;
            f.mVertex[1] = v1;
            f.mVertex[2] = v2;
            shared_settings->mFaces.push_back(f);

            // 保证小索引在前，大索引在后，插入 set 自动去重
            unique_edges.insert({std::min(v0, v1), std::max(v0, v1)});
            unique_edges.insert({std::min(v1, v2), std::max(v1, v2)});
            unique_edges.insert({std::min(v2, v0), std::max(v2, v0)});
        }

        // 将去重后的边正式注册为物理约束
        for (const auto& edge : unique_edges) {
            SoftBodySharedSettings::Edge e;
            e.mVertex[0] = edge.first;
            e.mVertex[1] = edge.second;
            e.mCompliance = 0.8f; // 0.0f 表示完全刚性，不拉伸。数值越大越像橡皮筋
            shared_settings->mEdgeConstraints.push_back(e);
        }

        // 让 Jolt 测量这些边的初始长度，作为静止状态的标准
        shared_settings->CalculateEdgeLengths();
        shared_settings->Optimize();

        SoftBodyCreationSettings creation_settings(shared_settings, RVec3::sZero(), Quat::sIdentity(), 1);

        // 【新增这一行】：重力影响设为 0，让软体保持悬浮，只受骨骼拖拽的惯性影响摆动！
        creation_settings.mGravityFactor = 0.8f;

        BodyInterface& body_interface = sys->GetBodyInterface();
        Body* soft_body = body_interface.CreateSoftBody(creation_settings);

        if (soft_body) {
            body_interface.AddBody(soft_body->GetID(), EActivation::Activate);
            return reinterpret_cast<void*>(static_cast<uintptr_t>(soft_body->GetID().GetIndexAndSequenceNumber()));
        }

        return nullptr;
    }

    int get_soft_body_vertex_count(void* physics_system_ptr, void* body_id_ptr) {
        PhysicsSystem* sys = static_cast<PhysicsSystem*>(physics_system_ptr);
        BodyID body_id(static_cast<uint32>(reinterpret_cast<uintptr_t>(body_id_ptr)));

        BodyLockRead lock(sys->GetBodyLockInterface(), body_id);
        if (lock.SucceededAndIsInBroadPhase()) {
            const Body& body = lock.GetBody();
            if (body.IsSoftBody()) {
                const SoftBodyMotionProperties* mp = static_cast<const SoftBodyMotionProperties*>(body.GetMotionProperties());
                return static_cast<int>(mp->GetVertices().size());
            }
        }
        return 0;
    }

    void get_soft_body_vertices(void* physics_system_ptr, void* body_id_ptr, float* out_vertices) {
        PhysicsSystem* sys = static_cast<PhysicsSystem*>(physics_system_ptr);
        BodyID body_id(static_cast<uint32>(reinterpret_cast<uintptr_t>(body_id_ptr)));

        BodyLockRead lock(sys->GetBodyLockInterface(), body_id);
        if (lock.SucceededAndIsInBroadPhase()) {
            const Body& body = lock.GetBody();
            if (body.IsSoftBody()) {
                const SoftBodyMotionProperties* mp = static_cast<const SoftBodyMotionProperties*>(body.GetMotionProperties());
                const Array<SoftBodyVertex>& vertices = mp->GetVertices();
                Mat44 world_transform = body.GetCenterOfMassTransform();

                for (size_t i = 0; i < vertices.size(); ++i) {
                    Vec3 world_pos = world_transform * vertices[i].mPosition;
                    out_vertices[i*3 + 0] = world_pos.GetX();
                    out_vertices[i*3 + 1] = world_pos.GetY();
                    out_vertices[i*3 + 2] = world_pos.GetZ();
                }
            }
        }
    }

    void update_physics_system(void* physics_system_ptr, float delta_time) {
        PhysicsSystem* sys = static_cast<PhysicsSystem*>(physics_system_ptr);
        // Jolt physics update typically requires temp allocator and job system.
        // For basic demonstration if they have global instances we could step.
        // Assuming zig side handles the update!
    }
    // 强制更新软体发根的位置（让头发跟着人物走）
    // 强制更新软体位置（形状匹配与阻尼防爆机制）
    // 强制更新软体位置
    void update_soft_body_roots(void* physics_system_ptr, void* body_id_ptr, const float* all_pos, const int* all_idx, int count, int is_first_frame) 
    {
        PhysicsSystem* sys = static_cast<PhysicsSystem*>(physics_system_ptr);
        BodyID body_id(static_cast<uint32>(reinterpret_cast<uintptr_t>(body_id_ptr)));

        // ═══════════════════════════════════════════════════════════════════
        // 【致命修复 1】：只要布料还在身上，每帧强制唤醒！严禁物理引擎偷懒休眠！
        // ═══════════════════════════════════════════════════════════════════
        sys->GetBodyInterface().ActivateBody(body_id);

        BodyLockWrite lock(sys->GetBodyLockInterface(), body_id);
        if (lock.SucceededAndIsInBroadPhase() || lock.Succeeded()) {
            Body& body = lock.GetBody();
            if (body.IsSoftBody()) {
                SoftBodyMotionProperties* mp = static_cast<SoftBodyMotionProperties*>(body.GetMotionProperties());
                auto& vertices = mp->GetVertices();
                Mat44 inv_transform = body.GetCenterOfMassTransform().Inversed();

                for (int i = 0; i < count; ++i) {
                    int v_idx = all_idx[i];
                    Vec3 target_pos = inv_transform * Vec3(all_pos[i*3], all_pos[i*3+1], all_pos[i*3+2]);

                    if (is_first_frame || vertices[v_idx].mInvMass == 0.0f) {
                        // 【发根 / 第一帧瞬移】：精准定位，钉死在模型上
                        vertices[v_idx].mPosition = target_pos;
                        vertices[v_idx].mVelocity = Vec3::sZero();
                    } else {
                        // ════════════════════════════════════════════════════════
                        // 【致命修复 2】：彻底删除所有的 diff 形状匹配牵引力！
                        // 让布料 100% 处于自由落体和弹性碰撞状态，只保留一点空气阻尼。
                        // ════════════════════════════════════════════════════════
                        vertices[v_idx].mVelocity *= 0.99f;
                    }
                }
            }
        }
    }
}
