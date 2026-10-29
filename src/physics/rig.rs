//! The physics rig of one model: its PMX rigid bodies and joints in a Jolt world, and
//! the mapping between bodies and bones.
//!
//! Each frame the bodies that follow bones move kinematically to the animated pose
//! (interpolated across sub-steps), the world steps, and the simulated bodies hand
//! their transforms back to their bones.

use glam::{Quat, Vec3};
use serde::{Deserialize, Serialize};

use super::ffi::{self, MmdBodyDesc, MmdJointDesc, MmdWorldSettings};
use super::world::{BodyTransform, RestOverlaps, World};
use crate::anim::coords;
use crate::anim::skeleton::{Override, Pose, Skeleton};
use crate::format::pmx::{PmxModel, RigidMode, RigidShape};

#[derive(Clone, Debug, Serialize, Deserialize, PartialEq)]
#[serde(default)]
pub struct PhysicsSettings {
    /// Model units per second²: MikuMikuDance's 1 unit is 8 cm, its gravity 9.8 × 10.
    pub gravity: f32,
    /// Longest sub-step in seconds; a frame is split into equal sub-steps no longer.
    pub max_substep: f32,
    pub max_substeps: u32,
    /// Frames longer than this (a stall, a seek) reset the rig instead of stepping.
    pub max_frame: f32,
    pub collision_steps: u32,
    pub velocity_steps: u32,
    pub position_steps: u32,
    /// Damping ratio of joint springs.
    pub spring_damping_ratio: f32,
    /// Scales every joint spring.
    pub spring_scale: f32,
    /// Extra damping on top of the model's, 0..1 of velocity lost per second.
    pub extra_damping: f32,
    /// Contacts between bodies that overlap in the bind pose.
    pub rest_overlaps: RestOverlaps,
}

impl Default for PhysicsSettings {
    fn default() -> Self {
        Self {
            gravity: 98.0,
            max_substep: 1.0 / 120.0,
            max_substeps: 6,
            max_frame: 0.25,
            collision_steps: 1,
            velocity_steps: 10,
            position_steps: 4,
            spring_damping_ratio: 0.25,
            spring_scale: 1.0,
            extra_damping: 0.0,
            rest_overlaps: RestOverlaps::IgnoreAll,
        }
    }
}

#[derive(Clone, Copy, Debug)]
struct RigBody {
    bone: Option<usize>,
    mode: RigidMode,
    /// Body transform in its bone's frame at rest.
    offset: BodyTransform,
}

pub struct PhysicsRig {
    world: World,
    bodies: Vec<RigBody>,
    /// Bone index → body that drives it.
    drivers: Vec<Option<usize>>,
    previous_targets: Vec<BodyTransform>,
    targets: Vec<BodyTransform>,
    interpolated: Vec<BodyTransform>,
    current: Vec<BodyTransform>,
    overrides: Vec<Option<Override>>,
    /// Per translation-locked joint: the two bodies and the joint anchor in each body's frame.
    joints: Vec<(usize, usize, Vec3, Vec3)>,
    names: Vec<String>,
    settings: PhysicsSettings,
    needs_reset: bool,
}

fn compose(a: BodyTransform, b: BodyTransform) -> BodyTransform {
    BodyTransform { position: a.position + a.rotation * b.position, rotation: (a.rotation * b.rotation).normalize() }
}

fn inverse(a: BodyTransform) -> BodyTransform {
    let rotation = a.rotation.inverse();
    BodyTransform { position: -(rotation * a.position), rotation }
}

/// MMD damping is the fraction of velocity lost per second; Jolt's is a rate.
pub fn damping_rate(fraction: f32) -> f32 {
    -(1.0 - fraction.clamp(0.0, 0.999)).ln()
}

