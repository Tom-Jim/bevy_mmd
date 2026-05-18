use bevy::prelude::*;
use bevy::reflect::TypePath;
use bevy::render::render_resource::{AsBindGroup, ShaderType};
use std::ffi::c_void;

use crate::vmd::VmdMotionClip;

#[derive(Component)]
pub struct JoltSoftBody {
    pub ptr: *mut c_void,
    pub num_vertices: usize,
    pub indices: Vec<u32>,
}
unsafe impl Send for JoltSoftBody {}
unsafe impl Sync for JoltSoftBody {}

#[derive(Component)]
pub struct JoltBody {
    pub _ptr: *mut c_void,
    pub size: Vec3,
}
// 重点：手动标记线程安全，因为 Jolt 的 Body 指针在初始化后是线程安全的句柄
unsafe impl Send for JoltBody {}
unsafe impl Sync for JoltBody {}

// 用于保存头发数据的全局资源
#[derive(Resource)]
pub struct HairPhysicsData {
    pub ptr: *mut c_void,
    pub root_pmx_indices: Vec<usize>,
    pub root_sb_indices: Vec<i32>,
    pub representative_pmx_indices: Vec<usize>, // 每个SB顶点对应一个代表性的PMX顶点(传给物理)
    pub sb_to_pmx_map: Vec<Vec<(usize, bevy::math::Vec3)>>, // 每个SB顶点对应的所有PMX顶点(用于渲染更新)
    pub is_initialized: bool,
}
unsafe impl Send for HairPhysicsData {}
unsafe impl Sync for HairPhysicsData {}

// ─────────────────────────────────────────────────────────────────────────────
// SkinVertex — 单个顶点的绑定姿态数据 + 蒙皮权重
// ─────────────────────────────────────────────────────────────────────────────
#[derive(Clone)]
pub struct SkinVertex {
    /// 绑定姿态顶点位置（模型空间，单位 cm）
    pub rest_position: Vec3,
    /// 绑定姿态顶点法线（用于光照，同样需要骨骼旋转变换）
    pub rest_normal: Vec3,
    /// 纹理 UV 坐标，不随骨骼变化
    pub uv: [f32; 2],
    /// 最多 4 个骨骼索引，-1 表示该槽无效
    pub bone_indices: [i32; 4],
    /// 对应骨骼权重
    pub bone_weights: [f32; 4],
}

// ─────────────────────────────────────────────────────────────────────────────
// PmxSharedSkin — 全局共享蒙皮数据（Resource）
// ─────────────────────────────────────────────────────────────────────────────
#[derive(Resource)]
pub struct PmxSharedSkin {
    /// 绑定姿态顶点数据（加载后只读）
    pub vertices: Vec<SkinVertex>,
    /// 每帧蒙皮后的顶点位置（由 animate_skinned_meshes 写入）
    pub skinned_positions: Vec<[f32; 3]>,
    /// 每帧蒙皮后的顶点法线（由 animate_skinned_meshes 写入）
    pub skinned_normals: Vec<[f32; 3]>,
}

// ─────────────────────────────────────────────────────────────────────────────
// SubMeshInfo — 每个按材质分组的子 Mesh 的描述信息（Component）
// ─────────────────────────────────────────────────────────────────────────────
#[derive(Component)]
pub struct SubMeshInfo {
    /// 该子 Mesh 使用的全局顶点范围 [vertex_start, vertex_end)
    pub vertex_start: usize,
    pub vertex_end: usize,
}

// ─────────────────────────────────────────────────────────────────────────────
// IK 相关数据结构
// ─────────────────────────────────────────────────────────────────────────────

/// IK 链路中单个关节的约束数据
#[derive(Clone)]
pub struct IkLinkData {
    /// 链路骨骼在全局骨骼数组中的索引
    pub bone_index: usize,
    /// 旋转角度约束 (最小欧拉角, 最大欧拉角)，单位弧度
    pub angle_limit: Option<(Vec3, Vec3)>,
}

