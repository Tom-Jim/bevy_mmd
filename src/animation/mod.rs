use bevy::prelude::*;

use PMXUtil::types::{Bone, Face, Material, VertexWeight};

use crate::components::{
    CpuDeformed, HairPhysicsData, IkConstraint, IkLinkData, PmxBone, PmxBoneData, PmxSharedSkin,
    PmxSkeleton, SubMeshInfo, VmdPlayback,
};
use crate::physics::{
    get_soft_body_vertices, step_physics, update_soft_body_roots, PHYSICS_SYSTEM_PTR,
};

/// Per-frame animation pipeline: advance playback, sample VMD, solve FK/IK, and update GPU joints.
/// CPU skinning is limited to vertices consumed by the native soft-body bridge.
pub fn skin_update_system(
    time: Res<Time<Fixed>>,
    mut playback: Option<ResMut<VmdPlayback>>,
    skeleton: Option<Res<PmxSkeleton>>,
    mut shared_skin: Option<ResMut<PmxSharedSkin>>,
    hair_data: Option<ResMut<HairPhysicsData>>,
    cfg: Res<crate::config::Config>,
    mut bone_query: Query<(&PmxBone, &mut Transform)>,
) {
    let (Some(pb), Some(skel), Some(skin)) =
        (playback.as_mut(), skeleton.as_ref(), shared_skin.as_mut())
    else {
        return;
    };

    // Advance playback time.
    let previous_time = pb.time_sec;
    pb.time_sec += time.delta_secs();
    let duration_sec = pb.clip.duration_frames as f32 / pb.fps;
    if duration_sec > 0.0 {
        pb.time_sec %= duration_sec;
    }
    let t = pb.time_sec;
    let fps = pb.fps;
    let n = skel.bones.len();
    let physics_indices = hair_data.as_ref().map(|hair| {
        hair.sb_to_pmx_map
            .iter()
            .flatten()
            .copied()
            .collect::<std::collections::HashSet<_>>()
    });

    // Sample VMD local transforms.
    // VMD stores each bone's delta from its rest pose:
    //   local_translation: additional displacement relative to rest_position
    //   local_rotation:    rotation layered on top of the bind pose
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

    // FK: propagate world transforms parent → child.
    // Formula (P = parent, C = child):
    //   C.world_rot = P.world_rot * C.local_rot
    //   C.world_pos = P.world_pos + P.world_rot * (rest_offset + C.local_t)
    //   rest_offset = C.rest_pos - P.rest_pos  (fixed in bind pose)
    let mut world_pos = vec![Vec3::ZERO; n];
    let mut world_rot = vec![Quat::IDENTITY; n];

    for &i in &skel.order {
        let bone = &skel.bones[i];
        let p = bone.parent;

        let mut final_local_r = local_r[i];
        if let Some((app_idx, weight)) = bone.append_rotation {
            if app_idx < n {
                let app_r = Quat::IDENTITY.slerp(local_r[app_idx], weight);
                final_local_r = (final_local_r * app_r).normalize();
            }
        }

        // Store the updated local rotation so downstream IK can read it.
        local_r[i] = final_local_r;

        if p < 0 || p as usize >= n {
            // root bone
            world_pos[i] = bone.rest_position + local_t[i];
            world_rot[i] = final_local_r;
        } else {
            let p = p as usize;
            let rest_offset = bone.rest_position - skel.bones[p].rest_position;
            world_pos[i] = world_pos[p] + world_rot[p] * (rest_offset + local_t[i]);
            world_rot[i] = (world_rot[p] * final_local_r).normalize();
        }
    }

    // IK: CCD (Cyclic Coordinate Descent) solver.
    // Each step, for every link bone from end-effector toward root:
    //   to_end    = normalize(effector_pos - link_pos)
    //   to_target = normalize(ik_target_pos - link_pos)
    //   delta     = from_rotation_arc(to_end, to_target)
    //   delta     = clamp_rotation(delta, limit_angle)   // prevents per-step jitter
    //   link.world_rot = delta * link.world_rot
    //   if angle limits: convert to local space → clamp Euler angles → convert back
    //   propagate: recompute world transforms for all descendants
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
        let target = world_pos[ik.ik_bone_idx]; // IK target (includes VMD displacement)
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
                // Knee joints are constrained to forward-only bend.
                let new_rot = if let Some((mn, mx)) = link.angle_limit {
                    let local_rot = (parent_rot.inverse() * new_rot).normalize();
                    let clamped = clamp_euler(local_rot, mn, mx);
                    (parent_rot * clamped).normalize()
                } else {
                    new_rot
                };
                world_rot[li] = new_rot;
                local_r[li] = (parent_rot.inverse() * new_rot).normalize();

                // Propagate rotation change to all descendants.
                propagate(
                    &skel.bones,
                    &skel.order,
                    li,
                    &local_t,
                    &local_r,
                    &mut world_pos,
                    &mut world_rot,
                );
            }
        }
    }

    // Keep animated positions only for soft-body vertices. Rigid meshes use Bevy's WGSL skinning.
    let mut animated_positions = std::collections::HashMap::<usize, Vec3>::new();
    if let Some(indices) = physics_indices.as_ref() {
        // Build skin matrices only when the native soft-body bridge needs CPU targets.
        let skin_mats: Vec<Mat4> = (0..n)
            .map(|i| {
                Mat4::from_rotation_translation(world_rot[i], world_pos[i])
                    * Mat4::from_translation(-skel.bones[i].rest_position)
            })
            .collect();

        // Apply morphs only to the subset consumed by soft-body physics.
        let mut morphed_positions =
            std::collections::HashMap::<usize, Vec3>::with_capacity(indices.len());
        for &vi in indices {
            if let Some(vertex) = skin.vertices.get(vi) {
                morphed_positions.insert(vi, vertex.rest_position);
            }
        }
        for morph in &skel.morphs {
            if let Some(weight) = pb.clip.sample_morph_at_seconds(&morph.name, t, fps) {
                if weight.abs() > 1e-4 {
                    for vm in &morph.offsets {
                        if let Some(position) = morphed_positions.get_mut(&vm.index) {
                            *position += vm.offset * weight;
                        }
                    }
                }
            }
        }

        animated_positions.reserve(indices.len());
        for &vi in indices {
            let Some(sv) = skin.vertices.get(vi) else {
                continue;
            };
            let rest_position = sv.rest_position;
            let morphed_position = morphed_positions.get(&vi).copied().unwrap_or(rest_position);
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
                pos += m.transform_point3(morphed_position) * bw;
                nor += m.transform_vector3(sv.rest_normal) * bw;
                wsum += bw;
            }
            if wsum > 0.0 && (wsum - 1.0).abs() > 1e-4 {
                pos /= wsum;
                nor /= wsum;
            }
            if wsum <= 0.0 {
                pos = morphed_position;
                nor = sv.rest_normal;
            }
            animated_positions.insert(vi, pos);
            skin.skinned_positions[vi] = pos.to_array();
            skin.skinned_normals[vi] = nor.normalize_or_zero().to_array();
        }
    }
    for (bone, mut transform) in &mut bone_query {
        if bone.index < n {
            transform.translation = world_pos[bone.index];
            transform.rotation = world_rot[bone.index];
            transform.scale = Vec3::ONE;
        }
    }
    if let Some(mut hair) = hair_data {
        let is_first = if !hair.is_initialized || pb.time_sec < previous_time {
            1
        } else {
            0
        };

        // Each frame, feed the full set of target skinned positions to the physics engine.
        let num_sb_verts = hair.representative_pmx_indices.len();
        let mut all_positions = Vec::with_capacity(num_sb_verts * 3);
        let mut all_sb_indices = Vec::with_capacity(num_sb_verts);

        for (sb_idx, &pmx_idx) in hair.representative_pmx_indices.iter().enumerate() {
            let pos = animated_positions
                .get(&pmx_idx)
                .copied()
                .unwrap_or(skin.vertices[pmx_idx].rest_position);
            all_positions.extend_from_slice(&pos.to_array());
            all_sb_indices.push(sb_idx as i32);
        }

        unsafe {
            let physics_system = PHYSICS_SYSTEM_PTR.load(std::sync::atomic::Ordering::SeqCst);
            update_soft_body_roots(
                physics_system,
                hair.ptr,
                all_positions.as_ptr(),
                all_sb_indices.as_ptr(),
                all_sb_indices.len() as i32,
                is_first, // 1 = teleport vertices, 0 = apply pull force
                time.delta_secs(),
                cfg.softbody.position_pull,
                cfg.softbody.velocity_pull,
                cfg.softbody.damping,
                cfg.softbody.max_speed,
            );

            step_physics(time.delta_secs());
            let mut capsules = Vec::with_capacity(skel.colliders.len() * 11);
            for collider in &skel.colliders {
                let rotation = world_rot[collider.bone];
                let center = world_pos[collider.bone] + rotation * collider.offset;
                capsules.extend_from_slice(&center.to_array());
                capsules.extend_from_slice(&(rotation * collider.rotation).to_array());
                let mut size = collider.size;
                if collider.kind == 1.0 {
                    size += Vec3::splat(cfg.softbody.collision_margin);
                } else {
                    size.x += cfg.softbody.collision_margin;
                }
                capsules.extend_from_slice(&size.to_array());
                capsules.push(collider.kind);
            }
            crate::physics::constrain_soft_body(
                physics_system,
                hair.ptr,
                capsules.as_ptr(),
                (capsules.len() / 11) as i32,
                all_positions.as_ptr(),
                cfg.softbody.max_distance,
            );

            // Read back physics-computed positions and overwrite the skinned result.
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

                for &pmx_idx in &hair.sb_to_pmx_map[sb_idx] {
                    if pmx_idx < skin.skinned_positions.len() {
                        // Overwrite skinned position with physics result, adding the
                        // per-vertex offset to preserve cloth thickness at seams.
                        let representative = hair.representative_pmx_indices[sb_idx];
                        let animated_offset = animated_positions
                            .get(&pmx_idx)
                            .copied()
                            .unwrap_or(skin.vertices[pmx_idx].rest_position)
                            - animated_positions
                                .get(&representative)
                                .copied()
                                .unwrap_or(skin.vertices[representative].rest_position);
                        skin.skinned_positions[pmx_idx] =
                            (Vec3::new(px, py, pz) + animated_offset).to_array();
                    }
                }
            }
        }
        hair.is_initialized = true;
    }
}

