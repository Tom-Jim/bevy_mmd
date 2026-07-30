use bevy::prelude::*;
use std::ffi::c_void;

use PMXUtil::types::{Bone, Face, Material, Vertex};

use crate::components::{HairPhysicsData, JoltSoftBody};
use crate::physics::{create_soft_body_from_mesh, PHYSICS_SYSTEM_PTR};

/// Spawns a simple hanging flag soft-body for demonstration purposes.
pub fn spawn_flag_softbody(commands: &mut Commands) {
    let grid_size = 15;
    let width = 10.0;
    let height = 10.0;
    let offset = Vec3::new(10.0, 15.0, 0.0);

    let mut flag_vertices = Vec::with_capacity(grid_size * grid_size * 3);
    let mut flag_inv_masses = Vec::with_capacity(grid_size * grid_size);
    let mut flag_indices = Vec::new();

    // Build vertex grid and inverse masses.
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

    // Build triangle index buffer.
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

/// Builds a physics soft-body mesh from PMX hair/cloth materials and registers it in the ECS.
/// On success, inserts `HairPhysicsData` resource and spawns a `JoltSoftBody` entity.
pub fn spawn_hair_from_pmx(
    commands: &mut Commands,
    vertices: &Vec<Vertex>,
    _faces: &Vec<Face>,
    materials_pmx: &Vec<Material>,
    face_groups: &Vec<(usize, Vec<u32>)>,
    bones: &Vec<Bone>,
) {
    // All soft-body and accessory keywords, including lining and name-tag meshes.
    let soft_keywords = [
        "发",
        "髪",
        "毛",
        "裙",
        "衣",
        "披肩",
        "摆",
        "擺",
        "辫",
        "辮",
        "羽",
        "链",
        "鏈",
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
        "流苏",
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

    // Materials that match soft_keywords but must NOT form a physics mesh
    // (rigid accessories, shoes, gloves, ear parts, butterflies).
    let exclude_keywords = ["衣饰", "衣飾", "鞋", "手套", "耳", "蝶"];

    // Accessories are attached to the nearest main soft-body particle rather
    // than forming their own physics mesh (e.g., name tags, lining panels,
    // hair accessories that follow hair motion).
    let accessory_keywords = [
        "biaoq",
        "内著",
        "內著",
        "衣金屬",
        "腰飾",
        "发饰",
        "髪飾",
        "发饰+",
        "髪飾+",
    ];

    let mut main_mat_indices = Vec::new();
    let mut acc_mat_indices = Vec::new();

    for (i, mat) in materials_pmx.iter().enumerate() {
        if accessory_keywords.iter().any(|&k| mat.name.contains(k)) {
            acc_mat_indices.push(i);
        } else if soft_keywords.iter().any(|&k| mat.name.contains(k)) {
            if !exclude_keywords.iter().any(|&k| mat.name.contains(k)) {
                main_mat_indices.push(i);
            }
        }
    }

    if main_mat_indices.is_empty() && acc_mat_indices.is_empty() {
        return;
    }

    // Core load-bearing bone keywords — vertices anchored to these are pinned.
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
        "裙_0",
        "後擺_根",
        "後擺1-1",
        "後擺2-1",
        "後擺3-1",
        "後擺4-1",
        "後擺5-1",
        "後擺6-1",
        "後擺7-1",
        "飘带_0",
        "飄帶_0",
        "腕",
        "肘",
        "手",
        "足",
        "腿",
        "膝",
        "花",
        "結",
        "结",
        "帶1-1",
    ];

    let mut is_core = vec![false; bones.len()];
    for (i, b) in bones.iter().enumerate() {
        if core_keywords.iter().any(|&k| b.name.contains(k)) {
            is_core[i] = true;
        }
    }

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

    let mut vertex_to_mat = std::collections::HashMap::new();
    for &mat_idx in main_mat_indices.iter().chain(acc_mat_indices.iter()) {
        for &idx in &face_groups[mat_idx].1 {
            vertex_to_mat.insert(idx, mat_idx);
        }
    }

    // Build main soft-body physics particles.
    let mut sb_vertices: Vec<f32> = Vec::new();
    let mut sb_inv_masses: Vec<f32> = Vec::new();
    let mut sb_indices: Vec<u32> = Vec::new();
    let mut pmx_to_sb_map = std::collections::HashMap::new();
    let mut root_sb_indices = Vec::new();
    let mut root_pmx_indices = Vec::new();
    let mut representative_pmx_indices = Vec::new();
    let mut sb_to_pmx_map: Vec<Vec<(usize, Vec3)>> = Vec::new();
    let mut pos_to_sb = std::collections::HashMap::new();

    let mut main_pmx_indices = std::collections::BTreeSet::new();
    for &mat_idx in &main_mat_indices {
        for &idx in &face_groups[mat_idx].1 {
            main_pmx_indices.insert(idx);
        }
    }

    let hair_keywords = ["发", "髪", "毛", "辫", "辮", "ヘア"];
    let mut is_hair_mat = std::collections::HashMap::new();
    for &mat_idx in &main_mat_indices {
        let name = &materials_pmx[mat_idx].name;
        is_hair_mat.insert(mat_idx, hair_keywords.iter().any(|&k| name.contains(k)));
    }

    for &pmx_idx in &main_pmx_indices {
        let v = &vertices[pmx_idx as usize];
        let mat_idx = vertex_to_mat.get(&(pmx_idx as u32)).copied().unwrap_or(0);
        let is_hair = is_hair_mat.get(&mat_idx).copied().unwrap_or(false);

        let qx = (v.position[0] * 100000.0).round() as i32;
        let qy = (v.position[1] * 100000.0).round() as i32;
        let qz = ((-v.position[2]) * 100000.0).round() as i32;

        // Hair materials must be segregated by material index so front and back
        // strands are not welded together — cross-welding causes violent jitter.
        let q_pos = if is_hair {
            (qx, qy, qz, mat_idx as i32)
        } else {
            // Cloth shares a single key so overlapping seam vertices are welded.
            (qx, qy, qz, -1)
        };

        let (bi, bw) = crate::animation::convert_vertex_weight(&v.weight_type);
        let mut is_anchored = false;
        for k in 0..4 {
            if bi[k] >= 0 && (bi[k] as usize) < is_anchor.len() && is_anchor[bi[k] as usize] {
                if bw[k] > 0.3 {
                    is_anchored = true;
                    break;
                }
            }
        }

        if let Some(&sb_idx) = pos_to_sb.get(&q_pos) {
            pmx_to_sb_map.insert(pmx_idx, sb_idx);

            // 计算相对偏移
            let sx = sb_vertices[sb_idx as usize * 3];
            let sy = sb_vertices[sb_idx as usize * 3 + 1];
            let sz = sb_vertices[sb_idx as usize * 3 + 2];
            let offset = Vec3::new(v.position[0] - sx, v.position[1] - sy, -v.position[2] - sz);

            sb_to_pmx_map[sb_idx as usize].push((pmx_idx as usize, offset));

            if is_anchored && sb_inv_masses[sb_idx as usize] != 0.0 {
                sb_inv_masses[sb_idx as usize] = 0.0;
                root_sb_indices.push(sb_idx as i32);
                root_pmx_indices.push(pmx_idx as usize);
            }
        } else {
            let current_sb_idx = (sb_vertices.len() / 3) as u32;
            pos_to_sb.insert(q_pos, current_sb_idx);
            pmx_to_sb_map.insert(pmx_idx, current_sb_idx);

            representative_pmx_indices.push(pmx_idx as usize);
            sb_to_pmx_map.push(vec![(pmx_idx as usize, Vec3::ZERO)]);

            sb_vertices.push(v.position[0]);
            sb_vertices.push(v.position[1]);
            sb_vertices.push(-v.position[2]);

            if is_anchored {
                sb_inv_masses.push(0.0);
                root_sb_indices.push(current_sb_idx as i32);
                root_pmx_indices.push(pmx_idx as usize);
            } else {
                sb_inv_masses.push(1.0);
            }
        }
    }

    for &mat_idx in &main_mat_indices {
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

    // Attach accessories to the nearest main soft-body particle.
    let mut acc_pmx_indices = std::collections::BTreeSet::new();
    for &mat_idx in &acc_mat_indices {
        for &idx in &face_groups[mat_idx].1 {
            acc_pmx_indices.insert(idx);
        }
    }

    if sb_vertices.is_empty() {
        return;
    }

    let acc_hair_keywords = ["发", "髪", "毛", "耳", "ヘア"];
    for &pmx_idx in &acc_pmx_indices {
        let v = &vertices[pmx_idx as usize];
        let vx = v.position[0];
        let vy = v.position[1];
        let vz = -v.position[2];
        let mat_idx = vertex_to_mat.get(&(pmx_idx as u32)).copied().unwrap_or(0);
        let mat_name = &materials_pmx[mat_idx].name;
        let is_acc_hair = acc_hair_keywords.iter().any(|&k| mat_name.contains(k));

    // Find the nearest main soft-body particle.
    let mut min_dist_sq = f32::MAX;
        let mut nearest_sb_idx = 0;

        // Linear search is acceptable here — this runs only once at startup.
        for i in 0..(sb_vertices.len() / 3) {
            // Match hair accessories to hair particles and cloth accessories to cloth particles;
            // cross-type attachment would cause cloth to pull hair or decorations to teleport.
            let sb_pmx = sb_to_pmx_map[i][0].0;
            let sb_mat_idx = vertex_to_mat.get(&(sb_pmx as u32)).copied().unwrap_or(0);
            let sb_is_hair = is_hair_mat.get(&sb_mat_idx).copied().unwrap_or(false);

            if is_acc_hair != sb_is_hair {
                continue; // cross-type attachment causes cloth to pull hair or decorations to teleport
            }

            let sx = sb_vertices[i * 3];
            let sy = sb_vertices[i * 3 + 1];
            let sz = sb_vertices[i * 3 + 2];
            let dist_sq = (vx - sx).powi(2) + (vy - sy).powi(2) + (vz - sz).powi(2);
            if dist_sq < min_dist_sq {
                min_dist_sq = dist_sq;
                nearest_sb_idx = i as u32;
            }
        }

        if min_dist_sq == f32::MAX {
            // Fallback: global search when no same-type particle exists nearby.
            for i in 0..(sb_vertices.len() / 3) {
                let sx = sb_vertices[i * 3];
                let sy = sb_vertices[i * 3 + 1];
                let sz = sb_vertices[i * 3 + 2];
                let dist_sq = (vx - sx).powi(2) + (vy - sy).powi(2) + (vz - sz).powi(2);
                if dist_sq < min_dist_sq {
                    min_dist_sq = dist_sq;
                    nearest_sb_idx = i as u32;
                }
            }
        }

        pmx_to_sb_map.insert(pmx_idx, nearest_sb_idx);

        let sx = sb_vertices[nearest_sb_idx as usize * 3];
        let sy = sb_vertices[nearest_sb_idx as usize * 3 + 1];
        let sz = sb_vertices[nearest_sb_idx as usize * 3 + 2];
        let offset = Vec3::new(vx - sx, vy - sy, vz - sz);

        sb_to_pmx_map[nearest_sb_idx as usize].push((pmx_idx as usize, offset));
    }

    // Fix isolated components that lack any anchor vertex.
    let num_sb_verts = sb_vertices.len() / 3;
    let mut adj = vec![Vec::new(); num_sb_verts];
    for chunk in sb_indices.chunks_exact(3) {
        let (v0, v1, v2) = (chunk[0] as usize, chunk[1] as usize, chunk[2] as usize);
        adj[v0].push(v1);
        adj[v0].push(v2);
        adj[v1].push(v0);
        adj[v1].push(v2);
        adj[v2].push(v0);
        adj[v2].push(v1);
    }

    let mut visited = vec![false; num_sb_verts];
    for i in 0..num_sb_verts {
        if !visited[i] {
            let mut comp = Vec::new();
            let mut stack = vec![i];
            visited[i] = true;
            let mut has_anchor = false;
            while let Some(curr) = stack.pop() {
                comp.push(curr);
                if sb_inv_masses[curr] == 0.0 {
                    has_anchor = true;
                }
                for &neighbor in &adj[curr] {
                    if !visited[neighbor] {
                        visited[neighbor] = true;
                        stack.push(neighbor);
                    }
                }
            }
    // Fix isolated connected components that have no anchor: pin small fragments
    // only (< 300 verts). Pinning a large mesh (thousands of verts) would freeze
    // the entire cloth into a rigid board, which is wrong.
    if !has_anchor && comp.len() < 300 {
                for &curr in &comp {
                    sb_inv_masses[curr] = 0.0;
                    root_sb_indices.push(curr as i32);
                    root_pmx_indices.push(sb_to_pmx_map[curr][0].0);
                }
            }
        }
    }

    if !sb_vertices.is_empty() && !sb_indices.is_empty() {
        unsafe {
            let physics_system =
                PHYSICS_SYSTEM_PTR.load(std::sync::atomic::Ordering::SeqCst) as *mut c_void;
            let soft_ptr = crate::physics::create_soft_body_from_mesh(
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
                    "spawned softbody: main_verts={}, acc_verts={}, physics_verts={}, pinned_roots={}",
                    main_pmx_indices.len(),
                    acc_pmx_indices.len(),
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
