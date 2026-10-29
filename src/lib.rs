//! MMD player: PMX models animated by VMD motions, hair and clothes simulated with Jolt.
//!
//! * [`format`] reads PMX and VMD files.
//! * [`anim`] evaluates skeletons, IK, morphs and motions (no engine dependency).
//! * [`physics`] runs the model's rigid-body rig in Jolt.
//! * `viewer` draws it all with Bevy; `web` is the browser entry point.

pub mod anim;
pub mod format;
pub mod physics;

#[cfg(feature = "viewer")]
pub mod viewer;

#[cfg(all(feature = "web", target_arch = "wasm32"))]
pub mod web;
