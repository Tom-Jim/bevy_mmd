//! Synthetic models and motions for the tests, and PMX/VMD writers so the parsers can
//! be checked on bytes built here.

#![allow(dead_code)]

use bevy3d_animation::format::pmx::*;
use bevy3d_animation::format::reader::encode_sjis;
use bevy3d_animation::format::vmd::{Bezier, BoneKey, IkKey, MorphKey, VmdMotion};

pub fn bone(name: &str, position: [f32; 3], parent: i32) -> Bone {
    Bone {
        name: name.into(),
        name_en: String::new(),
        position,
        parent,
        layer: 0,
        flags: bone_flags::ROTATABLE | bone_flags::VISIBLE | bone_flags::ENABLED,
        tail: BoneTail::Offset([0.0, 1.0, 0.0]),
        inherit: None,
        fixed_axis: None,
        local_axes: None,
        external_key: None,
        ik: None,
    }
}

pub fn vertex(position: [f32; 3], weight: Weight) -> Vertex {
    Vertex { position, normal: [0.0, 0.0, -1.0], uv: [0.0, 0.0], additional_uv: Vec::new(), weight, edge_scale: 1.0 }
}

pub fn material(name: &str, index_count: u32) -> Material {
    Material {
        name: name.into(),
        name_en: String::new(),
        diffuse: [1.0, 1.0, 1.0, 1.0],
        specular: [0.0; 3],
        specular_power: 5.0,
        ambient: [0.5; 3],
        flags: material_flags::EDGE,
        edge_color: [0.0, 0.0, 0.0, 1.0],
        edge_size: 1.0,
        texture: -1,
        sphere_texture: -1,
        sphere_mode: SphereMode::None,
        toon: Toon::Shared(0),
        memo: String::new(),
        index_count,
    }
}

/// A two-bone leg with IK: 腰 (root) → 足 → ひざ → 足首, and 足ＩＫ targeting 足首.
pub fn leg() -> PmxModel {
    let mut bones = vec![
        bone("腰", [0.0, 10.0, 0.0], -1),
        bone("足", [0.0, 10.0, 0.0], 0),
        bone("ひざ", [0.0, 5.0, 0.0], 1),
        bone("足首", [0.0, 0.0, 0.0], 2),
        bone("足ＩＫ", [0.0, 0.0, 0.0], -1),
    ];
    bones[4].flags |= bone_flags::IK | bone_flags::TRANSLATABLE;
    bones[4].ik = Some(Ik {
        target: 3,
        iterations: 40,
        limit_angle: 2.0,
        links: vec![
            // Knee: bends around X only (PMX left-handed limits).
            IkLink { bone: 2, limit: Some(([-3.14, 0.0, 0.0], [-0.008, 0.0, 0.0])) },
            IkLink { bone: 1, limit: None },
        ],
    });
    let vertices = vec![
        vertex([0.0, 10.0, 0.0], Weight::Bdef1 { bone: 1 }),
        vertex([0.5, 5.0, 0.0], Weight::Bdef2 { bones: [1, 2], weight: 0.5 }),
        vertex([0.0, 0.0, 0.0], Weight::Bdef1 { bone: 3 }),
    ];
    PmxModel {
        version: 2.0,
        name: "leg".into(),
        vertices,
        indices: vec![0, 1, 2],
        materials: vec![material("skin", 3)],
        bones,
        ..Default::default()
    }
}

