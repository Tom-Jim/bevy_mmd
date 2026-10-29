//! MikuMikuDance's shading as Bevy materials, both written in WESL and embedded in the
//! binary (`shader/*.wesl`), so the desktop and the browser compile the same source.
//!
//! * [`PmxMaterial`]: diffuse + ambient, texture, sphere map, toon ramp and specular,
//!   computed in gamma space like MikuMikuDance does.
//! * [`OutlineMaterial`]: the edge pass, the skinned mesh pushed out along its normals
//!   by a fixed number of pixels with its front faces culled.

use bevy::asset::{AssetPath, embedded_path};
use bevy::mesh::MeshVertexBufferLayoutRef;
use bevy::pbr::{Material, MaterialPipeline, MaterialPipelineKey};
use bevy::prelude::*;
use bevy::render::render_resource::{AsBindGroup, Face, RenderPipelineDescriptor, ShaderType, SpecializedMeshPipelineError};
use bevy::shader::ShaderRef;

use crate::anim::morph::MaterialValues;

fn shader(name: &str) -> ShaderRef {
    let path = embedded_path!("shader").join(name);
    ShaderRef::Path(AssetPath::from_path_buf(path).with_source("embedded"))
}

pub fn register(app: &mut App) {
    bevy::asset::embedded_asset!(app, "shader/pmx.wesl");
    bevy::asset::embedded_asset!(app, "shader/outline.wesl");
    app.add_plugins((MaterialPlugin::<PmxMaterial>::default(), MaterialPlugin::<OutlineMaterial>::default()));
}

#[derive(Clone, Copy, Debug, Default, ShaderType)]
pub struct PmxUniform {
    pub diffuse: Vec4,
    /// rgb, w = specular power.
    pub specular: Vec4,
    pub ambient: Vec4,
    pub texture_mul: Vec4,
    pub texture_add: Vec4,
    pub sphere_mul: Vec4,
    pub sphere_add: Vec4,
    pub toon_mul: Vec4,
    pub toon_add: Vec4,
    /// Direction towards the light (xyz).
    pub light_direction: Vec4,
    pub light_color: Vec4,
    /// x: sphere mode (0 none, 1 multiply, 2 add), y: 1 if a toon ramp applies.
    pub flags: UVec4,
}

impl PmxUniform {
    /// The uniform for material values after morphs, plus the morphs' texture tints.
    pub fn set_values(&mut self, v: &MaterialValues, add: &MaterialValues) {
        self.diffuse = v.diffuse;
        self.specular = v.specular.extend(v.specular_power);
        self.ambient = v.ambient.extend(1.0);
        // Tints: base·mul + add, with mul starting at 1 and add at 0.
        self.texture_mul = v.texture_tint;
        self.texture_add = add.texture_tint;
        self.sphere_mul = v.sphere_tint;
        self.sphere_add = add.sphere_tint;
        self.toon_mul = v.toon_tint;
        self.toon_add = add.toon_tint;
    }
}

#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub struct PmxMaterialKey {
    pub double_sided: bool,
    pub blended: bool,
}

impl From<&PmxMaterial> for PmxMaterialKey {
    fn from(m: &PmxMaterial) -> Self {
        Self { double_sided: m.double_sided, blended: matches!(m.alpha_mode, AlphaMode::Blend) }
    }
}

#[derive(Asset, TypePath, AsBindGroup, Clone, Debug)]
#[bind_group_data(PmxMaterialKey)]
pub struct PmxMaterial {
    #[uniform(0)]
    pub uniform: PmxUniform,
    #[texture(1)]
    #[sampler(2)]
    pub texture: Handle<Image>,
    #[texture(3)]
    #[sampler(4)]
    pub sphere: Handle<Image>,
    #[texture(5)]
    #[sampler(6)]
    pub toon: Handle<Image>,
    pub alpha_mode: AlphaMode,
    pub double_sided: bool,
    /// Position in the PMX material list: blended materials draw in this order.
    pub order: u32,
}

impl Material for PmxMaterial {
    fn fragment_shader() -> ShaderRef {
        shader("pmx.wesl")
    }

    fn alpha_mode(&self) -> AlphaMode {
        self.alpha_mode
    }

    /// Transparent items are sorted by view depth plus this bias. All parts of a model
    /// share one origin, so a large step per material reproduces MikuMikuDance's
    /// draw-in-file-order.
    fn depth_bias(&self) -> f32 {
        self.order as f32 * 1000.0
    }

    fn enable_prepass() -> bool {
        false
    }

    fn enable_shadows() -> bool {
        false
    }

    fn specialize(
        _pipeline: &MaterialPipeline,
        descriptor: &mut RenderPipelineDescriptor,
        _layout: &MeshVertexBufferLayoutRef,
        key: MaterialPipelineKey<Self>,
    ) -> Result<(), SpecializedMeshPipelineError> {
        descriptor.primitive.cull_mode = if key.bind_group_data.double_sided { None } else { Some(Face::Back) };
        // MikuMikuDance writes depth for every material, hair cards included.
        if key.bind_group_data.blended
            && let Some(depth) = descriptor.depth_stencil.as_mut()
        {
            depth.depth_write_enabled = Some(true);
        }
        Ok(())
    }
}

#[derive(Clone, Copy, Debug, Default, ShaderType)]
pub struct OutlineUniform {
    pub color: Vec4,
    /// Edge width in logical pixels.
    pub width: f32,
}

#[derive(Asset, TypePath, AsBindGroup, Clone, Debug)]
pub struct OutlineMaterial {
    #[uniform(0)]
    pub uniform: OutlineUniform,
    pub alpha_mode: AlphaMode,
    pub order: u32,
}

impl Material for OutlineMaterial {
    fn vertex_shader() -> ShaderRef {
        shader("outline.wesl")
    }

    fn fragment_shader() -> ShaderRef {
        shader("outline.wesl")
    }

    fn alpha_mode(&self) -> AlphaMode {
        self.alpha_mode
    }

    fn depth_bias(&self) -> f32 {
        // Edges draw after every material, as in MikuMikuDance.
        1.0e6 + self.order as f32 * 1000.0
    }

    fn enable_prepass() -> bool {
        false
    }

    fn enable_shadows() -> bool {
        false
    }

    fn specialize(
        _pipeline: &MaterialPipeline,
        descriptor: &mut RenderPipelineDescriptor,
        _layout: &MeshVertexBufferLayoutRef,
        _key: MaterialPipelineKey<Self>,
    ) -> Result<(), SpecializedMeshPipelineError> {
        descriptor.primitive.cull_mode = Some(Face::Front);
        Ok(())
    }
}
