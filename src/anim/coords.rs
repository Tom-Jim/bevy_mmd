//! MikuMikuDance is left-handed (Z into the screen); the viewer is right-handed.
//! Mirroring Z maps one onto the other: positions negate z, a rotation R becomes
//! S·R·S with S = diag(1, 1, -1), which negates the quaternion's x and y.

use glam::{EulerRot, Quat, Vec3};

pub fn position(v: [f32; 3]) -> Vec3 {
    Vec3::new(v[0], v[1], -v[2])
}

pub fn quat(q: [f32; 4]) -> Quat {
    let q = Quat::from_xyzw(-q[0], -q[1], q[2], q[3]);
    if q.length_squared() > 1.0e-12 { q.normalize() } else { Quat::IDENTITY }
}

/// PMX rigid bodies and joints store Euler angles applied as Y, then X, then Z.
pub fn euler_yxz(r: [f32; 3]) -> Quat {
    Quat::from_euler(EulerRot::YXZ, -r[1], -r[0], r[2])
}

/// A (lower, upper) range of a translation axis set: z flips and swaps.
pub fn linear_range(lower: [f32; 3], upper: [f32; 3]) -> ([f32; 3], [f32; 3]) {
    ([lower[0], lower[1], -upper[2]], [upper[0], upper[1], -lower[2]])
}

/// A (lower, upper) range of rotation angles: x and y flip and swap.
pub fn angular_range(lower: [f32; 3], upper: [f32; 3]) -> ([f32; 3], [f32; 3]) {
    ([-upper[0], -upper[1], lower[2]], [-lower[0], -lower[1], upper[2]])
}
