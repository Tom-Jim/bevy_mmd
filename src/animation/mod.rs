use bevy::prelude::*;
use std::ffi::c_void;

use PMXUtil::types::{Bone, Face, Material, VertexWeight};

use crate::components::{
    HairPhysicsData, IkConstraint, IkLinkData, PmxBoneData, PmxSharedSkin, PmxSkeleton,
    SubMeshInfo, VmdPlayback,
};
use crate::physics::{
    get_soft_body_vertices, step_physics, update_soft_body_roots, PHYSICS_SYSTEM_PTR,
};

// ═════════════════════════════════════════════════════════════════════════════
// skin_update_system — 每帧核心动画系统
//
// 执行步骤：
//   1. 推进播放时间
//   2. 从 VMD 采样各骨骼局部变换
//   3. FK：父→子递推世界变换
//   4. IK：CCD 求解
//   5. 构建蒙皮矩阵
//   6. 蒙皮：变换所有顶点位置和法线，写入 PmxSharedSkin
//
// 蒙皮只做一次（30921次变换），然后由 apply_skin_to_meshes 把结果分发给各 Mesh。
// ═════════════════════════════════════════════════════════════════════════════
pub fn skin_update_system(
    time: Res<Time>,
    mut playback: Option<ResMut<VmdPlayback>>,
    skeleton: Option<Res<PmxSkeleton>>,
    mut shared_skin: Option<ResMut<PmxSharedSkin>>,
    hair_data: Option<ResMut<HairPhysicsData>>,
    cfg: Res<crate::config::Config>,
) {
    let (Some(pb), Some(skel), Some(skin)) =
        (playback.as_mut(), skeleton.as_ref(), shared_skin.as_mut())
    else {
        return;
    };

    if pb.clip.duration_frames == 0 {
        return;
    }

    // ── Step 1：更新播放时间 ─────────────────────────────────────────────────
    pb.time_sec += time.delta_secs();
    let duration_sec = pb.clip.duration_frames as f32 / pb.fps;
    if duration_sec > 0.0 {
        pb.time_sec %= duration_sec;
    }
    let t = pb.time_sec;
    let fps = pb.fps;
    println!("Current VMD Frame: {}", (t * fps) as u32);
    let n = skel.bones.len();

    // ── Step 2：VMD 采样局部变换 ─────────────────────────────────────────────
    // VMD 存的是每根骨骼相对于自身 rest 姿态的偏移：
    //   local_translation：相对 rest_position 的额外位移
    //   local_rotation：在绑定姿态上叠加的局部旋转
    let mut local_t = vec![Vec3::ZERO; n];
    let mut local_r = vec![Quat::IDENTITY; n];
    for (i, bone) in skel.bones.iter().enumerate() {
        if let Some(pose) = pb.clip.sample_bone_at_seconds(&bone.name, t, fps) {
            local_t[i] = Vec3::new(pose.translation.x, pose.translation.y, -pose.translation.z);
            local_r[i] = Quat::from_xyzw(
                -pose.rotation.x,
                -pose.rotation.y,
                pose.rotation.z,
                pose.rotation.w,
            );
        }
    }

    // ── Step 3：FK — 父→子递推世界变换 ──────────────────────────────────────
    // 推导公式（设 P=父，C=子）：
    //   C.world_rot = P.world_rot × C.local_rot
    //   C.world_pos = P.world_pos + P.world_rot × (rest_offset + C.local_t)
    //   rest_offset = C.rest_pos - P.rest_pos（绑定姿态父子间距，固定）
    let mut world_pos = vec![Vec3::ZERO; n];
    let mut world_rot = vec![Quat::IDENTITY; n];

    // 按 deform_depth 升序排列，确保父在子之前计算
    let mut order: Vec<usize> = (0..n).collect();
    order.sort_by_key(|&i| skel.bones[i].deform_depth);

    for &i in &order {
        let bone = &skel.bones[i];
        let p = bone.parent;

        let mut final_local_r = local_r[i];
        if let Some((app_idx, weight)) = bone.append_rotation {
            if app_idx < n {
                let app_r = Quat::IDENTITY.slerp(local_r[app_idx], weight);
                final_local_r = (final_local_r * app_r).normalize();
            }
        }

        // 为了让后续 IK 等能获取更新后的总局部旋转，保存回去
        local_r[i] = final_local_r;

        if p < 0 || p as usize >= n {
            // 根骨骼
            world_pos[i] = bone.rest_position + local_t[i];
            world_rot[i] = final_local_r;
        } else {
            let p = p as usize;
            let rest_offset = bone.rest_position - skel.bones[p].rest_position;
            world_pos[i] = world_pos[p] + world_rot[p] * (rest_offset + local_t[i]);
            world_rot[i] = (world_rot[p] * final_local_r).normalize();
        }
    }

    // ── Step 4：IK — CCD 反向运动学 ─────────────────────────────────────────
    // CCD（循环坐标下降）每步：
    //   对链路骨骼 link（从末端往根部）：
    //     to_end    = normalize(效应骨骼位置 - link位置)
    //     to_target = normalize(IK目标点    - link位置)
    //     delta     = from_rotation_arc(to_end, to_target)
    //     delta     = clamp_rotation(delta, limit_angle)   // 防单步抖动
    //     link.world_rot = delta × link.world_rot
    //     若有角度限制：转局部空间→夹紧欧拉角→转回世界空间
    //     传播：重新计算 link 的所有子孙世界变换
    for ik in &skel.ik_constraints {
        if ik.ik_bone_idx >= n || ik.target_bone_idx >= n {
            continue;
        }
        let ik_name = &skel.bones[ik.ik_bone_idx].name;
        let is_ik_animated = pb.clip.bones.get(ik_name).map_or(0, |v| v.len()) > 1;
        if !is_ik_animated {
            let mut is_fk_animated = false;
            let mut p = skel.bones[ik.target_bone_idx].parent;
            for _ in 0..2 {
                if p >= 0 && p < n as i32 {
                    let parent_name = &skel.bones[p as usize].name;
                    if pb.clip.bones.get(parent_name).map_or(0, |v| v.len()) > 1 {
                        is_fk_animated = true;
                        break;
                    }
                    p = skel.bones[p as usize].parent;
                } else {
                    break;
                }
            }
            if is_fk_animated {
                continue;
            }
        }
        let target = world_pos[ik.ik_bone_idx]; // IK 目标点（已含 VMD 位移）
        for _ in 0..ik.iter_count {
            for link in &ik.links {
                let li = link.bone_index;
                if li >= n {
                    continue;
                }
                let to_end = (world_pos[ik.target_bone_idx] - world_pos[li]).normalize_or_zero();
                let to_target = (target - world_pos[li]).normalize_or_zero();
                if to_end.length_squared() < 1e-10 || to_target.length_squared() < 1e-10 {
                    continue;
                }

                let delta =
                    clamp_rotation(Quat::from_rotation_arc(to_end, to_target), ik.limit_angle);
                let new_rot = (delta * world_rot[li]).normalize();

                let parent_rot = parent_world_rot(&skel.bones, li, &world_rot);
                // 角度约束（膝盖只能前弯）
                let new_rot = if let Some((mn, mx)) = link.angle_limit {
                    let local_rot = (parent_rot.inverse() * new_rot).normalize();
                    let clamped = clamp_euler(local_rot, mn, mx);
                    (parent_rot * clamped).normalize()
                } else {
                    new_rot
                };
                world_rot[li] = new_rot;
                local_r[li] = (parent_rot.inverse() * new_rot).normalize();

                // 传播子孙变换
                propagate(
                    &skel.bones,
                    li,
                    &local_t,
                    &local_r,
                    &mut world_pos,
                    &mut world_rot,
                );
            }
        }
    }

    // ── Step 5：构建蒙皮矩阵 ────────────────────────────────────────────────
    // M_skin[i] = T(world_pos[i]) × R(world_rot[i]) × T(-rest_pos[i])
    // 对顶点 v：animated = M_skin × v_rest = R×(v_rest - rest_pos) + world_pos
    let skin_mats: Vec<Mat4> = (0..n)
        .map(|i| {
            Mat4::from_rotation_translation(world_rot[i], world_pos[i])
                * Mat4::from_translation(-skel.bones[i].rest_position)
        })
        .collect();

    // ── Step 6：CPU 蒙皮（只做一次！） ──────────────────────────────────────
    // 先把只读的 vertices 长度和引用提前拿出来，再做可变借用（Rust 借用规则）
    let vcount_skin = skin.vertices.len();
    let mut new_pos = vec![[0.0f32; 3]; vcount_skin];
    let mut new_nor = vec![[0.0f32; 3]; vcount_skin];

    // 计算 Morph
    let mut morphed_positions: Vec<Vec3> = skin.vertices.iter().map(|v| v.rest_position).collect();
    for morph in &skel.morphs {
        if let Some(weight) = pb.clip.sample_morph_at_seconds(&morph.name, t, fps) {
            if weight.abs() > 1e-4 {
                for vm in &morph.offsets {
                    if vm.index < vcount_skin {
                        morphed_positions[vm.index] += vm.offset * weight;
                    }
                }
            }
        }
    }

    for (vi, sv) in skin.vertices.iter().enumerate() {
        let mut pos = Vec3::ZERO;
        let mut nor = Vec3::ZERO;
        let mut wsum = 0.0f32;

        for k in 0..4 {
            let bidx = sv.bone_indices[k];
            let bw = sv.bone_weights[k];
            if bidx < 0 || bw <= 0.0 {
                continue;
            }
            let bidx = bidx as usize;
            if bidx >= n {
                continue;
            }
            let m = skin_mats[bidx];
            // transform_point3  = 含平移变换（位置用）
            // transform_vector3 = 不含平移（法线用，只旋转）
            pos += m.transform_point3(morphed_positions[vi]) * bw;
            nor += m.transform_vector3(sv.rest_normal) * bw;
            wsum += bw;
        }
        // BDEF4 权重总和可能不精确为 1，归一化修正
        if wsum > 0.0 && (wsum - 1.0).abs() > 1e-4 {
            pos /= wsum;
            nor /= wsum;
        }
        new_pos[vi] = pos.to_array();
        new_nor[vi] = nor.normalize_or_zero().to_array();
    }
    // 将计算结果写回共享 Resource
    skin.skinned_positions = new_pos.clone();
    skin.skinned_normals = new_nor;
    // ═════════════════════════════════════════════════════════════════════════
    // 【新增】：将发根或全量软体的最新世界坐标强制同步给物理引擎
    // ═════════════════════════════════════════════════════════════════════════
    // ═════════════════════════════════════════════════════════════════════════
    // 【终极防爆】：每帧全量传入蒙皮目标坐标，实施形状匹配与阻尼
    // ═════════════════════════════════════════════════════════════════════════
    if let Some(mut hair) = hair_data {
        let is_first = if !hair.is_initialized { 1 } else { 0 };

        // 无论是不是第一帧，我们都把整个软体的“完美动画坐标”传给物理引擎
        let num_sb_verts = hair.representative_pmx_indices.len();
        let mut all_positions = Vec::with_capacity(num_sb_verts * 3);
        let mut all_sb_indices = Vec::with_capacity(num_sb_verts);

        for (sb_idx, &pmx_idx) in hair.representative_pmx_indices.iter().enumerate() {
            let pos = new_pos[pmx_idx];
            all_positions.push(pos[0]);
            all_positions.push(pos[1]);
            all_positions.push(pos[2]);
            all_sb_indices.push(sb_idx as i32);
        }

        unsafe {
            let physics_system =
                PHYSICS_SYSTEM_PTR.load(std::sync::atomic::Ordering::SeqCst) as *mut c_void;
            update_soft_body_roots(
                physics_system,
                hair.ptr,
                all_positions.as_ptr(),
                all_sb_indices.as_ptr(),
                all_sb_indices.len() as i32,
                is_first, // 告诉 C++ 这次是要瞬移还是施加牵引力
                time.delta_secs(),
                cfg.softbody.position_pull,
                cfg.softbody.velocity_pull,
                cfg.softbody.damping,
                cfg.softbody.max_speed,
            );

            // 推进物理引擎模拟，确保 PBD 约束投影能够修正形状并保持拓扑大小不变
            step_physics(time.delta_secs().min(0.033));

            // ═════════════════════════════════════════════════════════════════
            // 【关键修复】：把物理引擎算好的悬垂坐标读回来，强制覆盖掉生硬的蒙皮！
            // ═════════════════════════════════════════════════════════════════
            let mut current_vertices = vec![0.0f32; num_sb_verts * 3];
            get_soft_body_vertices(
                physics_system,
                hair.ptr,
                current_vertices.as_mut_ptr(),
                num_sb_verts as i32,
            );

            for sb_idx in 0..num_sb_verts {
                let px = current_vertices[sb_idx * 3];
                let py = current_vertices[sb_idx * 3 + 1];
                let pz = current_vertices[sb_idx * 3 + 2];

                for &(pmx_idx, offset) in &hair.sb_to_pmx_map[sb_idx] {
                    if pmx_idx < skin.skinned_positions.len() {
                        // 强制覆写 PmxSharedSkin 里的坐标，这样下一步 apply_skin_to_meshes 就会渲染物理布料
                        // 叠加物理软体坐标与顶点相对于物理点的初始偏移，保证内衬等厚度不丢失
                        skin.skinned_positions[pmx_idx] =
                            [px + offset.x, py + offset.y, pz + offset.z];
                    }
                }
            }
        }
        hair.is_initialized = true;
    }
}

