//! PMX morphs: group morphs expand into their members, then vertex, UV, bone and
//! material morphs each contribute with their effective weight.

use glam::{Quat, Vec2, Vec3, Vec4};

use super::coords;
use crate::format::pmx::{MaterialOffset, MorphKind, PmxModel};

#[derive(Clone, Debug)]
pub enum Kind {
    Group(Vec<(usize, f32)>),
    Vertex(Vec<(u32, Vec3)>),
    Uv(Vec<(u32, Vec2)>),
    Bone(Vec<(usize, Vec3, Quat)>),
    Material(Vec<MaterialOffset>),
    /// Additional-UV and impulse morphs: nothing to draw.
    Inert,
}

#[derive(Clone, Debug, Default)]
pub struct MorphRig {
    pub names: Vec<String>,
    pub kinds: Vec<Kind>,
}

/// Material values a material morph scales or offsets.
#[derive(Clone, Copy, Debug, PartialEq)]
pub struct MaterialValues {
    pub diffuse: Vec4,
    pub specular: Vec3,
    pub specular_power: f32,
    pub ambient: Vec3,
    pub edge_color: Vec4,
    pub edge_size: f32,
    pub texture_tint: Vec4,
    pub sphere_tint: Vec4,
    pub toon_tint: Vec4,
}

impl MaterialValues {
    pub const ONE: Self = Self::splat(1.0);
    pub const ZERO: Self = Self::splat(0.0);

    const fn splat(v: f32) -> Self {
        Self {
            diffuse: Vec4::splat(v),
            specular: Vec3::splat(v),
            specular_power: v,
            ambient: Vec3::splat(v),
            edge_color: Vec4::splat(v),
            edge_size: v,
            texture_tint: Vec4::splat(v),
            sphere_tint: Vec4::splat(v),
            toon_tint: Vec4::splat(v),
        }
    }

    fn of(o: &MaterialOffset) -> Self {
        Self {
            diffuse: o.diffuse.into(),
            specular: o.specular.into(),
            specular_power: o.specular_power,
            ambient: o.ambient.into(),
            edge_color: o.edge_color.into(),
            edge_size: o.edge_size,
            texture_tint: o.texture_tint.into(),
            sphere_tint: o.sphere_tint.into(),
            toon_tint: o.toon_tint.into(),
        }
    }

    fn map2(self, other: Self, f: impl Fn(f32, f32) -> f32) -> Self {
        let v4 = |a: Vec4, b: Vec4| Vec4::new(f(a.x, b.x), f(a.y, b.y), f(a.z, b.z), f(a.w, b.w));
        let v3 = |a: Vec3, b: Vec3| Vec3::new(f(a.x, b.x), f(a.y, b.y), f(a.z, b.z));
        Self {
            diffuse: v4(self.diffuse, other.diffuse),
            specular: v3(self.specular, other.specular),
            specular_power: f(self.specular_power, other.specular_power),
            ambient: v3(self.ambient, other.ambient),
            edge_color: v4(self.edge_color, other.edge_color),
            edge_size: f(self.edge_size, other.edge_size),
            texture_tint: v4(self.texture_tint, other.texture_tint),
            sphere_tint: v4(self.sphere_tint, other.sphere_tint),
            toon_tint: v4(self.toon_tint, other.toon_tint),
        }
    }
}

/// Accumulated material morphs of one material: `base * mul + add`.
#[derive(Clone, Copy, Debug, PartialEq)]
pub struct MaterialMorph {
    pub mul: MaterialValues,
    pub add: MaterialValues,
}

impl Default for MaterialMorph {
    fn default() -> Self {
        Self { mul: MaterialValues::ONE, add: MaterialValues::ZERO }
    }
}

impl MaterialMorph {
    pub fn apply(&self, base: MaterialValues) -> MaterialValues {
        base.map2(self.mul, |b, m| b * m).map2(self.add, |b, a| b + a)
    }
}

const MAX_GROUP_DEPTH: u32 = 8;

