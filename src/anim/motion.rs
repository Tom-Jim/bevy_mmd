//! VMD tracks in the viewer's coordinates, sampled by frame (30 per second).
//!
//! Tracks are looked up by name once, when a motion is bound to a model
//! ([`Binding`]); sampling is then a binary search per track.

use std::collections::HashMap;

use glam::{Quat, Vec3};

use super::coords;
use super::morph::MorphRig;
use super::skeleton::Skeleton;
use crate::format::vmd::{Bezier, VmdMotion};

/// Keyframes per second of every VMD motion.
pub const FPS: f32 = 30.0;

#[derive(Clone, Debug)]
pub struct BoneKey {
    pub frame: u32,
    pub translation: Vec3,
    pub rotation: Quat,
    pub curves: [Bezier; 4],
}

#[derive(Clone, Debug, Default)]
pub struct BoneTrack {
    pub keys: Vec<BoneKey>,
}

#[derive(Clone, Debug, Default)]
pub struct MorphTrack {
    pub keys: Vec<(u32, f32)>,
}

#[derive(Clone, Debug, Default)]
pub struct Motion {
    pub bones: Vec<(String, BoneTrack)>,
    pub morphs: Vec<(String, MorphTrack)>,
    /// IK bone name → (frame, enabled) switches.
    pub ik: Vec<(String, Vec<(u32, bool)>)>,
    pub last_frame: u32,
}

/// Index of the last key at or before `frame`, or `None` before the first key.
fn key_before<T>(keys: &[T], frame: f32, frame_of: impl Fn(&T) -> u32) -> Option<usize> {
    let after = keys.partition_point(|k| frame_of(k) as f32 <= frame);
    after.checked_sub(1)
}

impl BoneTrack {
    pub fn sample(&self, frame: f32) -> (Vec3, Quat) {
        let keys = &self.keys;
        let Some(first) = keys.first() else {
            return (Vec3::ZERO, Quat::IDENTITY);
        };
        let Some(i) = key_before(keys, frame, |k| k.frame) else {
            return (first.translation, first.rotation);
        };
        let a = &keys[i];
        let Some(b) = keys.get(i + 1) else {
            return (a.translation, a.rotation);
        };
        let span = (b.frame - a.frame).max(1) as f32;
        let t = ((frame - a.frame as f32) / span).clamp(0.0, 1.0);
        let ease = Vec3::new(b.curves[0].eval(t), b.curves[1].eval(t), b.curves[2].eval(t));
        let translation = a.translation + (b.translation - a.translation) * ease;
        let rotation = a.rotation.slerp(b.rotation, b.curves[3].eval(t));
        (translation, rotation)
    }
}

impl MorphTrack {
    pub fn sample(&self, frame: f32) -> f32 {
        let keys = &self.keys;
        let Some(&(_, first)) = keys.first() else {
            return 0.0;
        };
        let Some(i) = key_before(keys, frame, |k| k.0) else {
            return first;
        };
        let (fa, wa) = keys[i];
        let Some(&(fb, wb)) = keys.get(i + 1) else {
            return wa;
        };
        let t = ((frame - fa as f32) / (fb - fa).max(1) as f32).clamp(0.0, 1.0);
        wa + (wb - wa) * t
    }
}

