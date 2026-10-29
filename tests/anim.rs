//! Skeleton, IK, motion sampling, morphs and the soft-tissue jiggle.

mod support;

use std::f32::consts::FRAC_PI_2;

use bevy3d_animation::anim::Animator;
use bevy3d_animation::anim::jiggle::{self, JiggleSettings};
use bevy3d_animation::anim::morph::MorphRig;
use bevy3d_animation::anim::motion::{FPS, Motion};
use bevy3d_animation::anim::skeleton::{Pose, Skeleton, Stage, decompose_xyz};
use bevy3d_animation::format::pmx::*;
use bevy3d_animation::format::vmd::VmdMotion;
use glam::{Mat3, Quat, Vec3};
use support::*;

fn motion(bones: Vec<bevy3d_animation::format::vmd::BoneKey>) -> Motion {
    Motion::from_vmd(&VmdMotion { bones, ..Default::default() })
}

#[test]
fn rest_pose_matches_the_bind_pose() {
    let model = leg();
    let skeleton = Skeleton::from_pmx(&model);
    let pose = skeleton.rest_pose();
    for (i, b) in model.bones.iter().enumerate() {
        let expected = Vec3::new(b.position[0], b.position[1], -b.position[2]);
        assert!(pose.world_pos[i].distance(expected) < 1e-5, "{}", b.name);
    }
}

#[test]
fn evaluation_order_puts_parents_first() {
    let mut model = leg();
    // A parent listed after its child, in a later layer.
    model.bones[1].layer = 2;
    let skeleton = Skeleton::from_pmx(&model);
    let position = |i: usize| skeleton.order.iter().position(|&b| b == i).unwrap();
    for (i, b) in skeleton.bones.iter().enumerate() {
        if let Some(p) = b.parent {
            assert!(position(p) < position(i));
        }
    }
}

#[test]
fn parent_cycles_are_cut() {
    let mut model = leg();
    model.bones[0].parent = 2;
    let skeleton = Skeleton::from_pmx(&model);
    assert_eq!(skeleton.order.len(), model.bones.len());
    let _ = skeleton.rest_pose();
}

#[test]
fn forward_kinematics_composes_rotations() {
    let model = leg();
    let skeleton = Skeleton::from_pmx(&model);
    let mut pose = skeleton.rest_pose();
    skeleton.begin_frame(&mut pose);
    pose.rotation[1] = Quat::from_rotation_z(FRAC_PI_2);
    skeleton.evaluate(&mut pose, &[false; 5], Stage::BeforePhysics);
    // The thigh swings 90° about Z: the knee moves from below the hip to its side.
    let knee = pose.world_pos[2];
    assert!(knee.distance(Vec3::new(5.0, 10.0, 0.0)) < 1e-4, "{knee:?}");
}

#[test]
fn ik_reaches_a_reachable_target_and_bends_the_knee_forward() {
    let model = leg();
    let mut animator = Animator::new(&model);
    // Raise the foot IK target 3 units and 2 forward (MMD forward is -Z).
    animator.set_motion(Some(motion(vec![key("足ＩＫ", 0, [0.0, 3.0, -2.0], [0.0, 0.0, 0.0, 1.0])])));
    animator.animate(0.0);
    animator.finish(None, 1.0 / 60.0);
    let pose = &animator.pose;
    let target = pose.world_pos[4];
    let foot = pose.world_pos[3];
    assert!(foot.distance(target) < 0.05, "foot {foot:?} target {target:?}");
    // The knee bends forward (+Z in the viewer's right-handed space), never backwards.
    assert!(pose.world_pos[2].z > 0.5, "knee {:?}", pose.world_pos[2]);
}

