use bevy::app::AppExit;
use bevy::prelude::*;
use bevy::render::view::screenshot::{save_to_disk, Screenshot};
use bevy::window::{PrimaryWindow, WindowCloseRequested};
use std::fs;
use std::process::Command;
pub struct ScreenRecordPlugin;

#[derive(Resource)]
pub struct RecordState {
    pub timer: Timer,
    pub is_recording: bool,
    pub frame_count: u32,
}

impl Plugin for ScreenRecordPlugin {
    fn build(&self, app: &mut App) {
        app.insert_resource(RecordState {
            timer: Timer::from_seconds(20.0, TimerMode::Once),
            is_recording: true,
            frame_count: 0,
        })
        .add_systems(
            Update,
            (
                update_record_timer,
                intercept_close_button,
                save_frame_system,
            ),
        );
    }
}
fn save_frame_system(
    mut state: ResMut<RecordState>,
    main_window: Query<Entity, With<PrimaryWindow>>,
    mut commands: Commands,
) {
    if !state.is_recording {
        return;
    }

    if let Ok(_window_entity) = main_window.single() {
        state.frame_count += 1;
        let path = format!("assets/records/frame_{:04}.png", state.frame_count);
        commands
            .spawn(Screenshot::primary_window())
            .observe(save_to_disk(path));
    }
}
/// System 1: intercepts window-close events during recording.
fn intercept_close_button(
    mut close_events: MessageReader<WindowCloseRequested>,
    state: Res<RecordState>,
    mut app_exit: MessageWriter<AppExit>,
) {
    for _ in close_events.read() {
        if state.is_recording {
            let remain = state.timer.remaining_secs();
            println!(
                "Recording in progress, {:.1}s remaining — do not force-close.",
                remain
            );
        } else {
            // let output_dir = "assets/records";
            // // 10 秒已经过了，自由还给用户，允许正常退出
            // println!("👋 录制早已完成，正常关闭程序。");
            // // 👇 [新增] 视频合成成功后，开始清理 PNG 图片
            // println!("🧹 正在清理临时图片...");
            // if let Ok(entries) = fs::read_dir(output_dir) {
            //     for entry in entries.flatten() {
            //         let path = entry.path();
            //         // 🚨 只删除 png 文件，千万别把刚生成的 mp4 删了
            //         if path.extension().and_then(|s| s.to_str()) == Some("png") {
            //             let _ = fs::remove_file(path);
            //         }
            //     }
            //     println!("✨ 临时图片清理完毕！");
            // }
            app_exit.write(AppExit::Success);
        }
    }
}

/// System 2: ticks the countdown and triggers video synthesis when time expires.
fn update_record_timer(
    mut state: ResMut<RecordState>,
    time: Res<Time>,
    mut app_exit: MessageWriter<AppExit>,
) {
    if !state.is_recording {
        return;
    }

    state.timer.tick(time.delta());

    if state.timer.just_finished() {
        println!("✅ 录制时间到！正在后台合成视频...");
        state.is_recording = false;
        synthesize_video();
        println!("🎉 视频合成完毕！程序即将自动退出。");

        let output_dir = "assets/records";
        println!("🧹 正在清理临时图片...");
        if let Ok(entries) = fs::read_dir(output_dir) {
            for entry in entries.flatten() {
                let path = entry.path();
                if path.extension().and_then(|s| s.to_str()) == Some("png") {
                    let _ = fs::remove_file(path);
                }
            }
            println!("✨ 临时图片清理完毕！");
        }
        app_exit.write(AppExit::Success);
    }
}

// /// 真正调用系统底层 FFmpeg 的执行函数
// fn synthesize_video() {
//     let output_dir = "assets/records";
//     if let Err(e) = fs::create_dir_all(output_dir) {
//         println!("❌ 无法创建录制文件夹: {}", e);
//         return;
//     }

//     let output_file = format!("{}/output_10s.mp4", output_dir);

//     let child = Command::new("ffmpeg")
//         .args([
//             "-y",
//             "-framerate",
//             "60",
//             "-i",
//             "assets/records/frame_%04d.png",
//             "-c:v",
//             "libx264",
//             "-pix_fmt",
//             "yuv420p",
//             &output_file,
//         ])
//         .spawn();

//     match child {
//         Ok(mut process) => match process.wait() {
//             Ok(status) if status.success() => {
//                 println!("🎬 完美！MP4 已成功保存到: {}", output_file);
//             }
//             Ok(status) => println!("❌ FFmpeg 运行失败，退出码: {}", status),
//             Err(e) => println!("❌ 等待 FFmpeg 结束时发生错误: {}", e),
//         },
//         Err(e) => println!("❌ 启动 FFmpeg 失败: {}", e),
//     }
// }
/// Invokes FFmpeg to encode captured frames as a looping GIF.
fn synthesize_video() {
    let output_dir = "assets/records";
    if let Err(e) = fs::create_dir_all(output_dir) {
        println!("❌ 无法创建录制文件夹: {}", e);
        return;
    }

    // 1. output file extension
    let output_file = format!("{}/output.gif", output_dir);

    let child = Command::new("ffmpeg")
        .args([
            "-y",
            "-framerate",
            "30",
            "-i",
            "assets/records/frame_%04d.png",
            // generate palette then apply it for accurate GIF colour reproduction
            "-vf",
            "split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse",
            // 0 = loop indefinitely
            "-loop",
            "0",
            &output_file,
        ])
        .spawn();

    match child {
        Ok(mut process) => match process.wait() {
            Ok(status) if status.success() => {
                println!("🎬 完美！GIF 已成功保存到: {}", output_file);
            }
            Ok(status) => println!("❌ FFmpeg 运行失败，退出码: {}", status),
            Err(e) => println!("❌ 等待 FFmpeg 结束时发生错误: {}", e),
        },
        Err(e) => println!("❌ 启动 FFmpeg 失败: {}", e),
    }
}