/// A hanging chain: a kinematic anchor body on `root` and `links` simulated capsules on
/// bones below it, joined by limited joints.
pub fn chain(links: usize) -> PmxModel {
    let mut bones = vec![bone("root", [0.0, 20.0, 0.0], -1)];
    let mut rigid_bodies = vec![rigid("anchor", 0, [0.0, 20.0, 0.0], RigidMode::FollowBone)];
    let mut joints = Vec::new();
    for i in 0..links {
        let y = 20.0 - 2.0 * (i as f32 + 1.0);
        bones.push(bone(&format!("link{i}"), [0.0, y + 2.0, 0.0], i as i32));
        rigid_bodies.push(rigid(&format!("link{i}"), i as i32 + 1, [0.0, y + 1.0, 0.0], RigidMode::Physics));
        joints.push(Joint {
            name: format!("j{i}"),
            name_en: String::new(),
            body_a: i as i32,
            body_b: i as i32 + 1,
            position: [0.0, y + 2.0, 0.0],
            rotation: [0.0; 3],
            linear_lower: [0.0; 3],
            linear_upper: [0.0; 3],
            angular_lower: [-0.5; 3],
            angular_upper: [0.5; 3],
            linear_spring: [0.0; 3],
            angular_spring: [10.0; 3],
        });
    }
    PmxModel { version: 2.0, name: "chain".into(), bones, rigid_bodies, joints, ..Default::default() }
}

pub fn rigid(name: &str, bone: i32, position: [f32; 3], mode: RigidMode) -> RigidBody {
    RigidBody {
        name: name.into(),
        name_en: String::new(),
        bone,
        group: 1,
        no_collision: 0xffff,
        shape: RigidShape::Capsule,
        size: [0.3, 1.0, 0.0],
        position,
        rotation: [0.0; 3],
        mass: 1.0,
        linear_damping: 0.5,
        angular_damping: 0.5,
        restitution: 0.0,
        friction: 0.5,
        mode,
    }
}

pub fn key(bone: &str, frame: u32, translation: [f32; 3], rotation: [f32; 4]) -> BoneKey {
    BoneKey { bone: bone.into(), frame, translation, rotation, curves: [Bezier::LINEAR; 4] }
}

// ---- writers ---------------------------------------------------------------

struct W(Vec<u8>, Header);

impl W {
    fn u8(&mut self, v: u8) {
        self.0.push(v);
    }
    fn i32(&mut self, v: i32) {
        self.0.extend_from_slice(&v.to_le_bytes());
    }
    fn u16(&mut self, v: u16) {
        self.0.extend_from_slice(&v.to_le_bytes());
    }
    fn f32s(&mut self, v: &[f32]) {
        for x in v {
            self.0.extend_from_slice(&x.to_le_bytes());
        }
    }
    fn text(&mut self, s: &str) {
        let bytes: Vec<u8> = s.encode_utf16().flat_map(u16::to_le_bytes).collect();
        self.i32(bytes.len() as i32);
        self.0.extend_from_slice(&bytes);
    }
    fn index(&mut self, v: i32, size: u8) {
        match size {
            1 => self.u8(v as i8 as u8),
            2 => self.u16(v as i16 as u16),
            _ => self.i32(v),
        }
    }
}