// ═════════════════════════════════════════════════════════════════════════════
// apply_skin_to_meshes — 把共享蒙皮结果写入各子 Mesh Asset
//
// 在 skin_update_system 之后运行（.chain() 保证顺序）。
// 每个 Mesh 从 PmxSharedSkin 中取 [vertex_start, vertex_end) 范围的数据。
//
// 由于所有子 Mesh 都使用全部顶点（vertex_start=0, vertex_end=vcount），
// 此步骤相当于把同一份蒙皮结果写入每个 Mesh——这是必要的，
// 因为 Bevy 每个 Mesh 实体是独立的 Asset，无法共享同一顶点缓冲区。
//
// 性能说明：
//   蒙皮计算只做一次（skin_update_system，30921次变换）
//   此处只是内存拷贝（35次 × 30921个顶点的 Vec 复制），
//   比之前的 35次蒙皮计算（1,082,235次变换）快约 50倍。
// ═════════════════════════════════════════════════════════════════════════════
pub fn apply_skin_to_meshes(
    shared_skin: Option<Res<PmxSharedSkin>>,
    mesh_query: Query<(&SubMeshInfo, &Mesh3d)>,
    mut mesh_assets: ResMut<Assets<Mesh>>,
) {
    let Some(skin) = shared_skin.as_ref() else {
        return;
    };

    for (info, mesh3d) in &mesh_query {
        let Some(mesh) = mesh_assets.get_mut(&mesh3d.0) else {
            continue;
        };
        let start = info.vertex_start;
        let end = info.vertex_end.min(skin.skinned_positions.len());
        // 取该子 Mesh 需要的顶点范围切片（目前是全部顶点）
        mesh.insert_attribute(
            Mesh::ATTRIBUTE_POSITION,
            skin.skinned_positions[start..end].to_vec(),
        );
        mesh.insert_attribute(
            Mesh::ATTRIBUTE_NORMAL,
            skin.skinned_normals[start..end].to_vec(),
        );
    }
}

