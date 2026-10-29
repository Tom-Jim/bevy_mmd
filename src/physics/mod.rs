//! MikuMikuDance physics on Jolt: rigid bodies on bones, 6DOF spring joints between
//! them. Hair, skirts and ribbons are the chains of simulated bodies a PMX model rigs.

pub mod ffi;
pub mod rig;
#[cfg(target_arch = "wasm32")]
mod wasi;
pub mod world;

pub use rig::{PhysicsRig, PhysicsSettings};
