//! A loaded PMX as Bevy entities: one skinned mesh per material (GPU skinning, joints
//! limited to the bones the material uses), its material and edge, and the bone
//! entities the skins follow. Vertex and UV morphs are applied on the CPU to the parts
//! they touch, only when their weights change.

use std::collections::HashMap;

use bevy::asset::RenderAssetUsages;
use bevy::camera::visibility::NoFrustumCulling;
use bevy::mesh::skinning::{SkinnedMesh, SkinnedMeshInverseBindposes};
use bevy::mesh::{Indices, PrimitiveTopology, VertexAttributeValues};
use bevy::prelude::*;

use super::config::RenderConfig;
use super::load::LoadedModel;
use super::material::{OutlineMaterial, OutlineUniform, PmxMaterial, PmxUniform};
use super::texture::{self, Alpha, Wrap};
use crate::anim::Animator;
use crate::anim::coords;
use crate::anim::morph::{Kind, MaterialMorph, MaterialValues};
use crate::format::pmx::{SphereMode, Toon, material_flags};
use crate::physics::{PhysicsRig, PhysicsSettings};

/// One drawn material of a model.
pub struct Part {
    pub material_index: usize,
    pub mesh: Handle<Mesh>,
    pub material: Handle<PmxMaterial>,
    pub outline: Option<Handle<OutlineMaterial>>,
    pub base: MaterialValues,
    pub edge_color: Vec4,
    pub edge_size: f32,
    morphs: Option<PartMorphs>,
    last_material: MaterialMorph,
}

struct PartMorphs {
    base_positions: Vec<[f32; 3]>,
    base_uvs: Vec<[f32; 2]>,
    /// (morph index, local vertex, offset).
    positions: Vec<(usize, Vec<(u32, Vec3)>)>,
    uvs: Vec<(usize, Vec<(u32, Vec2)>)>,
    last_weights: Vec<f32>,
}

#[derive(Component)]
pub struct MmdModel {
    pub name: String,
    pub path: String,
    pub animator: Animator,
    pub rig: Option<PhysicsRig>,
    pub bones: Vec<Entity>,
    pub parts: Vec<Part>,
    pub vertex_count: usize,
    pub face_count: usize,
    /// Rest-pose bounds, for framing the camera.
    pub bounds: (Vec3, Vec3),
    pub warnings: Vec<String>,
}

#[derive(Component)]
pub struct OutlinePart;

pub struct Assets3d<'a> {
    pub meshes: &'a mut Assets<Mesh>,
    pub materials: &'a mut Assets<PmxMaterial>,
    pub outlines: &'a mut Assets<OutlineMaterial>,
    pub images: &'a mut Assets<Image>,
    pub bindposes: &'a mut Assets<SkinnedMeshInverseBindposes>,
}

