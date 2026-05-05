// ═════════════════════════════════════════════════════════════════════════════
// bevy3Danimation — PMX + VMD 实时 CPU 蒙皮动画播放器
// ═════════════════════════════════════════════════════════════════════════════

use std::io::Write;
use std::path::{Path, PathBuf};

use PMXUtil::reader::ModelInfoStage;
use PMXUtil::types::{Bone, Face, Material, MaterialFlags, SphereModeKind, ToonMode, VertexWeight};

use bevy::asset::RenderAssetUsages;
use bevy::mesh::Indices;
use bevy::pbr::MaterialPlugin;
use bevy::prelude::*;
use bevy::reflect::TypePath;
use bevy::render::render_resource::{AsBindGroup, PrimitiveTopology, ShaderType};
use bevy::shader::ShaderRef;
use bevy_panorbit_camera::{PanOrbitCamera, PanOrbitCameraPlugin};

mod vmd_motion;
use vmd_motion::VmdMotionClip;

// ─────────────────────────────────────────────────────────────────────────────
// 路径常量
// ─────────────────────────────────────────────────────────────────────────────
const PMX_FILE_PATH: &str =
    "模型/星穹铁道—爻光_by_崩坏：星穹铁道_165cb3448b45a0f2dd74d92bd6234876/星穹铁道—爻光.pmx";
const VMD_FILE_PATH: &str = "VMD/贝洛伯格第三节.vmd";
const GLOBAL_EMISSIVE_STRENGTH: f32 = 0.5;
const PMX_LOG_PATH: &str = "src/pmx_info.txt";
const VMD_LOG_PATH: &str = "src/vmd_info.txt";

// ═════════════════════════════════════════════════════════════════════════════
// 数据结构
// ═════════════════════════════════════════════════════════════════════════════

// ─────────────────────────────────────────────────────────────────────────────
// SkinVertex — 单个顶点的绑定姿态数据 + 蒙皮权重
//
// 蒙皮原理：
//   animated_pos = Σ_k( weight_k × SkinMat[bone_k] × rest_position )
//   SkinMat[i]   = WorldMat[i] × inverse(RestMat[i])
//                = T(world_pos) × R(world_rot) × T(-rest_pos)
//
// 这份数据加载后不再变化，每帧只读不写。
// ─────────────────────────────────────────────────────────────────────────────
#[derive(Clone)]
struct SkinVertex {
    /// 绑定姿态顶点位置（模型空间，单位 cm）
    rest_position: Vec3,
    /// 绑定姿态顶点法线（用于光照，同样需要骨骼旋转变换）
    rest_normal: Vec3,
    /// 纹理 UV 坐标，不随骨骼变化
    uv: [f32; 2],
    /// 最多 4 个骨骼索引，-1 表示该槽无效
    bone_indices: [i32; 4],
    /// 对应骨骼权重
    bone_weights: [f32; 4],
}

// ─────────────────────────────────────────────────────────────────────────────
// PmxSharedSkin — 全局共享蒙皮数据（Resource）
//
// 【性能关键】
// 30921 个顶点 × 35 个材质 = 原先每帧做 1,082,235 次变换。
// 改为：每帧只做一次蒙皮，得到 30921 个新位置/法线，
// 然后各 Mesh 从中拷贝自己需要的那段（按顶点范围切片）。
//
// 共享数据流：
//   1. animate_skinned_meshes 把蒙皮结果写入 new_positions / new_normals
//   2. apply_skin_to_meshes   把各 Mesh 需要的那段数据写入 Mesh Asset
// ─────────────────────────────────────────────────────────────────────────────
#[derive(Resource)]
struct PmxSharedSkin {
    /// 绑定姿态顶点数据（加载后只读）
    vertices: Vec<SkinVertex>,
    /// 每帧蒙皮后的顶点位置（由 animate_skinned_meshes 写入）
    skinned_positions: Vec<[f32; 3]>,
    /// 每帧蒙皮后的顶点法线（由 animate_skinned_meshes 写入）
    skinned_normals: Vec<[f32; 3]>,
}

// ─────────────────────────────────────────────────────────────────────────────
// SubMeshInfo — 每个按材质分组的子 Mesh 的描述信息（Component）
//
// 子 Mesh 的顶点数据是全局顶点数组的一段连续子集（PMX 顶点是全局共享的）。
// 记录 vertex_start..vertex_end 即可，每帧从 PmxSharedSkin 中切片取用。
// ─────────────────────────────────────────────────────────────────────────────
#[derive(Component)]
struct SubMeshInfo {
    /// 该子 Mesh 使用的全局顶点范围 [vertex_start, vertex_end)
    /// 注意：PMX 的所有材质共享同一套顶点，所以每个子 Mesh 都使用全部顶点
    /// 因此 vertex_start=0, vertex_end=顶点总数
    vertex_start: usize,
    vertex_end: usize,
}

