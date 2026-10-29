//! The Jolt bridge and the MMD rig: joints hold their limits, chains swing and settle,
//! and the rig quirks that tore cloth stay fixed (boneless helpers, bodies overlapping
//! in the bind pose, collisions between jointed neighbours).

mod support;

use bevy3d_animation::anim::Animator;
use bevy3d_animation::anim::motion::Motion;
use bevy3d_animation::format::pmx::{PmxModel, RigidMode};
use bevy3d_animation::format::vmd::VmdMotion;
use bevy3d_animation::physics::rig::damping_rate;
use bevy3d_animation::physics::{PhysicsRig, PhysicsSettings};
use bevy3d_animation::physics::ffi::{MmdBodyDesc, MmdJointDesc, MmdWorldSettings, SHAPE_BOX, SHAPE_SPHERE};
use bevy3d_animation::physics::world::{BodyTransform, RestOverlaps, World};
use glam::{Quat, Vec3};

fn settings(gravity: f32) -> MmdWorldSettings {
    MmdWorldSettings { gravity: [0.0, -gravity, 0.0], spring_damping_ratio: 0.25, velocity_steps: 10, position_steps: 4 }
}

fn body(position: Vec3, kinematic: bool, mass: f32) -> MmdBodyDesc {
    MmdBodyDesc {
        shape: if kinematic { SHAPE_BOX } else { SHAPE_SPHERE },
        size: [0.5, 0.5, 0.5],
        position: position.to_array(),
        rotation: Quat::IDENTITY.to_array(),
        mass,
        linear_damping: 0.5,
        angular_damping: 0.5,
        friction: 0.5,
        group: 0,
        collide_mask: 0,
        kinematic: kinematic as u32,
        ..Default::default()
    }
}

#[test]
fn limited_joint_holds_under_gravity() {
    let mut world = World::new(&settings(98.0), 8);
    let a = world.add_body(&body(Vec3::ZERO, true, 1.0)).unwrap();
    let b = world.add_body(&body(Vec3::new(0.0, 0.0, 1.0), false, 2.0)).unwrap();
    world
        .add_joint(&MmdJointDesc {
            body_a: a as i32,
            body_b: b as i32,
            position: [0.0, 0.0, 1.0],
            rotation: Quat::IDENTITY.to_array(),
            linear_lower: [-0.15, -0.05, -0.05],
            linear_upper: [0.15, 0.05, 0.05],
            angular_lower: [-0.087, -0.122, -0.052],
            angular_upper: [0.087, 0.122, 0.052],
            ..Default::default()
        })
        .unwrap();
    world.finish(RestOverlaps::IgnoreAll);
    let mut out = Vec::new();
    for _ in 0..240 {
        world.move_kinematic(&[BodyTransform::IDENTITY, BodyTransform::IDENTITY], 1.0 / 120.0);
        world.step(1.0 / 120.0, 1);
    }
    world.read(&mut out);
    let offset = out[b].position - Vec3::new(0.0, 0.0, 1.0);
    let angle = out[b].rotation.angle_between(Quat::IDENTITY).to_degrees();
    eprintln!("offset {offset:?} angle {angle:.2}");
    assert!(offset.y > -0.06 && offset.length() < 0.17, "{offset:?}");
    assert!(angle < 8.5, "{angle}");
}

#[test]
fn helper_chain_does_not_break_limits() {
    let mut world = World::new(&settings(98.0), 8);
    let a = world.add_body(&body(Vec3::ZERO, true, 1.0)).unwrap();
    let h = world.add_body(&body(Vec3::new(0.0, 0.0, 1.0), false, 1.0)).unwrap();
    let b = world.add_body(&body(Vec3::new(0.0, 0.0, 1.0), false, 2.0)).unwrap();
    let joint = |a: usize, b: usize, ll: [f32; 3], lu: [f32; 3], al: [f32; 3], au: [f32; 3]| MmdJointDesc {
        body_a: a as i32,
        body_b: b as i32,
        position: [0.0, 0.0, 1.0],
        rotation: Quat::IDENTITY.to_array(),
        linear_lower: ll,
        linear_upper: lu,
        angular_lower: al,
        angular_upper: au,
        ..Default::default()
    };
    world.add_joint(&joint(a, b, [-0.15, -0.05, -0.05], [0.15, 0.05, 0.05], [-0.087, -0.122, -0.052], [0.087, 0.122, 0.052])).unwrap();
    world.add_joint(&joint(a, h, [0.0; 3], [0.0; 3], [0.0; 3], [0.0; 3])).unwrap();
    world.add_joint(&joint(h, b, [0.5, 0.5, 0.0], [0.0; 3], [0.0087; 3], [0.0; 3])).unwrap();
    world.finish(RestOverlaps::IgnoreAll);
    let mut out = Vec::new();
    for _ in 0..240 {
        world.move_kinematic(&[BodyTransform::IDENTITY; 3], 1.0 / 120.0);
        world.step(1.0 / 120.0, 1);
    }
    world.read(&mut out);
    let offset = out[b].position - Vec3::new(0.0, 0.0, 1.0);
    let angle = out[b].rotation.angle_between(Quat::IDENTITY).to_degrees();
    let helper = out[h].position - Vec3::new(0.0, 0.0, 1.0);
    eprintln!("breast offset {offset:?} angle {angle:.2}, helper offset {helper:?}");
    assert!(offset.length() < 0.17, "{offset:?}");
    assert!(angle < 8.5, "{angle}");
}

