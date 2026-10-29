//! Bevy 0.20's pan-orbit camera controller, driven by the mouse: left drag orbits,
//! right or middle drag pans, the wheel zooms. Bevy's controller takes its anchor from
//! picking; this viewer does not raycast skinned meshes every frame, so motions anchor
//! at the last depth, which [`frame_model`] sets to the model's distance.

use bevy::camera_controller::pan_orbit_camera::SyncCameraPosition;
use bevy::camera_controller::pan_orbit_camera::prelude::*;
use bevy::core_pipeline::tonemapping::{DebandDither, Tonemapping};
use bevy::input::mouse::{MouseScrollUnit, MouseWheel};
use bevy::prelude::*;
use bevy::render::view::Msaa;
use bevy::window::CursorMoved;

pub struct CameraPlugin;

impl Plugin for CameraPlugin {
    fn build(&self, app: &mut App) {
        app.add_plugins(MinimalPanOrbitCameraPlugin)
            .add_systems(PreUpdate, drive_controller.before(SyncCameraPosition));
    }
}

#[derive(Component)]
pub struct ViewerCamera;

pub fn spawn(commands: &mut Commands, msaa: u32) {
    let msaa = match msaa {
        1 => Msaa::Off,
        2 => Msaa::Sample2,
        8 => Msaa::Sample8,
        _ => Msaa::Sample4,
    };
    commands.spawn((
        Camera3d::default(),
        Projection::Perspective(PerspectiveProjection { fov: 30f32.to_radians(), near: 0.5, ..default() }),
        // MikuMikuDance writes display colours directly: no tone curve.
        Tonemapping::None,
        DebandDither::Disabled,
        msaa,
        Transform::from_xyz(0.0, 10.0, 45.0).looking_at(Vec3::new(0.0, 10.0, 0.0), Vec3::Y),
        PanOrbitCamera {
            orbit_constraint: OrbitConstraint::Fixed { up: bevy::math::DVec3::Y, can_pass_tdc: false },
            ..PanOrbitCamera::default().with_initial_anchor_depth(45.0)
        },
        ViewerCamera,
    ));
}

/// Places the camera in front of a model of the given rest bounds.
pub fn frame_model(transform: &mut Transform, controller: &mut PanOrbitCamera, bounds: (Vec3, Vec3)) {
    let (min, max) = bounds;
    let height = (max.y - min.y).max(1.0);
    let target = Vec3::new(0.5 * (min.x + max.x), min.y + 0.55 * height, 0.5 * (min.z + max.z));
    let distance = height * 2.1;
    *transform = Transform::from_translation(target + Vec3::new(0.0, 0.05 * height, distance)).looking_at(target, Vec3::Y);
    controller.end_move();
    controller.current_motion = default();
    controller.last_anchor_depth = -(distance as f64);
}

#[derive(Default)]
struct DragState {
    active: Option<MouseButton>,
}

fn drive_controller(
    buttons: Res<ButtonInput<MouseButton>>,
    keys: Res<ButtonInput<KeyCode>>,
    mut moves: MessageReader<CursorMoved>,
    mut wheels: MessageReader<MouseWheel>,
    mut cameras: Query<&mut PanOrbitCamera, With<ViewerCamera>>,
    mut state: Local<DragState>,
) {
    let Ok(mut camera) = cameras.single_mut() else {
        moves.clear();
        wheels.clear();
        return;
    };
    let shift = keys.pressed(KeyCode::ShiftLeft) || keys.pressed(KeyCode::ShiftRight);
    if let Some(button) = state.active
        && !buttons.pressed(button)
    {
        camera.end_move();
        state.active = None;
    }
    if state.active.is_none() {
        for button in [MouseButton::Left, MouseButton::Right, MouseButton::Middle] {
            if buttons.just_pressed(button) {
                if button == MouseButton::Left && !shift {
                    camera.start_orbit(None);
                } else {
                    camera.start_pan(None);
                }
                state.active = Some(button);
                break;
            }
        }
    }
    let delta: Vec2 = moves.read().filter_map(|m| m.delta).sum();
    let zoom: f32 = wheels
        .read()
        .map(|w| match w.unit {
            MouseScrollUnit::Line => w.y * 100.0,
            MouseScrollUnit::Pixel => w.y,
        })
        .sum();
    if state.active.is_some() {
        camera.send_screenspace_input(delta);
        camera.send_zoom_input(zoom);
    } else if zoom != 0.0 {
        if !camera.current_motion.is_zooming_only() {
            camera.start_zoom(None);
        }
        camera.send_zoom_input(zoom);
    } else if camera.current_motion.is_zooming_only() {
        // Wheel input arrives in bursts: keep the zoom alive until its smoothing settles.
        let window = camera.smoothing.zoom.mul_f32(2.0);
        let speed = camera.current_motion.inputs().map_or(0.0, |i| i.zoom_velocity_abs(window));
        if speed <= 0.0 {
            camera.end_move();
        }
    }
}