// ═════════════════════════════════════════════════════════════════════════════
// IK 辅助函数
// ═════════════════════════════════════════════════════════════════════════════

/// 从 PMX Bone 列表提取所有 IK 约束
pub fn build_ik_constraints(bones: &[Bone]) -> Vec<IkConstraint> {
    let n = bones.len();
    let mut out = Vec::new();
    for (ik_bone_idx, bone) in bones.iter().enumerate() {
        let Some(ik) = &bone.ik_info else { continue };
        let target_idx = ik.ik_target_bone_index as usize;
        if target_idx >= n {
            continue;
        }

        let mut links = Vec::new();
        for link in &ik.ik_links {
            let li = link.ik_bone_index as usize;
            if li >= n {
                continue;
            }
            links.push(IkLinkData {
                bone_index: li,
                angle_limit: link
                    .angle_limit
                    .map(|(mn, mx)| (-Vec3::from(mx), -Vec3::from(mn))),
            });
        }
        if links.is_empty() {
            continue;
        }

        out.push(IkConstraint {
            ik_bone_idx,
            target_bone_idx: target_idx,
            iter_count: (ik.ik_iter_count as usize).min(32),
            limit_angle: ik.ik_limit_angle,
            links,
        });
    }
    out
}

/// IK 修改某骨骼旋转后，向下传播更新所有子孙的世界变换
fn propagate(
    bones: &[PmxBoneData],
    changed: usize,
    local_t: &[Vec3],
    local_r: &[Quat],
    world_pos: &mut Vec<Vec3>,
    world_rot: &mut Vec<Quat>,
) {
    let n = bones.len();
    let mut dirty = vec![false; n];
    dirty[changed] = true;
    // PMX 骨骼通常父索引 < 子索引，顺序遍历即可保证传播正确
    for i in 0..n {
        let p = bones[i].parent;
        if p < 0 {
            continue;
        }
        let p = p as usize;
        if p >= n || !dirty[p] {
            continue;
        }
        let offset = bones[i].rest_position - bones[p].rest_position;
        world_pos[i] = world_pos[p] + world_rot[p] * (offset + local_t[i]);
        world_rot[i] = (world_rot[p] * local_r[i]).normalize();
        dirty[i] = true;
    }
}

