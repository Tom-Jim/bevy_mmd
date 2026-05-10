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

        // 将去重后的边正式注册为物理拉伸约束 (Edge Constraints)
        for (const auto& edge : unique_edges) {
            SoftBodySharedSettings::Edge e;
            e.mVertex[0] = edge.first;
            e.mVertex[1] = edge.second;
            // 使用极小的 compliance（而不是 0），避免数值刚性导致的震荡/撕裂
            e.mCompliance = 0.0f; 
            shared_settings->mEdgeConstraints.push_back(e);
        }

        // 4. 计算初始状态
        shared_settings->CalculateEdgeLengths();
        shared_settings->Optimize();

        // 5. 实例化软体
        SoftBodyCreationSettings creation_settings(shared_settings, RVec3::sZero(), Quat::sIdentity(), 1);

        // 增加求解器内部迭代次数（默认是5）。这能在不破坏拓扑且 collision_steps=1 的情况下，
        // 极大增加布料约束的刚性，彻底解决重力导致的布料拉扯伸长和下垂垮塌问题。
        creation_settings.mNumIterations = 30;

        // 【关键设置】：不让 Jolt 自动更新软体的中心点 (CenterOfMass)。
        // 我们的软体是被钉死在动画骨架上的，如果 Jolt 自动计算 COM 位移，
        // 整个局部空间就会随着布料下垂发生漂移，导致我们算出的 target_pos 完全错误，从而引发疯狂的拉扯和反弹！
        creation_settings.mUpdatePosition = false;

        // 恢复真实重力 (1.0f)，使用现实世界的 9.8m/s^2 进行模拟
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
                // 由于我们禁用了 mUpdatePosition，mPosition 直接就是绝对世界坐标。
                size_t count = std::min(vertices.size(), static_cast<size_t>(max_vertices));
                for (size_t i = 0; i < count; ++i) {
                    out_vertices[i*3 + 0] = vertices[i].mPosition.GetX();
                    out_vertices[i*3 + 1] = vertices[i].mPosition.GetY();
                    out_vertices[i*3 + 2] = vertices[i].mPosition.GetZ();
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
    void update_soft_body_roots(void* physics_system_ptr, void* body_id_ptr, const float* all_pos, const int* all_idx, int count, int is_first_frame, float delta_time) 
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
                // 我们之前禁用了 Jolt 的 COM 自动更新，所以局部坐标域等同于世界坐标域。
                int max_v = static_cast<int>(vertices.size());
                for (int i = 0; i < count; ++i) {
                    int v_idx = all_idx[i];
                    if (v_idx < 0 || v_idx >= max_v) continue; // 安全检查：防止越界

                    // 动画蒙皮坐标直接作为目标位置
                    Vec3 target_pos(all_pos[i*3], all_pos[i*3+1], all_pos[i*3+2]);
                    
                    if (is_first_frame || vertices[v_idx].mInvMass == 0.0f) {
                        // 【发根锚点 / 瞬移】：钉死在骨骼动画位置
                        vertices[v_idx].mPosition = target_pos;
                        vertices[v_idx].mVelocity = Vec3::sZero();
                    } else {
                        // 软性形状匹配 (Soft Shape Matching) - 修复飞碟摆动和 720 度大风车
                        // 使用纯粹的 PBD (Position Based) 修正代替 Velocity 弹簧，彻底消除果冻弹跳和超速甩圈。
                        Vec3 diff = target_pos - vertices[v_idx].mPosition;
                        
                        // 1. 位置强拉：每帧强行向目标移动 5%，这相当于无动能累积的极度阻尼约束，完美贴合角色腿部。
                        vertices[v_idx].mPosition += diff * 0.05f;

                        // 2. 移除剧烈的速度累积，仅保留微弱的随动拖拽力
                        vertices[v_idx].mVelocity += diff * 2.0f * delta_time;

                        // 3. 空气阻尼减弱，让丝绸顺滑飘落而不是像在泥浆中
                        vertices[v_idx].mVelocity *= 0.995f; 

                        // 4. 暴力限速：防止离心力过大导致头发甩成螺旋桨 (720度大回环)
                        float speed_sq = vertices[v_idx].mVelocity.LengthSq();
                        if (speed_sq > 400.0f) { // 最大速度限制 20m/s
                            vertices[v_idx].mVelocity *= (20.0f / std::sqrt(speed_sq));
                        }
                    }
                }
            }
        }
    }
}