//! Bone hierarchy, forward kinematics, inherited ("append") transforms and the CCD IK
//! solver, following MikuMikuDance's evaluation order: bones sorted by
//! (after-physics, layer, index), each one's inherited transform and IK solved when
//! it is reached, the rig's physics in between the two stages.

use std::collections::HashMap;
use std::f32::consts::PI;

use glam::{Mat3, Quat, Vec3};

use super::coords;
use crate::format::pmx::{PmxModel, bone_flags};

#[derive(Clone, Debug)]
pub struct Inherit {
    pub source: usize,
    pub ratio: f32,
    pub rotation: bool,
    pub translation: bool,
    pub local: bool,
}

#[derive(Clone, Debug)]
pub struct IkLink {
    pub bone: usize,
    /// Euler XYZ limits (min, max) in the viewer's coordinates.
    pub limit: Option<(Vec3, Vec3)>,
}

#[derive(Clone, Debug)]
pub struct IkChain {
    /// The effector that should reach the IK bone.
    pub target: usize,
    pub iterations: u32,
    pub limit_angle: f32,
    pub links: Vec<IkLink>,
}

#[derive(Clone, Debug)]
pub struct BoneDef {
    pub name: String,
    pub parent: Option<usize>,
    /// Model-space position in the bind pose.
    pub rest: Vec3,
    /// `rest` relative to the parent's rest position.
    pub offset: Vec3,
    pub inherit: Option<Inherit>,
    pub ik: Option<IkChain>,
    pub after_physics: bool,
}

#[derive(Clone, Debug, Default)]
pub struct Skeleton {
    pub bones: Vec<BoneDef>,
    /// Evaluation order; every parent precedes its children.
    pub order: Vec<usize>,
    pub children: Vec<Vec<usize>>,
    by_name: HashMap<String, usize>,
}

/// A transform the physics rig imposes on a bone.
#[derive(Clone, Copy, Debug)]
pub enum Override {
    /// Position and rotation from a simulated body.
    Full(Vec3, Quat),
    /// Rotation from a simulated body; the animated position stays.
    Rotation(Quat),
}

/// Per-bone animation state of one frame.
#[derive(Clone, Debug, Default)]
pub struct Pose {
    /// Animated local translation (on top of the rest offset) and rotation.
    pub translation: Vec<Vec3>,
    pub rotation: Vec<Quat>,
    pub world_pos: Vec<Vec3>,
    pub world_rot: Vec<Quat>,
    append_t: Vec<Vec3>,
    append_r: Vec<Quat>,
    ik_r: Vec<Quat>,
    /// IK scratch: Euler angles of the previous iteration and the hinge angle.
    ik_prev: Vec<Vec3>,
    ik_plane: Vec<f32>,
    ik_saved: Vec<Quat>,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Stage {
    BeforePhysics,
    AfterPhysics,
}

impl Skeleton {
    pub fn from_pmx(model: &PmxModel) -> Self {
        let n = model.bones.len();
        let valid = |i: i32, me: usize| (i >= 0 && (i as usize) < n && i as usize != me).then_some(i as usize);
        let mut bones = Vec::with_capacity(n);
        for (i, b) in model.bones.iter().enumerate() {
            let parent = valid(b.parent, i);
            let rest = coords::position(b.position);
            let inherit = b.inherit.and_then(|(source, ratio)| {
                let source = valid(source, i)?;
                Some(Inherit {
                    source,
                    ratio,
                    rotation: b.has(bone_flags::INHERIT_ROTATION),
                    translation: b.has(bone_flags::INHERIT_TRANSLATION),
                    local: b.has(bone_flags::LOCAL_INHERIT),
                })
            });
            let ik = b.ik.as_ref().and_then(|ik| {
                let target = valid(ik.target, i)?;
                let links: Vec<IkLink> = ik
                    .links
                    .iter()
                    .filter_map(|l| {
                        let bone = valid(l.bone, i)?;
                        let limit = l.limit.map(|(lo, hi)| {
                            let (lo, hi) = coords::angular_range(lo, hi);
                            (Vec3::from(lo), Vec3::from(hi))
                        });
                        Some(IkLink { bone, limit })
                    })
                    .collect();
                (!links.is_empty()).then(|| IkChain {
                    target,
                    iterations: ik.iterations.min(256),
                    limit_angle: if ik.limit_angle > 0.0 { ik.limit_angle } else { PI },
                    links,
                })
            });
            bones.push(BoneDef {
                name: b.name.clone(),
                parent,
                rest,
                offset: rest,
                inherit,
                ik,
                after_physics: b.has(bone_flags::AFTER_PHYSICS),
            });
        }
        let layers: Vec<i32> = model.bones.iter().map(|b| b.layer).collect();
        Self::assemble(bones, &layers)
    }