#[test]
fn ik_switched_off_by_the_motion_leaves_the_leg_alone() {
    let model = leg();
    let mut animator = Animator::new(&model);
    let vmd = VmdMotion {
        bones: vec![key("足ＩＫ", 0, [0.0, 3.0, -2.0], [0.0, 0.0, 0.0, 1.0])],
        ik: vec![ik_key(0, &[("足ＩＫ", false)])],
        ..Default::default()
    };
    animator.set_motion(Some(Motion::from_vmd(&vmd)));
    animator.animate(0.0);
    animator.finish(None, 1.0 / 60.0);
    assert!(animator.pose.world_pos[3].distance(Vec3::ZERO) < 1e-4);
}

#[test]
fn euler_decomposition_inverts_xyz_composition() {
    for (x, y, z) in [(0.3, -0.4, 0.2), (-1.2, 0.9, 2.0), (0.0, 0.0, 0.0), (2.5, -1.4, -0.3)] {
        let m = Mat3::from_rotation_x(x) * Mat3::from_rotation_y(y) * Mat3::from_rotation_z(z);
        let e = decompose_xyz(m, Vec3::new(x, y, z));
        let back = Mat3::from_rotation_x(e.x) * Mat3::from_rotation_y(e.y) * Mat3::from_rotation_z(e.z);
        assert!((back - m).abs_diff_eq(Mat3::ZERO, 1e-4), "{x} {y} {z} -> {e:?}");
    }
}

#[test]
fn inherited_rotation_follows_its_source() {
    let mut model = leg();
    model.bones.push(bone("補助", [1.0, 10.0, 0.0], 0));
    let n = model.bones.len() - 1;
    model.bones[n].flags |= bone_flags::INHERIT_ROTATION;
    model.bones[n].inherit = Some((1, 0.5));
    let mut animator = Animator::new(&model);
    let r = Quat::from_rotation_x(0.8);
    let lh = [-r.x, -r.y, r.z, r.w];
    let vmd = VmdMotion { bones: vec![key("足", 0, [0.0; 3], lh)], ik: vec![ik_key(0, &[("足ＩＫ", false)])], ..Default::default() };
    animator.set_motion(Some(Motion::from_vmd(&vmd)));
    animator.animate(0.0);
    animator.finish(None, 1.0 / 60.0);
    let angle = animator.pose.world_rot[n].angle_between(Quat::IDENTITY);
    assert!((angle - 0.4).abs() < 1e-3, "{angle}");
}

#[test]
fn bone_track_interpolates_between_keys_and_holds_at_the_ends() {
    let m = motion(vec![
        key("センター", 0, [0.0; 3], [0.0, 0.0, 0.0, 1.0]),
        key("センター", 30, [10.0, 0.0, 0.0], [0.0, 0.0, 0.0, 1.0]),
    ]);
    let track = &m.bones[0].1;
    assert!((track.sample(15.0).0.x - 5.0).abs() < 1e-4);
    assert_eq!(track.sample(-5.0).0.x, 0.0);
    assert_eq!(track.sample(100.0).0.x, 10.0);
    assert!((m.duration_secs() - 30.0 / FPS).abs() < 1e-6);
}

#[test]
fn duplicate_keys_keep_the_last_one_and_quaternions_take_the_short_way() {
    let q = Quat::from_rotation_y(3.0);
    let m = motion(vec![
        key("a", 0, [1.0, 0.0, 0.0], [0.0, 0.0, 0.0, 1.0]),
        key("a", 0, [2.0, 0.0, 0.0], [0.0, 0.0, 0.0, 1.0]),
        key("a", 10, [0.0; 3], [-q.x, -q.y, -q.z, -q.w]),
    ]);
    let track = &m.bones[0].1;
    assert_eq!(track.keys.len(), 2);
    assert_eq!(track.keys[0].translation.x, 2.0);
    assert!(track.keys[0].rotation.dot(track.keys[1].rotation) >= 0.0);
}

