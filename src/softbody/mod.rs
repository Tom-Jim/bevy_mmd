use bevy::prelude::*;
use std::ffi::c_void;

use PMXUtil::types::{Bone, Face, Material, Vertex};

use crate::components::{HairPhysicsData, JoltSoftBody};
use crate::physics::{create_soft_body_from_mesh, PHYSICS_SYSTEM_PTR};

/// 在场景中生成一个简单的悬挂旗帜软体（示例）
pub fn spawn_flag_softbody(commands: &mut Commands) {
    // === 生成一个悬挂的旗帜软体 ===
    let grid_size = 15; // 15x15 的网格
    let width = 10.0;
    let height = 10.0;
    let offset = Vec3::new(10.0, 15.0, 0.0); // 放在角色旁边的高处

    let mut flag_vertices = Vec::with_capacity(grid_size * grid_size * 3);
    let mut flag_inv_masses = Vec::with_capacity(grid_size * grid_size);
    let mut flag_indices = Vec::new();

    // 1. 生成顶点和质量逆
    for y in 0..grid_size {
        for x in 0..grid_size {
            let px = (x as f32 / (grid_size - 1) as f32) * width;
            let py = (y as f32 / (grid_size - 1) as f32) * height;

            flag_vertices.push(offset.x + px);
            flag_vertices.push(offset.y);
            flag_vertices.push(offset.z + py);

            // Top row pinned
            if y == 0 {
                flag_inv_masses.push(0.0);
            } else {
                flag_inv_masses.push(1.0);
            }
        }
    }

    // 2. 生成三角面索引 (构建网格)
    for y in 0..(grid_size - 1) {
        for x in 0..(grid_size - 1) {
            let top_left = (y * grid_size + x) as u32;
            let top_right = top_left + 1;
            let bottom_left = ((y + 1) * grid_size + x) as u32;
            let bottom_right = bottom_left + 1;

            flag_indices.push(top_left);
            flag_indices.push(bottom_left);
            flag_indices.push(top_right);

            flag_indices.push(top_right);
            flag_indices.push(bottom_left);
            flag_indices.push(bottom_right);
        }
    }

    unsafe {
        let physics_system =
            PHYSICS_SYSTEM_PTR.load(std::sync::atomic::Ordering::SeqCst) as *mut c_void;
        let flag_ptr = create_soft_body_from_mesh(
            flag_vertices.as_ptr(),
            (flag_vertices.len() / 3) as i32,
            flag_indices.as_ptr() as *const i32,
            flag_indices.len() as i32,
            flag_inv_masses.as_ptr(),
            physics_system,
        );

        if !flag_ptr.is_null() {
            commands.spawn((JoltSoftBody {
                ptr: flag_ptr,
                num_vertices: flag_vertices.len() / 3,
                indices: flag_indices,
            },));
            info!("spawned flag softbody");
        }
    }
}