/// 获取骨骼的父世界旋转（根骨骼返回单位四元数）
fn parent_world_rot(bones: &[PmxBoneData], idx: usize, world_rot: &[Quat]) -> Quat {
    let p = bones[idx].parent;
    if p < 0 || p as usize >= bones.len() {
        Quat::IDENTITY
    } else {
        world_rot[p as usize]
    }
}

/// 限制四元数旋转角不超过 max_angle（弧度），防止 CCD 单步大幅抖动
fn clamp_rotation(q: Quat, max_angle: f32) -> Quat {
    let q = if q.w < 0.0 {
        Quat::from_xyzw(-q.x, -q.y, -q.z, -q.w)
    } else {
        q
    };
    let angle = 2.0 * q.w.clamp(-1.0, 1.0).acos();
    if angle <= max_angle || angle < 1e-6 {
        return q;
    }
    let half = max_angle * 0.5;
    let axis = Vec3::new(q.x, q.y, q.z).normalize_or_zero();
    Quat::from_xyzw(
        axis.x * half.sin(),
        axis.y * half.sin(),
        axis.z * half.sin(),
        half.cos(),
    )
    .normalize()
}

/// 将四元数转为欧拉角后夹紧到 [min,max]，再转回四元数（用于关节角度限制）
fn clamp_euler(q: Quat, min_ang: Vec3, max_ang: Vec3) -> Quat {
    let e = quat_to_euler_xyz(q);
    euler_xyz_to_quat(Vec3::new(
        e.x.clamp(min_ang.x, max_ang.x),
        e.y.clamp(min_ang.y, max_ang.y),
        e.z.clamp(min_ang.z, max_ang.z),
    ))
}

