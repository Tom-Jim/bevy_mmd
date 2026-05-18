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
    pub update_position: bool,
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
    pub fn load_from_assets() -> Self {
        let path = "src/config.toml";
        
        // 读取文件，读不到直接报错退出
        let s = fs::read_to_string(path)
            .expect(&format!("[config] 致命错误: 无法读取配置文件 {}。请检查文件是否存在或权限是否正确！", path));
            
        // 解析 TOML，格式不对直接报错退出
        toml::from_str::<Config>(&s)
            .expect("[config] 致命错误: TOML 解析失败！请检查文件里的字段名和数据类型是否匹配！")
    }
}