pub fn spawn(
    commands: &mut Commands,
    assets: &mut Assets3d,
    loaded: LoadedModel,
    render: &RenderConfig,
    physics: &PhysicsSettings,
) -> Entity {
    let LoadedModel { name, path, model, textures, warnings } = loaded;
    let animator = Animator::new(&model);
    let rig = PhysicsRig::new(&model, &animator.skeleton, physics);

    let root = commands.spawn((Transform::default(), Visibility::default(), Name::new(name.clone()))).id();
    let bones: Vec<Entity> = animator
        .skeleton
        .bones
        .iter()
        .map(|b| commands.spawn((Transform::from_translation(b.rest), ChildOf(root))).id())
        .collect();

    let white = assets.images.add(texture::solid([255; 4], Wrap::Repeat));
    let mut repeat_handles: HashMap<usize, (Handle<Image>, Alpha)> = HashMap::new();
    let mut clamp_handles: HashMap<usize, Handle<Image>> = HashMap::new();
    for (i, d) in textures.repeat.into_iter().enumerate() {
        if let Some(d) = d {
            repeat_handles.insert(i, (assets.images.add(d.image), d.alpha));
        }
    }
    for (i, d) in textures.clamp.into_iter().enumerate() {
        if let Some(d) = d {
            clamp_handles.insert(i, assets.images.add(d.image));
        }
    }
    let mut shared_toons: Vec<Option<Handle<Image>>> = vec![None; 10];
    for (i, d) in textures.shared_toons.into_iter().enumerate().take(10) {
        shared_toons[i] = d.map(|d| assets.images.add(d.image));
    }

    let light_direction = -Vec3::from(render.light_direction).normalize_or(Vec3::NEG_Y);
    let light_color = Vec3::from(render.light_color).extend(1.0);

    let positions: Vec<[f32; 3]> = model.vertices.iter().map(|v| coords::position(v.position).to_array()).collect();
    let normals: Vec<[f32; 3]> = model.vertices.iter().map(|v| coords::position(v.normal).normalize_or_zero().to_array()).collect();
    let weights: Vec<([u32; 4], [f32; 4])> = model.vertices.iter().map(|v| v.weight.linear()).collect();
    let (min, max) = positions.iter().fold((Vec3::splat(f32::MAX), Vec3::splat(f32::MIN)), |(lo, hi), p| {
        (lo.min(Vec3::from(*p)), hi.max(Vec3::from(*p)))
    });

    let mut parts = Vec::new();
    let mut cursor = 0usize;
    for (mi, m) in model.materials.iter().enumerate() {
        let count = m.index_count as usize;
        let face_indices = &model.indices[cursor..(cursor + count).min(model.indices.len())];
        cursor += count;
        if face_indices.is_empty() {
            continue;
        }

        // Local vertex and joint tables of this part.
        let mut local_of: HashMap<u32, u32> = HashMap::new();
        let mut globals: Vec<u32> = Vec::new();
        let mut indices = Vec::with_capacity(face_indices.len());
        for tri in face_indices.chunks_exact(3) {
            // Mirroring Z turns MikuMikuDance's clockwise front faces counter-clockwise
            // in world space but keeps them clockwise on screen: swap two corners.
            for &g in &[tri[0], tri[2], tri[1]] {
                let l = *local_of.entry(g).or_insert_with(|| {
                    globals.push(g);
                    globals.len() as u32 - 1
                });
                indices.push(l);
            }
        }
        let mut joint_of: HashMap<u32, u16> = HashMap::new();
        let mut joints: Vec<u32> = Vec::new();
        let mut joint_index = Vec::with_capacity(globals.len());
        let mut joint_weight = Vec::with_capacity(globals.len());
        for &g in &globals {
            let (b, w) = weights[g as usize];
            let mut idx = [0u16; 4];
            for k in 0..4 {
                let bone = if (b[k] as usize) < bones.len() { b[k] } else { 0 };
                if w[k] > 0.0 || k == 0 {
                    idx[k] = *joint_of.entry(bone).or_insert_with(|| {
                        joints.push(bone);
                        joints.len() as u16 - 1
                    });
                }
            }
            joint_index.push(idx);
            joint_weight.push(w);
        }

        let morphs = part_morphs(&animator, &local_of);
        let usage = if morphs.is_some() { RenderAssetUsages::default() } else { RenderAssetUsages::RENDER_WORLD };
        let part_positions: Vec<[f32; 3]> = globals.iter().map(|&g| positions[g as usize]).collect();
        let part_uvs: Vec<[f32; 2]> = globals.iter().map(|&g| model.vertices[g as usize].uv).collect();
        let mut mesh = Mesh::new(PrimitiveTopology::TriangleList, usage);
        mesh.insert_attribute(Mesh::ATTRIBUTE_POSITION, part_positions.clone());
        mesh.insert_attribute(Mesh::ATTRIBUTE_NORMAL, globals.iter().map(|&g| normals[g as usize]).collect::<Vec<_>>());
        mesh.insert_attribute(Mesh::ATTRIBUTE_UV_0, part_uvs.clone());
        mesh.insert_attribute(Mesh::ATTRIBUTE_JOINT_INDEX, VertexAttributeValues::Uint16x4(joint_index));
        mesh.insert_attribute(Mesh::ATTRIBUTE_JOINT_WEIGHT, joint_weight);
        mesh.insert_indices(Indices::U32(indices));
        let mesh = assets.meshes.add(mesh);
        let morphs = morphs.map(|(positions_m, uvs_m)| PartMorphs {
            base_positions: part_positions,
            base_uvs: part_uvs,
            positions: positions_m,
            uvs: uvs_m,
            last_weights: Vec::new(),
        });

        let skin = SkinnedMesh {
            inverse_bindposes: assets.bindposes.add(
                joints
                    .iter()
                    .map(|&b| Mat4::from_translation(-animator.skeleton.bones[b as usize].rest))
                    .collect::<Vec<_>>(),
            ),
            joints: joints.iter().map(|&b| bones[b as usize]).collect(),
        };

        // Material.
        let (tex, tex_alpha) = (m.texture >= 0)
            .then(|| repeat_handles.get(&(m.texture as usize)).cloned())
            .flatten()
            .unwrap_or((white.clone(), Alpha::Opaque));
        let sphere_mode = match m.sphere_mode {
            SphereMode::Multiply => 1,
            SphereMode::Add => 2,
            _ => 0,
        };
        let sphere = (sphere_mode != 0 && m.sphere_texture >= 0)
            .then(|| clamp_handles.get(&(m.sphere_texture as usize)).cloned())
            .flatten();
        let sphere_mode = if sphere.is_some() { sphere_mode } else { 0 };
        let toon = match m.toon {
            Toon::Texture(i) if i >= 0 => clamp_handles.get(&(i as usize)).cloned(),
            Toon::Texture(_) => None,
            Toon::Shared(i) => Some(
                shared_toons[i as usize].get_or_insert_with(|| assets.images.add(texture::shared_toon(i))).clone(),
            ),
        };
        let base = MaterialValues {
            diffuse: m.diffuse.into(),
            specular: m.specular.into(),
            specular_power: m.specular_power,
            ambient: m.ambient.into(),
            edge_color: m.edge_color.into(),
            edge_size: m.edge_size,
            texture_tint: Vec4::ONE,
            sphere_tint: Vec4::ONE,
            toon_tint: Vec4::ONE,
        };
        let mut uniform = PmxUniform {
            light_direction: light_direction.extend(0.0),
            light_color,
            flags: UVec4::new(sphere_mode, toon.is_some() as u32, 0, 0),
            ..default()
        };
        uniform.set_values(&base, &MaterialValues::ZERO);
        let alpha_mode = if m.diffuse[3] < 0.999 || tex_alpha == Alpha::Blended { AlphaMode::Blend } else { AlphaMode::Opaque };
        let material = assets.materials.add(PmxMaterial {
            uniform,
            texture: tex,
            sphere: sphere.unwrap_or_else(|| white.clone()),
            toon: toon.unwrap_or_else(|| white.clone()),
            alpha_mode,
            double_sided: m.flags & material_flags::DOUBLE_SIDED != 0,
            order: mi as u32,
        });
        commands.spawn((
            Mesh3d(mesh.clone()),
            MeshMaterial3d(material.clone()),
            skin.clone(),
            NoFrustumCulling,
            Transform::default(),
            ChildOf(root),
            Name::new(m.name.clone()),
        ));

        let edge_color = Vec4::from(m.edge_color);
        let has_edge = m.flags & material_flags::EDGE != 0 && m.edge_size > 0.0 && edge_color.w > 0.0;
        let outline = has_edge.then(|| {
            let handle = assets.outlines.add(OutlineMaterial {
                uniform: OutlineUniform { color: edge_color, width: m.edge_size * render.outline_scale },
                alpha_mode: if edge_color.w < 0.999 { AlphaMode::Blend } else { AlphaMode::Opaque },
                order: mi as u32,
            });
            let visibility = if render.outline { Visibility::Inherited } else { Visibility::Hidden };
            commands.spawn((
                Mesh3d(mesh.clone()),
                MeshMaterial3d(handle.clone()),
                skin,
                NoFrustumCulling,
                Transform::default(),
                visibility,
                OutlinePart,
                ChildOf(root),
            ));
            handle
        });

        parts.push(Part {
            material_index: mi,
            mesh,
            material,
            outline,
            base,
            edge_color,
            edge_size: m.edge_size,
            morphs,
            last_material: MaterialMorph::default(),
        });
    }

    commands.entity(root).insert(MmdModel {
        name,
        path,
        animator,
        rig,
        bones,
        parts,
        vertex_count: model.vertices.len(),
        face_count: model.indices.len() / 3,
        bounds: (min, max),
        warnings,
    });
    root
}