/// PMX 2.0 bytes (UTF-16, the index sizes of `model.header`) for everything the
/// parser reads except soft bodies.
pub fn write_pmx(model: &PmxModel) -> Vec<u8> {
    let h = model.header;
    let mut w = W(Vec::new(), h);
    w.0.extend_from_slice(b"PMX ");
    w.f32s(&[2.0]);
    w.u8(8);
    w.0.extend_from_slice(&[0, h.additional_uv, h.vertex_index_size, h.texture_index_size, h.material_index_size, h.bone_index_size, h.morph_index_size, h.rigid_index_size]);
    for s in [&model.name, &model.name_en, &model.comment, &String::new()] {
        w.text(s);
    }
    let bs = h.bone_index_size;
    w.i32(model.vertices.len() as i32);
    for v in &model.vertices {
        w.f32s(&v.position);
        w.f32s(&v.normal);
        w.f32s(&v.uv);
        for uv in &v.additional_uv {
            w.f32s(uv);
        }
        match &v.weight {
            Weight::Bdef1 { bone } => {
                w.u8(0);
                w.index(*bone, bs);
            }
            Weight::Bdef2 { bones, weight } => {
                w.u8(1);
                w.index(bones[0], bs);
                w.index(bones[1], bs);
                w.f32s(&[*weight]);
            }
            Weight::Bdef4 { bones, weights } => {
                w.u8(2);
                bones.iter().for_each(|b| w.index(*b, bs));
                w.f32s(weights);
            }
            Weight::Sdef { bones, weight, c, r0, r1 } => {
                w.u8(3);
                w.index(bones[0], bs);
                w.index(bones[1], bs);
                w.f32s(&[*weight]);
                w.f32s(c);
                w.f32s(r0);
                w.f32s(r1);
            }
            Weight::Qdef { bones, weights } => {
                w.u8(4);
                bones.iter().for_each(|b| w.index(*b, bs));
                w.f32s(weights);
            }
        }
        w.f32s(&[v.edge_scale]);
    }
    w.i32(model.indices.len() as i32);
    for &i in &model.indices {
        match h.vertex_index_size {
            1 => w.u8(i as u8),
            2 => w.u16(i as u16),
            _ => w.i32(i as i32),
        }
    }
    w.i32(model.textures.len() as i32);
    model.textures.iter().for_each(|t| w.text(t));
    w.i32(model.materials.len() as i32);
    for m in &model.materials {
        w.text(&m.name);
        w.text(&m.name_en);
        w.f32s(&m.diffuse);
        w.f32s(&m.specular);
        w.f32s(&[m.specular_power]);
        w.f32s(&m.ambient);
        w.u8(m.flags);
        w.f32s(&m.edge_color);
        w.f32s(&[m.edge_size]);
        w.index(m.texture, h.texture_index_size);
        w.index(m.sphere_texture, h.texture_index_size);
        w.u8(match m.sphere_mode {
            SphereMode::None => 0,
            SphereMode::Multiply => 1,
            SphereMode::Add => 2,
            SphereMode::SubTexture => 3,
        });
        match m.toon {
            Toon::Shared(i) => {
                w.u8(1);
                w.u8(i);
            }
            Toon::Texture(i) => {
                w.u8(0);
                w.index(i, h.texture_index_size);
            }
        }
        w.text(&m.memo);
        w.i32(m.index_count as i32);
    }
    w.i32(model.bones.len() as i32);
    for b in &model.bones {
        w.text(&b.name);
        w.text(&b.name_en);
        w.f32s(&b.position);
        w.index(b.parent, bs);
        w.i32(b.layer);
        w.u16(b.flags);
        match &b.tail {
            BoneTail::Bone(i) => w.index(*i, bs),
            BoneTail::Offset(o) => w.f32s(o),
        }
        if let Some((i, r)) = b.inherit {
            w.index(i, bs);
            w.f32s(&[r]);
        }
        if let Some(a) = b.fixed_axis {
            w.f32s(&a);
        }
        if let Some((x, z)) = b.local_axes {
            w.f32s(&x);
            w.f32s(&z);
        }
        if let Some(k) = b.external_key {
            w.i32(k);
        }
        if let Some(ik) = &b.ik {
            w.index(ik.target, bs);
            w.i32(ik.iterations as i32);
            w.f32s(&[ik.limit_angle]);
            w.i32(ik.links.len() as i32);
            for l in &ik.links {
                w.index(l.bone, bs);
                match l.limit {
                    Some((lo, hi)) => {
                        w.u8(1);
                        w.f32s(&lo);
                        w.f32s(&hi);
                    }
                    None => w.u8(0),
                }
            }
        }
    }
    w.i32(model.morphs.len() as i32);
    for m in &model.morphs {
        w.text(&m.name);
        w.text(&m.name_en);
        w.u8(m.panel);
        match &m.kind {
            MorphKind::Group(items) => {
                w.u8(0);
                w.i32(items.len() as i32);
                for (i, r) in items {
                    w.index(*i, h.morph_index_size);
                    w.f32s(&[*r]);
                }
            }
            MorphKind::Vertex(items) => {
                w.u8(1);
                w.i32(items.len() as i32);
                for (v, o) in items {
                    match h.vertex_index_size {
                        1 => w.u8(*v as u8),
                        2 => w.u16(*v as u16),
                        _ => w.i32(*v as i32),
                    }
                    w.f32s(o);
                }
            }
            MorphKind::Bone(items) => {
                w.u8(2);
                w.i32(items.len() as i32);
                for (b, t, r) in items {
                    w.index(*b, bs);
                    w.f32s(t);
                    w.f32s(r);
                }
            }
            other => panic!("writer does not support {other:?}"),
        }
    }
    w.i32(0); // display frames
    w.i32(model.rigid_bodies.len() as i32);
    for r in &model.rigid_bodies {
        w.text(&r.name);
        w.text(&r.name_en);
        w.index(r.bone, bs);
        w.u8(r.group);
        w.u16(r.no_collision);
        w.u8(match r.shape {
            RigidShape::Sphere => 0,
            RigidShape::Box => 1,
            RigidShape::Capsule => 2,
        });
        w.f32s(&r.size);
        w.f32s(&r.position);
        w.f32s(&r.rotation);
        w.f32s(&[r.mass, r.linear_damping, r.angular_damping, r.restitution, r.friction]);
        w.u8(match r.mode {
            RigidMode::FollowBone => 0,
            RigidMode::Physics => 1,
            RigidMode::PhysicsWithBone => 2,
        });
    }
    w.i32(model.joints.len() as i32);
    for j in &model.joints {
        w.text(&j.name);
        w.text(&j.name_en);
        w.u8(0);
        w.index(j.body_a, h.rigid_index_size);
        w.index(j.body_b, h.rigid_index_size);
        for v in [j.position, j.rotation, j.linear_lower, j.linear_upper, j.angular_lower, j.angular_upper, j.linear_spring, j.angular_spring] {
            w.f32s(&v);
        }
    }
    let _ = &w.1;
    w.0
}

