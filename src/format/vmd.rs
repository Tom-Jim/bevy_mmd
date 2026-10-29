//! VMD motions: bone and morph keyframes, plus the IK on/off track.
//! Camera, light and shadow tracks are skipped.

use super::FormatError;
use super::reader::{Reader, decode_sjis};

pub const SIGNATURE_V2: &[u8] = b"Vocaloid Motion Data 0002";
const SIGNATURE_V1: &[u8] = b"Vocaloid Motion Data file";

#[derive(Clone, Debug, Default, PartialEq)]
pub struct VmdMotion {
    pub model_name: String,
    pub bones: Vec<BoneKey>,
    pub morphs: Vec<MorphKey>,
    pub ik: Vec<IkKey>,
}

/// A cubic Bézier easing curve with control points (x1, y1), (x2, y2) in 0..=127.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct Bezier {
    pub x1: u8,
    pub y1: u8,
    pub x2: u8,
    pub y2: u8,
}

impl Bezier {
    pub const LINEAR: Bezier = Bezier { x1: 20, y1: 20, x2: 107, y2: 107 };

    pub fn is_linear(&self) -> bool {
        self.x1 == self.y1 && self.x2 == self.y2
    }

    /// Eased progress for linear progress `x` in 0..=1.
    pub fn eval(&self, x: f32) -> f32 {
        let x = x.clamp(0.0, 1.0);
        if self.is_linear() {
            return x;
        }
        let (x1, y1) = (self.x1.min(127) as f32 / 127.0, self.y1.min(127) as f32 / 127.0);
        let (x2, y2) = (self.x2.min(127) as f32 / 127.0, self.y2.min(127) as f32 / 127.0);
        let curve = |t: f32, p1: f32, p2: f32| {
            let u = 1.0 - t;
            3.0 * u * u * t * p1 + 3.0 * u * t * t * p2 + t * t * t
        };
        let slope = |t: f32, p1: f32, p2: f32| {
            let u = 1.0 - t;
            3.0 * u * u * p1 + 6.0 * u * t * (p2 - p1) + 3.0 * t * t * (1.0 - p2)
        };
        // Newton steps from t = x, then bisection if they leave the bracket.
        let mut t = x;
        for _ in 0..8 {
            let err = curve(t, x1, x2) - x;
            if err.abs() < 1.0e-5 {
                return curve(t, y1, y2);
            }
            let d = slope(t, x1, x2);
            if d.abs() < 1.0e-6 {
                break;
            }
            t -= err / d;
            if !(0.0..=1.0).contains(&t) {
                break;
            }
        }
        let (mut lo, mut hi) = (0.0f32, 1.0f32);
        for _ in 0..24 {
            t = 0.5 * (lo + hi);
            if curve(t, x1, x2) < x {
                lo = t;
            } else {
                hi = t;
            }
        }
        curve(0.5 * (lo + hi), y1, y2)
    }
}

#[derive(Clone, Debug, PartialEq)]
pub struct BoneKey {
    pub bone: String,
    pub frame: u32,
    pub translation: [f32; 3],
    /// Quaternion x, y, z, w.
    pub rotation: [f32; 4],
    /// Easing of the segment that ends at this key: x, y, z, rotation.
    pub curves: [Bezier; 4],
}

#[derive(Clone, Debug, PartialEq)]
pub struct MorphKey {
    pub morph: String,
    pub frame: u32,
    pub weight: f32,
}

#[derive(Clone, Debug, PartialEq)]
pub struct IkKey {
    pub frame: u32,
    /// IK bone name and whether its solver runs from this frame on.
    pub states: Vec<(String, bool)>,
}

impl VmdMotion {
    pub fn parse(bytes: &[u8]) -> Result<Self, FormatError> {
        let mut r = Reader::new(bytes);
        let signature = r.bytes(30).map_err(|_| FormatError::Signature("VMD".into()))?;
        let name_len = if signature.starts_with(SIGNATURE_V2) {
            20
        } else if signature.starts_with(SIGNATURE_V1) {
            10
        } else {
            return Err(FormatError::Signature("VMD".into()));
        };
        let mut motion = VmdMotion { model_name: decode_sjis(r.bytes(name_len)?), ..Default::default() };

        let n = section_count(&mut r, 111)?;
        motion.bones.reserve(n);
        for _ in 0..n {
            let bone = decode_sjis(r.bytes(15)?);
            let frame = r.u32()?;
            let translation = r.vec3()?;
            let rotation = r.vec4()?;
            let interp = r.bytes(64)?;
            // Byte layout of the 4×16 interpolation block: axis a's curve is
            // x1 = [a], y1 = [a + 4], x2 = [a + 8], y2 = [a + 12].
            let curve = |a: usize| Bezier { x1: interp[a], y1: interp[a + 4], x2: interp[a + 8], y2: interp[a + 12] };
            if translation.iter().chain(&rotation).any(|v| !v.is_finite()) {
                continue;
            }
            motion.bones.push(BoneKey {
                bone,
                frame,
                translation,
                rotation,
                curves: [curve(0), curve(1), curve(2), curve(3)],
            });
        }

        let n = section_count(&mut r, 23)?;
        motion.morphs.reserve(n);
        for _ in 0..n {
            let morph = decode_sjis(r.bytes(15)?);
            let frame = r.u32()?;
            let weight = r.f32()?;
            if weight.is_finite() {
                motion.morphs.push(MorphKey { morph, frame, weight });
            }
        }

        // Camera, light and self-shadow tracks.
        for size in [61usize, 28, 9] {
            let n = section_count(&mut r, size)?;
            r.bytes(n * size)?;
        }

        let n = section_count(&mut r, 9)?;
        for _ in 0..n {
            let frame = r.u32()?;
            let _show = r.u8()?;
            let count = r.u32()? as usize;
            if count.saturating_mul(21) > r.remaining() {
                return Err(FormatError::BadCount { at: r.position(), count: count as i64 });
            }
            let mut states = Vec::with_capacity(count);
            for _ in 0..count {
                let name = decode_sjis(r.bytes(20)?);
                states.push((name, r.u8()? != 0));
            }
            motion.ik.push(IkKey { frame, states });
        }
        Ok(motion)
    }

    /// Last keyed frame of any track.
    pub fn last_frame(&self) -> u32 {
        let bones = self.bones.iter().map(|k| k.frame);
        let morphs = self.morphs.iter().map(|k| k.frame);
        bones.chain(morphs).max().unwrap_or(0)
    }
}

/// A section length, or 0 when the file ends before the section (older exporters
/// stop after the morphs).
fn section_count(r: &mut Reader, item: usize) -> Result<usize, FormatError> {
    if r.remaining() < 4 {
        return Ok(0);
    }
    let at = r.position();
    let n = r.u32()? as usize;
    if n.saturating_mul(item) > r.remaining() {
        return Err(FormatError::BadCount { at, count: n as i64 });
    }
    Ok(n)
}