impl MorphRig {
    pub fn from_pmx(model: &PmxModel) -> Self {
        let n = model.morphs.len();
        let bones = model.bones.len();
        let mut names = Vec::with_capacity(n);
        let mut kinds = Vec::with_capacity(n);
        for (index, m) in model.morphs.iter().enumerate() {
            names.push(m.name.clone());
            let in_range = |i: i32, len: usize| (i >= 0 && (i as usize) < len).then_some(i as usize);
            kinds.push(match &m.kind {
                MorphKind::Group(items) | MorphKind::Flip(items) => Kind::Group(
                    items
                        .iter()
                        .filter_map(|&(i, w)| in_range(i, n).filter(|&i| i != index).map(|i| (i, w)))
                        .collect(),
                ),
                MorphKind::Vertex(items) => Kind::Vertex(
                    items
                        .iter()
                        .filter(|(v, _)| (*v as usize) < model.vertices.len())
                        .map(|&(v, o)| (v, coords::position(o)))
                        .collect(),
                ),
                MorphKind::Uv { channel: 0, offsets } => Kind::Uv(
                    offsets
                        .iter()
                        .filter(|(v, _)| (*v as usize) < model.vertices.len())
                        .map(|&(v, o)| (v, Vec2::new(o[0], o[1])))
                        .collect(),
                ),
                MorphKind::Bone(items) => Kind::Bone(
                    items
                        .iter()
                        .filter_map(|&(b, t, r)| in_range(b, bones).map(|b| (b, coords::position(t), coords::quat(r))))
                        .collect(),
                ),
                MorphKind::Material(items) => Kind::Material(items.clone()),
                _ => Kind::Inert,
            });
        }
        Self { names, kinds }
    }

    pub fn len(&self) -> usize {
        self.names.len()
    }

    pub fn is_empty(&self) -> bool {
        self.names.is_empty()
    }

    /// Effective weight of every morph: its own weight plus what group morphs pass on.
    pub fn expand(&self, weights: &[f32], effective: &mut Vec<f32>) {
        effective.clear();
        effective.resize(self.len(), 0.0);
        for (i, &w) in weights.iter().enumerate().take(self.len()) {
            if w != 0.0 {
                self.add_weight(i, w, effective, 0);
            }
        }
    }

    fn add_weight(&self, i: usize, w: f32, effective: &mut [f32], depth: u32) {
        match &self.kinds[i] {
            Kind::Group(members) if depth < MAX_GROUP_DEPTH => {
                for &(m, ratio) in members {
                    self.add_weight(m, w * ratio, effective, depth + 1);
                }
            }
            _ => effective[i] += w,
        }
    }

    /// Adds bone morphs to the animated local transforms.
    pub fn apply_bones(&self, effective: &[f32], translation: &mut [Vec3], rotation: &mut [Quat]) {
        for (kind, &w) in self.kinds.iter().zip(effective) {
            if let Kind::Bone(items) = kind
                && w != 0.0
            {
                for &(b, t, r) in items {
                    if b < translation.len() {
                        translation[b] += t * w;
                        rotation[b] = (rotation[b] * Quat::IDENTITY.slerp(r, w)).normalize();
                    }
                }
            }
        }
    }

    /// Material morph state per material.
    pub fn materials(&self, effective: &[f32], count: usize, out: &mut Vec<MaterialMorph>) {
        out.clear();
        out.resize(count, MaterialMorph::default());
        for (kind, &w) in self.kinds.iter().zip(effective) {
            let Kind::Material(items) = kind else { continue };
            if w == 0.0 {
                continue;
            }
            for o in items {
                let value = MaterialValues::of(o);
                let targets = if o.material < 0 { 0..count } else { o.material as usize..(o.material as usize + 1).min(count) };
                for m in targets {
                    let state = &mut out[m];
                    if o.operation == 0 {
                        state.mul = state.mul.map2(value, |acc, v| acc * (1.0 + (v - 1.0) * w));
                    } else {
                        state.add = state.add.map2(value, |acc, v| acc + v * w);
                    }
                }
            }
        }
    }

    pub fn has_material_morphs(&self) -> bool {
        self.kinds.iter().any(|k| matches!(k, Kind::Material(_)))
    }
}
