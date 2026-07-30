use bevy::asset::AssetPlugin;
use bevy::pbr::MaterialPlugin;
use bevy::prelude::*;
use bevy_panorbit_camera::PanOrbitCameraPlugin;

mod animation;
mod components;
mod config;
mod physics;
mod pmx;
mod screen_record;
mod setup;
mod softbody;
mod vmd;

use animation::*;
use components::*;
use physics::*;
use setup::setup;

fn main() {
    println!("Rust: Starting engine...");

    unsafe {
        let ptr = jolt_init();
        PHYSICS_SYSTEM_PTR.store(ptr as *mut _, std::sync::atomic::Ordering::SeqCst);

        let result = jolt_math_test(10.001, 31.00314);
        println!("Rust: Got math result from Zig/Jolt: {}", result);
    }
    App::new()
        .add_plugins(
            DefaultPlugins
                .set(AssetPlugin {
                    file_path: "assets".into(),
                    watch_for_changes_override: Some(true),
                    ..Default::default()
                })
                .set(WindowPlugin {
                    primary_window: Some(Window {
                        title: "bevy3Danimation MMD Player".into(),
                        ..Default::default()
                    }),
                    // Disabled: window-close control is delegated to screen_record module.
                    //close_when_requested: false,
                    ..Default::default()
                }),
        )
        .add_plugins(MaterialPlugin::<PmxMaterial>::default())
        .add_plugins(PanOrbitCameraPlugin)
        //.add_plugins(screen_record::ScreenRecordPlugin)
        .add_systems(Startup, setup)
        // Two-phase: compute skinning once, then copy results into each Mesh.
        .add_systems(Update, (skin_update_system, apply_skin_to_meshes).chain())
        .add_systems(Update, (draw_debug_bodies, draw_soft_bodies))
        .run();
}