#[test]
fn group_morphs_expand_and_bone_morphs_move_bones() {
    let mut model = leg();
    model.morphs = vec![
        Morph { name: "上げ".into(), name_en: String::new(), panel: 1, kind: MorphKind::Bone(vec![(0, [0.0, 2.0, 0.0], [0.0, 0.0, 0.0, 1.0])]) },
        Morph { name: "全部".into(), name_en: String::new(), panel: 1, kind: MorphKind::Group(vec![(0, 0.5)]) },
        // A group that names itself must not recurse forever.
        Morph { name: "輪".into(), name_en: String::new(), panel: 1, kind: MorphKind::Group(vec![(2, 1.0), (1, 1.0)]) },
    ];
    let rig = MorphRig::from_pmx(&model);
    let mut effective = Vec::new();
    rig.expand(&[0.0, 1.0, 0.0], &mut effective);
    assert!((effective[0] - 0.5).abs() < 1e-6);
    rig.expand(&[0.0, 0.0, 1.0], &mut effective);
    assert!((effective[0] - 0.5).abs() < 1e-6);

    let mut animator = Animator::new(&model);
    let vmd = VmdMotion { morphs: vec![morph_key("全部", 0, 1.0)], ..Default::default() };
    animator.set_motion(Some(Motion::from_vmd(&vmd)));
    animator.animate(0.0);
    animator.finish(None, 1.0 / 60.0);
    assert!((animator.pose.world_pos[0].y - 11.0).abs() < 1e-4);
}

/// A torso with a breast bone that carries skin, for the jiggle.
fn torso() -> PmxModel {
    let bones = vec![bone("センター", [0.0, 10.0, 0.0], -1), bone("上半身", [0.0, 12.0, 0.0], 0), bone("左胸", [1.0, 14.0, -1.0], 1)];
    let vertices = (0..30).map(|i| vertex([1.0, 14.0 + i as f32 * 0.01, -1.2], Weight::Bdef1 { bone: 2 })).collect();
    PmxModel { version: 2.0, bones, vertices, ..Default::default() }
}

#[test]
fn jiggle_picks_sided_soft_tissue_bones_only() {
    let mut model = torso();
    model.bones.push(bone("胸飾り", [0.0, 14.0, -1.0], 1));
    model.bones.push(bone("ButterflyL", [0.0, 14.0, -1.0], 1));
    let n = model.bones.len();
    model.vertices.extend((0..30).map(|_| vertex([0.0, 14.0, -1.0], Weight::Bdef2 { bones: [n as i32 - 1, n as i32 - 2], weight: 0.5 })));
    let animator = Animator::new(&model);
    let names: Vec<&str> = animator.jiggle.bones().map(|(b, _)| animator.skeleton.bones[b].name.as_str()).collect();
    assert_eq!(names, ["左胸"]);
}

#[test]
fn jiggle_lags_a_jump_overshoots_and_settles() {
    let model = torso();
    let mut animator = Animator::new(&model);
    // The body rises 2 units in 0.2 s, then holds.
    animator.set_motion(Some(motion(vec![
        key("センター", 0, [0.0; 3], [0.0, 0.0, 0.0, 1.0]),
        key("センター", 6, [0.0, 2.0, 0.0], [0.0, 0.0, 0.0, 1.0]),
        key("センター", 60, [0.0, 2.0, 0.0], [0.0, 0.0, 0.0, 1.0]),
    ])));
    let rest = |a: &Animator| a.pose.world_pos[1] + (a.skeleton.bones[2].rest - a.skeleton.bones[1].rest);
    let (mut lag, mut overshoot) = (0f32, 0f32);
    for f in 0..240 {
        animator.animate(f as f32 / 120.0);
        animator.finish(None, 1.0 / 120.0);
        let offset = (animator.pose.world_pos[2] - rest(&animator)).y;
        if f < 24 {
            lag = lag.min(offset);
        } else {
            overshoot = overshoot.max(offset);
        }
    }
    let height = 4.0f32.max(1.0);
    let max = JiggleSettings::default().chest.max_offset * height;
    assert!(lag < -0.01, "the breast trails the rise ({lag})");
    assert!(overshoot > 0.005, "and bounces past it ({overshoot})");
    assert!(lag.abs() <= max + 1e-4, "within the cap ({lag} vs {max})");
    let settled = (animator.pose.world_pos[2] - rest(&animator)).length();
    assert!(settled < 0.002, "and settles ({settled})");
}

