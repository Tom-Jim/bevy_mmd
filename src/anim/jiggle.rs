//! Inertial secondary motion of soft tissue: chest and hips lag behind the body's
//! acceleration and settle back with a damped bounce.
//!
//! Each jiggle bone carries a point mass tied to its animated position by a spring.
//! The spring is stiffer front-to-back than up-and-down (the torso's frame), so a jump
//! bounces vertically and a twist sways sideways, as soft tissue does. The mass's
//! offset from the animated position moves the bone (and its children). It runs after
//! the rigid-body rig, so it adds motion to models whose rigs have none for these
//! areas, and a capped offset can never tear the skin.

use glam::{Quat, Vec3};
use serde::{Deserialize, Serialize};

use super::skeleton::{Override, Pose, Skeleton};
use crate::format::pmx::PmxModel;

#[derive(Clone, Copy, Debug, Serialize, Deserialize, PartialEq)]
pub struct Spring {
    /// Natural frequency of the vertical bounce, Hz.
    pub frequency: f32,
    /// Damping ratio (1 = no overshoot).
    pub damping: f32,
    /// Stiffness multipliers (torso frame): sideways, vertical, front-to-back.
    pub stiffness: [f32; 3],
    /// Largest offset as a fraction of the model's height.
    pub max_offset: f32,
}

#[derive(Clone, Debug, Serialize, Deserialize, PartialEq)]
#[serde(default)]
pub struct JiggleSettings {
    pub enabled: bool,
    /// Scales every offset (0 = off, 1 = as tuned).
    pub strength: f32,
    pub chest: Spring,
    pub hips: Spring,
}

