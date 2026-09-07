use crate::components::*;
use crate::config::Config;
use bevy::prelude::*;
use bevy::prelude::{Quat, Vec3};
use std::collections::HashMap;
use std::fs::File;
use std::io::BufReader;
use std::path::Path;

// Error types for VMD parsing.
#[derive(Debug)]
pub enum VmdMotionError {
    Io(std::io::Error),
    Parse(String),
    Vmd(vmd_parser::VmdError),
}

impl From<std::io::Error> for VmdMotionError {
    fn from(value: std::io::Error) -> Self {
        Self::Io(value)
    }
}

impl From<vmd_parser::VmdError> for VmdMotionError {
    fn from(value: vmd_parser::VmdError) -> Self {
        Self::Vmd(value)
    }
}

/// Per-axis cubic Bezier interpolation curve stored in VMD keyframes.
/// Each curve occupies 16 bytes; the four effective control points are:
///   x1=bytes[0], y1=bytes[4], x2=bytes[8], y2=bytes[12]
/// Normalised to [0,1]: P0=(0,0), P1=(x1/127, y1/127), P2=(x2/127, y2/127), P3=(1,1).
/// x1==y1==20 and x2==y2==107 indicates a linear curve.
#[derive(Debug, Clone, Copy)]
pub struct BezierCurve {
    pub x1: u8, // P1.x * 127
    pub y1: u8, // P1.y * 127
    pub x2: u8, // P2.x * 127
    pub y2: u8, // P2.y * 127
}

impl BezierCurve {
    pub fn from_bytes(b: &[u8; 16]) -> Self {
        Self {
            x1: b[0],
            y1: b[4],
            x2: b[8],
            y2: b[12],
        }
    }

    pub fn sample(&self, x: f32) -> f32 {
        if self.is_linear() {
            return x;
        }
        let curve = |t: f32, a: u8, b: u8| {
            let u = 1.0 - t;
            3.0 * u * u * t * (a.min(127) as f32 / 127.0)
                + 3.0 * u * t * t * (b.min(127) as f32 / 127.0)
                + t * t * t
        };
        let (mut low, mut high) = (0.0, 1.0);
        for _ in 0..16 {
            let mid = (low + high) * 0.5;
            if curve(mid, self.x1, self.x2) < x {
                low = mid;
            } else {
                high = mid;
            }
        }
        curve((low + high) * 0.5, self.y1, self.y2)
    }

    pub fn is_linear(&self) -> bool {
        self.x1 == 20 && self.y1 == 20 && self.x2 == 107 && self.y2 == 107
    }
}

/// Bone keyframe: local transform of a bone at a specific frame, plus per-axis Bezier curves.
#[derive(Debug, Clone, Copy)]
pub struct VmdBoneKeyframe {
    pub frame: u32,
    /// Local translation delta (cm, right-hand Z-back coordinate system).
    pub translation: Vec3,
    pub rotation: Quat,
    pub x_curve: BezierCurve,
    pub y_curve: BezierCurve,
    pub z_curve: BezierCurve,
    pub r_curve: BezierCurve,
}

/// Morph (blend-shape) keyframe. Weight is in [0.0, 1.0].
#[derive(Debug, Clone)]
pub struct VmdMorphKeyframe {
    pub name: String,
    pub frame: u32,
    pub weight: f32,
}

#[derive(Debug, Clone, Copy)]
pub struct BonePose {
    pub translation: Vec3,
    pub rotation: Quat,
}