impl PhysicsRig {
    /// `None` when the model has no rigid bodies.
    pub fn new(model: &PmxModel, skeleton: &Skeleton, settings: &PhysicsSettings) -> Option<Self> {
        if model.rigid_bodies.is_empty() {
            return None;
        }
        let world_settings = MmdWorldSettings {
            gravity: [0.0, -settings.gravity, 0.0],
            spring_damping_ratio: settings.spring_damping_ratio,
            velocity_steps: settings.velocity_steps,
            position_steps: settings.position_steps,
        };
        let mut world = World::new(&world_settings, model.rigid_bodies.len() as u32 + 16);
        let mut bodies = Vec::with_capacity(model.rigid_bodies.len());
        let mut drivers = vec![None; skeleton.len()];
        // PMX body index → world body index (a body Jolt rejects leaves a hole).
        let mut ids = Vec::with_capacity(model.rigid_bodies.len());
        let mut rest = Vec::with_capacity(model.rigid_bodies.len());
        let mut names = Vec::new();
        let mut joints = Vec::new();
        let extra = damping_rate(settings.extra_damping);
        for rb in &model.rigid_bodies {
            let bone = (rb.bone >= 0 && (rb.bone as usize) < skeleton.len()).then_some(rb.bone as usize);
            let world_tf = BodyTransform { position: coords::position(rb.position), rotation: coords::euler_yxz(rb.rotation) };
            let bone_tf = bone.map_or(BodyTransform::IDENTITY, |b| BodyTransform {
                position: skeleton.bones[b].rest,
                rotation: Quat::IDENTITY,
            });
            // Boneless bodies are helpers: simulated ones move with their joints, and a
            // boneless "follow bone" body follows the model's root.
            let mode = rb.mode;
            let desc = MmdBodyDesc {
                shape: match rb.shape {
                    RigidShape::Sphere => ffi::SHAPE_SPHERE,
                    RigidShape::Box => ffi::SHAPE_BOX,
                    RigidShape::Capsule => ffi::SHAPE_CAPSULE,
                },
                size: rb.size.map(f32::abs),
                position: world_tf.position.to_array(),
                rotation: world_tf.rotation.to_array(),
                mass: rb.mass,
                linear_damping: damping_rate(rb.linear_damping) + extra,
                angular_damping: damping_rate(rb.angular_damping) + extra,
                restitution: rb.restitution,
                friction: rb.friction,
                group: rb.group as u32,
                collide_mask: (!rb.no_collision) as u32 & 0xffff,
                kinematic: (mode == RigidMode::FollowBone) as u32,
            };
            let id = world.add_body(&desc);
            ids.push(id);
            if id.is_none() {
                continue;
            }
            let index = bodies.len();
            rest.push(world_tf);
            names.push(rb.name.clone());
            bodies.push(RigBody { bone, mode, offset: compose(inverse(bone_tf), world_tf) });
            if let Some(b) = bone
                && mode != RigidMode::FollowBone
                && drivers[b].is_none()
            {
                drivers[b] = Some(index);
            }
        }
        for j in &model.joints {
            let body = |i: i32| ids.get(usize::try_from(i).ok()?).copied().flatten();
            let (Some(a), Some(b)) = (body(j.body_a), body(j.body_b)) else { continue };
            let (linear_lower, linear_upper) = coords::linear_range(j.linear_lower, j.linear_upper);
            let (angular_lower, angular_upper) = coords::angular_range(j.angular_lower, j.angular_upper);
            let desc = MmdJointDesc {
                body_a: a as i32,
                body_b: b as i32,
                position: coords::position(j.position).to_array(),
                rotation: coords::euler_yxz(j.rotation).to_array(),
                linear_lower,
                linear_upper,
                angular_lower,
                angular_upper,
                linear_spring: j.linear_spring.map(|k| k.abs() * settings.spring_scale),
                angular_spring: j.angular_spring.map(|k| k.abs() * settings.spring_scale),
            };
            let locked = (0..3).all(|i| j.linear_lower[i] == j.linear_upper[i]);
            if world.add_joint(&desc).is_some() && locked {
                let anchor = coords::position(j.position);
                let local = |i: usize| rest[i].rotation.inverse() * (anchor - rest[i].position);
                joints.push((a, b, local(a), local(b)));
            }
        }
        // Bodies stand in the bind pose until the first step: the overlap test sees the
        // rig as the modeller built it.
        world.finish(settings.rest_overlaps);
        let n = bodies.len();
        Some(Self {
            world,
            bodies,
            drivers,
            previous_targets: vec![BodyTransform::IDENTITY; n],
            targets: vec![BodyTransform::IDENTITY; n],
            interpolated: vec![BodyTransform::IDENTITY; n],
            current: Vec::with_capacity(n),
            overrides: vec![None; skeleton.len()],
            joints,
            names,
            settings: settings.clone(),
            needs_reset: true,
        })
    }

