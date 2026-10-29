//! Character animation without any engine: skeleton and IK, VMD sampling, morphs,
//! and [`Animator`], which turns one model, one motion and a time into a pose.

pub mod coords;
pub mod jiggle;
pub mod morph;
pub mod motion;
pub mod skeleton;

use glam::{Quat, Vec3};

use crate::format::pmx::PmxModel;
use jiggle::{Jiggle, JiggleSettings};
use morph::{MaterialMorph, MorphRig};
use motion::{Binding, FPS, Motion};
use skeleton::{Override, Pose, Skeleton, Stage};

/// The animated state of one model: everything a frame needs, reused across frames.
pub struct Animator {
    pub skeleton: Skeleton,
    pub morphs: MorphRig,
    pub pose: Pose,
    /// Morph weights from the motion, then their group-expanded values.
    pub weights: Vec<f32>,
    pub effective: Vec<f32>,
    pub materials: Vec<MaterialMorph>,
    pub jiggle: Jiggle,
    pub jiggle_settings: JiggleSettings,
    material_count: usize,
    ik_enabled: Vec<bool>,
    motion: Option<(Motion, Binding)>,
}

impl Animator {
    pub fn new(model: &PmxModel) -> Self {
        let skeleton = Skeleton::from_pmx(model);
        let morphs = MorphRig::from_pmx(model);
        let pose = skeleton.rest_pose();
        let n = skeleton.len();
        Self {
            weights: vec![0.0; morphs.len()],
            effective: vec![0.0; morphs.len()],
            materials: vec![MaterialMorph::default(); model.materials.len()],
            material_count: model.materials.len(),
            jiggle: Jiggle::new(model, &skeleton),
            jiggle_settings: JiggleSettings::default(),
            ik_enabled: vec![true; n],
            skeleton,
            morphs,
            pose,
            motion: None,
        }
    }

    pub fn set_motion(&mut self, motion: Option<Motion>) {
        self.motion = motion.map(|m| {
            let binding = Binding::new(&m, &self.skeleton, &self.morphs);
            (m, binding)
        });
    }

    pub fn motion(&self) -> Option<&Motion> {
        self.motion.as_ref().map(|(m, _)| m)
    }

    pub fn binding(&self) -> Option<&Binding> {
        self.motion.as_ref().map(|(_, b)| b)
    }

    pub fn duration_secs(&self) -> f32 {
        self.motion().map_or(0.0, Motion::duration_secs)
    }

    /// Samples the motion at `time` and evaluates the bones that come before physics.
    pub fn animate(&mut self, time: f32) {
        let frame = time.max(0.0) * FPS;
        let Self { skeleton, morphs, pose, weights, effective, materials, ik_enabled, motion, .. } = self;
        skeleton.begin_frame(pose);
        match motion {
            Some((m, binding)) => {
                binding.sample_bones(m, frame, &mut pose.translation, &mut pose.rotation);
                binding.sample_morphs(m, frame, weights);
                binding.sample_ik(m, frame, ik_enabled);
            }
            None => {
                weights.fill(0.0);
                ik_enabled.fill(true);
            }
        }
        morphs.expand(weights, effective);
        morphs.apply_bones(effective, &mut pose.translation, &mut pose.rotation);
        morphs.materials(effective, self.material_count, materials);
        skeleton.evaluate(pose, ik_enabled, Stage::BeforePhysics);
    }

    /// Imposes the physics results, adds the soft-tissue jiggle of a `dt`-second
    /// frame, then evaluates the bones that come after physics.
    pub fn finish(&mut self, overrides: Option<&[Option<Override>]>, dt: f32) {
        if let Some(overrides) = overrides {
            self.skeleton.apply_physics(&mut self.pose, overrides);
        }
        if let Some(jiggle) = self.jiggle.step(&self.pose, dt, &self.jiggle_settings) {
            self.skeleton.apply_physics(&mut self.pose, jiggle);
        }
        self.skeleton.evaluate(&mut self.pose, &self.ik_enabled, Stage::AfterPhysics);
    }

    /// Restarts the jiggle springs (after a seek, a loop or a new motion).
    pub fn reset_dynamics(&mut self) {
        self.jiggle.reset();
    }

    /// Skinning matrix inputs: world transform of bone `i` relative to its bind pose.
    pub fn skin_transform(&self, i: usize) -> (Vec3, Quat) {
        let rot = self.pose.world_rot[i];
        (self.pose.world_pos[i] - rot * self.skeleton.bones[i].rest, rot)
    }
}
