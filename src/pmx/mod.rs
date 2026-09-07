use std::path::{Path, PathBuf};
use PMXUtil::reader::ModelInfoStage;
use PMXUtil::types::{MaterialFlags, SphereModeKind, ToonMode};

use bevy::asset::RenderAssetUsages;
use bevy::mesh::skinning::{SkinnedMesh, SkinnedMeshInverseBindposes};
use bevy::mesh::Indices;
use bevy::prelude::*;
use bevy::render::render_resource::PrimitiveTopology;

use crate::animation::{build_ik_constraints, convert_vertex_weight, group_faces_by_material};
use crate::components::*;
use crate::config::Config;
use crate::softbody;

fn is_soft_material(name: &str) -> bool {
    ["发", "髪", "毛", "裙", "衣", "披肩", "摆", "擺", "辫"]
        .iter()
        .any(|keyword| name.contains(keyword))
}

/// Loads a PMX file and builds all ECS resources: materials, meshes, skeleton, skinning data, and soft bodies.
pub fn init_pmx(
    commands: &mut Commands,
    asset_server: &Res<AssetServer>,
    meshes: &mut ResMut<Assets<Mesh>>,
    materials: &mut ResMut<Assets<PmxMaterial>>,
    inverse_bindposes: &mut ResMut<Assets<SkinnedMeshInverseBindposes>>,
    cfg: &Config,
) -> Result<(), String> {
    let pmx_file = &cfg.paths.pmx;
    let pmx_path = if Path::new(pmx_file).is_absolute() {
        pmx_file.to_string()
    } else {
        format!("assets/{}", pmx_file)
    };
    // PMXUtil exposes a panicking reader; complete parsing before changing ECS state.
    let parsed = std::panic::catch_unwind(|| {
        let loader = ModelInfoStage::open(pmx_path.clone())
            .ok_or_else(|| format!("Cannot open {pmx_path}"))?;
        let (_, ns) = loader.read();
        let (vertices, ns) = ns.read();
        let (faces, ns) = ns.read();
        let (textures, ns) = ns.read();
        let (materials, ns) = ns.read();
        let (bones, ns) = ns.read();
        let (morphs, ns) = ns.read();
        let (_, ns) = ns.read();
        let (rigids, _) = ns.read();
        Ok::<_, String>((vertices, faces, textures, materials, bones, morphs, rigids))
    })
    .map_err(|_| format!("Invalid PMX: {pmx_path}"))??;
    let (vertices, faces, textures, materials_pmx, bones, morphs, rigids) = parsed;
    if vertices.is_empty()
        || faces.iter().any(|f| {
            f.vertices
                .iter()
                .any(|&i| i < 0 || i as usize >= vertices.len())
        })
    {
        return Err("PMX contains empty geometry or invalid vertex indices".into());
    }

    if vertices.iter().any(|v| {
        v.position
            .iter()
            .chain(v.norm.iter())
            .any(|x| !x.is_finite())
    }) || bones.iter().any(|b| {
        b.parent < -1 || b.parent >= bones.len() as i32 || b.position.iter().any(|x| !x.is_finite())
    }) {
        return Err("PMX contains invalid bone or vertex data".into());
    }
    let mut order = Vec::with_capacity(bones.len());
    let mut visited = vec![false; bones.len()];
    let mut candidates: Vec<_> = (0..bones.len()).collect();
    candidates.sort_by_key(|&i| bones[i].deform_depth);
    while order.len() < bones.len() {
        let previous_len = order.len();
        for &i in &candidates {
            if !visited[i] && (bones[i].parent < 0 || visited[bones[i].parent as usize]) {
                visited[i] = true;
                order.push(i);
            }
        }
        if order.len() == previous_len {
            return Err("PMX bone hierarchy contains a cycle".into());
        }
    }

    // ═════════════════════════════════════════════════════════════════════════
    // Build global skinning data (PmxSharedSkin).
    let vcount = vertices.len();

    // Convert PMX VertexWeight variants to uniform (bone_indices[4], bone_weights[4]) representation.
    let skin_vertices: Vec<SkinVertex> = vertices
        .iter()
        .map(|v| {
            let (bi, bw) = convert_vertex_weight(&v.weight_type);
            SkinVertex {
                rest_position: Vec3::new(v.position[0], v.position[1], -v.position[2]),
                rest_normal: Vec3::new(v.norm[0], v.norm[1], -v.norm[2]),
                bone_indices: bi,
                bone_weights: bw,
            }
        })
        .collect();

    // Initialize skinned positions and normals to the bind pose.
    let init_positions: Vec<[f32; 3]> = skin_vertices
        .iter()
        .map(|sv| sv.rest_position.to_array())
        .collect();
    let init_normals: Vec<[f32; 3]> = skin_vertices
        .iter()
        .map(|sv| sv.rest_normal.to_array())
        .collect();

    commands.insert_resource(PmxSharedSkin {
        vertices: skin_vertices.clone(),
        skinned_positions: init_positions,
        skinned_normals: init_normals,
        previous_positions: skin_vertices
            .iter()
            .map(|vertex| vertex.rest_position.to_array())
            .collect(),
        physics_mask: vec![false; vcount],
    });

    // ═════════════════════════════════════════════════════════════════════════
    // Build skeleton and IK constraints.
    let bone_data: Vec<PmxBoneData> = bones
        .iter()
        .map(|b| {
            let append_rotation = match b.inherits.rotate_and_translate {
                PMXUtil::types::RotateAndTranslateInherits::Rotate(idx, weight) => {
                    if idx >= 0 {
                        Some((idx as usize, weight))
                    } else {
                        None
                    }
                }
                PMXUtil::types::RotateAndTranslateInherits::Both(idx, weight) => {
                    if idx >= 0 {
                        Some((idx as usize, weight))
                    } else {
                        None
                    }
                }
                _ => None,
            };

            PmxBoneData {
                name: b.name.clone(),
                rest_position: Vec3::new(b.position[0], b.position[1], -b.position[2]),
                parent: b.parent,
                append_rotation,
            }
        })
        .collect();

    let ik_constraints = build_ik_constraints(&bones);

    let mut morph_data = Vec::new();
    for m in morphs {
        if let PMXUtil::types::MorphKinds::Vertex(v_morphs) = m.morph_data {
            let offsets: Vec<PmxVertexMorph> = v_morphs
                .iter()
                .map(|vm| PmxVertexMorph {
                    index: vm.index as usize,
                    offset: Vec3::new(vm.offset[0], vm.offset[1], -vm.offset[2]),
                })
                .collect();
            morph_data.push(PmxMorphData {
                name: m.name.clone(),
                offsets,
            });
        }
    }

    let colliders = rigids
        .iter()
        .filter_map(|rigid| {
            if rigid.bone_index < 0 || rigid.bone_index as usize >= bone_data.len() {
                return None;
            }
            let bone = rigid.bone_index as usize;
            let position = Vec3::new(rigid.position[0], rigid.position[1], -rigid.position[2]);
            let size = Vec3::from(rigid.size).abs();
            if !size.is_finite() || !position.is_finite() {
                return None;
            }
            Some(PmxCollider {
                bone,
                offset: position - bone_data[bone].rest_position,
                rotation: Quat::from_euler(
                    EulerRot::XYZ,
                    -rigid.rotation[0],
                    -rigid.rotation[1],
                    rigid.rotation[2],
                ),
                size,
                kind: match rigid.form {
                    PMXUtil::types::RigidForm::Sphere => 0.0,
                    PMXUtil::types::RigidForm::Box => 1.0,
                    PMXUtil::types::RigidForm::Capsule => 2.0,
                },
            })
        })
        .collect();
    let mut collision_triangles = Vec::new();
    let mut collision_vertex_indices = Vec::new();
    let mut collision_lookup = std::collections::HashMap::<usize, u32>::new();
    let collision_center = skin_vertices
        .iter()
        .fold(Vec3::ZERO, |sum, vertex| sum + vertex.rest_position)
        / skin_vertices.len().max(1) as f32;
    let mut face_cursor = 0usize;
    for material in &materials_pmx {
        let triangle_count = (material.num_face_vertices / 3) as usize;
        if is_soft_material(&material.name) {
            face_cursor += triangle_count;
            continue;
        }
        for _ in 0..triangle_count {
            let face = &faces[face_cursor];
            let mut triangle_indices = [0u32; 3];
            for (corner, triangle_index) in triangle_indices.iter_mut().enumerate() {
                let vertex_index = face.vertices[corner] as usize;
                *triangle_index = *collision_lookup.entry(vertex_index).or_insert_with(|| {
                    let local_index = collision_vertex_indices.len() as u32;
                    collision_vertex_indices.push(vertex_index);
                    local_index
                });
            }
            // Keep a consistent outward winding so the native solver can
            // distinguish a point inside the closed shell from one outside.
            let rest_a = skin_vertices[face.vertices[0] as usize].rest_position;
            let rest_b = skin_vertices[face.vertices[1] as usize].rest_position;
            let rest_c = skin_vertices[face.vertices[2] as usize].rest_position;
            let edge_a = rest_b - rest_a;
            let edge_b = rest_c - rest_a;
            let face_normal = edge_a.cross(edge_b);
            let face_center = (rest_a + rest_b + rest_c) / 3.0;
            if face_normal.dot(face_center - collision_center) < 0.0 {
                triangle_indices.swap(1, 2);
            }
            collision_triangles.push(PmxCollisionTriangle {
                vertices: triangle_indices,
            });
            face_cursor += 1;
        }
    }
    let bone_entities: Vec<Entity> = (0..bone_data.len())
        .map(|index| {
            commands
                .spawn((
                    PmxBone { index },
                    Transform::default(),
                    GlobalTransform::default(),
                ))
                .id()
        })
        .collect();
    let inverse_bindposes_handle = inverse_bindposes.add(
        bone_data
            .iter()
            .map(|bone| Mat4::from_translation(-bone.rest_position))
            .collect::<Vec<_>>(),
    );
    commands.insert_resource(PmxSkeleton {
        bones: bone_data,
        order,
        ik_constraints,
        morphs: morph_data,
        colliders,
        collision_triangles,
        collision_vertex_indices,
    });

    // ═════════════════════════════════════════════════════════════════════════
    // Build Bevy material list.
    let model_dir = PathBuf::from(&cfg.paths.pmx)
        .parent()
        .expect("PMX path has no parent directory")
        .to_path_buf();
    let normalize_sep = |s: &str| s.replace('\\', "/");
    let mut bevy_materials_list = Vec::new();

    for mat in &materials_pmx {
        let base_texture =
            if mat.texture_index >= 0 && (mat.texture_index as usize) < textures.len() {
                let name = normalize_sep(&textures[mat.texture_index as usize]);
                Some(asset_server.load(model_dir.join(name)))
            } else {
                None
            };

        let (sphere_texture, sphere_mode) = match mat.sphere_mode {
            Some(mode) if mode.index >= 0 && (mode.index as usize) < textures.len() => {
                let name = normalize_sep(&textures[mode.index as usize]);
                let m = match mode.kind {
                    SphereModeKind::Mul => 1,
                    SphereModeKind::Add => 2,
                    SphereModeKind::SubTexture => 0,
                };
                (Some(asset_server.load(model_dir.join(name))), m)
            }
            _ => (None, 0),
        };

        let toon_texture = match mat.toon_mode {
            ToonMode::Separate(i) if i >= 0 && (i as usize) < textures.len() => {
                let name = normalize_sep(&textures[i as usize]);
                Some(asset_server.load(model_dir.join(name)))
            }
            ToonMode::Common(i) => {
                let name = format!("toon{:02}.bmp", u32::from(i) + 1);
                let asset_path = model_dir.join(name);
                let disk_path = if asset_path.is_absolute() {
                    asset_path.clone()
                } else {
                    Path::new("assets").join(&asset_path)
                };
                disk_path.is_file().then(|| asset_server.load(asset_path))
            }
            _ => None,
        };

        let has_edge = mat.draw_mode.contains(MaterialFlags::HAS_EDGE);
        let use_toon = toon_texture.is_some();

        bevy_materials_list.push(materials.add(PmxMaterial {
            base_color_texture: base_texture,
            sphere_texture,
            toon_texture,
            uniform: PmxUniform {
                diffuse: Vec4::from(mat.diffuse),
                ambient: Vec4::new(mat.ambient[0], mat.ambient[1], mat.ambient[2], 1.0),
                edge_color: Vec4::from(mat.edge_color),
                flags: UVec4::new(sphere_mode, 0, u32::from(has_edge), u32::from(use_toon)),
                emissive_strength: cfg.render.global_emissive_strength,
                _pad0: Vec3::ZERO,
            },
        }));
    }

    // Each sub-mesh stores only the vertices referenced by its material faces.
    // PmxSharedSkin keeps the global PMX skin result used to update these local
    // mesh buffers without duplicating the complete model for every material.
    let face_groups = group_faces_by_material(&faces, &materials_pmx);

    let init_positions: Vec<[f32; 3]> = (0..vcount)
        .map(|i| {
            let v = &vertices[i];
            Vec3::new(v.position[0], v.position[1], -v.position[2]).to_array()
        })
        .collect();
    let init_normals: Vec<[f32; 3]> = (0..vcount)
        .map(|i| {
            Vec3::new(
                vertices[i].norm[0],
                vertices[i].norm[1],
                -vertices[i].norm[2],
            )
            .to_array()
        })
        .collect();
    let init_uvs: Vec<[f32; 2]> = vertices.iter().map(|v| v.uv).collect();

    for (mat_index, face_indices) in face_groups.clone() {
        let double_sided = materials_pmx[mat_index]
            .draw_mode
            .contains(MaterialFlags::DISABLE_CULLING);

        let mut pmx_vertex_indices = Vec::new();
        let mut local_lookup = std::collections::HashMap::<u32, u32>::new();
        let mut local_face_indices = Vec::with_capacity(face_indices.len());
        for &global_index in &face_indices {
            let local_index = if let Some(&index) = local_lookup.get(&global_index) {
                index
            } else {
                let index = pmx_vertex_indices.len() as u32;
                local_lookup.insert(global_index, index);
                pmx_vertex_indices.push(global_index as usize);
                index
            };
            local_face_indices.push(local_index);
        }

        let mut flipped_indices = Vec::with_capacity(local_face_indices.len());
        for tri in local_face_indices.as_chunks::<3>().0 {
            flipped_indices.push(tri[0]);
            flipped_indices.push(tri[2]);
            flipped_indices.push(tri[1]);
        }
        let final_indices: Vec<u32> = if double_sided {
            let mut doubled = Vec::with_capacity(local_face_indices.len() * 2);
            doubled.extend_from_slice(&flipped_indices);
            doubled.extend_from_slice(&local_face_indices);
            doubled
        } else {
            flipped_indices
        };

        let soft_material = is_soft_material(&materials_pmx[mat_index].name);

        let mut mesh = Mesh::new(
            PrimitiveTopology::TriangleList,
            RenderAssetUsages::default(),
        );
        mesh.insert_attribute(
            Mesh::ATTRIBUTE_POSITION,
            pmx_vertex_indices
                .iter()
                .map(|&index| init_positions[index])
                .collect::<Vec<_>>(),
        );
        mesh.insert_attribute(
            Mesh::ATTRIBUTE_NORMAL,
            pmx_vertex_indices
                .iter()
                .map(|&index| init_normals[index])
                .collect::<Vec<_>>(),
        );
        mesh.insert_attribute(
            Mesh::ATTRIBUTE_UV_0,
            pmx_vertex_indices
                .iter()
                .map(|&index| init_uvs[index])
                .collect::<Vec<_>>(),
        );
        if !soft_material {
            mesh.insert_attribute(
                Mesh::ATTRIBUTE_JOINT_INDEX,
                bevy::mesh::VertexAttributeValues::Uint16x4(
                    pmx_vertex_indices
                        .iter()
                        .map(|&index| &skin_vertices[index])
                        .map(|v| {
                            [
                                v.bone_indices[0].max(0) as u16,
                                v.bone_indices[1].max(0) as u16,
                                v.bone_indices[2].max(0) as u16,
                                v.bone_indices[3].max(0) as u16,
                            ]
                        })
                        .collect::<Vec<_>>(),
                ),
            );
            mesh.insert_attribute(
                Mesh::ATTRIBUTE_JOINT_WEIGHT,
                pmx_vertex_indices
                    .iter()
                    .map(|&index| skin_vertices[index].bone_weights)
                    .collect::<Vec<_>>(),
            );
        }
        mesh.insert_indices(Indices::U32(final_indices));

        let mesh_handle = meshes.add(mesh);

        let mut entity = commands.spawn((
            Mesh3d(mesh_handle),
            MeshMaterial3d(bevy_materials_list[mat_index].clone()),
            Transform::default(),
            bevy::camera::visibility::NoFrustumCulling,
            SubMeshInfo { pmx_vertex_indices },
        ));
        if soft_material {
            entity.insert(CpuDeformed);
        } else {
            entity.insert(SkinnedMesh {
                inverse_bindposes: inverse_bindposes_handle.clone(),
                joints: bone_entities.clone(),
            });
        }
    }

    commands.remove_resource::<HairPhysicsData>();
    // Delegate soft-body creation (hair, skirt) to the softbody module.
    softbody::spawn_hair_from_pmx(
        commands,
        &vertices,
        &materials_pmx,
        &face_groups,
        &bones,
        &cfg.softbody,
    );
    Ok(())
}