/// Copies the shared skin result into each sub-mesh Asset.
/// Runs after `skin_update_system` (enforced via `.chain()`).
/// All sub-meshes share the same vertex range (0..vcount), so this is a
/// per-mesh memcpy rather than a second skinning pass — roughly 50× faster.
pub fn apply_skin_to_meshes(
    shared_skin: Option<Res<PmxSharedSkin>>,
    mesh_query: Query<(&SubMeshInfo, &Mesh3d), With<CpuDeformed>>,
    mut mesh_assets: ResMut<Assets<Mesh>>,
) {
    let Some(skin) = shared_skin.as_ref() else {
        return;
    };

    for (info, mesh3d) in &mesh_query {
        let Some(mut mesh) = mesh_assets.get_mut(&mesh3d.0) else {
            continue;
        };
        let start = info.vertex_start;
        let end = info.vertex_end.min(skin.skinned_positions.len());
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

/// Extracts all IK constraints from the PMX bone list.
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

/// Propagates a bone rotation change to all descendants.
fn propagate(
    bones: &[PmxBoneData],
    order: &[usize],
    changed: usize,
    local_t: &[Vec3],
    local_r: &[Quat],
    world_pos: &mut [Vec3],
    world_rot: &mut [Quat],
) {
    let n = bones.len();
    let mut dirty = vec![false; n];
    dirty[changed] = true;
    for &i in order {
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

/// Returns the world rotation of the parent bone, or identity for root bones.
fn parent_world_rot(bones: &[PmxBoneData], idx: usize, world_rot: &[Quat]) -> Quat {
    let p = bones[idx].parent;
    if p < 0 || p as usize >= bones.len() {
        Quat::IDENTITY
    } else {
        world_rot[p as usize]
    }
}

/// Clamps a quaternion's rotation angle to `max_angle` radians to prevent large per-step CCD jumps.
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

/// Clamps a quaternion to [min_ang, max_ang] Euler angles; used for joint angle limits.
fn clamp_euler(q: Quat, min_ang: Vec3, max_ang: Vec3) -> Quat {
    let e = quat_to_euler_xyz(q);
    euler_xyz_to_quat(Vec3::new(
        e.x.clamp(min_ang.x, max_ang.x),
        e.y.clamp(min_ang.y, max_ang.y),
        e.z.clamp(min_ang.z, max_ang.z),
    ))
}

/// Converts a quaternion to XYZ Euler angles in radians.
fn quat_to_euler_xyz(q: Quat) -> Vec3 {
    let (x, y, z, w) = (q.x, q.y, q.z, q.w);
    Vec3::new(
        (2.0 * (w * x + y * z)).atan2(1.0 - 2.0 * (x * x + y * y)),
        (2.0 * (w * y - z * x)).clamp(-1.0, 1.0).asin(),
        (2.0 * (w * z + x * y)).atan2(1.0 - 2.0 * (y * y + z * z)),
    )
}

/// Converts XYZ Euler angles (radians) to a quaternion.
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
