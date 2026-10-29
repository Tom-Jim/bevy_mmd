//! The viewer in a plain window, without the Tauri shell: for profiling and debugging.
//! `cargo run --release --features standalone --bin viewer [model.pmx] [motion.vmd]`
//!
//! `VIEWER_SHOT=out.png` saves the window after `VIEWER_SHOT_AT` seconds (default 6)
//! and exits; `VIEWER_STATUS=1` prints the status JSON.

use bevy::prelude::*;
use bevy::render::view::screenshot::{Screenshot, save_to_disk};
use bevy::window::PresentMode;
use bevy3d_animation::viewer::config::ViewerConfig;
use bevy3d_animation::viewer::source::Source;
use bevy3d_animation::viewer::{MmdPlugin, bridge};

fn main() {
    let assets = std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("assets");
    let mut app = App::new();
    app.add_plugins(DefaultPlugins.set(WindowPlugin {
        primary_window: Some(Window {
            title: "bevy3Danimation".into(),
            present_mode: PresentMode::AutoVsync,
            ..default()
        }),
        ..default()
    }))
    .add_plugins(MmdPlugin { config: ViewerConfig::defaults(), assets: Source::Disk(assets) });
    let paths: Vec<String> = std::env::args().skip(1).collect();
    if !paths.is_empty() {
        bridge::queue(bridge::Command::LoadPaths { paths });
    }
    bridge::set_sink(|json| {
        if std::env::var_os("VIEWER_STATUS").is_some() {
            println!("{json}");
        }
    });
    if let Ok(path) = std::env::var("VIEWER_SHOT") {
        let at: f32 = std::env::var("VIEWER_SHOT_AT").ok().and_then(|v| v.parse().ok()).unwrap_or(6.0);
        app.add_systems(Update, move |mut commands: Commands, time: Res<Time>, mut state: Local<u8>, mut exit: MessageWriter<AppExit>| {
            let t = time.elapsed_secs();
            if *state == 0 && t > at {
                commands.spawn(Screenshot::primary_window()).observe(save_to_disk(path.clone()));
                *state = 1;
            } else if *state == 1 && t > at + 1.5 {
                exit.write(AppExit::Success);
            }
        });
    }
    app.run();
}