/// 四元数 → XYZ 欧拉角（弧度）
fn quat_to_euler_xyz(q: Quat) -> Vec3 {
    let (x, y, z, w) = (q.x, q.y, q.z, q.w);
    Vec3::new(
        (2.0 * (w * x + y * z)).atan2(1.0 - 2.0 * (x * x + y * y)),
        (2.0 * (w * y - z * x)).clamp(-1.0, 1.0).asin(),
        (2.0 * (w * z + x * y)).atan2(1.0 - 2.0 * (y * y + z * z)),
    )
}

/// XYZ 欧拉角 → 四元数
fn euler_xyz_to_quat(e: Vec3) -> Quat {
    (Quat::from_rotation_z(e.z) * Quat::from_rotation_y(e.y) * Quat::from_rotation_x(e.x))
        .normalize()
}

pub fn convert_vertex_weight(w: &VertexWeight) -> ([i32; 4], [f32; 4]) {
    match w {
        VertexWeight::BDEF1(b) => {
            let mut bi = [-1i32; 4];
            let mut bw = [0f32; 4];
            bi[0] = *b;
            bw[0] = 1.0;
            (bi, bw)
        }
        VertexWeight::BDEF2 {
            bone_index_1: b1,
            bone_index_2: b2,
            bone_weight_1: w1,
        } => {
            let mut bi = [-1i32; 4];
            let mut bw = [0f32; 4];
            bi[0] = *b1;
            bi[1] = *b2;
            bw[0] = *w1;
            bw[1] = 1.0 - w1;
            (bi, bw)
        }
        VertexWeight::BDEF4 {
            bone_index_1: b1,
            bone_index_2: b2,
            bone_index_3: b3,
            bone_index_4: b4,
            bone_weight_1: w1,
            bone_weight_2: w2,
            bone_weight_3: w3,
            bone_weight_4: w4,
        } => ([*b1, *b2, *b3, *b4], [*w1, *w2, *w3, *w4]),
        VertexWeight::SDEF {
            bone_index_1: b1,
            bone_index_2: b2,
            bone_weight_1: w1,
            ..
        } => {
            let mut bi = [-1i32; 4];
            let mut bw = [0f32; 4];
            bi[0] = *b1;
            bi[1] = *b2;
            bw[0] = *w1;
            bw[1] = 1.0 - w1;
            (bi, bw)
        }
        VertexWeight::QDEF {
            bone_index_1: b1,
            bone_index_2: b2,
            bone_index_3: b3,
            bone_index_4: b4,
            bone_weight_1: w1,
            bone_weight_2: w2,
            bone_weight_3: w3,
            bone_weight_4: w4,
        } => ([*b1, *b2, *b3, *b4], [*w1, *w2, *w3, *w4]),
    }
}

