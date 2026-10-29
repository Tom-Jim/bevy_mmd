//! PMX and VMD parsing: round trips through the writers in `support`, every index
//! width, and corrupt input that must fail cleanly.

mod support;

use bevy3d_animation::format::FormatError;
use bevy3d_animation::format::pmx::*;
use bevy3d_animation::format::vmd::{Bezier, VmdMotion};
use support::*;

fn full_model() -> PmxModel {
    let mut m = leg();
    m.textures = vec!["tex\\body.png".into(), "toon.bmp".into()];
    m.materials[0].texture = 0;
    m.materials[0].toon = Toon::Texture(1);
    m.materials[0].sphere_mode = SphereMode::Add;
    m.bones[2].inherit = Some((1, 0.5));
    m.bones[2].flags |= bone_flags::INHERIT_ROTATION;
    m.vertices[2].weight = Weight::Sdef { bones: [2, 3], weight: 0.25, c: [0.0; 3], r0: [0.0, 1.0, 0.0], r1: [0.0, -1.0, 0.0] };
    m.morphs = vec![
        Morph { name: "あ".into(), name_en: "a".into(), panel: 3, kind: MorphKind::Vertex(vec![(1, [0.0, 0.5, 0.0])]) },
        Morph { name: "笑い".into(), name_en: String::new(), panel: 3, kind: MorphKind::Bone(vec![(2, [0.0, 0.1, 0.0], [0.0, 0.0, 0.0, 1.0])]) },
        Morph { name: "グループ".into(), name_en: String::new(), panel: 4, kind: MorphKind::Group(vec![(0, 1.0), (1, 0.5)]) },
    ];
    let c = chain(2);
    m.rigid_bodies = c.rigid_bodies.iter().map(|r| RigidBody { bone: r.bone.min(4), ..r.clone() }).collect();
    m.joints = c.joints;
    m
}

#[test]
fn pmx_round_trips_with_every_index_width() {
    for size in [1u8, 2, 4] {
        let mut model = full_model();
        model.header = Header {
            vertex_index_size: size,
            texture_index_size: size,
            material_index_size: size,
            bone_index_size: size,
            morph_index_size: size,
            rigid_index_size: size,
            ..Default::default()
        };
        let parsed = PmxModel::parse(&write_pmx(&model)).unwrap();
        assert_eq!(parsed.vertices, model.vertices, "index size {size}");
        assert_eq!(parsed.indices, model.indices);
        assert_eq!(parsed.textures, model.textures);
        assert_eq!(parsed.materials, model.materials);
        assert_eq!(parsed.bones, model.bones);
        assert_eq!(parsed.morphs, model.morphs);
        assert_eq!(parsed.rigid_bodies, model.rigid_bodies);
        assert_eq!(parsed.joints, model.joints);
        assert_eq!(parsed.name, "leg");
    }
}

#[test]
fn pmx_rejects_bad_input() {
    assert!(matches!(PmxModel::parse(b"PMD 1234"), Err(FormatError::Signature(_))));
    let bytes = write_pmx(&full_model());
    // Every truncation fails with an error, never a panic.
    for cut in (0..bytes.len()).step_by(7) {
        assert!(PmxModel::parse(&bytes[..cut]).is_err() || cut > bytes.len() - 8, "cut at {cut}");
    }
    let mut model = leg();
    model.indices = vec![0, 1, 9];
    assert!(PmxModel::parse(&write_pmx(&model)).is_err(), "face index past the vertices");
}

#[test]
fn pmx_without_physics_sections_parses() {
    let model = leg();
    let mut bytes = write_pmx(&model);
    // Drop the empty rigid-body and joint counts, as old exporters do.
    bytes.truncate(bytes.len() - 8);
    let parsed = PmxModel::parse(&bytes).unwrap();
    assert!(parsed.rigid_bodies.is_empty() && parsed.joints.is_empty());
}

#[test]
fn weights_normalise_and_ignore_missing_bones() {
    let w = Weight::Bdef4 { bones: [1, -1, 2, 3], weights: [2.0, 5.0, 2.0, 0.0] };
    let (bones, weights) = w.linear();
    assert_eq!(bones[0], 1);
    assert_eq!(bones[2], 2);
    assert!((weights.iter().sum::<f32>() - 1.0).abs() < 1e-6);
    assert_eq!(weights[1], 0.0);
    let (_, w) = Weight::Bdef2 { bones: [0, 1], weight: 0.25 }.linear();
    assert_eq!(w[..2], [0.25, 0.75]);
}

#[test]
fn vmd_round_trips_shift_jis_names_and_curves() {
    let mut eased = key("センター", 30, [1.0, 2.0, 3.0], [0.0, 0.0, 0.0, 1.0]);
    eased.curves = [Bezier { x1: 64, y1: 0, x2: 64, y2: 127 }, Bezier::LINEAR, Bezier::LINEAR, Bezier { x1: 10, y1: 90, x2: 100, y2: 20 }];
    let motion = VmdMotion {
        model_name: "初音ミク".into(),
        bones: vec![key("センター", 0, [0.0; 3], [0.0, 0.0, 0.0, 1.0]), eased],
        morphs: vec![morph_key("まばたき", 10, 1.0)],
        ik: vec![ik_key(0, &[("左足ＩＫ", false), ("右足ＩＫ", true)])],
    };
    let parsed = VmdMotion::parse(&write_vmd(&motion)).unwrap();
    assert_eq!(parsed, motion);
    assert_eq!(parsed.last_frame(), 30);
}

#[test]
fn vmd_rejects_bad_input() {
    assert!(VmdMotion::parse(b"not a motion").is_err());
    let motion = VmdMotion { bones: vec![key("a", 0, [0.0; 3], [0.0, 0.0, 0.0, 1.0])], ..Default::default() };
    let bytes = write_vmd(&motion);
    assert!(VmdMotion::parse(&bytes[..60]).is_err());
}

#[test]
fn bezier_eases_monotonically() {
    let linear = Bezier::LINEAR;
    for i in 0..=10 {
        let x = i as f32 / 10.0;
        assert!((linear.eval(x) - x).abs() < 1e-6);
    }
    let ease = Bezier { x1: 127, y1: 0, x2: 0, y2: 127 };
    assert!(ease.eval(0.25) < 0.25 && ease.eval(0.75) > 0.75);
    let mut last = 0.0;
    for i in 0..=100 {
        let y = ease.eval(i as f32 / 100.0);
        assert!(y >= last - 1e-5, "not monotonic at {i}");
        last = y;
    }
    assert!((ease.eval(0.0)).abs() < 1e-4 && (ease.eval(1.0) - 1.0).abs() < 1e-4);
}