/// Full parsed VMD animation clip.
#[derive(Debug, Default)]
pub struct VmdMotionClip {
    /// Highest frame number across all bone keyframes.
    pub duration_frames: u32,
    pub bones: HashMap<String, Vec<VmdBoneKeyframe>>,
    pub morphs: HashMap<String, Vec<VmdMorphKeyframe>>,
}
pub fn init_vmd(commands: &mut Commands, cfg: &Config) {
    let vmd_file = &cfg.paths.vmd;
    let vmd_path = if Path::new(vmd_file).is_absolute() {
        vmd_file.to_string()
    } else {
        format!("assets/{}", vmd_file)
    };
    match VmdMotionClip::from_file(&vmd_path) {
        Ok(clip) => {
            commands.insert_resource(VmdPlayback {
                clip,
                fps: 30.0,
                time_sec: 0.0,
            });
        }
        Err(e) => eprintln!("[ERROR] VMD load failed: {}", e),
    }
}
impl VmdMotionClip {
    pub fn from_file(path: impl AsRef<Path>) -> Result<Self, VmdMotionError> {
        let file = File::open(path)?;
        let mut reader = BufReader::new(file);
        let vmd = vmd_parser::vmd_read(&mut reader)?;

        let mut clip = VmdMotionClip::default();

        for record in &vmd.bone {
            let dbg = format!("{:?}", record);
            let (bone_name, kf) = parse_bone_record_debug(&dbg).ok_or_else(|| {
                VmdMotionError::Parse(format!("failed to parse bone keyframe: {dbg}"))
            })?;
            clip.duration_frames = clip.duration_frames.max(kf.frame);
            clip.bones.entry(bone_name).or_default().push(kf);
        }
        for keyframes in clip.bones.values_mut() {
            keyframes.sort_by_key(|k| k.frame);
        }

        for record in &vmd.morph {
            let dbg = format!("{:?}", record);
            if let Some(m) = parse_morph_record_debug(&dbg) {
                clip.duration_frames = clip.duration_frames.max(m.frame);
                clip.morphs.entry(m.name.clone()).or_default().push(m);
            }
        }
        for keyframes in clip.morphs.values_mut() {
            keyframes.sort_by_key(|k| k.frame);
        }

        Ok(clip)
    }

    pub fn sample_morph_at_frame(&self, morph_name: &str, frame: f32) -> Option<f32> {
        let keys = self.morphs.get(morph_name)?;
        if keys.is_empty() {
            return None;
        }
        if frame <= keys[0].frame as f32 {
            return Some(keys[0].weight);
        }
        if frame >= keys[keys.len() - 1].frame as f32 {
            return Some(keys[keys.len() - 1].weight);
        }
        let mut i = 0usize;
        while i + 1 < keys.len() {
            let a = &keys[i];
            let b = &keys[i + 1];
            if frame >= a.frame as f32 && frame <= b.frame as f32 {
                let dt = (b.frame - a.frame).max(1) as f32;
                let t = ((frame - a.frame as f32) / dt).clamp(0.0, 1.0);
                // VMD morph doesn't use bezier curves, just linear lerp
                return Some(a.weight + (b.weight - a.weight) * t);
            }
            i += 1;
        }
        None
    }

    pub fn sample_morph_at_seconds(&self, morph_name: &str, seconds: f32, fps: f32) -> Option<f32> {
        self.sample_morph_at_frame(morph_name, seconds.max(0.0) * fps.max(1.0))
    }

    pub fn sample_bone_at_frame(&self, bone_name: &str, frame: f32) -> Option<BonePose> {
        let keys = self.bones.get(bone_name)?;
        if keys.is_empty() {
            return None;
        }
        if frame <= keys[0].frame as f32 {
            return Some(BonePose {
                translation: keys[0].translation,
                rotation: keys[0].rotation,
            });
        }
        if frame >= keys[keys.len() - 1].frame as f32 {
            let last = keys[keys.len() - 1];
            return Some(BonePose {
                translation: last.translation,
                rotation: last.rotation,
            });
        }
        let mut i = 0usize;
        while i + 1 < keys.len() {
            let a = keys[i];
            let b = keys[i + 1];
            if frame >= a.frame as f32 && frame <= b.frame as f32 {
                let dt = (b.frame - a.frame).max(1) as f32;
                let t = ((frame - a.frame as f32) / dt).clamp(0.0, 1.0);
                return Some(BonePose {
                    translation: a.translation
                        + (b.translation - a.translation)
                            * Vec3::new(
                                b.x_curve.sample(t),
                                b.y_curve.sample(t),
                                b.z_curve.sample(t),
                            ),
                    rotation: a.rotation.slerp(b.rotation, b.r_curve.sample(t)),
                });
            }
            i += 1;
        }
        None
    }

    pub fn sample_bone_at_seconds(
        &self,
        bone_name: &str,
        seconds: f32,
        fps: f32,
    ) -> Option<BonePose> {
        self.sample_bone_at_frame(bone_name, seconds.max(0.0) * fps.max(1.0))
    }
}

// Debug-string parsing helpers. The parser keeps keyframe fields private, so
// records are formatted and decoded here.
fn extract_between<'a>(s: &'a str, start: &str, end: &str) -> Option<&'a str> {
    let a = s.find(start)? + start.len();
    let b = s[a..].find(end)? + a;
    Some(&s[a..b])
}