    /// Fills `offset`, `children`, the evaluation order and the name table.
    pub fn assemble(mut bones: Vec<BoneDef>, layers: &[i32]) -> Self {
        let n = bones.len();
        // A parent cycle would make FK loop: cut it at the bone that closes it.
        for i in 0..n {
            let mut steps = 0;
            let mut p = bones[i].parent;
            while let Some(j) = p {
                steps += 1;
                if j == i || steps > n {
                    bones[i].parent = None;
                    break;
                }
                p = bones[j].parent;
            }
        }
        for i in 0..n {
            bones[i].offset = match bones[i].parent {
                Some(p) => bones[i].rest - bones[p].rest,
                None => bones[i].rest,
            };
        }
        let mut children = vec![Vec::new(); n];
        for (i, b) in bones.iter().enumerate() {
            if let Some(p) = b.parent {
                children[p].push(i);
            }
        }
        let mut sorted: Vec<usize> = (0..n).collect();
        sorted.sort_by_key(|&i| (bones[i].after_physics, layers.get(i).copied().unwrap_or(0), i));
        let mut placed = vec![false; n];
        let mut order = Vec::with_capacity(n);
        while order.len() < n {
            let before = order.len();
            for &i in &sorted {
                if !placed[i] && bones[i].parent.is_none_or(|p| placed[p]) {
                    placed[i] = true;
                    order.push(i);
                }
            }
            assert!(order.len() > before, "parent cycles are cut above");
        }
        let mut by_name = HashMap::with_capacity(n);
        for (i, b) in bones.iter().enumerate() {
            by_name.entry(b.name.clone()).or_insert(i);
        }
        Self { bones, order, children, by_name }
    }

    pub fn len(&self) -> usize {
        self.bones.len()
    }

    pub fn is_empty(&self) -> bool {
        self.bones.is_empty()
    }

    pub fn find(&self, name: &str) -> Option<usize> {
        self.by_name.get(name).copied()
    }

    pub fn rest_pose(&self) -> Pose {
        let n = self.len();
        let mut pose = Pose {
            translation: vec![Vec3::ZERO; n],
            rotation: vec![Quat::IDENTITY; n],
            world_pos: self.bones.iter().map(|b| b.rest).collect(),
            world_rot: vec![Quat::IDENTITY; n],
            append_t: vec![Vec3::ZERO; n],
            append_r: vec![Quat::IDENTITY; n],
            ik_r: vec![Quat::IDENTITY; n],
            ik_prev: vec![Vec3::ZERO; n],
            ik_plane: vec![0.0; n],
            ik_saved: Vec::new(),
        };
        // The bind pose: no IK (knee limits would bend the legs a little).
        let no_ik = vec![false; n];
        self.evaluate(&mut pose, &no_ik, Stage::BeforePhysics);
        self.evaluate(&mut pose, &no_ik, Stage::AfterPhysics);
        pose
    }

    /// Resets the per-frame state; call before writing the frame's animation.
    pub fn begin_frame(&self, pose: &mut Pose) {
        pose.translation.fill(Vec3::ZERO);
        pose.rotation.fill(Quat::IDENTITY);
        pose.append_t.fill(Vec3::ZERO);
        pose.append_r.fill(Quat::IDENTITY);
        pose.ik_r.fill(Quat::IDENTITY);
    }

