//! Viewer configuration: `defaults.toml`, embedded in the binary.

use bevy::prelude::Resource;
use serde::{Deserialize, Serialize};

use crate::anim::jiggle::JiggleSettings;
use crate::physics::PhysicsSettings;

pub const DEFAULTS: &str = include_str!("defaults.toml");

#[derive(Clone, Debug, Default, Serialize, Deserialize, PartialEq)]
#[serde(default)]
pub struct SceneConfig {
    pub model: String,
    pub motion: String,
}

#[derive(Clone, Debug, Serialize, Deserialize, PartialEq)]
#[serde(default)]
pub struct PlaybackConfig {
    pub speed: f32,
    pub looping: bool,
}

impl Default for PlaybackConfig {
    fn default() -> Self {
        Self { speed: 1.0, looping: true }
    }
}

#[derive(Clone, Debug, Serialize, Deserialize, PartialEq)]
#[serde(default)]
pub struct RenderConfig {
    pub light_direction: [f32; 3],
    pub light_color: [f32; 3],
    pub background: [f32; 3],
    pub outline: bool,
    pub outline_scale: f32,
    pub msaa: u32,
}

impl Default for RenderConfig {
    fn default() -> Self {
        Self {
            light_direction: [-0.5, -1.0, -0.5],
            light_color: [0.6; 3],
            background: [0.09, 0.1, 0.12],
            outline: true,
            outline_scale: 1.0,
            msaa: 4,
        }
    }
}

#[derive(Clone, Debug, Default, Serialize, Deserialize, PartialEq, Resource)]
#[serde(default)]
pub struct ViewerConfig {
    pub scene: SceneConfig,
    pub playback: PlaybackConfig,
    pub render: RenderConfig,
    pub physics: PhysicsSettings,
    pub jiggle: JiggleSettings,
}

impl ViewerConfig {
    pub fn parse(text: &str) -> Result<Self, String> {
        let config: Self = toml::from_str(text).map_err(|e| format!("viewer config: {e}"))?;
        config.validate()?;
        Ok(config)
    }

    pub fn defaults() -> Self {
        Self::parse(DEFAULTS).expect("defaults.toml is valid")
    }

    pub fn validate(&self) -> Result<(), String> {
        let p = &self.physics;
        let finite = [p.gravity, p.max_substep, p.max_frame, p.spring_damping_ratio, p.spring_scale, p.extra_damping]
            .iter()
            .all(|v| v.is_finite() && *v >= 0.0);
        if !finite || !(p.max_substep > 0.0) || p.max_substeps == 0 || p.extra_damping >= 1.0 {
            return Err("viewer config: physics values out of range".into());
        }
        if !(self.playback.speed.is_finite() && self.playback.speed >= 0.0) {
            return Err("viewer config: playback speed out of range".into());
        }
        if ![1, 2, 4, 8].contains(&self.render.msaa) {
            return Err("viewer config: msaa must be 1, 2, 4 or 8".into());
        }
        Ok(())
    }
}
