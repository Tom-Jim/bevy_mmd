use bevy::asset::AssetPlugin;
use bevy::diagnostic::{FrameTimeDiagnosticsPlugin, LogDiagnosticsPlugin};
use bevy::pbr::MaterialPlugin;
use bevy::prelude::*;
use bevy_panorbit_camera::PanOrbitCameraPlugin;
use std::time::Duration;

mod animation;
mod components;
mod config;
mod file_drop;
mod physics;
mod pmx;
mod setup;
mod softbody;
mod vmd;

use animation::*;
use components::*;
use physics::*;
use setup::setup;

fn main() {
    println!("Rust: Starting engine...");
    let asset_root = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("assets");

    unsafe {
        let ptr = jolt_init();
        PHYSICS_SYSTEM_PTR.store(ptr as *mut _, std::sync::atomic::Ordering::SeqCst);
    }
    App::new()
        .add_plugins(
            DefaultPlugins
                .set(AssetPlugin {
                    file_path: asset_root.to_string_lossy().into_owned(),
                    unapproved_path_mode: bevy::asset::UnapprovedPathMode::Allow,
                    watch_for_changes_override: Some(true),
                    ..Default::default()
                })
                .set(WindowPlugin {
                    primary_window: Some(Window {
                        title: "bevy3Danimation MMD Player".into(),
                        ..Default::default()
                    }),
                    ..Default::default()
                }),
        )
        .add_plugins(MaterialPlugin::<PmxMaterial>::default())
        .add_plugins(FrameTimeDiagnosticsPlugin::default())
        .add_plugins(LogDiagnosticsPlugin {
            wait_duration: Duration::from_secs(1),
            ..Default::default()
        })
        .add_plugins(PanOrbitCameraPlugin)
        .insert_resource(Time::<Fixed>::from_hz(60.0))
        .add_systems(Startup, setup)
        // Two-phase: compute skinning once, then copy results into each Mesh.
        .add_systems(FixedUpdate, skin_update_system)
        .add_systems(Update, file_drop::reload_dropped_files)
        .add_systems(PostUpdate, apply_skin_to_meshes)
        .add_systems(Last, physics::shutdown)
        .run();
}