impl Default for JiggleSettings {
    fn default() -> Self {
        Self {
            enabled: true,
            strength: 1.0,
            chest: Spring { frequency: 4.2, damping: 0.22, stiffness: [1.6, 1.0, 2.2], max_offset: 0.012 },
            hips: Spring { frequency: 3.4, damping: 0.3, stiffness: [1.4, 1.0, 2.0], max_offset: 0.009 },
        }
    }
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Region {
    Chest,
    Hips,
}

#[derive(Clone, Debug)]
struct Body {
    bone: usize,
    region: Region,
    /// The bone whose frame orients the spring (the torso bone above).
    frame: Option<usize>,
    position: Vec3,
    velocity: Vec3,
    offset: Vec3,
}

#[derive(Clone, Debug, Default)]
pub struct Jiggle {
    bodies: Vec<Body>,
    height: f32,
    primed: bool,
    overrides: Vec<Option<Override>>,
}

const CHEST: [&str; 5] = ["胸", "乳", "おっぱい", "bust", "breast"];
const HIPS: [&str; 5] = ["尻", "ヒップ", "臀", "hip", "butt"];
/// Bones that match the words above but are the torso or an ornament, not soft tissue.
const NOT_SOFT: [&str; 10] = ["上半身", "下半身", "胸元", "ネクタイ", "リボン", "腰", "花", "飾", "IK", "ＩＫ"];

/// Lower-case Latin words of a name, for whole-word matches ("butt" is not "Butterfly").
fn words(name: &str) -> Vec<String> {
    name.to_lowercase().split(|c: char| !c.is_ascii_alphabetic()).filter(|w| !w.is_empty()).map(str::to_string).collect()
}

fn region_of(name: &str) -> Option<Region> {
    if NOT_SOFT.iter().any(|w| name.contains(w)) {
        return None;
    }
    let latin = words(name);
    let has = |list: &[&str]| list.iter().any(|w| if w.is_ascii() { latin.iter().any(|l| l == w) } else { name.contains(w) });
    if has(&CHEST) {
        Some(Region::Chest)
    } else if has(&HIPS) {
        Some(Region::Hips)
    } else {
        None
    }
}

/// -1 left, 1 right, 0 neither: soft tissue comes in pairs, so unsided bones are skipped.
fn side_of(name: &str) -> i8 {
    let latin = words(name);
    if name.contains('左') || latin.iter().any(|w| w == "l" || w == "left") {
        -1
    } else if name.contains('右') || latin.iter().any(|w| w == "r" || w == "right") {
        1
    } else {
        0
    }
}

/// Gives a model without buttock bones a pair under `下半身`.
///
/// Each new bone sits inside the buttock; vertices on the back of the hip near it pass
/// part of their `下半身` weight to it, falling off smoothly with distance. At rest the
/// bone moves exactly like `下半身`, so the skin is unchanged until the spring moves it.
/// Weight on the legs stays where it is, so thigh deformation is not affected.
/// Returns the number of bones added.
pub fn add_hip_bones(model: &mut PmxModel) -> usize {
    use crate::format::pmx::{Bone, BoneTail, Weight, bone_flags};
    let has_hips = model.bones.iter().any(|b| region_of(&b.name) == Some(Region::Hips) && side_of(&b.name) != 0);
    let find = |name: &str| model.bones.iter().position(|b| b.name == name);
    let (Some(lower), Some(left), Some(right)) = (find("下半身"), find("左足"), find("右足")) else { return 0 };
    if has_hips {
        return 0;
    }
    let (lo, hi) = model.vertices.iter().fold((f32::MAX, f32::MIN), |(lo, hi), v| (lo.min(v.position[1]), hi.max(v.position[1])));
    let height = (hi - lo).max(1.0);
    let mut added = 0;
    for leg in [left, right] {
        let joint = Vec3::from(model.bones[leg].position);
        let hip_x = joint.x;
        let weight_on = |w: &Weight, bone: usize| {
            let (b, ws) = w.linear();
            (0..4).filter(|&k| b[k] as usize == bone).map(|k| ws[k]).sum::<f32>()
        };
        // MikuMikuDance models face -Z: the back of the hip is +Z of the leg joint.
        let surface: Vec<Vec3> = model
            .vertices
            .iter()
            .map(|v| (Vec3::from(v.position), weight_on(&v.weight, lower)))
            .filter(|(p, w)| {
                *w > 0.3 && (p.y - (joint.y - 0.02 * height)).abs() < 0.05 * height && p.x * hip_x > 0.0 && (p.x - hip_x).abs() < 0.06 * height && p.z > joint.z
            })
            .map(|(p, _)| p)
            .collect();
        if surface.len() < 8 {
            continue;
        }
        let back = surface.iter().copied().fold(Vec3::ZERO, |a, p| a + p) / surface.len() as f32;
        let center = Vec3::new(back.x, back.y, 0.5 * (back.z + joint.z));
        let radius = 0.075 * height;
        let index = model.bones.len() as i32;
        let side = if leg == left { "L" } else { "R" };
        model.bones.push(Bone {
            name: format!("jiggle hip {side}"),
            name_en: format!("jiggle hip {side}"),
            position: center.to_array(),
            parent: lower as i32,
            layer: model.bones[lower].layer,
            flags: bone_flags::ROTATABLE | bone_flags::TRANSLATABLE,
            tail: BoneTail::Offset([0.0, 0.0, 0.0]),
            inherit: None,
            fixed_axis: None,
            local_axes: None,
            external_key: None,
            ik: None,
        });
        for v in &mut model.vertices {
            let p = Vec3::from(v.position);
            let d = p.distance(back);
            if d >= radius || p.z < joint.z - 0.01 * height {
                continue;
            }
            let (bones, weights) = v.weight.linear();
            let Some(slot) = (0..4).find(|&k| bones[k] as usize == lower && weights[k] > 0.0) else { continue };
            let falloff = (1.0 - d / radius).powi(2) * 0.85;
            let moved = weights[slot] * falloff;
            let mut b: [i32; 4] = bones.map(|x| x as i32);
            let mut w = weights;
            w[slot] -= moved;
            // An empty slot takes the new bone; otherwise the weakest weight merges into 下半身.
            let free = (0..4).find(|&k| w[k] == 0.0 && k != slot).unwrap_or_else(|| {
                let k = (0..4).filter(|&k| k != slot).min_by(|&a, &c| w[a].total_cmp(&w[c])).unwrap();
                w[slot] += w[k];
                k
            });
            b[free] = index;
            w[free] = moved;
            v.weight = Weight::Bdef4 { bones: b, weights: w };
        }
        added += 1;
    }
    added
}

impl Jiggle {
    /// Picks, per region and side, the soft-tissue bone that carries the most skin.
    pub fn new(model: &PmxModel, skeleton: &Skeleton) -> Self {
        let mut skin = vec![0f32; skeleton.len()];
        for v in &model.vertices {
            let (bones, weights) = v.weight.linear();
            for k in 0..4 {
                if let Some(s) = skin.get_mut(bones[k] as usize) {
                    *s += weights[k];
                }
            }
        }
        let mut best: Vec<((Region, i8), usize)> = Vec::new();
        for (i, bone) in skeleton.bones.iter().enumerate() {
            let Some(region) = region_of(&bone.name) else { continue };
            let side = side_of(&bone.name);
            if skin[i] < 1.0 || side == 0 {
                continue;
            }
            let key = (region, side);
            match best.iter_mut().find(|(k, _)| *k == key) {
                Some((_, b)) if skin[i] > skin[*b] => *b = i,
                Some(_) => {}
                None => best.push((key, i)),
            }
        }
        // A bone below another chosen bone would jiggle twice.
        let chosen: Vec<usize> = best.iter().map(|(_, b)| *b).collect();
        let below_chosen = |mut i: usize| {
            while let Some(p) = skeleton.bones[i].parent {
                if chosen.contains(&p) {
                    return true;
                }
                i = p;
            }
            false
        };
        let bodies = best
            .iter()
            .filter(|(_, b)| !below_chosen(*b))
            .map(|&((region, _), bone)| Body {
                bone,
                region,
                frame: skeleton.bones[bone].parent,
                position: Vec3::ZERO,
                velocity: Vec3::ZERO,
                offset: Vec3::ZERO,
            })
            .collect();
        let (lo, hi) = skeleton.bones.iter().fold((f32::MAX, f32::MIN), |(lo, hi), b| (lo.min(b.rest.y), hi.max(b.rest.y)));
        Self { bodies, height: (hi - lo).max(1.0), primed: false, overrides: vec![None; skeleton.len()] }
    }