    /// World transforms of one stage. `ik_enabled[i]` switches the IK of bone `i`
    /// (missing entries are on).
    pub fn evaluate(&self, pose: &mut Pose, ik_enabled: &[bool], stage: Stage) {
        let after = stage == Stage::AfterPhysics;
        for &i in &self.order {
            let bone = &self.bones[i];
            if bone.after_physics != after {
                continue;
            }
            if let Some(inherit) = &bone.inherit {
                self.apply_inherit(pose, i, inherit);
            }
            self.update_world(pose, i);
            if let Some(ik) = &bone.ik
                && ik_enabled.get(i).copied().unwrap_or(true)
            {
                self.solve_ik(pose, i, ik);
            }
        }
    }

    /// Imposes the physics results and re-derives every other bone of the first stage
    /// from them.
    pub fn apply_physics(&self, pose: &mut Pose, overrides: &[Option<Override>]) {
        for &i in &self.order {
            let bone = &self.bones[i];
            if bone.after_physics {
                continue;
            }
            let (parent_pos, parent_rot) = self.parent_world(pose, i);
            match overrides.get(i).copied().flatten() {
                Some(Override::Full(pos, rot)) => {
                    let inv = parent_rot.inverse();
                    pose.rotation[i] = (inv * rot).normalize();
                    pose.translation[i] = inv * (pos - parent_pos) - bone.offset;
                    pose.append_t[i] = Vec3::ZERO;
                    pose.append_r[i] = Quat::IDENTITY;
                    pose.ik_r[i] = Quat::IDENTITY;
                    pose.world_pos[i] = pos;
                    pose.world_rot[i] = rot;
                }
                Some(Override::Rotation(rot)) => {
                    pose.rotation[i] = (parent_rot.inverse() * rot).normalize();
                    pose.append_r[i] = Quat::IDENTITY;
                    pose.ik_r[i] = Quat::IDENTITY;
                    pose.world_pos[i] = parent_pos + parent_rot * (bone.offset + pose.translation[i] + pose.append_t[i]);
                    pose.world_rot[i] = rot;
                }
                None => self.update_world(pose, i),
            }
        }
    }

    pub fn local_rotation(&self, pose: &Pose, i: usize) -> Quat {
        pose.ik_r[i] * pose.rotation[i] * pose.append_r[i]
    }

    fn parent_world(&self, pose: &Pose, i: usize) -> (Vec3, Quat) {
        match self.bones[i].parent {
            Some(p) => (pose.world_pos[p], pose.world_rot[p]),
            None => (Vec3::ZERO, Quat::IDENTITY),
        }
    }

    fn update_world(&self, pose: &mut Pose, i: usize) {
        let (pp, pr) = self.parent_world(pose, i);
        let local_t = self.bones[i].offset + pose.translation[i] + pose.append_t[i];
        pose.world_pos[i] = pp + pr * local_t;
        pose.world_rot[i] = (pr * self.local_rotation(pose, i)).normalize();
    }

    fn update_subtree(&self, pose: &mut Pose, root: usize) {
        self.update_world(pose, root);
        let mut stack: Vec<usize> = self.children[root].clone();
        while let Some(i) = stack.pop() {
            self.update_world(pose, i);
            stack.extend_from_slice(&self.children[i]);
        }
    }

    fn apply_inherit(&self, pose: &mut Pose, i: usize, inherit: &Inherit) {
        let s = inherit.source;
        let source_has_inherit = self.bones[s].inherit.is_some();
        if inherit.rotation {
            let mut r = if inherit.local || !source_has_inherit {
                pose.rotation[s]
            } else {
                pose.rotation[s] * pose.append_r[s]
            };
            r = pose.ik_r[s] * r;
            pose.append_r[i] = Quat::IDENTITY.slerp(r.normalize(), inherit.ratio);
        }
        if inherit.translation {
            let mut t = pose.translation[s];
            if !inherit.local && source_has_inherit {
                t += pose.append_t[s];
            }
            pose.append_t[i] = t * inherit.ratio;
        }
    }

