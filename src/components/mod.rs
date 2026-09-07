use bevy::prelude::*;
use bevy::reflect::TypePath;
use bevy::render::render_resource::{AsBindGroup, ShaderType};
use std::ffi::c_void;

use crate::vmd::VmdMotionClip;

// Global resource holding hair/cloth soft-body state.
#[derive(Resource)]
pub struct HairPhysicsData {
    pub ptr: *mut c_void,
    pub representative_pmx_indices: Vec<usize>, // one canonical PMX index per soft-body vertex, drives physics
    pub root_sb_indices: Vec<i32>,              // animated anchor vertices only
    pub sb_to_pmx_map: Vec<Vec<usize>>, // all PMX indices per soft-body vertex, drives render sync
    pub physics_indices: Vec<usize>,    // deduplicated PMX vertices that require CPU skinning
    pub collision_triangles_buffer: Vec<f32>,
    pub all_positions_buffer: Vec<f32>,
    pub all_sb_indices_buffer: Vec<i32>,
    pub root_positions_buffer: Vec<f32>,
    pub current_vertices_buffer: Vec<f32>,
    /// Per-particle material group: 0 = cloth, 1 = hair.
    pub vertex_groups: Vec<u8>,
    pub is_initialized: bool,
}
unsafe impl Send for HairPhysicsData {}
unsafe impl Sync for HairPhysicsData {}

/// Bind-pose vertex data plus skinning weights.
#[derive(Clone)]
pub struct SkinVertex {
    pub rest_position: Vec3,
    pub rest_normal: Vec3,
    /// Up to four bone indices; -1 marks an unused slot.
    pub bone_indices: [i32; 4],
    pub bone_weights: [f32; 4],
}

#[derive(Resource)]
pub struct PmxSharedSkin {
    /// Read-only after initial load.
    pub vertices: Vec<SkinVertex>,
    /// Written each frame by `skin_update_system`.
    pub skinned_positions: Vec<[f32; 3]>,
    pub skinned_normals: Vec<[f32; 3]>,
    /// Previous fixed-step positions used to interpolate soft-body rendering.
    pub previous_positions: Vec<[f32; 3]>,
    /// Marks vertices that are physically simulated and therefore interpolated.
    pub physics_mask: Vec<bool>,
}

#[derive(Component)]
pub struct PmxBone {
    pub index: usize,
}

#[derive(Component)]
pub struct CpuDeformed;

/// Global PMX vertex indices used by this sub-mesh, in local mesh order.
#[derive(Component)]
pub struct SubMeshInfo {
    pub pmx_vertex_indices: Vec<usize>,
}

#[derive(Clone)]
pub struct IkLinkData {
    pub bone_index: usize,
    /// Joint angle clamp (min_euler, max_euler) in radians; None if unconstrained.
    pub angle_limit: Option<(Vec3, Vec3)>,
}

#[derive(Clone)]
pub struct IkConstraint {
    /// Bone whose world position is the IK target, driven directly by VMD.
    pub ik_bone_idx: usize,
    /// End-effector bone that must reach ik_bone_idx.
    pub target_bone_idx: usize,
    pub iter_count: usize,
    /// Per-step CCD rotation clamp in radians; prevents single-frame jitter.
    pub limit_angle: f32,
    pub links: Vec<IkLinkData>,
}

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

/// Immutable bone data loaded from the PMX bind pose.
pub struct PmxBoneData {
    /// Japanese name used to match VMD keyframes.
    pub name: String,
    pub rest_position: Vec3,
    /// -1 for root bones.
    pub parent: i32,
    /// Appended rotation: (source_bone_index, blend_weight).
    pub append_rotation: Option<(usize, f32)>,
}

#[derive(Resource)]
pub struct PmxSkeleton {
    pub bones: Vec<PmxBoneData>,
    pub order: Vec<usize>,
    pub ik_constraints: Vec<IkConstraint>,
    pub morphs: Vec<PmxMorphData>,
    pub colliders: Vec<PmxCollider>,
    pub collision_triangles: Vec<PmxCollisionTriangle>,
    pub collision_vertex_indices: Vec<usize>,
}

#[derive(Resource)]
pub struct VmdPlayback {
    pub clip: VmdMotionClip,
    /// VMD standard frame rate (30 fps).
    pub fps: f32,
    pub time_sec: f32,
}

#[derive(Clone, Debug, ShaderType)]
pub struct PmxUniform {
    pub diffuse: Vec4,
    pub ambient: Vec4,
    pub edge_color: Vec4,
    /// x=sphere_mode(0/1/2), y=reserved, z=edge_enabled, w=toon_enabled
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

/// Bone-relative collision proxy imported from a static PMX rigid body.
pub struct PmxCollider {
    pub bone: usize,
    pub offset: Vec3,
    pub rotation: Quat,
    pub size: Vec3,
    pub kind: f32,
}

/// A rigid model-surface triangle used as a deforming collision shell.
pub struct PmxCollisionTriangle {
    pub vertices: [u32; 3],
}