    pub fn bones(&self) -> impl Iterator<Item = (usize, Region)> + '_ {
        self.bodies.iter().map(|b| (b.bone, b.region))
    }

    /// Forget the motion so far (after a seek, a loop or a new motion).
    pub fn reset(&mut self) {
        self.primed = false;
    }

    /// Advances the springs by `dt` against the current pose and returns the bone
    /// transforms they impose (indexed by bone), or `None` when nothing moves.
    pub fn step(&mut self, pose: &Pose, dt: f32, settings: &JiggleSettings) -> Option<&[Option<Override>]> {
        if !settings.enabled || settings.strength <= 0.0 || self.bodies.is_empty() {
            return None;
        }
        let restart = !self.primed || !(dt > 0.0) || dt > 0.25;
        self.primed = true;
        let substeps = ((dt / (1.0 / 240.0)).ceil() as u32).clamp(1, 16);
        let h = dt / substeps as f32;
        self.overrides.fill(None);
        for body in &mut self.bodies {
            let target = pose.world_pos[body.bone];
            let frame = body.frame.map_or(Quat::IDENTITY, |f| pose.world_rot[f]);
            let spring = match body.region {
                Region::Chest => settings.chest,
                Region::Hips => settings.hips,
            };
            if restart {
                body.position = target;
                body.velocity = Vec3::ZERO;
                body.offset = Vec3::ZERO;
            } else {
                let omega = std::f32::consts::TAU * spring.frequency;
                let k = Vec3::from(spring.stiffness) * omega * omega;
                let c = Vec3::from(spring.stiffness).map(f32::sqrt) * 2.0 * spring.damping * omega;
                // Semi-implicit Euler in the torso frame; the target moves linearly
                // across the sub-steps from where the mass's anchor was.
                let start = body.position - body.offset;
                for s in 1..=substeps {
                    let anchor = start.lerp(target, s as f32 / substeps as f32);
                    let d = frame.inverse() * (body.position - anchor);
                    let v = frame.inverse() * body.velocity;
                    let a = -k * d - c * v;
                    body.velocity += frame * a * h;
                    body.position += body.velocity * h;
                }
                let max = spring.max_offset * self.height;
                let mut offset = body.position - target;
                if offset.length() > max {
                    offset = offset.normalize() * max;
                    body.position = target + offset;
                    // Drop the outward speed at the stop so it does not stick there.
                    let n = offset.normalize();
                    body.velocity -= n * body.velocity.dot(n).max(0.0);
                }
                body.offset = offset;
            }
            let shown = body.offset * settings.strength;
            self.overrides[body.bone] = Some(Override::Full(target + shown, pose.world_rot[body.bone]));
        }
        Some(&self.overrides)
    }
}