/// Runs `model` with `motion` for `frames` at 60 Hz; returns the animator.
fn simulate(model: &PmxModel, motion: Option<VmdMotion>, frames: u32, settings: &PhysicsSettings) -> (Animator, PhysicsRig) {
    let mut animator = Animator::new(model);
    animator.set_motion(motion.as_ref().map(Motion::from_vmd));
    let mut rig = PhysicsRig::new(model, &animator.skeleton, settings).expect("the model has bodies");
    for f in 0..frames {
        animator.animate(f as f32 / 60.0);
        let overrides = rig.step(&animator.pose, 1.0 / 60.0).to_vec();
        animator.finish(Some(&overrides), 1.0 / 60.0);
    }
    (animator, rig)
}

#[test]
fn hanging_chain_stays_connected_and_at_rest() {
    let model = support::chain(5);
    let (animator, rig) = simulate(&model, None, 240, &PhysicsSettings::default());
    for (error, a, b) in rig.joint_errors() {
        assert!(error < 0.05, "{a}-{b} apart by {error}");
    }
    // Hanging straight down from the anchor, the chain keeps its rest shape.
    for i in 1..=5 {
        let rest = animator.skeleton.bones[i].rest;
        assert!(animator.pose.world_pos[i].distance(rest) < 0.1, "link {i} at {:?}", animator.pose.world_pos[i]);
    }
}

#[test]
fn chain_swings_behind_a_moving_anchor_and_settles() {
    let model = support::chain(4);
    let vmd = VmdMotion {
        bones: vec![
            support::key("root", 0, [0.0; 3], [0.0, 0.0, 0.0, 1.0]),
            support::key("root", 15, [6.0, 0.0, 0.0], [0.0, 0.0, 0.0, 1.0]),
            support::key("root", 300, [6.0, 0.0, 0.0], [0.0, 0.0, 0.0, 1.0]),
        ],
        ..Default::default()
    };
    let mut animator = Animator::new(&model);
    animator.set_motion(Some(Motion::from_vmd(&vmd)));
    let mut rig = PhysicsRig::new(&model, &animator.skeleton, &PhysicsSettings::default()).unwrap();
    let mut max_lag = 0f32;
    for f in 0..600 {
        animator.animate(f as f32 / 60.0);
        let overrides = rig.step(&animator.pose, 1.0 / 60.0).to_vec();
        animator.finish(Some(&overrides), 1.0 / 60.0);
        let tip = animator.pose.world_pos[4];
        let root = animator.pose.world_pos[0];
        max_lag = max_lag.max(root.x - tip.x);
    }
    let tip = animator.pose.world_pos[4];
    assert!(max_lag > 0.5, "the tip trails the anchor ({max_lag})");
    assert!((tip.x - 6.0).abs() < 0.2, "and hangs below it again ({tip:?})");
}

#[test]
fn boneless_helper_bodies_are_simulated_not_pinned() {
    // A helper body without a bone joined to the last link: it must travel with the
    // chain instead of staying at its rest position in the world.
    let mut model = support::chain(2);
    let mut helper = support::rigid("helper", -1, [0.0, 15.0, 0.0], RigidMode::Physics);
    helper.shape = bevy3d_animation::format::pmx::RigidShape::Sphere;
    model.rigid_bodies.push(helper);
    let mut joint = model.joints[1].clone();
    joint.name = "helper".into();
    joint.body_a = 2;
    joint.body_b = 3;
    joint.position = [0.0, 15.0, 0.0];
    model.joints.push(joint);
    let vmd = VmdMotion {
        bones: vec![support::key("root", 0, [0.0; 3], [0.0, 0.0, 0.0, 1.0]), support::key("root", 30, [0.0, 0.0, 10.0], [0.0, 0.0, 0.0, 1.0])],
        ..Default::default()
    };
    let (_, rig) = simulate(&model, Some(vmd), 180, &PhysicsSettings::default());
    let helper = rig.body_transforms()[3];
    // MMD +Z is the viewer's -Z: the anchor moved to z = -10.
    assert!(helper.position.z < -8.0, "helper left behind at {:?}", helper.position);
}

#[test]
fn bodies_overlapping_at_rest_do_not_push_apart() {
    // Two strands whose links overlap side by side, in colliding groups.
    let mut model = support::chain(3);
    let n = model.rigid_bodies.len();
    let second: Vec<_> = model.rigid_bodies[1..].iter().map(|r| {
        let mut r = r.clone();
        r.name = format!("{}b", r.name);
        r.position[0] += 0.2;
        r.no_collision = 0;
        r
    }).collect();
    for r in &mut model.rigid_bodies {
        r.no_collision = 0;
    }
    model.rigid_bodies.extend(second);
    let still = PhysicsSettings { gravity: 0.0, ..Default::default() };
    let (animator, _) = simulate(&model, None, 120, &still);
    for i in 1..model.bones.len() {
        let d = animator.pose.world_pos[i].distance(animator.skeleton.bones[i].rest);
        assert!(d < 0.01, "bone {i} pushed {d} away ({n} bodies)");
    }
}

#[test]
fn damping_converts_retention_to_rates() {
    assert_eq!(damping_rate(0.0), 0.0);
    assert!((damping_rate(0.5) - std::f32::consts::LN_2).abs() < 1e-6);
    assert!(damping_rate(1.0).is_finite());
}

#[test]
fn worlds_on_many_threads() {
    let threads: Vec<_> = (0..8)
        .map(|_| std::thread::spawn(|| simulate(&support::chain(3), None, 30, &PhysicsSettings::default()).0.pose.world_pos[3]))
        .collect();
    for t in threads {
        assert!(t.join().unwrap().is_finite());
    }
}