/// 一个完整的 IK 约束定义
#[derive(Clone)]
pub struct IkConstraint {
    /// IK 骨骼索引（其世界位置即 IK 目标点，由 VMD 直接驱动）
    pub ik_bone_idx: usize,
    /// 效应骨骼（IK 链末端，需要到达 ik_bone 位置）
    pub target_bone_idx: usize,
    /// CCD 最大迭代次数
    pub iter_count: usize,
    /// 每步 CCD 最大旋转角（弧度），防止单帧抖动
    pub limit_angle: f32,
    /// IK 链路骨骼列表（从效应骨骼向上排列）
    pub links: Vec<IkLinkData>,
}

// ─────────────────────────────────────────────────────────────────────────────
// PmxBoneData — 骨骼静态数据（绑定姿态，加载后不变）
// ─────────────────────────────────────────────────────────────────────────────
#[derive(Clone)]
pub struct PmxVertexMorph {
    pub index: usize,
    pub offset: Vec3,
}

#[derive(Clone)]
pub struct PmxMorphData {
    pub name: String,
    pub offsets: Vec<PmxVertexMorph>,
}

pub struct PmxBoneData {
    /// 日文名称（VMD 用骨骼名匹配关键帧）
    pub name: String,
    /// 绑定姿态下骨骼头部的世界位置（单位 cm）
    pub rest_position: Vec3,
    /// 父骨骼索引，-1 = 根骨骼
    pub parent: i32,
    /// 变形优先级，越小越先计算（保证父→子顺序）
    pub deform_depth: i32,
    /// 赋予旋转 (目标骨骼索引, 权重)
    pub append_rotation: Option<(usize, f32)>,
}

// ─────────────────────────────────────────────────────────────────────────────
// PmxSkeleton — 全局骨架 Resource
// ─────────────────────────────────────────────────────────────────────────────
#[derive(Resource)]
pub struct PmxSkeleton {
    /// 骨骼静态数据数组（索引与 PMX 文件一致）
    pub bones: Vec<PmxBoneData>,
    /// 所有 IK 约束列表（含腿部 IK、脚尖 IK 等）
    pub ik_constraints: Vec<IkConstraint>,
    /// 面部表情等顶点 Morph
    pub morphs: Vec<PmxMorphData>,
}

// ─────────────────────────────────────────────────────────────────────────────
// VmdPlayback — VMD 播放状态 Resource
// ─────────────────────────────────────────────────────────────────────────────
#[derive(Resource)]
pub struct VmdPlayback {
    /// 解析后的 VMD 动作数据
    pub clip: VmdMotionClip,
    /// 播放帧率（VMD 标准 30fps）
    pub fps: f32,
    /// 当前播放时间（秒）
    pub time_sec: f32,
}

// ─────────────────────────────────────────────────────────────────────────────
// PmxUniform / PmxMaterial — GPU 材质数据
// ─────────────────────────────────────────────────────────────────────────────
#[derive(Clone, Debug, ShaderType)]
pub struct PmxUniform {
    pub diffuse: Vec4,
    pub ambient: Vec4,
    pub edge_color: Vec4,
    /// x=球面模式(0/1/2), y=预留, z=描边, w=卡通贴图
    pub flags: UVec4,
    pub emissive_strength: f32,
    pub _pad0: Vec3,
}

#[derive(Asset, TypePath, AsBindGroup, Debug, Clone)]
pub struct PmxMaterial {
    #[texture(1)]
    #[sampler(2)]
    pub base_color_texture: Option<Handle<Image>>,
    #[texture(3)]
    #[sampler(4)]
    pub sphere_texture: Option<Handle<Image>>,
    #[texture(5)]
    #[sampler(6)]
    pub toon_texture: Option<Handle<Image>>,
    #[uniform(0)]
    pub uniform: PmxUniform,
}

impl bevy::pbr::Material for PmxMaterial {
    fn fragment_shader() -> bevy::shader::ShaderRef {
        "shaders/pmx_material.wgsl".into()
    }
}