// ─────────────────────────────────────────────────────────────────────────────
// IK 相关数据结构
// ─────────────────────────────────────────────────────────────────────────────

/// IK 链路中单个关节的约束数据
#[derive(Clone)]
struct IkLinkData {
    /// 链路骨骼在全局骨骼数组中的索引
    bone_index: usize,
    /// 旋转角度约束 (最小欧拉角, 最大欧拉角)，单位弧度
    /// None = 无约束；膝盖通常设 min.x > 0 以防止膝盖反折
    angle_limit: Option<(Vec3, Vec3)>,
}

/// 一个完整的 IK 约束定义
/// PMX IK 结构：ik_bone 位置是目标点，target_bone 是末端效应器，
/// links 是被 CCD 旋转的中间骨骼链（从末端往根部排列）
#[derive(Clone)]
struct IkConstraint {
    /// IK 骨骼索引（其世界位置即 IK 目标点，由 VMD 直接驱动）
    ik_bone_idx: usize,
    /// 效应骨骼（IK 链末端，需要到达 ik_bone 位置）
    target_bone_idx: usize,
    /// CCD 最大迭代次数
    iter_count: usize,
    /// 每步 CCD 最大旋转角（弧度），防止单帧抖动
    limit_angle: f32,
    /// IK 链路骨骼列表（从效应骨骼向上排列）
    links: Vec<IkLinkData>,
}

// ─────────────────────────────────────────────────────────────────────────────
// PmxBoneData — 骨骼静态数据（绑定姿态，加载后不变）
// ─────────────────────────────────────────────────────────────────────────────
#[derive(Clone)]
struct PmxVertexMorph {
    index: usize,
    offset: Vec3,
}

#[derive(Clone)]
struct PmxMorphData {
    name: String,
    offsets: Vec<PmxVertexMorph>,
}

struct PmxBoneData {
    /// 日文名称（VMD 用骨骼名匹配关键帧）
    name: String,
    /// 绑定姿态下骨骼头部的世界位置（单位 cm）
    rest_position: Vec3,
    /// 父骨骼索引，-1 = 根骨骼
    parent: i32,
    /// 变形优先级，越小越先计算（保证父→子顺序）
    deform_depth: i32,
    /// 赋予旋转 (目标骨骼索引, 权重)
    append_rotation: Option<(usize, f32)>,
}

// ─────────────────────────────────────────────────────────────────────────────
// PmxSkeleton — 全局骨架 Resource
// ─────────────────────────────────────────────────────────────────────────────
#[derive(Resource)]
struct PmxSkeleton {
    /// 骨骼静态数据数组（索引与 PMX 文件一致）
    bones: Vec<PmxBoneData>,
    /// 所有 IK 约束列表（含腿部 IK、脚尖 IK 等）
    ik_constraints: Vec<IkConstraint>,
    /// 面部表情等顶点 Morph
    morphs: Vec<PmxMorphData>,
}

// ─────────────────────────────────────────────────────────────────────────────
// VmdPlayback — VMD 播放状态 Resource
// ─────────────────────────────────────────────────────────────────────────────
#[derive(Resource)]
struct VmdPlayback {
    /// 解析后的 VMD 动作数据
    clip: VmdMotionClip,
    /// 播放帧率（VMD 标准 30fps）
    fps: f32,
    /// 当前播放时间（秒）
    time_sec: f32,
}

// ─────────────────────────────────────────────────────────────────────────────
// PmxUniform / PmxMaterial — GPU 材质数据
// ─────────────────────────────────────────────────────────────────────────────
#[derive(Clone, Debug, ShaderType)]
struct PmxUniform {
    diffuse: Vec4,
    ambient: Vec4,
    edge_color: Vec4,
    /// x=球面模式(0/1/2), y=预留, z=描边, w=卡通贴图
    flags: UVec4,
    emissive_strength: f32,
    _pad0: Vec3,
}

#[derive(Asset, TypePath, AsBindGroup, Debug, Clone)]
struct PmxMaterial {
    #[texture(1)]
    #[sampler(2)]
    base_color_texture: Option<Handle<Image>>,
    #[texture(3)]
    #[sampler(4)]
    sphere_texture: Option<Handle<Image>>,
    #[texture(5)]
    #[sampler(6)]
    toon_texture: Option<Handle<Image>>,
    #[uniform(0)]
    uniform: PmxUniform,
}

