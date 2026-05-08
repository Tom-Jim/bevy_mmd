// 引入 set 和 algorithm 用于边去重 (Edge Deduplication)
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

    /**
     * @brief 从网格数据创建一个 Jolt 物理软体 (Soft Body)
     * 
     * 此函数接收来自 Rust 端的顶点数据、索引数据和质量倒数 (Inverse Mass)，并在 Jolt 物理世界中
     * 实例化一个软体。它处理了物理边的去重、柔顺度设置和初始长度计算。
     * 
     * @param vertices 顶点位置数组的指针 (格式: [x0, y0, z0, x1, y1, z1, ...])
     * @param num_vertices 顶点的总数
     * @param indices 面索引数组的指针 (格式: [v0, v1, v2, v3, v4, v5, ...])
     * @param num_indices 索引的总数 (通常是面数 * 3)
     * @param inv_masses 顶点的质量倒数数组指针 (0.0 表示固定/Kinematic, >0.0 表示动态/Dynamic)
     * @param physics_system_ptr 指向 Jolt PhysicsSystem 实例的指针 (来自 Zig)
     * 
     * @return void* 成功时返回新创建的软体的 BodyID 编码指针，失败时返回 nullptr。
     * 
     * @note 相关联的 Rust 结构：`HairPhysicsData`, `JoltSoftBody`
     */
    void* create_soft_body_from_mesh(
        const float* vertices, int num_vertices,
        const int* indices, int num_indices,
        const float* inv_masses,
        void* physics_system_ptr
    ) {
        if (!physics_system_ptr || !vertices || !indices || !inv_masses || num_vertices <= 0 || num_indices <= 0) return nullptr;

        PhysicsSystem* sys = static_cast<PhysicsSystem*>(physics_system_ptr);

        Ref<SoftBodySharedSettings> shared_settings = new SoftBodySharedSettings();

        // 1. 填入顶点数据与质量逆
        // 遍历所有传入的顶点，初始化它们在软体中的局部坐标和物理属性。
        for (int i = 0; i < num_vertices; ++i) {
            SoftBodySharedSettings::Vertex v;
            v.mPosition = Float3(vertices[i*3], vertices[i*3+1], vertices[i*3+2]);
            v.mVelocity = Float3(0, 0, 0); // 初始速度为0
            v.mInvMass = inv_masses[i];    // 决定顶点是钉死在骨骼上还是自由摆动
            shared_settings->mVertices.push_back(v);
        }

        // 2. 面与边的构建及去重
        // 【关键逻辑】：使用 std::set 过滤重复的边。
        // PMX 模型网格通常由离散的三角形组成。如果直接把所有三角形的边当做弹簧约束，
        // 两个相邻三角形共享的边就会产生两次甚至多次弹簧约束，导致该处的弹力翻倍甚至爆炸。
        // 所以我们必须把所有的边提取出来去重，确保两个顶点之间最多只有一根弹簧。
        std::set<std::pair<int, int>> unique_edges;

        for (int i = 0; i < num_indices; i += 3) {
            int v0 = indices[i];
            int v1 = indices[i+1];
            int v2 = indices[i+2];

            if (v0 < 0 || v0 >= num_vertices || v1 < 0 || v1 >= num_vertices || v2 < 0 || v2 >= num_vertices) {
                continue; // 跳过无效的三角形索引，防止越界
            }

            // 注册面，这主要用于软体与其他刚体（如角色碰撞胶囊）之间的碰撞检测。
            SoftBodySharedSettings::Face f;
            f.mVertex[0] = v0;
            f.mVertex[1] = v1;
            f.mVertex[2] = v2;
            shared_settings->mFaces.push_back(f);

            // 注册边，保证小索引在前，大索引在后，插入 std::set 自动实现去重。
            unique_edges.insert({std::min(v0, v1), std::max(v0, v1)});
            unique_edges.insert({std::min(v1, v2), std::max(v1, v2)});
            unique_edges.insert({std::min(v2, v0), std::max(v2, v0)});
        }

        // 3. 将去重后的边正式注册为物理拉伸约束 (Edge Constraints)
        for (const auto& edge : unique_edges) {
            SoftBodySharedSettings::Edge e;
            e.mVertex[0] = edge.first;
            e.mVertex[1] = edge.second;
            // mCompliance 定义了边的柔顺度/弹性。
            // 0.0f 表示完全不可拉伸，完美模拟丝绸和棉布等非弹性织物。
            // 彻底去除橡皮筋效果，保持拓扑形状不变。
            e.mCompliance = 0.0f; 
            shared_settings->mEdgeConstraints.push_back(e);
        }

        // 4. 计算初始状态
        // 让 Jolt 测量此时所有顶点构成的边的长度，以此作为"静止状态"的弹簧原长。
        shared_settings->CalculateEdgeLengths();
        shared_settings->Optimize();

        // 5. 实例化软体
        SoftBodyCreationSettings creation_settings(shared_settings, RVec3::sZero(), Quat::sIdentity(), 1);

        // 设定重力乘数。1.0f 意味着布料受到的重力较弱，营造丝绸轻盈飘逸的自然下坠感。
        creation_settings.mGravityFactor = 1.0f;

        BodyInterface& body_interface = sys->GetBodyInterface();
        Body* soft_body = body_interface.CreateSoftBody(creation_settings);

        if (soft_body) {
            // 将软体加入物理世界，并设定为激活状态（开始模拟）
            body_interface.AddBody(soft_body->GetID(), EActivation::Activate);
            return reinterpret_cast<void*>(static_cast<uintptr_t>(soft_body->GetID().GetIndexAndSequenceNumber()));
        }

        return nullptr;
    }

    /**
     * @brief 获取软体当前的顶点总数
     * 
     * 主要用于调试和安全检查。因为 Jolt 内部优化（如果调用了 Optimize）可能会改变顶点数量。
     * 
     * @param physics_system_ptr 指向 Jolt PhysicsSystem 的指针
     * @param body_id_ptr 软体的 BodyID 句柄
     * @return int 物理引擎中该软体当前的顶点数量
     */
    int get_soft_body_vertex_count(void* physics_system_ptr, void* body_id_ptr) {
        if (!physics_system_ptr || !body_id_ptr) return 0;
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

    /**
     * @brief 获取软体经过物理模拟后的最新世界空间坐标
     * 
     * 每一帧 Rust 都会调用此函数，将物理引擎计算出的衣服/头发下垂、摆动后的顶点坐标
     * 拉取回 CPU，然后覆盖掉骨骼蒙皮的原始坐标，从而渲染出动态的布料效果。
     * 
     * @param physics_system_ptr 指向 Jolt PhysicsSystem 的指针
     * @param body_id_ptr 软体的 BodyID 句柄
     * @param out_vertices 用于接收输出坐标的数组指针 (需预先分配好空间)
     */
    void get_soft_body_vertices(void* physics_system_ptr, void* body_id_ptr, float* out_vertices, int max_vertices) {
        if (!physics_system_ptr || !body_id_ptr || !out_vertices || max_vertices <= 0) return;
        PhysicsSystem* sys = static_cast<PhysicsSystem*>(physics_system_ptr);
        BodyID body_id(static_cast<uint32>(reinterpret_cast<uintptr_t>(body_id_ptr)));

        BodyLockRead lock(sys->GetBodyLockInterface(), body_id);
        if (lock.SucceededAndIsInBroadPhase()) {
            const Body& body = lock.GetBody();
            if (body.IsSoftBody()) {
                const SoftBodyMotionProperties* mp = static_cast<const SoftBodyMotionProperties*>(body.GetMotionProperties());
                const Array<SoftBodyVertex>& vertices = mp->GetVertices();
                // 软体的顶点坐标通常是相对于质心(CenterOfMass)的局部坐标。
                // 必须乘以质心的世界变换矩阵，才能得到真实的 3D 世界坐标。
                Mat44 world_transform = body.GetCenterOfMassTransform();

                size_t count = std::min(vertices.size(), static_cast<size_t>(max_vertices));
                for (size_t i = 0; i < count; ++i) {
                    Vec3 world_pos = world_transform * vertices[i].mPosition;
                    out_vertices[i*3 + 0] = world_pos.GetX();
                    out_vertices[i*3 + 1] = world_pos.GetY();
                    out_vertices[i*3 + 2] = world_pos.GetZ();
                }
            }
        }
    }

    /**
     * @brief [占位符] 更新物理系统
     * 
     * 此函数在本架构中并未使用。因为物理引擎的 Step(步进) 逻辑是在 Zig 层 (api.zig) 中处理的。
     * 保留此函数是为了未来可能的 C++ 端扩展。
     */
    void update_physics_system(void* physics_system_ptr, float delta_time) {
        PhysicsSystem* sys = static_cast<PhysicsSystem*>(physics_system_ptr);
        // Jolt physics update typically requires temp allocator and job system.
        // For basic demonstration if they have global instances we could step.
        // Assuming zig side handles the update!
    }

    /**
     * @brief 强制更新软体顶点的位置与动量 (核心防穿模与角色追随逻辑)
     * 
     * 这是整个软体系统最核心的一环。PMX 模型的软体（衣服/头发）并没有与角色的物理碰撞体
     * （Capsule/Box）绑定。如果不施加外力，衣服不仅会穿过角色的大腿，还会在角色跑动时远远落后于角色。
     * 此函数通过引入"软性形状匹配 (Soft Shape Matching)"，让软体在自由摆动的同时，总是倾向于
     * 回归骨骼动画驱动的蒙皮坐标。
     * 
     * @param physics_system_ptr Jolt PhysicsSystem 指针
     * @param body_id_ptr 软体的 BodyID
     * @param all_pos Rust 端算出的所有顶点当帧的"完美骨骼蒙皮坐标" (即原始动画应在的位置)
     * @param all_idx 与 all_pos 对应的软体顶点索引数组
     * @param count 要更新的顶点数量
     * @param is_first_frame 是否为第一帧 (第一帧时需要瞬间移动软体，而不是施加牵引力)
     */
    void update_soft_body_roots(void* physics_system_ptr, void* body_id_ptr, const float* all_pos, const int* all_idx, int count, int is_first_frame) 
    {
        if (!physics_system_ptr || !body_id_ptr || !all_pos || !all_idx || count <= 0) return;

        PhysicsSystem* sys = static_cast<PhysicsSystem*>(physics_system_ptr);
        BodyID body_id(static_cast<uint32>(reinterpret_cast<uintptr_t>(body_id_ptr)));

        // ═══════════════════════════════════════════════════════════════════
        // 【关键】：每帧强制唤醒软体！
        // Jolt 引擎会在物体静止时使其进入休眠状态 (Deactivate) 以节省性能。
        // 但对于绑定在角色身上的衣服，只要动画在播放，它就必须随时响应角色运动。
        // ═══════════════════════════════════════════════════════════════════
        sys->GetBodyInterface().ActivateBody(body_id);

        BodyLockWrite lock(sys->GetBodyLockInterface(), body_id);
        if (lock.SucceededAndIsInBroadPhase() || lock.Succeeded()) {
            Body& body = lock.GetBody();
            if (body.IsSoftBody()) {
                SoftBodyMotionProperties* mp = static_cast<SoftBodyMotionProperties*>(body.GetMotionProperties());
                auto& vertices = mp->GetVertices();
                // 由于我们传入的 all_pos 是世界坐标，而软体的顶点位于相对于质心的局部空间，
                // 我们必须使用质心变换矩阵的逆矩阵 (Inversed) 将其转换回局部空间进行比较。
                Mat44 inv_transform = body.GetCenterOfMassTransform().Inversed();

                int max_v = static_cast<int>(vertices.size());
                for (int i = 0; i < count; ++i) {
                    int v_idx = all_idx[i];
                    if (v_idx < 0 || v_idx >= max_v) continue; // 安全检查：防止越界

                    // 计算出该顶点在软体局部空间中的目标动画坐标
                    Vec3 target_pos = inv_transform * Vec3(all_pos[i*3], all_pos[i*3+1], all_pos[i*3+2]);

                    // 分支 1：如果是第一帧，或者是 mInvMass == 0 的顶点 (钉死在躯干上的锚点)
                    if (is_first_frame || vertices[v_idx].mInvMass == 0.0f) {
                        // 【发根锚点】：钉死在骨骼动画位置
                        vertices[v_idx].mPosition = target_pos;
                        vertices[v_idx].mVelocity = Vec3::sZero();
                    } else {
                        // 【PBD 基于位置的形变修正 (丝绸仿真)】
                        // 绝不能将 diff 加到 Velocity 上！那会产生胡克定律的弹簧振荡（果冻弹射效应）。
                        // 真正的丝绸 PBD 做法是：直接把位置向目标点微调，以此抵抗重力和保持布料大体形状，
                        // 直接修改位置不会产生任何多余的动能，因此绝对不会反弹和果冻抖动。
                        Vec3 diff = target_pos - vertices[v_idx].mPosition;
                        
                        // 0.03f 代表每帧向动画网格温柔靠拢 10%，不产生任何物理速度积蓄
                        vertices[v_idx].mPosition += diff * 0.1f;

                        // 丝绸的空气阻力极大（飘逸感），通过强力衰减速度让布料像在空气中缓慢下坠，消除残留抖动
                        vertices[v_idx].mVelocity *= 0.2f; 
                    }
                }
            }
        }
    }
}