type MorphTables = (Vec<(usize, Vec<(u32, Vec3)>)>, Vec<(usize, Vec<(u32, Vec2)>)>);

/// The vertex and UV morphs that move vertices of one part, in its local indices.
fn part_morphs(animator: &Animator, local_of: &HashMap<u32, u32>) -> Option<MorphTables> {
    let mut positions = Vec::new();
    let mut uvs = Vec::new();
    for (mi, kind) in animator.morphs.kinds.iter().enumerate() {
        match kind {
            Kind::Vertex(items) => {
                let local: Vec<(u32, Vec3)> = items.iter().filter_map(|(v, o)| local_of.get(v).map(|&l| (l, *o))).collect();
                if !local.is_empty() {
                    positions.push((mi, local));
                }
            }
            Kind::Uv(items) => {
                let local: Vec<(u32, Vec2)> = items.iter().filter_map(|(v, o)| local_of.get(v).map(|&l| (l, *o))).collect();
                if !local.is_empty() {
                    uvs.push((mi, local));
                }
            }
            _ => {}
        }
    }
    (!positions.is_empty() || !uvs.is_empty()).then_some((positions, uvs))
}

impl MmdModel {
    /// Uploads the morphed vertices of parts whose morph weights changed.
    pub fn update_morphs(&mut self, meshes: &mut Assets<Mesh>) {
        let effective = &self.animator.effective;
        for part in &mut self.parts {
            let Some(pm) = part.morphs.as_mut() else { continue };
            let weights: Vec<f32> = pm
                .positions
                .iter()
                .map(|(m, _)| effective[*m])
                .chain(pm.uvs.iter().map(|(m, _)| effective[*m]))
                .collect();
            let changed = pm.last_weights.len() != weights.len()
                || pm.last_weights.iter().zip(&weights).any(|(a, b)| (a - b).abs() > 1.0e-4);
            if !changed {
                continue;
            }
            let Some(mut mesh) = meshes.get_mut(&part.mesh) else { continue };
            if !pm.positions.is_empty() {
                let mut positions = pm.base_positions.clone();
                for (m, offsets) in &pm.positions {
                    let w = effective[*m];
                    if w == 0.0 {
                        continue;
                    }
                    for (l, o) in offsets {
                        let p = &mut positions[*l as usize];
                        p[0] += o.x * w;
                        p[1] += o.y * w;
                        p[2] += o.z * w;
                    }
                }
                mesh.insert_attribute(Mesh::ATTRIBUTE_POSITION, positions);
            }
            if !pm.uvs.is_empty() {
                let mut uvs = pm.base_uvs.clone();
                for (m, offsets) in &pm.uvs {
                    let w = effective[*m];
                    for (l, o) in offsets {
                        let uv = &mut uvs[*l as usize];
                        uv[0] += o.x * w;
                        uv[1] += o.y * w;
                    }
                }
                mesh.insert_attribute(Mesh::ATTRIBUTE_UV_0, uvs);
            }
            pm.last_weights = weights;
        }
    }

    /// Applies material morphs to the material and edge uniforms that changed.
    pub fn update_materials(&mut self, materials: &mut Assets<PmxMaterial>, outlines: &mut Assets<OutlineMaterial>, outline_scale: f32) {
        for part in &mut self.parts {
            let state = self.animator.materials[part.material_index];
            if state == part.last_material {
                continue;
            }
            part.last_material = state;
            let values = state.apply(part.base);
            if let Some(mut m) = materials.get_mut(&part.material) {
                m.uniform.set_values(&values, &state.add);
                // Tints are applied as texel·mul + add in the shader.
                m.uniform.texture_mul = state.mul.texture_tint;
                m.uniform.sphere_mul = state.mul.sphere_tint;
                m.uniform.toon_mul = state.mul.toon_tint;
            }
            if let Some(handle) = &part.outline
                && let Some(mut o) = outlines.get_mut(handle)
            {
                o.uniform.color = values.edge_color;
                o.uniform.width = values.edge_size * outline_scale;
            }
        }
    }

    pub fn height(&self) -> f32 {
        (self.bounds.1.y - self.bounds.0.y).max(1.0)
    }
}