impl bevy::pbr::Material for PmxMaterial {
    fn fragment_shader() -> ShaderRef {
        "shaders/pmx_material.wgsl".into()
    }
    fn alpha_mode(&self) -> AlphaMode {
        if self.uniform.diffuse.w < 0.999 {
            AlphaMode::Blend
        } else {
            AlphaMode::Opaque
        }
    }
}

// ═════════════════════════════════════════════════════════════════════════════
// main
// ═════════════════════════════════════════════════════════════════════════════
fn main() {
    App::new()
        .add_plugins(DefaultPlugins.set(AssetPlugin {
            file_path: "assets".into(),
            watch_for_changes_override: Some(true),
            ..Default::default()
        }))
        .add_plugins(MaterialPlugin::<PmxMaterial>::default())
        .add_plugins(PanOrbitCameraPlugin)
        .add_systems(Startup, setup)
        // 两阶段：先计算骨骼+蒙皮，再把结果写入各 Mesh
        .add_systems(Update, (skin_update_system, apply_skin_to_meshes).chain())
        .run();
}

// ═════════════════════════════════════════════════════════════════════════════
// setup — 场景初始化
// ═════════════════════════════════════════════════════════════════════════════
fn setup(
    mut commands: Commands,
    asset_server: Res<AssetServer>,
    mut meshes: ResMut<Assets<Mesh>>,
    mut materials: ResMut<Assets<PmxMaterial>>,
) {
    // ── 打开 PMX 文件 ─────────────────────────────────────────────────────────
    let pmx_path = if Path::new(PMX_FILE_PATH).is_absolute() {
        PMX_FILE_PATH.to_string()
    } else {
        format!("assets/{}", PMX_FILE_PATH)
    };
    let loader = ModelInfoStage::open(pmx_path.clone())
        .unwrap_or_else(|| panic!("无法加载 PMX：{}", pmx_path));

    // ── PMX 信息写入文件（不阻塞主流程） ────────────────────────────────────
    let mut pmx_log = std::fs::File::create(PMX_LOG_PATH)
        .unwrap_or_else(|e| panic!("无法创建 {}: {}", PMX_LOG_PATH, e));

    // [1] Header
    let header = loader.get_header();
    writeln!(pmx_log, "═══ [1] Header ═══").ok();
    writeln!(
        pmx_log,
        "  version={:?}  encode={:?}  additional_uv={}",
        header.version, header.encode, header.additional_uv
    )
    .ok();
    writeln!(pmx_log, "{:#?}", header).ok();

    // [2] ModelInfo
    let (model_info, ns) = loader.read();
    writeln!(pmx_log, "\n═══ [2] ModelInfo ═══").ok();
    writeln!(
        pmx_log,
        "  name={}  name_en={}",
        model_info.name, model_info.name_en
    )
    .ok();
    writeln!(pmx_log, "  comment:\n{}", model_info.comment).ok();

    // [3] Vertices
    let (vertices, ns) = ns.read();
    writeln!(pmx_log, "\n═══ [3] Vertices ({}) ═══", vertices.len()).ok();
    writeln!(
        pmx_log,
        "  字段: position(绑定姿态世界坐标cm) norm(法线) uv(纹理坐标)"
    )
    .ok();
    writeln!(
        pmx_log,
        "  蒙皮类型: BDEF1(单骨骼) BDEF2(2骨骼线性) BDEF4(4骨骼线性)"
    )
    .ok();
    writeln!(pmx_log, "           SDEF(球面变形) QDEF(双四元数,PMX2.1)").ok();
    for (i, v) in vertices.iter().take(5).enumerate() {
        writeln!(pmx_log, "  [{:>5}] pos=({:.3},{:.3},{:.3}) norm=({:.3},{:.3},{:.3}) uv=({:.3},{:.3}) weight={:?}",
            i,
            v.position[0], v.position[1], v.position[2],
            v.norm[0], v.norm[1], v.norm[2],
            v.uv[0], v.uv[1],
            format_vertex_weight(&v.weight_type)).ok();
    }
    writeln!(pmx_log, "  ... (只显示前5条)").ok();

    // [4] Faces
    let (faces, ns) = ns.read();
    writeln!(pmx_log, "\n═══ [4] Faces ({} 三角形) ═══", faces.len()).ok();
    writeln!(pmx_log, "  每个Face含3个顶点索引，逆时针为正面").ok();
    for (i, f) in faces.iter().take(5).enumerate() {
        writeln!(
            pmx_log,
            "  [{:>5}] v0={} v1={} v2={}",
            i, f.vertices[0], f.vertices[1], f.vertices[2]
        )
        .ok();
    }

    // [5] Textures
    let (textures, ns) = ns.read();
    writeln!(pmx_log, "\n═══ [5] Textures ({}) ═══", textures.len()).ok();
    writeln!(pmx_log, "  相对PMX文件目录的路径，\\ 需转为 /").ok();
    for (i, t) in textures.iter().enumerate() {
        writeln!(pmx_log, "  [{:>3}] {}", i, t).ok();
    }

    // [6] Materials
    let (materials_pmx, ns) = ns.read();
    writeln!(pmx_log, "\n═══ [6] Materials ({}) ═══", materials_pmx.len()).ok();
    writeln!(
        pmx_log,
        "  diffuse:漫反射RGBA  specular:高光RGB×光泽度  ambient:环境光RGB"
    )
    .ok();
    writeln!(
        pmx_log,
        "  draw_mode:渲染标志  texture_index:纹理索引(-1=无)"
    )
    .ok();
    writeln!(
        pmx_log,
        "  sphere_mode:球面贴图(Mul/Add/Sub)  toon_mode:卡通贴图"
    )
    .ok();
    writeln!(pmx_log, "  num_face_vertices:覆盖的顶点索引数(÷3=三角面数)").ok();
    for (i, m) in materials_pmx.iter().enumerate() {
        writeln!(
            pmx_log,
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
        )
        .ok();
        writeln!(pmx_log, "       ambient=({:.2},{:.2},{:.2}) edge=({:.2},{:.2},{:.2},{:.2})×{:.2}  tex={}  faces={}",
            m.ambient[0], m.ambient[1], m.ambient[2],
            m.edge_color[0], m.edge_color[1], m.edge_color[2], m.edge_color[3], m.edge_size,
            m.texture_index, m.num_face_vertices / 3).ok();
        writeln!(
            pmx_log,
            "       draw_mode={:?}  sphere={:?}  toon={:?}",
            m.draw_mode, m.sphere_mode, m.toon_mode
        )
        .ok();
    }

    // [7] Bones
    let (bones, ns) = ns.read();
    let (morphs, _ns) = ns.read();
    writeln!(pmx_log, "\n═══ [7] Bones ({}) ═══", bones.len()).ok();
    writeln!(
        pmx_log,
        "  position:绑定姿态世界坐标  parent:父骨骼索引(-1=根)"
    )
    .ok();
    writeln!(
        pmx_log,
        "  deform_depth:变形优先级(小=先算)  ik_info:IK约束"
    )
    .ok();
    writeln!(
        pmx_log,
        "  fixed_axis:固定旋转轴  inherits:继承其他骨骼变换比例"
    )
    .ok();
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
        writeln!(
            pmx_log,
            "  [{:>3}] 「{}」 pos=({:.3},{:.3},{:.3}) parent={} depth={} IK:{} INHERITS:{}",
            i, b.name, b.position[0], b.position[1], b.position[2], b.parent, b.deform_depth, ik, inherits
        )
        .ok();
    }
    writeln!(pmx_log, "\n═══ PMX 写入完毕 ═══").ok();
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
                if idx >= 0 { Some((idx as usize, weight)) } else { None }
            }
            PMXUtil::types::RotateAndTranslateInherits::Both(idx, weight) => {
                if idx >= 0 { Some((idx as usize, weight)) } else { None }
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
    let model_dir = PathBuf::from(PMX_FILE_PATH)
        .parent()
        .expect("PMX 路径无父目录")
        .to_path_buf();
    let normalize_sep = |s: &str| s.replace('\\', "/");
    let mut bevy_materials_list = Vec::new();

    for mat in &materials_pmx {
        let base_texture = if mat.texture_index >= 0 {
            let name = normalize_sep(&textures[mat.texture_index as usize]);
            Some(asset_server.load(model_dir.join(name)))
        } else {
            None
        };

        let (sphere_texture, sphere_mode) = match mat.sphere_mode {
            Some(mode) if mode.index >= 0 => {
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
            ToonMode::Separate(i) if i >= 0 => {
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
                emissive_strength: GLOBAL_EMISSIVE_STRENGTH,
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

    // 初始顶点数据（绑定姿态，第一帧蒙皮完成前先显示）
    let init_positions: Vec<[f32; 3]> = (0..vcount)
        .map(|i| {
            let sv = &{
                // 临时从 vertices 中取（后面 PmxSharedSkin 已建好）
                let v = &vertices[i];
                Vec3::new(v.position[0], v.position[1], -v.position[2])
            };
            sv.to_array()
        })
        .collect();
    let init_normals: Vec<[f32; 3]> = (0..vcount)
        .map(|i| Vec3::new(vertices[i].norm[0], vertices[i].norm[1], -vertices[i].norm[2]).to_array())
        .collect();
    let init_uvs: Vec<[f32; 2]> = vertices.iter().map(|v| v.uv).collect();

    for (mat_index, face_indices) in face_groups {
        let double_sided = materials_pmx[mat_index]
            .draw_mode
            .contains(MaterialFlags::DISABLE_CULLING);

        // 构建索引列表（双面材质追加反向三角形）
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

        // 每个子 Mesh 包含全部顶点（PMX 顶点是全局共享的）
        // MAIN_WORLD | RENDER_WORLD：CPU 端保留数据可每帧修改，同时上传 GPU
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
            // SubMeshInfo 记录该子 Mesh 对应的顶点范围（全局顶点）
            SubMeshInfo {
                vertex_start: 0,
                vertex_end: vcount,
            },
        ));
    }

    // ═════════════════════════════════════════════════════════════════════════
    // 加载 VMD
    // ═════════════════════════════════════════════════════════════════════════
    let vmd_path = if Path::new(VMD_FILE_PATH).is_absolute() {
        VMD_FILE_PATH.to_string()
    } else {
        format!("assets/{}", VMD_FILE_PATH)
    };
    match VmdMotionClip::from_file(&vmd_path) {
        Ok(clip) => {
            // clip.write_info_to_file(VMD_LOG_PATH);
            println!("[INFO] VMD 信息已写入 {}", VMD_LOG_PATH);
            commands.insert_resource(VmdPlayback {
                clip,
                fps: 30.0,
                time_sec: 0.0,
            });
        }
        Err(e) => eprintln!("[ERROR] VMD 加载失败: {:?}", e),
    }

    // ═════════════════════════════════════════════════════════════════════════
    // 灯光 & 相机
    // ═════════════════════════════════════════════════════════════════════════
    commands.spawn((
        PointLight {
            intensity: 2_000_000.0,
            range: 500.0,
            shadows_enabled: false,
            ..default()
        },
        Transform::from_xyz(5.0, 50.0, -20.0),
    ));
    commands.spawn(AmbientLight {
        color: Color::WHITE,
        brightness: 200.0,
        ..default()
    });
    commands.spawn((
        DirectionalLight {
            illuminance: 10000.0,
            shadows_enabled: false,
            ..default()
        },
        Transform::from_xyz(10.0, 30.0, -10.0).looking_at(Vec3::ZERO, Vec3::Y),
    ));
    commands.spawn((
        Camera3d::default(),
        Transform::from_xyz(0.0, 15.0, 50.0).looking_at(Vec3::new(0.0, 20.0, 0.0), Vec3::Y),
        PanOrbitCamera::default(),
    ));
}

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
fn skin_update_system(
    time: Res<Time>,
    mut playback: Option<ResMut<VmdPlayback>>,
    skeleton: Option<Res<PmxSkeleton>>,
    mut shared_skin: Option<ResMut<PmxSharedSkin>>,
) {
    let (Some(mut pb), Some(skel), Some(mut skin)) =
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
            local_r[i] = Quat::from_xyzw(-pose.rotation.x, -pose.rotation.y, pose.rotation.z, pose.rotation.w);
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
    skin.skinned_positions = new_pos;
    skin.skinned_normals = new_nor;
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
fn apply_skin_to_meshes(
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
fn build_ik_constraints(bones: &[Bone]) -> Vec<IkConstraint> {
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
                angle_limit: link.angle_limit.map(|(mn, mx)| {
                     
                     
                     
                    (-Vec3::from(mx), -Vec3::from(mn))
                }),
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

// ═════════════════════════════════════════════════════════════════════════════
// 辅助函数
// ═════════════════════════════════════════════════════════════════════════════

/// 将 PMX VertexWeight 枚举统一为 ([i32;4], [f32;4])
fn convert_vertex_weight(w: &VertexWeight) -> ([i32; 4], [f32; 4]) {
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

/// 格式化 VertexWeight 为日志字符串
fn format_vertex_weight(w: &VertexWeight) -> String {
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

/// 按材质顺序分组三角面索引（PMX 面列表按材质连续排列）
fn group_faces_by_material(faces: &[Face], mats: &[Material]) -> Vec<(usize, Vec<u32>)> {
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
