// ═════════════════════════════════════════════════════════════════════════════
// bevy3Danimation — PMX + VMD 实时 CPU 蒙皮动画播放器
// ═════════════════════════════════════════════════════════════════════════════

use std::ffi::c_void;

use bevy::asset::AssetPlugin;
use bevy::pbr::MaterialPlugin;
use bevy::prelude::*;
use bevy_panorbit_camera::PanOrbitCameraPlugin;

mod animation;
mod components;
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

    // 调用 C 接口必须放在 unsafe 块里
    unsafe {
        // 1. 让 Zig 初始化 Jolt Physics
        let ptr = jolt_init();
        PHYSICS_SYSTEM_PTR.store(ptr as *mut _, std::sync::atomic::Ordering::SeqCst);

        // 2. 测试传参和返回值
        let result = jolt_math_test(10.001, 31.00314);
        println!("Rust: Got math result from Zig/Jolt: {}", result);
    }
    App::new()
        .add_plugins(DefaultPlugins.set(AssetPlugin {
            file_path: "assets".into(),
            watch_for_changes_override: Some(true),
            ..Default::default()
        }))
        .add_plugins(MaterialPlugin::<PmxMaterial>::default())
        .add_plugins(PanOrbitCameraPlugin)
        .add_systems(Startup, setup)
        // 两阶段：先计算骨骼+蒙皮，再把结果写入各 Mesh
        .add_systems(Update, (skin_update_system, apply_skin_to_meshes).chain())
        .add_systems(Update, (draw_debug_bodies, draw_soft_bodies))
        .run();
}