pub fn write_vmd(motion: &VmdMotion) -> Vec<u8> {
    let mut out = Vec::new();
    let mut sig = b"Vocaloid Motion Data 0002".to_vec();
    sig.resize(30, 0);
    out.extend_from_slice(&sig);
    out.extend_from_slice(&encode_sjis(&motion.model_name, 20));
    out.extend_from_slice(&(motion.bones.len() as u32).to_le_bytes());
    for k in &motion.bones {
        out.extend_from_slice(&encode_sjis(&k.bone, 15));
        out.extend_from_slice(&k.frame.to_le_bytes());
        for v in k.translation.iter().chain(&k.rotation) {
            out.extend_from_slice(&v.to_le_bytes());
        }
        let mut interp = [0u8; 64];
        for (axis, c) in k.curves.iter().enumerate() {
            interp[axis] = c.x1;
            interp[axis + 4] = c.y1;
            interp[axis + 8] = c.x2;
            interp[axis + 12] = c.y2;
        }
        out.extend_from_slice(&interp);
    }
    out.extend_from_slice(&(motion.morphs.len() as u32).to_le_bytes());
    for k in &motion.morphs {
        out.extend_from_slice(&encode_sjis(&k.morph, 15));
        out.extend_from_slice(&k.frame.to_le_bytes());
        out.extend_from_slice(&k.weight.to_le_bytes());
    }
    // Camera, light, shadow.
    for _ in 0..3 {
        out.extend_from_slice(&0u32.to_le_bytes());
    }
    out.extend_from_slice(&(motion.ik.len() as u32).to_le_bytes());
    for k in &motion.ik {
        out.extend_from_slice(&k.frame.to_le_bytes());
        out.push(1);
        out.extend_from_slice(&(k.states.len() as u32).to_le_bytes());
        for (name, on) in &k.states {
            out.extend_from_slice(&encode_sjis(name, 20));
            out.push(*on as u8);
        }
    }
    out
}

pub fn morph_key(name: &str, frame: u32, weight: f32) -> MorphKey {
    MorphKey { morph: name.into(), frame, weight }
}

pub fn ik_key(frame: u32, states: &[(&str, bool)]) -> IkKey {
    IkKey { frame, states: states.iter().map(|(n, o)| (n.to_string(), *o)).collect() }
}