impl Motion {
    pub fn from_vmd(vmd: &VmdMotion) -> Self {
        let mut bones: HashMap<&str, Vec<BoneKey>> = HashMap::new();
        for k in &vmd.bones {
            bones.entry(&k.bone).or_default().push(BoneKey {
                frame: k.frame,
                translation: coords::position(k.translation),
                rotation: coords::quat(k.rotation),
                curves: k.curves,
            });
        }
        let mut morphs: HashMap<&str, Vec<(u32, f32)>> = HashMap::new();
        for k in &vmd.morphs {
            morphs.entry(&k.morph).or_default().push((k.frame, k.weight));
        }
        let mut ik: HashMap<&str, Vec<(u32, bool)>> = HashMap::new();
        for k in &vmd.ik {
            for (name, on) in &k.states {
                ik.entry(name).or_default().push((k.frame, *on));
            }
        }
        // Sort by frame; of keys on the same frame the last one in the file wins.
        let mut bones: Vec<(String, BoneTrack)> = bones
            .into_iter()
            .map(|(name, mut keys)| {
                keys.sort_by_key(|k| k.frame);
                keys.reverse();
                keys.dedup_by_key(|k| k.frame);
                keys.reverse();
                // Neighbouring quaternions in one hemisphere: slerp takes the short way.
                for i in 1..keys.len() {
                    if keys[i].rotation.dot(keys[i - 1].rotation) < 0.0 {
                        keys[i].rotation = -keys[i].rotation;
                    }
                }
                (name.to_string(), BoneTrack { keys })
            })
            .collect();
        bones.sort_by(|a, b| a.0.cmp(&b.0));
        let mut morphs: Vec<(String, MorphTrack)> = morphs
            .into_iter()
            .map(|(name, mut keys)| {
                keys.sort_by_key(|k| k.0);
                keys.reverse();
                keys.dedup_by_key(|k| k.0);
                keys.reverse();
                (name.to_string(), MorphTrack { keys })
            })
            .collect();
        morphs.sort_by(|a, b| a.0.cmp(&b.0));
        let mut ik: Vec<(String, Vec<(u32, bool)>)> = ik
            .into_iter()
            .map(|(name, mut keys)| {
                keys.sort_by_key(|k| k.0);
                (name.to_string(), keys)
            })
            .collect();
        ik.sort_by(|a, b| a.0.cmp(&b.0));
        Self { bones, morphs, ik, last_frame: vmd.last_frame() }
    }

    pub fn duration_secs(&self) -> f32 {
        self.last_frame as f32 / FPS
    }
}

/// A motion's tracks resolved against one model.
#[derive(Clone, Debug, Default)]
pub struct Binding {
    /// Bone index → bone track index.
    pub bones: Vec<Option<usize>>,
    /// Morph index → morph track index.
    pub morphs: Vec<Option<usize>>,
    /// Bone index → IK track index.
    pub ik: Vec<Option<usize>>,
    /// Bones and morphs of the motion the model lacks.
    pub missing_bones: usize,
    pub missing_morphs: usize,
}

impl Binding {
    pub fn new(motion: &Motion, skeleton: &Skeleton, morphs: &MorphRig) -> Self {
        let bone_tracks: HashMap<&str, usize> = motion.bones.iter().enumerate().map(|(i, (n, _))| (n.as_str(), i)).collect();
        let morph_tracks: HashMap<&str, usize> = motion.morphs.iter().enumerate().map(|(i, (n, _))| (n.as_str(), i)).collect();
        let ik_tracks: HashMap<&str, usize> = motion.ik.iter().enumerate().map(|(i, (n, _))| (n.as_str(), i)).collect();
        let bones: Vec<Option<usize>> = skeleton.bones.iter().map(|b| bone_tracks.get(b.name.as_str()).copied()).collect();
        let morph_binding: Vec<Option<usize>> = morphs.names.iter().map(|n| morph_tracks.get(n.as_str()).copied()).collect();
        let ik: Vec<Option<usize>> = skeleton.bones.iter().map(|b| ik_tracks.get(b.name.as_str()).copied()).collect();
        let missing_bones = motion.bones.iter().filter(|(n, _)| skeleton.find(n).is_none()).count();
        let missing_morphs = motion.morphs.len() - morph_binding.iter().flatten().count();
        Self { bones, morphs: morph_binding, ik, missing_bones, missing_morphs }
    }

    /// Writes the animated local transforms of `frame` into `translation`/`rotation`.
    pub fn sample_bones(&self, motion: &Motion, frame: f32, translation: &mut [Vec3], rotation: &mut [Quat]) {
        for (i, track) in self.bones.iter().enumerate() {
            if let Some(t) = track {
                let (pos, rot) = motion.bones[*t].1.sample(frame);
                translation[i] = pos;
                rotation[i] = rot;
            }
        }
    }

    pub fn sample_morphs(&self, motion: &Motion, frame: f32, weights: &mut [f32]) {
        for (i, track) in self.morphs.iter().enumerate() {
            weights[i] = track.map_or(0.0, |t| motion.morphs[t].1.sample(frame));
        }
    }

    /// IK switches at `frame`: bones without a track stay on.
    pub fn sample_ik(&self, motion: &Motion, frame: f32, enabled: &mut [bool]) {
        for (i, track) in self.ik.iter().enumerate() {
            enabled[i] = match track {
                Some(t) => {
                    let keys = &motion.ik[*t].1;
                    key_before(keys, frame, |k| k.0).map_or_else(|| keys.first().is_none_or(|k| k.1), |j| keys[j].1)
                }
                None => true,
            };
        }
    }
}
