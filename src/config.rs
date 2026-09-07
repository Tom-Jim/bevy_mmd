use bevy::prelude::Resource;
use serde::Deserialize;
use std::fs;

#[derive(Debug, Deserialize, Clone, Resource)]
pub struct Config {
    pub paths: Paths,
    pub softbody: SoftBodyConfig,
    pub render: RenderConfig,
}

#[derive(Debug, Deserialize, Clone)]
pub struct Paths {
    pub pmx: String,
    pub vmd: String,
}

#[derive(Debug, Deserialize, Clone)]
pub struct SoftBodyConfig {
    pub position_pull: f32,
    pub velocity_pull: f32,
    pub damping: f32,
    pub max_speed: f32,
    pub stretch_compliance: f32,
    pub shear_compliance: f32,
    pub bend_compliance: f32,
    pub iterations: i32,
    pub gravity_factor: f32,
    pub collision_margin: f32,
    pub max_distance: f32,
    #[serde(default = "default_hair_gravity_factor")]
    pub hair_gravity_factor: f32,
    #[serde(default = "default_cloth_gravity_factor")]
    pub cloth_gravity_factor: f32,
    #[serde(default = "default_hair_damping")]
    pub hair_damping: f32,
    #[serde(default = "default_cloth_damping")]
    pub cloth_damping: f32,
    #[serde(default = "default_hair_air_drag")]
    pub hair_air_drag: f32,
    #[serde(default = "default_cloth_air_drag")]
    pub cloth_air_drag: f32,
}

fn default_hair_gravity_factor() -> f32 {
    0.72
}
fn default_cloth_gravity_factor() -> f32 {
    1.0
}
fn default_hair_damping() -> f32 {
    0.985
}
fn default_cloth_damping() -> f32 {
    0.965
}
fn default_hair_air_drag() -> f32 {
    0.65
}
fn default_cloth_air_drag() -> f32 {
    0.35
}

#[derive(Debug, Deserialize, Clone)]
pub struct RenderConfig {
    pub global_emissive_strength: f32,
    pub point_light_intensity: f32,
    pub point_light_range: f32,
    pub ambient_brightness: f32,
    pub directional_illuminance: f32,
}

impl Config {
    pub fn load() -> Self {
        let path = "config.toml";

        let s = fs::read_to_string(path).unwrap_or_else(|e| panic!("Cannot read {path}: {e}"));

        let cfg = toml::from_str::<Config>(&s)
            .expect("[config] fatal: TOML parse failed — verify field names and types");
        let soft = &cfg.softbody;
        assert!(
            [
                soft.position_pull,
                soft.velocity_pull,
                soft.damping,
                soft.max_speed,
                soft.stretch_compliance,
                soft.shear_compliance,
                soft.bend_compliance,
                soft.gravity_factor,
                soft.collision_margin,
                soft.max_distance,
                soft.hair_gravity_factor,
                soft.cloth_gravity_factor,
                soft.hair_damping,
                soft.cloth_damping,
                soft.hair_air_drag,
                soft.cloth_air_drag
            ]
            .iter()
            .all(|v| v.is_finite() && *v >= 0.0),
            "Physics parameters must be finite and nonnegative"
        );
        assert!(
            soft.position_pull <= 1.0
                && soft.damping <= 1.0
                && soft.max_distance > 0.0
                && soft.max_speed > 0.0
                && soft.hair_damping <= 1.0
                && soft.cloth_damping <= 1.0
                && (1..=128).contains(&soft.iterations),
            "Invalid physics parameter range"
        );
        cfg
    }
}
