use bevy::prelude::*;
use bevy_panorbit_camera::PanOrbitCamera;

use crate::components::*;
use crate::config::Config;

/// 场景初始化：加载 PMX、构建蒙皮、创建子 Mesh、加载 VMD、创建灯光/相机。
///
/// 这个函数原本在 `main.rs` 中。为了把 `main.rs` 保持简洁，我们把它抽出到
/// `setup` 模块里。函数体保持与原实现一致，未改变业务逻辑，只做了模块
/// 组织与注释增强。
pub fn setup(
    mut commands: Commands,
    asset_server: Res<AssetServer>,
    mut meshes: ResMut<Assets<Mesh>>,
    mut materials: ResMut<Assets<PmxMaterial>>,
) {
    // 读取配置（assets/config.toml），并作为 Resource 注入 ECS
    let cfg = Config::load_from_assets();
    commands.insert_resource(cfg.clone());

    // 把 PMX 加载与 Mesh/Material 构建委托给 pmx 模块
    crate::pmx::init_pmx(
        &mut commands,
        &asset_server,
        &mut meshes,
        &mut materials,
        &cfg,
    );
    crate::vmd::init_vmd(&mut commands, &cfg);
    // 灯光 & 相机
    commands.spawn((
        PointLight {
            intensity: cfg.render.point_light_intensity,
            range: cfg.render.point_light_range,
            shadows_enabled: false,
            ..default()
        },
        Transform::from_xyz(5.0, 50.0, -20.0),
    ));
    commands.spawn(AmbientLight {
        color: Color::WHITE,
        brightness: cfg.render.ambient_brightness,
        ..default()
    });
    commands.spawn((
        DirectionalLight {
            illuminance: cfg.render.directional_illuminance,
            shadows_enabled: false,
            ..default()
        },
        Transform::from_xyz(10.0, 30.0, -10.0).looking_at(Vec3::ZERO, Vec3::Y),
    ));
    commands.spawn((
        Camera3d::default(),
        Transform::from_xyz(0.0, 30.0, 50.0).looking_at(Vec3::new(0.0, 50.0, 0.0), Vec3::Y),
        PanOrbitCamera::default(),
    ));
}