    fn solve_ik(&self, pose: &mut Pose, ik_bone: usize, ik: &IkChain) {
        for link in &ik.links {
            pose.ik_r[link.bone] = Quat::IDENTITY;
            pose.ik_prev[link.bone] = Vec3::ZERO;
            pose.ik_plane[link.bone] = 0.0;
        }
        // The outermost link's subtree holds the whole chain and the effector.
        let root = ik.links.last().map_or(ik.target, |l| l.bone);
        self.update_subtree(pose, root);

        let mut best = f32::INFINITY;
        let mut saved = std::mem::take(&mut pose.ik_saved);
        for iteration in 0..ik.iterations {
            self.solve_ik_step(pose, ik_bone, ik, iteration);
            let dist = pose.world_pos[ik.target].distance(pose.world_pos[ik_bone]);
            if dist < best {
                best = dist;
                saved.clear();
                saved.extend(ik.links.iter().map(|l| pose.ik_r[l.bone]));
            } else {
                for (link, r) in ik.links.iter().zip(&saved) {
                    pose.ik_r[link.bone] = *r;
                }
                break;
            }
            if dist < 1.0e-4 {
                break;
            }
        }
        if !saved.is_empty() {
            for (link, r) in ik.links.iter().zip(&saved) {
                pose.ik_r[link.bone] = *r;
            }
        }
        pose.ik_saved = saved;
        self.update_subtree(pose, root);
    }

    fn solve_ik_step(&self, pose: &mut Pose, ik_bone: usize, ik: &IkChain, iteration: u32) {
        for link in &ik.links {
            let b = link.bone;
            if b == ik.target {
                continue;
            }
            if let Some((lo, hi)) = link.limit
                && let Some(axis) = single_axis(lo, hi)
            {
                self.solve_ik_plane(pose, ik_bone, ik, link, axis, lo, hi, iteration);
                continue;
            }
            let inv_rot = pose.world_rot[b].inverse();
            let to_ik = (inv_rot * (pose.world_pos[ik_bone] - pose.world_pos[b])).normalize_or_zero();
            let to_target = (inv_rot * (pose.world_pos[ik.target] - pose.world_pos[b])).normalize_or_zero();
            if to_ik == Vec3::ZERO || to_target == Vec3::ZERO {
                continue;
            }
            let angle = to_target.dot(to_ik).clamp(-1.0, 1.0).acos();
            if angle < 1.0e-5 {
                continue;
            }
            let axis = to_target.cross(to_ik);
            if axis.length_squared() < 1.0e-12 {
                continue;
            }
            let delta = Quat::from_axis_angle(axis.normalize(), angle.min(ik.limit_angle));
            let anim = pose.rotation[b];
            let mut rot = (pose.ik_r[b] * anim * delta).normalize();
            if let Some((lo, hi)) = link.limit {
                let prev = pose.ik_prev[b];
                let euler = decompose_xyz(Mat3::from_quat(rot), prev);
                let clamped = euler.clamp(lo, hi);
                let step = Vec3::splat(ik.limit_angle);
                let clamped = (clamped - prev).clamp(-step, step) + prev;
                rot = Quat::from_rotation_x(clamped.x) * Quat::from_rotation_y(clamped.y) * Quat::from_rotation_z(clamped.z);
                pose.ik_prev[b] = clamped;
            }
            pose.ik_r[b] = (rot * anim.inverse()).normalize();
            self.update_subtree(pose, b);
        }
    }