fn extract_after<'a>(s: &'a str, start: &str) -> Option<&'a str> {
    let a = s.find(start)? + start.len();
    Some(&s[a..])
}

fn extract_bracket_array<'a>(s: &'a str, key: &str) -> Option<&'a str> {
    let start = s.find(key)? + key.len();
    let end = s[start..].find(']')? + start;
    Some(&s[start..end])
}

fn parse_f32_3(src: &str) -> Option<[f32; 3]> {
    let mut vals = src.split(',').map(|v| v.trim().parse::<f32>().ok());
    Some([vals.next()??, vals.next()??, vals.next()??])
}

fn parse_f32_4(src: &str) -> Option<[f32; 4]> {
    let mut vals = src.split(',').map(|v| v.trim().parse::<f32>().ok());
    Some([vals.next()??, vals.next()??, vals.next()??, vals.next()??])
}

// Bone record parser.
// Debug format example:
// BoneKeyFrameRecord { bone_name: "センター", frame_time: 0,
//   translation: [0.0, 0.0, 0.0], rotation: [0.0, 0.0, 0.0, 1.0],
//   x_curve: [20, ...16 bytes...], y_curve: [...], z_curve: [...], r_curve: [...] }
fn parse_bone_record_debug(input: &str) -> Option<(String, VmdBoneKeyframe)> {
    let name = extract_between(input, "bone_name: \"", "\"")?;
    let frame_s = extract_after(input, "frame_time: ")?;
    let frame: u32 = frame_s.split(',').next()?.trim().parse().ok()?;

    let translation_src = extract_bracket_array(input, "translation: [")?;
    let rotation_src = extract_bracket_array(input, "rotation: [")?;

    let t = parse_f32_3(translation_src)?;
    let r = parse_f32_4(rotation_src)?;
    if t.iter().chain(r.iter()).any(|x| !x.is_finite())
        || Quat::from_array(r).length_squared() < 1e-8
    {
        return None;
    }

    // Parse the four per-axis interpolation curves (16 bytes each).
    let x_curve = parse_curve_field(input, "x_curve: ")?;
    let y_curve = parse_curve_field(input, "y_curve: ")?;
    let z_curve = parse_curve_field(input, "z_curve: ")?;
    let r_curve = parse_curve_field(input, "r_curve: ")?;

    Some((
        name.to_string(),
        VmdBoneKeyframe {
            frame,
            translation: Vec3::new(t[0], t[1], t[2]),
            rotation: Quat::from_xyzw(r[0], r[1], r[2], r[3]).normalize(),
            x_curve: BezierCurve::from_bytes(&x_curve),
            y_curve: BezierCurve::from_bytes(&y_curve),
            z_curve: BezierCurve::from_bytes(&z_curve),
            r_curve: BezierCurve::from_bytes(&r_curve),
        },
    ))
}

/// Locates `key: [...]` in a Debug string and extracts a 16-byte array.
fn parse_curve_field(input: &str, key: &str) -> Option<[u8; 16]> {
    let start_pos = input.find(key)? + key.len();
    let sub = &input[start_pos..];
    // sub starts at '['
    let inner_start = sub.find('[')? + 1;
    let inner_end = sub.find(']')?;
    let inner = &sub[inner_start..inner_end];
    let mut vals = inner.split(',').map(|v| v.trim().parse::<u8>().ok());
    let mut arr = [0u8; 16];
    for item in &mut arr {
        *item = vals.next()??;
    }
    Some(arr)
}

// Morph record parser. Example debug format:
// MorphKeyFrameRecord { morph_name: "まばたき", frame_time: 0, weight: 0.0 }
fn parse_morph_record_debug(input: &str) -> Option<VmdMorphKeyframe> {
    let name = extract_between(input, "morph_name: \"", "\"")?;
    let frame_s = extract_after(input, "frame_time: ")?;
    let frame: u32 = frame_s.split(',').next()?.trim().parse().ok()?;
    let weight_s = extract_after(input, "weight: ")?;
    let weight: f32 = weight_s.trim_end_matches('}').trim().parse().ok()?;

    Some(VmdMorphKeyframe {
        name: name.to_string(),
        frame,
        weight,
    })
}

impl std::fmt::Display for VmdMotionError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::Io(e) => write!(f, "{e}"),
            Self::Parse(e) => write!(f, "{e}"),
            Self::Vmd(e) => write!(f, "{e:?}"),
        }
    }
}