#[test]
fn jiggle_off_means_no_offset() {
    let model = torso();
    let mut animator = Animator::new(&model);
    animator.jiggle_settings.enabled = false;
    animator.set_motion(Some(motion(vec![key("センター", 0, [0.0; 3], [0.0, 0.0, 0.0, 1.0]), key("センター", 6, [0.0, 2.0, 0.0], [0.0, 0.0, 0.0, 1.0])])));
    for f in 0..12 {
        animator.animate(f as f32 / 60.0);
        animator.finish(None, 1.0 / 60.0);
    }
    let expected = animator.pose.world_pos[1] + Vec3::new(1.0, 2.0, 1.0);
    assert!(animator.pose.world_pos[2].distance(expected) < 1e-4);
}

#[test]
fn hip_bones_are_added_without_changing_the_rest_skin() {
    // A lower body with legs and a ring of buttock vertices behind the hips.
    let mut bones = vec![bone("センター", [0.0, 10.0, 0.0], -1), bone("下半身", [0.0, 11.0, 0.0], 0)];
    bones.push(bone("左足", [1.0, 9.5, 0.0], 1));
    bones.push(bone("右足", [-1.0, 9.5, 0.0], 1));
    let mut vertices = Vec::new();
    for side in [-1.0f32, 1.0] {
        for i in 0..40 {
            let a = i as f32 / 40.0 * std::f32::consts::PI;
            vertices.push(vertex([side * (1.0 + 0.5 * a.cos()), 9.3 + 0.3 * a.sin(), 0.4 + 0.2 * a.sin()], Weight::Bdef2 { bones: [1, if side < 0.0 { 3 } else { 2 }], weight: 0.7 }));
        }
    }
    let mut model = PmxModel { version: 2.0, bones, vertices, ..Default::default() };
    // Tall enough that the region sizes are realistic.
    model.vertices.push(vertex([0.0, 0.0, 0.0], Weight::Bdef1 { bone: 0 }));
    model.vertices.push(vertex([0.0, 20.0, 0.0], Weight::Bdef1 { bone: 0 }));
    let before = Animator::new(&model);
    let skin_before = skin(&model, &before);
    assert_eq!(jiggle::add_hip_bones(&mut model), 2);
    assert_eq!(jiggle::add_hip_bones(&mut model), 0, "only once");
    let after = Animator::new(&model);
    let regions: Vec<_> = after.jiggle.bones().map(|(_, r)| r).collect();
    assert_eq!(regions.len(), 2);
    let skin_after = skin(&model, &after);
    for (a, b) in skin_before.iter().zip(&skin_after) {
        assert!(a.distance(*b) < 1e-4);
    }
    let moved = model.vertices.iter().filter(|v| v.weight.linear().0.contains(&4) || v.weight.linear().0.contains(&5)).count();
    assert!(moved > 10, "{moved} vertices follow the new bones");
}

fn skin(model: &PmxModel, animator: &Animator) -> Vec<Vec3> {
    let pose: &Pose = &animator.pose;
    model
        .vertices
        .iter()
        .map(|v| {
            let (b, w) = v.weight.linear();
            let p = Vec3::new(v.position[0], v.position[1], -v.position[2]);
            (0..4)
                .map(|k| {
                    let i = b[k] as usize;
                    let rest = animator.skeleton.bones[i].rest;
                    (pose.world_rot[i] * (p - rest) + pose.world_pos[i]) * w[k]
                })
                .sum()
        })
        .collect()
}
