//! PMX 2.0 / 2.1 models.

use super::FormatError;
use super::reader::{Encoding, Reader, read_text};

#[derive(Clone, Debug, Default, PartialEq)]
pub struct PmxModel {
    pub version: f32,
    pub header: Header,
    pub name: String,
    pub name_en: String,
    pub comment: String,
    pub vertices: Vec<Vertex>,
    /// Triangle list, three vertex indices per face.
    pub indices: Vec<u32>,
    pub textures: Vec<String>,
    pub materials: Vec<Material>,
    pub bones: Vec<Bone>,
    pub morphs: Vec<Morph>,
    pub rigid_bodies: Vec<RigidBody>,
    pub joints: Vec<Joint>,
}

#[derive(Clone, Copy, Debug, PartialEq)]
pub struct Header {
    pub encoding: Encoding,
    pub additional_uv: u8,
    pub vertex_index_size: u8,
    pub texture_index_size: u8,
    pub material_index_size: u8,
    pub bone_index_size: u8,
    pub morph_index_size: u8,
    pub rigid_index_size: u8,
}

impl Default for Header {
    fn default() -> Self {
        Self {
            encoding: Encoding::Utf16,
            additional_uv: 0,
            vertex_index_size: 4,
            texture_index_size: 4,
            material_index_size: 4,
            bone_index_size: 4,
            morph_index_size: 4,
            rigid_index_size: 4,
        }
    }
}

#[derive(Clone, Debug, PartialEq)]
pub enum Weight {
    Bdef1 { bone: i32 },
    Bdef2 { bones: [i32; 2], weight: f32 },
    Bdef4 { bones: [i32; 4], weights: [f32; 4] },
    Sdef { bones: [i32; 2], weight: f32, c: [f32; 3], r0: [f32; 3], r1: [f32; 3] },
    Qdef { bones: [i32; 4], weights: [f32; 4] },
}

impl Weight {
    /// Up to four (bone, weight) pairs with the weights normalised; unused slots are
    /// bone 0 with weight 0. SDEF and QDEF fall back to linear blending.
    pub fn linear(&self) -> ([u32; 4], [f32; 4]) {
        let (bones, weights): ([i32; 4], [f32; 4]) = match *self {
            Weight::Bdef1 { bone } => ([bone, -1, -1, -1], [1.0, 0.0, 0.0, 0.0]),
            Weight::Bdef2 { bones, weight } | Weight::Sdef { bones, weight, .. } => {
                ([bones[0], bones[1], -1, -1], [weight, 1.0 - weight, 0.0, 0.0])
            }
            Weight::Bdef4 { bones, weights } | Weight::Qdef { bones, weights } => (bones, weights),
        };
        let mut out_b = [0u32; 4];
        let mut out_w = [0f32; 4];
        let mut sum = 0.0;
        for i in 0..4 {
            if bones[i] >= 0 && weights[i] > 0.0 && weights[i].is_finite() {
                out_b[i] = bones[i] as u32;
                out_w[i] = weights[i];
                sum += weights[i];
            }
        }
        if sum > 0.0 {
            out_w.iter_mut().for_each(|w| *w /= sum);
        } else {
            out_b = [bones[0].max(0) as u32, 0, 0, 0];
            out_w = [1.0, 0.0, 0.0, 0.0];
        }
        (out_b, out_w)
    }
}

#[derive(Clone, Debug, PartialEq)]
pub struct Vertex {
    pub position: [f32; 3],
    pub normal: [f32; 3],
    pub uv: [f32; 2],
    pub additional_uv: Vec<[f32; 4]>,
    pub weight: Weight,
    pub edge_scale: f32,
}