    #[allow(clippy::too_many_arguments)]
    fn solve_ik_plane(
        &self,
        pose: &mut Pose,
        ik_bone: usize,
        ik: &IkChain,
        link: &IkLink,
        axis: usize,
        lo: Vec3,
        hi: Vec3,
        iteration: u32,
    ) {
        let b = link.bone;
        let rotate_axis = [Vec3::X, Vec3::Y, Vec3::Z][axis];
        let inv_rot = pose.world_rot[b].inverse();
        let to_ik = (inv_rot * (pose.world_pos[ik_bone] - pose.world_pos[b])).normalize_or_zero();
        let to_target = (inv_rot * (pose.world_pos[ik.target] - pose.world_pos[b])).normalize_or_zero();
        if to_ik == Vec3::ZERO || to_target == Vec3::ZERO {
            return;
        }
        let angle = to_target.dot(to_ik).clamp(-1.0, 1.0).acos().min(ik.limit_angle);
        let forward = (Quat::from_axis_angle(rotate_axis, angle) * to_target).dot(to_ik);
        let backward = (Quat::from_axis_angle(rotate_axis, -angle) * to_target).dot(to_ik);
        let mut new_angle = pose.ik_plane[b] + if forward > backward { angle } else { -angle };
        let (min, max) = (lo[axis], hi[axis]);
        if iteration == 0 && (new_angle < min || new_angle > max) {
            if -new_angle > min && -new_angle < max {
                new_angle = -new_angle;
            } else {
                let half = 0.5 * (min + max);
                if (half - new_angle).abs() > (half + new_angle).abs() {
                    new_angle = -new_angle;
                }
            }
        }
        let new_angle = new_angle.clamp(min, max);
        pose.ik_plane[b] = new_angle;
        pose.ik_r[b] = (Quat::from_axis_angle(rotate_axis, new_angle) * pose.rotation[b].inverse()).normalize();
        self.update_subtree(pose, b);
    }
}

/// The only axis a limit leaves free (a knee), if exactly one is.
fn single_axis(lo: Vec3, hi: Vec3) -> Option<usize> {
    let free: Vec<usize> = (0..3).filter(|&a| lo[a] != 0.0 || hi[a] != 0.0).collect();
    (free.len() == 1).then(|| free[0])
}

fn normalize_angle(a: f32) -> f32 {
    a.rem_euclid(2.0 * PI)
}

fn diff_angle(a: f32, b: f32) -> f32 {
    let d = normalize_angle(a) - normalize_angle(b);
    if d > PI {
        d - 2.0 * PI
    } else if d < -PI {
        d + 2.0 * PI
    } else {
        d
    }
}

/// Euler angles (x, y, z) with R = Rx·Ry·Rz, picking among the equivalent solutions the
/// one closest to `before` so the solver does not flip between branches.
pub fn decompose_xyz(m: Mat3, before: Vec3) -> Vec3 {
    // Row r, column c of R = Rx·Ry·Rz:
    //   R02 = sy,  R01 = -cy·sz,  R00 = cy·cz,  R12 = -sx·cy,  R22 = cx·cy.
    let e = |r: usize, c: usize| m.col(c)[r];
    let sy = e(0, 2).clamp(-1.0, 1.0);
    let mut r = Vec3::new(0.0, sy.asin(), 0.0);
    if 1.0 - sy.abs() < 1.0e-6 {
        // Gimbal lock: only x ± z is defined. Keep x and solve z from Rx(-x)·R = Ry·Rz,
        // whose row 1 is (sz, cz, 0).
        r.x = before.x;
        let rest = Mat3::from_rotation_x(-r.x) * m;
        r.z = rest.col(0)[1].atan2(rest.col(1)[1]);
    } else {
        r.x = (-e(1, 2)).atan2(e(2, 2));
        r.z = (-e(0, 1)).atan2(e(0, 0));
    }
    let err = |v: Vec3| diff_angle(v.x, before.x).abs() + diff_angle(v.y, before.y).abs() + diff_angle(v.z, before.z).abs();
    let mut best = r;
    let mut best_err = err(r);
    for sx in [PI, -PI] {
        for (ty, sz) in [(PI, PI), (PI, -PI), (-PI, PI), (-PI, -PI)] {
            let candidate = Vec3::new(r.x + sx, ty - r.y, r.z + sz);
            let e = err(candidate);
            if e < best_err {
                best_err = e;
                best = candidate;
            }
        }
    }
    best
}
