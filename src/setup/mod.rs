use bevy::prelude::*;
use bevy_panorbit_camera::PanOrbitCamera;

use crate::components::*;
use crate::config::Config;

pub fn setup(
    mut commands: Commands,
    asset_server: Res<AssetServer>,
    mut meshes: ResMut<Assets<Mesh>>,
    mut materials: ResMut<Assets<PmxMaterial>>,
) {
    let cfg = Config::load_from_assets();
    commands.insert_resource(cfg.clone());

    crate::pmx::init_pmx(
        &mut commands,
        &asset_server,
        &mut meshes,
        &mut materials,
        &cfg,
    );
    crate::vmd::init_vmd(&mut commands, &cfg);
    commands.spawn((
        PointLight {
            intensity: cfg.render.point_light_intensity,
            range: cfg.render.point_light_range,
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