pub mod material_flags {
    pub const DOUBLE_SIDED: u8 = 0x01;
    pub const GROUND_SHADOW: u8 = 0x02;
    pub const CAST_SHADOW: u8 = 0x04;
    pub const RECEIVE_SHADOW: u8 = 0x08;
    pub const EDGE: u8 = 0x10;
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum SphereMode {
    None,
    Multiply,
    Add,
    SubTexture,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Toon {
    /// Index into `PmxModel::textures`, or -1.
    Texture(i32),
    /// One of MikuMikuDance's shared `toon01.bmp` … `toon10.bmp` (0-based).
    Shared(u8),
}

#[derive(Clone, Debug, PartialEq)]
pub struct Material {
    pub name: String,
    pub name_en: String,
    pub diffuse: [f32; 4],
    pub specular: [f32; 3],
    pub specular_power: f32,
    pub ambient: [f32; 3],
    pub flags: u8,
    pub edge_color: [f32; 4],
    pub edge_size: f32,
    pub texture: i32,
    pub sphere_texture: i32,
    pub sphere_mode: SphereMode,
    pub toon: Toon,
    pub memo: String,
    /// Number of indices (not faces) of this material in `PmxModel::indices`.
    pub index_count: u32,
}

pub mod bone_flags {
    pub const TAIL_IS_BONE: u16 = 0x0001;
    pub const ROTATABLE: u16 = 0x0002;
    pub const TRANSLATABLE: u16 = 0x0004;
    pub const VISIBLE: u16 = 0x0008;
    pub const ENABLED: u16 = 0x0010;
    pub const IK: u16 = 0x0020;
    pub const LOCAL_INHERIT: u16 = 0x0080;
    pub const INHERIT_ROTATION: u16 = 0x0100;
    pub const INHERIT_TRANSLATION: u16 = 0x0200;
    pub const FIXED_AXIS: u16 = 0x0400;
    pub const LOCAL_AXIS: u16 = 0x0800;
    pub const AFTER_PHYSICS: u16 = 0x1000;
    pub const EXTERNAL_PARENT: u16 = 0x2000;
}

#[derive(Clone, Debug, PartialEq)]
pub enum BoneTail {
    Bone(i32),
    Offset([f32; 3]),
}

#[derive(Clone, Debug, PartialEq)]
pub struct IkLink {
    pub bone: i32,
    /// Euler limits (min, max) in radians.
    pub limit: Option<([f32; 3], [f32; 3])>,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Ik {
    pub target: i32,
    pub iterations: u32,
    /// Largest rotation per iteration and link, in radians.
    pub limit_angle: f32,
    pub links: Vec<IkLink>,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Bone {
    pub name: String,
    pub name_en: String,
    pub position: [f32; 3],
    pub parent: i32,
    /// Deformation layer: bones are evaluated by (after_physics, layer, index).
    pub layer: i32,
    pub flags: u16,
    pub tail: BoneTail,
    /// Inherited ("append") rotation and/or translation: (source bone, ratio).
    pub inherit: Option<(i32, f32)>,
    pub fixed_axis: Option<[f32; 3]>,
    pub local_axes: Option<([f32; 3], [f32; 3])>,
    pub external_key: Option<i32>,
    pub ik: Option<Ik>,
}

impl Bone {
    pub fn has(&self, flag: u16) -> bool {
        self.flags & flag != 0
    }
}

#[derive(Clone, Debug, PartialEq)]
pub struct MaterialOffset {
    /// -1 targets every material.
    pub material: i32,
    /// 0 multiplies, 1 adds.
    pub operation: u8,
    pub diffuse: [f32; 4],
    pub specular: [f32; 3],
    pub specular_power: f32,
    pub ambient: [f32; 3],
    pub edge_color: [f32; 4],
    pub edge_size: f32,
    pub texture_tint: [f32; 4],
    pub sphere_tint: [f32; 4],
    pub toon_tint: [f32; 4],
}

#[derive(Clone, Debug, PartialEq)]
pub enum MorphKind {
    Group(Vec<(i32, f32)>),
    Vertex(Vec<(u32, [f32; 3])>),
    Bone(Vec<(i32, [f32; 3], [f32; 4])>),
    /// UV (channel 0) or additional UV 1..4 offsets.
    Uv { channel: u8, offsets: Vec<(u32, [f32; 4])> },
    Material(Vec<MaterialOffset>),
    Flip(Vec<(i32, f32)>),
    Impulse(Vec<(i32, bool, [f32; 3], [f32; 3])>),
}

#[derive(Clone, Debug, PartialEq)]
pub struct Morph {
    pub name: String,
    pub name_en: String,
    pub panel: u8,
    pub kind: MorphKind,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum RigidShape {
    Sphere,
    Box,
    Capsule,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum RigidMode {
    /// Kinematic: the body follows its bone.
    FollowBone,
    /// Simulated: the bone follows the body.
    Physics,
    /// Simulated rotation; the bone keeps its animated position.
    PhysicsWithBone,
}

#[derive(Clone, Debug, PartialEq)]
pub struct RigidBody {
    pub name: String,
    pub name_en: String,
    pub bone: i32,
    pub group: u8,
    /// Groups this body does *not* collide with (bit set = no collision).
    pub no_collision: u16,
    pub shape: RigidShape,
    pub size: [f32; 3],
    pub position: [f32; 3],
    pub rotation: [f32; 3],
    pub mass: f32,
    /// MMD damping: the fraction of velocity lost per second.
    pub linear_damping: f32,
    pub angular_damping: f32,
    pub restitution: f32,
    pub friction: f32,
    pub mode: RigidMode,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Joint {
    pub name: String,
    pub name_en: String,
    pub body_a: i32,
    pub body_b: i32,
    pub position: [f32; 3],
    pub rotation: [f32; 3],
    pub linear_lower: [f32; 3],
    pub linear_upper: [f32; 3],
    pub angular_lower: [f32; 3],
    pub angular_upper: [f32; 3],
    pub linear_spring: [f32; 3],
    pub angular_spring: [f32; 3],
}

impl PmxModel {
    pub fn parse(bytes: &[u8]) -> Result<Self, FormatError> {
        let mut r = Reader::new(bytes);
        if r.bytes(4).ok() != Some(b"PMX ".as_slice()) {
            return Err(FormatError::Signature("PMX".into()));
        }
        let version = r.f32()?;
        if !(2.0..2.2).contains(&version) {
            return Err(FormatError::Signature(format!("PMX 2.x (version {version})")));
        }
        let globals = r.u8()? as usize;
        let g = r.bytes(globals)?;
        if g.len() < 8 {
            return Err(FormatError::Invalid("PMX header has fewer than 8 globals".into()));
        }
        let header = Header {
            encoding: if g[0] == 1 { Encoding::Utf8 } else { Encoding::Utf16 },
            additional_uv: g[1].min(4),
            vertex_index_size: g[2],
            texture_index_size: g[3],
            material_index_size: g[4],
            bone_index_size: g[5],
            morph_index_size: g[6],
            rigid_index_size: g[7],
        };
        let enc = header.encoding;
        let mut model = PmxModel {
            version,
            header,
            name: read_text(&mut r, enc)?,
            name_en: read_text(&mut r, enc)?,
            comment: read_text(&mut r, enc)?,
            ..Default::default()
        };
        let _comment_en = read_text(&mut r, enc)?;

        let n = r.count(41)?;
        model.vertices.reserve(n);
        for _ in 0..n {
            model.vertices.push(read_vertex(&mut r, &header)?);
        }

        let n = r.count(header.vertex_index_size as usize)?;
        if n % 3 != 0 {
            return Err(FormatError::Invalid(format!("{n} face indices is not a triangle list")));
        }
        model.indices.reserve(n);
        for _ in 0..n {
            let i = r.vertex_index(header.vertex_index_size)?;
            if i as usize >= model.vertices.len() {
                return Err(FormatError::Invalid(format!("face index {i} out of range")));
            }
            model.indices.push(i);
        }

        let n = r.count(4)?;
        for _ in 0..n {
            model.textures.push(read_text(&mut r, enc)?);
        }

        let n = r.count(8)?;
        for _ in 0..n {
            model.materials.push(read_material(&mut r, &header)?);
        }
        let used: u64 = model.materials.iter().map(|m| m.index_count as u64).sum();
        if used > model.indices.len() as u64 {
            return Err(FormatError::Invalid("materials cover more faces than the model has".into()));
        }

        let n = r.count(8)?;
        for _ in 0..n {
            model.bones.push(read_bone(&mut r, &header)?);
        }

        let n = r.count(8)?;
        for _ in 0..n {
            model.morphs.push(read_morph(&mut r, &header)?);
        }

        // Display frames: only the editor uses them.
        let n = r.count(8)?;
        for _ in 0..n {
            read_text(&mut r, enc)?;
            read_text(&mut r, enc)?;
            r.u8()?;
            let items = r.count(2)?;
            for _ in 0..items {
                let size = if r.u8()? == 0 { header.bone_index_size } else { header.morph_index_size };
                r.index(size)?;
            }
        }

        // Older exporters stop after the morphs or display frames.
        if r.is_empty() {
            return Ok(model);
        }
        let n = r.count(8)?;
        for _ in 0..n {
            model.rigid_bodies.push(read_rigid(&mut r, &header)?);
        }
        if r.is_empty() {
            return Ok(model);
        }
        let n = r.count(8)?;
        for _ in 0..n {
            model.joints.push(read_joint(&mut r, &header)?);
        }
        // PMX 2.1 soft bodies follow; the viewer simulates the rigid rig only.
        Ok(model)
    }
}

fn read_vertex(r: &mut Reader, h: &Header) -> Result<Vertex, FormatError> {
    let position = r.vec3()?;
    let normal = r.vec3()?;
    let uv = r.vec2()?;
    let mut additional_uv = Vec::with_capacity(h.additional_uv as usize);
    for _ in 0..h.additional_uv {
        additional_uv.push(r.vec4()?);
    }
    let bs = h.bone_index_size;
    let weight = match r.u8()? {
        0 => Weight::Bdef1 { bone: r.index(bs)? },
        1 => Weight::Bdef2 { bones: [r.index(bs)?, r.index(bs)?], weight: r.f32()? },
        2 => Weight::Bdef4 {
            bones: [r.index(bs)?, r.index(bs)?, r.index(bs)?, r.index(bs)?],
            weights: r.vec4()?,
        },
        3 => Weight::Sdef {
            bones: [r.index(bs)?, r.index(bs)?],
            weight: r.f32()?,
            c: r.vec3()?,
            r0: r.vec3()?,
            r1: r.vec3()?,
        },
        4 => Weight::Qdef {
            bones: [r.index(bs)?, r.index(bs)?, r.index(bs)?, r.index(bs)?],
            weights: r.vec4()?,
        },
        t => return Err(FormatError::Invalid(format!("vertex weight type {t}"))),
    };
    Ok(Vertex { position, normal, uv, additional_uv, weight, edge_scale: r.f32()? })
}

fn read_material(r: &mut Reader, h: &Header) -> Result<Material, FormatError> {
    let enc = h.encoding;
    let name = read_text(r, enc)?;
    let name_en = read_text(r, enc)?;
    let diffuse = r.vec4()?;
    let specular = r.vec3()?;
    let specular_power = r.f32()?;
    let ambient = r.vec3()?;
    let flags = r.u8()?;
    let edge_color = r.vec4()?;
    let edge_size = r.f32()?;
    let texture = r.index(h.texture_index_size)?;
    let sphere_texture = r.index(h.texture_index_size)?;
    let sphere_mode = match r.u8()? {
        1 => SphereMode::Multiply,
        2 => SphereMode::Add,
        3 => SphereMode::SubTexture,
        _ => SphereMode::None,
    };
    let toon = if r.u8()? == 1 {
        Toon::Shared(r.u8()?.min(9))
    } else {
        Toon::Texture(r.index(h.texture_index_size)?)
    };
    let memo = read_text(r, enc)?;
    let index_count = r.i32()?;
    if index_count < 0 || index_count % 3 != 0 {
        return Err(FormatError::Invalid(format!("material {name}: {index_count} indices")));
    }
    Ok(Material {
        name,
        name_en,
        diffuse,
        specular,
        specular_power,
        ambient,
        flags,
        edge_color,
        edge_size,
        texture,
        sphere_texture,
        sphere_mode,
        toon,
        memo,
        index_count: index_count as u32,
    })
}

fn read_bone(r: &mut Reader, h: &Header) -> Result<Bone, FormatError> {
    use bone_flags::*;
    let enc = h.encoding;
    let bs = h.bone_index_size;
    let name = read_text(r, enc)?;
    let name_en = read_text(r, enc)?;
    let position = r.vec3()?;
    let parent = r.index(bs)?;
    let layer = r.i32()?;
    let flags = r.u16()?;
    let tail = if flags & TAIL_IS_BONE != 0 { BoneTail::Bone(r.index(bs)?) } else { BoneTail::Offset(r.vec3()?) };
    let inherit = if flags & (INHERIT_ROTATION | INHERIT_TRANSLATION) != 0 {
        Some((r.index(bs)?, r.f32()?))
    } else {
        None
    };
    let fixed_axis = if flags & FIXED_AXIS != 0 { Some(r.vec3()?) } else { None };
    let local_axes = if flags & LOCAL_AXIS != 0 { Some((r.vec3()?, r.vec3()?)) } else { None };
    let external_key = if flags & EXTERNAL_PARENT != 0 { Some(r.i32()?) } else { None };
    let ik = if flags & IK != 0 {
        let target = r.index(bs)?;
        let iterations = r.i32()?.max(0) as u32;
        let limit_angle = r.f32()?;
        let n = r.count(bs as usize + 1)?;
        let mut links = Vec::with_capacity(n);
        for _ in 0..n {
            let bone = r.index(bs)?;
            let limit = if r.u8()? == 1 { Some((r.vec3()?, r.vec3()?)) } else { None };
            links.push(IkLink { bone, limit });
        }
        Some(Ik { target, iterations, limit_angle, links })
    } else {
        None
    };
    Ok(Bone { name, name_en, position, parent, layer, flags, tail, inherit, fixed_axis, local_axes, external_key, ik })
}

fn read_morph(r: &mut Reader, h: &Header) -> Result<Morph, FormatError> {
    let enc = h.encoding;
    let name = read_text(r, enc)?;
    let name_en = read_text(r, enc)?;
    let panel = r.u8()?;
    let kind = r.u8()?;
    let n = r.count(1)?;
    let vs = h.vertex_index_size;
    let kind = match kind {
        0 | 9 => {
            let mut v = Vec::with_capacity(n);
            for _ in 0..n {
                v.push((r.index(h.morph_index_size)?, r.f32()?));
            }
            if kind == 0 { MorphKind::Group(v) } else { MorphKind::Flip(v) }
        }
        1 => {
            let mut v = Vec::with_capacity(n);
            for _ in 0..n {
                v.push((r.vertex_index(vs)?, r.vec3()?));
            }
            MorphKind::Vertex(v)
        }
        2 => {
            let mut v = Vec::with_capacity(n);
            for _ in 0..n {
                v.push((r.index(h.bone_index_size)?, r.vec3()?, r.vec4()?));
            }
            MorphKind::Bone(v)
        }
        3..=7 => {
            let mut offsets = Vec::with_capacity(n);
            for _ in 0..n {
                offsets.push((r.vertex_index(vs)?, r.vec4()?));
            }
            MorphKind::Uv { channel: kind - 3, offsets }
        }
        8 => {
            let mut v = Vec::with_capacity(n);
            for _ in 0..n {
                v.push(MaterialOffset {
                    material: r.index(h.material_index_size)?,
                    operation: r.u8()?,
                    diffuse: r.vec4()?,
                    specular: r.vec3()?,
                    specular_power: r.f32()?,
                    ambient: r.vec3()?,
                    edge_color: r.vec4()?,
                    edge_size: r.f32()?,
                    texture_tint: r.vec4()?,
                    sphere_tint: r.vec4()?,
                    toon_tint: r.vec4()?,
                });
            }
            MorphKind::Material(v)
        }
        10 => {
            let mut v = Vec::with_capacity(n);
            for _ in 0..n {
                v.push((r.index(h.rigid_index_size)?, r.u8()? != 0, r.vec3()?, r.vec3()?));
            }
            MorphKind::Impulse(v)
        }
        t => return Err(FormatError::Invalid(format!("morph {name}: type {t}"))),
    };
    Ok(Morph { name, name_en, panel, kind })
}

fn read_rigid(r: &mut Reader, h: &Header) -> Result<RigidBody, FormatError> {
    let enc = h.encoding;
    let name = read_text(r, enc)?;
    let name_en = read_text(r, enc)?;
    let bone = r.index(h.bone_index_size)?;
    let group = r.u8()?.min(15);
    let no_collision = r.u16()?;
    let shape = match r.u8()? {
        0 => RigidShape::Sphere,
        1 => RigidShape::Box,
        _ => RigidShape::Capsule,
    };
    let size = r.vec3()?;
    let position = r.vec3()?;
    let rotation = r.vec3()?;
    let mass = r.f32()?;
    let linear_damping = r.f32()?;
    let angular_damping = r.f32()?;
    let restitution = r.f32()?;
    let friction = r.f32()?;
    let mode = match r.u8()? {
        0 => RigidMode::FollowBone,
        1 => RigidMode::Physics,
        _ => RigidMode::PhysicsWithBone,
    };
    Ok(RigidBody {
        name,
        name_en,
        bone,
        group,
        no_collision,
        shape,
        size,
        position,
        rotation,
        mass,
        linear_damping,
        angular_damping,
        restitution,
        friction,
        mode,
    })
}

fn read_joint(r: &mut Reader, h: &Header) -> Result<Joint, FormatError> {
    let enc = h.encoding;
    let name = read_text(r, enc)?;
    let name_en = read_text(r, enc)?;
    // PMX 2.1 joint types (6DOF, P2P, cone twist, …) share one layout; all are read as
    // the 6DOF spring every MMD rig uses.
    let _kind = r.u8()?;
    Ok(Joint {
        name,
        name_en,
        body_a: r.index(h.rigid_index_size)?,
        body_b: r.index(h.rigid_index_size)?,
        position: r.vec3()?,
        rotation: r.vec3()?,
        linear_lower: r.vec3()?,
        linear_upper: r.vec3()?,
        angular_lower: r.vec3()?,
        angular_upper: r.vec3()?,
        linear_spring: r.vec3()?,
        angular_spring: r.vec3()?,
    })
}