/// 根据 PMX 顶点/面/材质信息构建用于 Jolt 的轻量级软体网格并创建软体
/// 注：函数会在成功时向 ECS 插入 `HairPhysicsData` 资源并产生一个 `JoltSoftBody` 实体。
pub fn spawn_hair_from_pmx(
    commands: &mut Commands,
    vertices: &Vec<Vertex>,
    faces: &Vec<Face>,
    materials_pmx: &Vec<Material>,
    face_groups: &Vec<(usize, Vec<u32>)>,
    bones: &Vec<Bone>,
) {
    // 选择哪些材质看起来是“软体”（启发式关键字匹配）
    let soft_keywords = [
        "发",
        "髪",
        "毛",
        "裙",
        "衣",
        "披肩",
        "飾",
        "饰",
        "摆",
        "擺",
        "辫",
        "辮",
        "羽",
        "链",
        "鏈",
        "biaoq",
        "带",
        "帶",
        "袖",
        "尾",
        "飘",
        "飄",
        "丝",
        "絲",
        "结",
        "結",
        "布",
        "耳环",
        "耳環",
        "流苏",
        "イヤリング",
        "ピアス",
        "タッセル",
        "ヘア",
        "スカート",
        "服",
        "リボン",
        "マント",
        "紐",
        "ネクタイ",
        "フリル",
        "ケープ",
    ];
    let mut soft_mat_indices = Vec::new();
    for (i, mat) in materials_pmx.iter().enumerate() {
        if soft_keywords.iter().any(|&k| mat.name.contains(k)) {
            soft_mat_indices.push(i);
        }
    }

    if soft_mat_indices.is_empty() {
        return;
    }

    // 定义核心承重骨骼关键字
    let core_keywords = [
        "上半身",
        "下半身",
        "腰",
        "胸",
        "頭",
        "首",
        "肩",
        "带_根",
        "结_根",
        "饰_根",
        "裙_根",
        "腕",
        "肘",
        "手",
        "足",
        "腿",
        "膝",
    ];
    let mut is_core = vec![false; bones.len()];
    for (i, b) in bones.iter().enumerate() {
        if core_keywords.iter().any(|&k| b.name.contains(k)) {
            is_core[i] = true;
        }
    }

    // 检测锚点骨骼（核心骨骼或其一两级子骨骼）
    let mut is_anchor = vec![false; bones.len()];
    for (i, b) in bones.iter().enumerate() {
        if is_core[i] {
            is_anchor[i] = true;
            continue;
        }
        let mut current_parent = b.parent;
        let mut depth = 1;
        while current_parent >= 0 && depth <= 1 {
            if is_core[current_parent as usize] {
                is_anchor[i] = true;
                break;
            }
            current_parent = bones[current_parent as usize].parent;
            depth += 1;
        }
    }

    // 收集属于软体材质的所有 PMX 顶点索引
    let mut soft_pmx_indices = std::collections::BTreeSet::new();
    for &mat_idx in &soft_mat_indices {
        for &idx in &face_groups[mat_idx].1 {
            soft_pmx_indices.insert(idx);
        }
    }

    let mut sb_vertices: Vec<f32> = Vec::new();
    let mut sb_inv_masses: Vec<f32> = Vec::new();
    let mut sb_indices: Vec<u32> = Vec::new();
    let mut pmx_to_sb_map = std::collections::HashMap::new();
    let mut root_sb_indices = Vec::new();
    let mut root_pmx_indices = Vec::new();

    let mut representative_pmx_indices = Vec::new();
    let mut sb_to_pmx_map: Vec<Vec<usize>> = Vec::new();
    let mut pos_to_sb = std::collections::HashMap::new();

    for &pmx_idx in &soft_pmx_indices {
        let v = &vertices[pmx_idx as usize];

        let qx = (v.position[0] * 1000.0).round() as i32;
        let qy = (v.position[1] * 1000.0).round() as i32;
        let qz = (v.position[2] * 1000.0).round() as i32;
        let q_pos = (qx, qy, qz);

        if let Some(&sb_idx) = pos_to_sb.get(&q_pos) {
            pmx_to_sb_map.insert(pmx_idx, sb_idx);
            sb_to_pmx_map[sb_idx as usize].push(pmx_idx as usize);
        } else {
            let current_sb_idx = (sb_vertices.len() / 3) as u32;
            pos_to_sb.insert(q_pos, current_sb_idx);
            pmx_to_sb_map.insert(pmx_idx, current_sb_idx);

            representative_pmx_indices.push(pmx_idx as usize);
            sb_to_pmx_map.push(vec![pmx_idx as usize]);

            sb_vertices.push(v.position[0]);
            sb_vertices.push(v.position[1]);
            sb_vertices.push(v.position[2]);

            // 评估是否被锚定（如果任意锚点骨骼权重大于 15%）
            let (bi, bw) = crate::animation::convert_vertex_weight(&v.weight_type);
            let mut is_anchored = false;
            for k in 0..4 {
                let bone_idx = bi[k];
                let weight = bw[k];
                if bone_idx >= 0
                    && (bone_idx as usize) < is_anchor.len()
                    && is_anchor[bone_idx as usize]
                {
                    if weight > 0.1 {
                        is_anchored = true;
                        break;
                    }
                }
            }

            if is_anchored {
                sb_inv_masses.push(0.0);
                root_sb_indices.push(current_sb_idx as i32);
                root_pmx_indices.push(pmx_idx as usize);
            } else {
                sb_inv_masses.push(1.0);
            }
        }
    }

    for &mat_idx in &soft_mat_indices {
        for chunk in face_groups[mat_idx].1.chunks_exact(3) {
            if let (Some(&v0), Some(&v1), Some(&v2)) = (
                pmx_to_sb_map.get(&chunk[0]),
                pmx_to_sb_map.get(&chunk[1]),
                pmx_to_sb_map.get(&chunk[2]),
            ) {
                sb_indices.push(v0);
                sb_indices.push(v1);
                sb_indices.push(v2);
            }
        }
    }

    if !sb_vertices.is_empty() && !sb_indices.is_empty() {
        unsafe {
            let physics_system =
                PHYSICS_SYSTEM_PTR.load(std::sync::atomic::Ordering::SeqCst) as *mut c_void;
            let soft_ptr = create_soft_body_from_mesh(
                sb_vertices.as_ptr(),
                (sb_vertices.len() / 3) as i32,
                sb_indices.as_ptr() as *const i32,
                sb_indices.len() as i32,
                sb_inv_masses.as_ptr(),
                physics_system,
            );

            if !soft_ptr.is_null() {
                commands.spawn((JoltSoftBody {
                    ptr: soft_ptr,
                    num_vertices: sb_vertices.len() / 3,
                    indices: sb_indices,
                },));

                info!(
                    "spawned hair softbody: pmx_verts={}, sb_verts={}, pinned_roots={}",
                    soft_pmx_indices.len(),
                    sb_vertices.len() / 3,
                    root_pmx_indices.len()
                );

                commands.insert_resource(HairPhysicsData {
                    ptr: soft_ptr,
                    root_pmx_indices,
                    root_sb_indices,
                    representative_pmx_indices,
                    sb_to_pmx_map,
                    is_initialized: false,
                });
            }
        }
    }
}
