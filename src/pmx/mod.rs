use std::io::Write;
use std::path::{Path, PathBuf};
use PMXUtil::reader::ModelInfoStage;
use PMXUtil::types::{MaterialFlags, SphereModeKind, ToonMode};

use bevy::asset::RenderAssetUsages;
use bevy::mesh::Indices;
use bevy::prelude::*;
use bevy::render::render_resource::PrimitiveTopology;

use crate::animation::{
    build_ik_constraints, convert_vertex_weight, format_vertex_weight, group_faces_by_material,
};
use crate::components::*;
use crate::config::Config;
use crate::softbody;

// PMX 日志路径（写入到 src/pmx/pmx_info.txt）
const PMX_LOG_PATH: &str = "src/pmx/pmx_info.txt";

/// 加载 PMX 文件并在 ECS 中构建材质/网格/蒙皮/骨架等资源。
/// 这个函数将 PMX 特有的职责封装在 `pmx` 模块中，并在需要时委托软体创建给 `softbody` 模块。
pub fn init_pmx(
    commands: &mut Commands,
    asset_server: &Res<AssetServer>,
    meshes: &mut ResMut<Assets<Mesh>>,
    materials: &mut ResMut<Assets<PmxMaterial>>,
    cfg: &Config,
) {
    // ── 打开 PMX 文件 ─────────────────────────────────────────────────────────
    let pmx_file = &cfg.paths.pmx;
    let pmx_path = if Path::new(pmx_file).is_absolute() {
        pmx_file.to_string()
    } else {
        format!("assets/{}", pmx_file)
    };
    let loader = ModelInfoStage::open(pmx_path.clone())
        .unwrap_or_else(|| panic!("无法加载 PMX：{}", pmx_path));
    // ── PMX 信息写入文件（写入到 src/pmx/pmx_info.txt） ─────────────────────────
    // ── 使用 BufWriter 加速写入 ──────────────────────────────────────────
    let raw_file = std::fs::File::create(PMX_LOG_PATH)
        .unwrap_or_else(|e| panic!("无法创建 {}: {}", PMX_LOG_PATH, e));
    let mut pmx_log = std::io::BufWriter::new(raw_file);

    // 为了方便，定义一个宏来处理 writeln 错误
    macro_rules! wln {
        () => { if let Err(e) = writeln!(pmx_log) { eprintln!("[write_pmx_info] 写入失败: {}", e); } };
        ($($arg:tt)*) => { if let Err(e) = writeln!(pmx_log, $($arg)*) { eprintln!("[write_pmx_info] 写入失败: {}", e); } };
    }

    // [1] Header
    let header = loader.get_header();
    wln!("═══ [1] Header ═══");
    wln!(
        "  version={:?}  encode={:?}  additional_uv={}",
        header.version,
        header.encode,
        header.additional_uv
    );
    wln!("{:#?}", header);

    // [2] ModelInfo
    let (model_info, ns) = loader.read();
    wln!("\n═══ [2] ModelInfo ═══");
    wln!("  name={}  name_en={}", model_info.name, model_info.name_en);
    wln!("  comment:\n{}", model_info.comment);

    // [3] Vertices
    let (vertices, ns) = ns.read();
    wln!("\n═══ [3] Vertices ({}) ═══", vertices.len());
    wln!("  字段: position(绑定姿态世界坐标cm) norm(法线) uv(纹理坐标)");
    wln!("  蒙皮类型: BDEF1(单骨骼) BDEF2(2骨骼线性) BDEF4(4骨骼线性)");
    wln!("           SDEF(球面变形) QDEF(双四元数,PMX2.1)");
    for (i, v) in vertices.iter().take(5).enumerate() {
        wln!("  [{:>5}] pos=({:.3},{:.3},{:.3}) norm=({:.3},{:.3},{:.3}) uv=({:.3},{:.3}) weight={:?}",
            i,
            v.position[0], v.position[1], v.position[2],
            v.norm[0], v.norm[1], v.norm[2],
            v.uv[0], v.uv[1],
            format_vertex_weight(&v.weight_type));
    }
    wln!("  ... (只显示前5条)");

    // [4] Faces
    let (faces, ns) = ns.read();
    wln!("\n═══ [4] Faces ({} 三角形) ═══", faces.len());
    wln!("  每个Face含3个顶点索引，逆时针为正面");
    for (i, f) in faces.iter().take(5).enumerate() {
        wln!(
            "  [{:>5}] v0={} v1={} v2={}",
            i,
            f.vertices[0],
            f.vertices[1],
            f.vertices[2]
        );
    }

    // [5] Textures
    let (textures, ns) = ns.read();
    wln!("\n═══ [5] Textures ({}) ═══", textures.len());
    wln!("  相对PMX文件目录的路径，\\ 需转为 /");
    for (i, t) in textures.iter().enumerate() {
        wln!("  [{:>3}] {}", i, t);
    }

    // [6] Materials
    let (materials_pmx, ns) = ns.read();
    wln!("\n═══ [6] Materials ({}) ═══", materials_pmx.len());
    wln!("  diffuse:漫反射RGBA  specular:高光RGB×光泽度  ambient:环境光RGB");
    wln!("  draw_mode:渲染标志  texture_index:纹理索引(-1=无)");
    wln!("  sphere_mode:球面贴图(Mul/Add/Sub)  toon_mode:卡通贴图");
    wln!("  num_face_vertices:覆盖的顶点索引数(÷3=三角面数)");
    for (i, m) in materials_pmx.iter().enumerate() {
        wln!(
            "  [{:>3}] 「{}」 diffuse=({:.2},{:.2},{:.2},{:.2}) spec=({:.2},{:.2},{:.2})×{:.1}",
            i,
            m.name,
            m.diffuse[0],
            m.diffuse[1],
            m.diffuse[2],
            m.diffuse[3],
            m.specular[0],
            m.specular[1],
            m.specular[2],
            m.specular_factor
        );
        wln!("       ambient=({:.2},{:.2},{:.2}) edge=({:.2},{:.2},{:.2},{:.2})×{:.2}  tex={}  faces={}",
            m.ambient[0], m.ambient[1], m.ambient[2],
            m.edge_color[0], m.edge_color[1], m.edge_color[2], m.edge_color[3], m.edge_size,
            m.texture_index, m.num_face_vertices / 3);
        wln!(
            "       draw_mode={:?}  sphere={:?}  toon={:?}",
            m.draw_mode,
            m.sphere_mode,
            m.toon_mode
        );
    }

    // [7] Bones
    let (bones, ns) = ns.read();
    let (morphs, _ns) = ns.read();
    wln!("\n═══ [7] Bones ({}) ═══", bones.len());
    wln!("  position:绑定姿态世界坐标  parent:父骨骼索引(-1=根)");
    wln!("  deform_depth:变形优先级(小=先算)  ik_info:IK约束");
    wln!("  fixed_axis:固定旋转轴  inherits:继承其他骨骼变换比例");
    for (i, b) in bones.iter().enumerate() {
        let inherits = format!("{:?}", b.inherits);
        let ik = if let Some(ik) = &b.ik_info {
            format!(
                "IK→{} iter={} limit_angle={:.3}rad links={}",
                ik.ik_target_bone_index,
                ik.ik_iter_count,
                ik.ik_limit_angle,
                ik.ik_links.len()
            )
        } else {
            "无".to_string()
        };
        wln!(
            "  [{:>3}] 「{}」 pos=({:.3},{:.3},{:.3}) parent={} depth={} IK:{} INHERITS:{}",
            i,
            b.name,
            b.position[0],
            b.position[1],
            b.position[2],
            b.parent,
            b.deform_depth,
            ik,
            inherits
        );
    }
    wln!("\n═══ PMX 写入完毕 ═══");
    pmx_log.flush().ok();
    println!("[INFO] PMX 信息已写入 {}", PMX_LOG_PATH);

    // ═════════════════════════════════════════════════════════════════════════
    // 构建全局蒙皮数据 PmxSharedSkin
    // ═════════════════════════════════════════════════════════════════════════
    let vcount = vertices.len();

    // 将 PMX VertexWeight 枚举统一为 (bone_indices[4], bone_weights[4])
    let skin_vertices: Vec<SkinVertex> = vertices
        .iter()
        .map(|v| {
            let (bi, bw) = convert_vertex_weight(&v.weight_type);
            SkinVertex {
                rest_position: Vec3::new(v.position[0], v.position[1], -v.position[2]),
                rest_normal: Vec3::new(v.norm[0], v.norm[1], -v.norm[2]),
                uv: v.uv,
                bone_indices: bi,
                bone_weights: bw,
            }
        })
        .collect();

    // 初始蒙皮结果 = 绑定姿态（第0帧之前先显示正确的 T-pose）
    let init_positions: Vec<[f32; 3]> = skin_vertices
        .iter()
        .map(|sv| sv.rest_position.to_array())
        .collect();
    let init_normals: Vec<[f32; 3]> = skin_vertices
        .iter()
        .map(|sv| sv.rest_normal.to_array())
        .collect();

    commands.insert_resource(PmxSharedSkin {
        vertices: skin_vertices,
        skinned_positions: init_positions,
        skinned_normals: init_normals,
    });

    // ═════════════════════════════════════════════════════════════════════════
    // 构建骨架 + IK 约束
    // ═════════════════════════════════════════════════════════════════════════
    let mut name_to_index = std::collections::HashMap::new();
    let bone_data: Vec<PmxBoneData> = bones
        .iter()
        .enumerate()
        .map(|(i, b)| {
            name_to_index.insert(b.name.clone(), i);
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
                deform_depth: b.deform_depth,
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

    commands.insert_resource(PmxSkeleton {
        bones: bone_data,
        ik_constraints,
        morphs: morph_data,
    });

    // ═════════════════════════════════════════════════════════════════════════
    // 构建 Bevy 材质列表
    // ═════════════════════════════════════════════════════════════════════════
    let model_dir = PathBuf::from(&cfg.paths.pmx)
        .parent()
        .expect("PMX 路径无父目录")
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
                Some(asset_server.load(model_dir.join(name)))
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

    // ═════════════════════════════════════════════════════════════════════════
    // 按材质分组建立子 Mesh 实体
    //
    // 【核心修复】
    // 每个子 Mesh 共享同一套顶点（全部 vcount 个），
    // 只是索引列表不同（引用该材质对应的那些三角面）。
    // 顶点数据由 PmxSharedSkin 统一管理，每帧只蒙皮一次，
    // 然后 apply_skin_to_meshes 把同一份结果写入每个 Mesh。
    // ═════════════════════════════════════════════════════════════════════════
    let face_groups = group_faces_by_material(&faces, &materials_pmx);

    // 在 PMX 阶段把 Mesh/材质都创建好
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

        let mut flipped_indices = Vec::with_capacity(face_indices.len());
        for tri in face_indices.chunks_exact(3) {
            flipped_indices.push(tri[0]);
            flipped_indices.push(tri[2]);
            flipped_indices.push(tri[1]);
        }
        let final_indices: Vec<u32> = if double_sided {
            let mut doubled = Vec::with_capacity(face_indices.len() * 2);
            doubled.extend_from_slice(&flipped_indices);
            doubled.extend_from_slice(&face_indices);
            doubled
        } else {
            flipped_indices
        };

        let mut mesh = Mesh::new(
            PrimitiveTopology::TriangleList,
            RenderAssetUsages::default(),
        );
        mesh.insert_attribute(Mesh::ATTRIBUTE_POSITION, init_positions.clone());
        mesh.insert_attribute(Mesh::ATTRIBUTE_NORMAL, init_normals.clone());
        mesh.insert_attribute(Mesh::ATTRIBUTE_UV_0, init_uvs.clone());
        mesh.insert_indices(Indices::U32(final_indices));

        let mesh_handle = meshes.add(mesh);

        commands.spawn((
            Mesh3d(mesh_handle),
            MeshMaterial3d(bevy_materials_list[mat_index].clone()),
            Transform::default(),
            SubMeshInfo {
                vertex_start: 0,
                vertex_end: vcount,
            },
        ));
    }

    // 委托软体模块构建头发/裙摆软体（如果存在）
    softbody::spawn_hair_from_pmx(
        commands,
        &vertices,
        &faces,
        &materials_pmx,
        &face_groups,
        &bones,
    );
}