pub fn format_vertex_weight(w: &VertexWeight) -> String {
    match w {
        VertexWeight::BDEF1(b) => format!("BDEF1(b={})", b),
        VertexWeight::BDEF2 {
            bone_index_1: b1,
            bone_index_2: b2,
            bone_weight_1: w1,
        } => format!("BDEF2(b{}×{:.3}+b{}×{:.3})", b1, w1, b2, 1.0 - w1),
        VertexWeight::BDEF4 {
            bone_index_1: b1,
            bone_index_2: b2,
            bone_index_3: b3,
            bone_index_4: b4,
            bone_weight_1: w1,
            bone_weight_2: w2,
            bone_weight_3: w3,
            bone_weight_4: w4,
        } => format!(
            "BDEF4(b{}×{:.2} b{}×{:.2} b{}×{:.2} b{}×{:.2})",
            b1, w1, b2, w2, b3, w3, b4, w4
        ),
        VertexWeight::SDEF {
            bone_index_1: b1,
            bone_index_2: b2,
            bone_weight_1: w1,
            ..
        } => format!("SDEF(b{}×{:.3}+b{}×{:.3})", b1, w1, b2, 1.0 - w1),
        VertexWeight::QDEF {
            bone_index_1: b1,
            bone_index_2: b2,
            bone_index_3: b3,
            bone_index_4: b4,
            bone_weight_1: w1,
            bone_weight_2: w2,
            bone_weight_3: w3,
            bone_weight_4: w4,
        } => format!(
            "QDEF(b{}×{:.2} b{}×{:.2} b{}×{:.2} b{}×{:.2})",
            b1, w1, b2, w2, b3, w3, b4, w4
        ),
    }
}

pub fn group_faces_by_material(faces: &[Face], mats: &[Material]) -> Vec<(usize, Vec<u32>)> {
    let mut groups = Vec::new();
    let mut cursor = 0usize;
    for (mi, mat) in mats.iter().enumerate() {
        let count = (mat.num_face_vertices / 3) as usize;
        let mut idx = Vec::new();
        for _ in 0..count {
            if cursor >= faces.len() {
                break;
            }
            idx.extend(faces[cursor].vertices.iter().map(|&v| v as u32));
            cursor += 1;
        }
        groups.push((mi, idx));
    }
    groups
}