    pub fn body_count(&self) -> usize {
        self.bodies.len()
    }

    pub fn dynamic_count(&self) -> usize {
        self.bodies.iter().filter(|b| b.mode != RigidMode::FollowBone).count()
    }

    /// Snap every body to the pose on the next step (after a seek, a loop or a load).
    pub fn request_reset(&mut self) {
        self.needs_reset = true;
    }

    pub fn set_gravity(&mut self, g: f32) {
        self.settings.gravity = g;
        self.world.set_gravity(Vec3::new(0.0, -g, 0.0));
    }

    fn bone_targets(&mut self, pose: &Pose) {
        for (t, body) in self.targets.iter_mut().zip(&self.bodies) {
            let bone = body.bone.map_or(BodyTransform::IDENTITY, |b| BodyTransform {
                position: pose.world_pos[b],
                rotation: pose.world_rot[b],
            });
            *t = compose(bone, body.offset);
        }
    }

    /// Advances the rig by `dt` seconds against the pose of this frame and returns the
    /// bone transforms the simulated bodies impose (indexed by bone).
    pub fn step(&mut self, pose: &Pose, dt: f32) -> &[Option<Override>] {
        self.bone_targets(pose);
        if self.needs_reset || !(dt > 0.0) || dt > self.settings.max_frame {
            self.world.reset(&self.targets);
            self.previous_targets.clone_from(&self.targets);
            self.needs_reset = false;
            // Settle the chains at the new pose without carrying any history.
            self.world.move_kinematic(&self.targets, self.settings.max_substep);
            for _ in 0..2 {
                self.world.step(self.settings.max_substep, self.settings.collision_steps);
            }
        } else {
            let n = ((dt / self.settings.max_substep).ceil() as u32).clamp(1, self.settings.max_substeps.max(1));
            let h = dt / n as f32;
            for s in 1..=n {
                let a = s as f32 / n as f32;
                for ((out, from), to) in self.interpolated.iter_mut().zip(&self.previous_targets).zip(&self.targets) {
                    *out = BodyTransform {
                        position: from.position.lerp(to.position, a),
                        rotation: from.rotation.slerp(to.rotation, a),
                    };
                }
                self.world.move_kinematic(&self.interpolated, h);
                self.world.step(h, self.settings.collision_steps);
            }
            self.previous_targets.clone_from(&self.targets);
        }
        self.world.read(&mut self.current);
        self.overrides.fill(None);
        for (bone, driver) in self.drivers.iter().enumerate() {
            let Some(i) = *driver else { continue };
            let body = &self.bodies[i];
            let Some(tf) = self.current.get(i) else { continue };
            if !tf.position.is_finite() || !tf.rotation.is_finite() {
                self.needs_reset = true;
                continue;
            }
            let bone_tf = compose(*tf, inverse(body.offset));
            self.overrides[bone] = Some(match body.mode {
                RigidMode::PhysicsWithBone => Override::Rotation(bone_tf.rotation),
                _ => Override::Full(bone_tf.position, bone_tf.rotation),
            });
        }
        &self.overrides
    }

    /// How far apart the two anchors of each translation-locked joint are, in model
    /// units: zero for a joint that holds. With the names of the two bodies.
    pub fn joint_errors(&self) -> Vec<(f32, &str, &str)> {
        self.joints
            .iter()
            .filter_map(|&(a, b, la, lb)| {
                let (ta, tb) = (self.current.get(a)?, self.current.get(b)?);
                let pa = ta.position + ta.rotation * la;
                let pb = tb.position + tb.rotation * lb;
                Some((pa.distance(pb), self.names[a].as_str(), self.names[b].as_str()))
            })
            .collect()
    }

    /// Current body transforms (for debugging and tests).
    pub fn body_transforms(&self) -> &[BodyTransform] {
        &self.current
    }
}
