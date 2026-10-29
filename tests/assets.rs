//! Every PMX and VMD under `assets/` (the local, untracked model library): each parses,
//! binds, animates and simulates without non-finite values, and the simulated cloth
//! and hair do not tear: triangle edges stay close to their rest length.
//! Skips when the library is absent.

use std::path::{Path, PathBuf};

use bevy3d_animation::anim::coords;
use bevy3d_animation::anim::motion::Motion;
use bevy3d_animation::anim::Animator;
use bevy3d_animation::format::{pmx::PmxModel, vmd::VmdMotion};
use bevy3d_animation::physics::{PhysicsRig, PhysicsSettings};
use glam::Vec3;

fn files(ext: &str) -> Vec<PathBuf> {
    fn walk(dir: &Path, ext: &str, out: &mut Vec<PathBuf>) {
        let Ok(entries) = std::fs::read_dir(dir) else { return };
        for e in entries.flatten() {
            let p = e.path();
            if p.is_dir() {
                walk(&p, ext, out);
            } else if p.extension().and_then(|e| e.to_str()).is_some_and(|e| e.eq_ignore_ascii_case(ext)) {
                out.push(p);
            }
        }
    }
    let mut out = Vec::new();
    walk(&Path::new(env!("CARGO_MANIFEST_DIR")).join("assets"), ext, &mut out);
    out.sort();
    out
}

/// The dance motion of the library (the one with the most bone keys).
fn dance(motions: &[PathBuf]) -> Option<Motion> {
    motions
        .iter()
        .filter_map(|p| VmdMotion::parse(&std::fs::read(p).ok()?).ok())
        .max_by_key(|m| m.bones.len())
        .map(|m| Motion::from_vmd(&m))
}

/// Skinned vertex positions of the current pose (linear blend skinning).
fn skin(model: &PmxModel, animator: &Animator, out: &mut Vec<Vec3>) {
    let transforms: Vec<_> = (0..animator.skeleton.len()).map(|i| animator.skin_transform(i)).collect();
    out.clear();
    out.extend(model.vertices.iter().map(|v| {
        let rest = coords::position(v.position);
        let (bones, weights) = v.weight.linear();
        let mut p = Vec3::ZERO;
        for k in 0..4 {
            if weights[k] > 0.0 {
                let (t, r) = transforms.get(bones[k] as usize).copied().unwrap_or_default();
                p += (r * rest + t) * weights[k];
            }
        }
        p
    }));
}

struct Stretch {
    /// Fraction of edge samples longer than twice their rest length.
    torn: f64,
    worst: f32,
}

fn run(model: &PmxModel, motion: Option<&Motion>, physics: bool, frames: u32) -> Stretch {
    let mut animator = Animator::new(model);
    animator.set_motion(motion.cloned());
    let mut rig = physics.then(|| PhysicsRig::new(model, &animator.skeleton, &PhysicsSettings::default())).flatten();
    let rest: Vec<Vec3> = model.vertices.iter().map(|v| coords::position(v.position)).collect();
    let edges: Vec<(usize, usize, f32)> = model
        .indices
        .chunks_exact(3)
        .flat_map(|t| [(t[0], t[1]), (t[1], t[2]), (t[2], t[0])])
        .map(|(a, b)| (a as usize, b as usize, rest[a as usize].distance(rest[b as usize])))
        .filter(|e| e.2 > 1.0e-3)
        .collect();
    let mut skinned = Vec::new();
    let (mut torn, mut samples, mut worst) = (0u64, 0u64, 1.0f32);
    for frame in 0..frames {
        animator.animate(frame as f32 / 60.0);
        let overrides = rig.as_mut().map(|r| r.step(&animator.pose, 1.0 / 60.0).to_vec());
        animator.finish(overrides.as_deref(), 1.0 / 60.0);
        assert!(animator.pose.world_pos.iter().all(|p| p.is_finite()), "non-finite pose at frame {frame}");
        if frame % 10 != 9 {
            continue;
        }
        skin(model, &animator, &mut skinned);
        for &(a, b, len) in &edges {
            let ratio = skinned[a].distance(skinned[b]) / len;
            worst = worst.max(ratio);
            torn += (ratio > 2.0) as u64;
            samples += 1;
        }
    }
    Stretch { torn: torn as f64 / samples.max(1) as f64, worst }
}

#[test]
fn every_model_plays_without_tearing() {
    let models = files("pmx");
    if models.is_empty() {
        eprintln!("no PMX under assets/, skipped");
        return;
    }
    let motion = dance(&files("vmd"));
    for path in &models {
        let mut model = PmxModel::parse(&std::fs::read(path).unwrap()).unwrap_or_else(|e| panic!("{}: {e}", path.display()));
        bevy3d_animation::anim::jiggle::add_hip_bones(&mut model);
        let t0 = std::time::Instant::now();
        let animated = run(&model, motion.as_ref(), false, 600);
        let simulated = run(&model, motion.as_ref(), true, 600);
        let ms = t0.elapsed().as_secs_f64() * 1000.0 / 1200.0;
        let name = path.file_name().unwrap().to_string_lossy();
        let jiggle = Animator::new(&model);
        let soft: Vec<String> = jiggle.jiggle.bones().map(|(b, r)| format!("{}:{r:?}", jiggle.skeleton.bones[b].name)).collect();
        eprintln!("{name}: jiggle {soft:?}");
        eprintln!(
            "{name}: {} bodies; torn edges {:.4}% (animation alone {:.4}%), worst stretch {:.2} ({:.2}); {ms:.2} ms/frame",
            model.rigid_bodies.len(),
            simulated.torn * 100.0,
            animated.torn * 100.0,
            simulated.worst,
            animated.worst,
        );
        // Physics may stretch cloth a little, but it must not tear it apart.
        assert!(
            simulated.torn <= animated.torn + 0.0002,
            "{name}: {:.3}% of edges more than doubled (animation alone {:.3}%)",
            simulated.torn * 100.0,
            animated.torn * 100.0
        );
    }
}

#[test]
fn every_motion_parses() {
    for path in files("vmd") {
        VmdMotion::parse(&std::fs::read(&path).unwrap()).unwrap_or_else(|e| panic!("{}: {e}", path.display()));
    }
}
