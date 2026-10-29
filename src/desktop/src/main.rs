//! Desktop shell. Tauri owns the window and the React control layer; Bevy renders the
//! MMD player natively into the same window, under the transparent webview.

#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

use std::cell::RefCell;
use std::path::{Path, PathBuf};
use std::rc::Rc;
use std::sync::Mutex;

use bevy::app::PluginsState;
use bevy::prelude::*;
use bevy::tasks::tick_global_task_pools_on_main_thread;
use bevy::window::{
    PrimaryWindow, RawHandleWrapper, RawHandleWrapperHolder, WindowResized, WindowResolution, WindowScaleFactorChanged,
    WindowWrapper,
};
use bevy3d_animation::viewer::config::ViewerConfig;
use bevy3d_animation::viewer::source::Source;
use bevy3d_animation::viewer::{MmdPlugin, bridge};
use tauri::{DragDropEvent, Emitter, Manager, RunEvent, WindowEvent};

/// The asset library: next to the executable's resources in a bundle, the source
/// tree's `assets/` when run from the repository.
fn asset_root(app: &tauri::App) -> PathBuf {
    let source = Path::new(env!("CARGO_MANIFEST_DIR")).join("../../assets");
    app.path()
        .resource_dir()
        .ok()
        .map(|d| d.join("assets"))
        .filter(|d| d.is_dir())
        .unwrap_or(source)
}

/// One JSON command from the React panels (`viewer::bridge::Command`).
#[tauri::command]
fn ui_command(json: String) -> Result<(), String> {
    bridge::send(&json)
}

/// Files picked in the panels arrive one per call, the relative path in a header;
/// `load_commit` hands the set to the viewer.
static PICKED: Mutex<Vec<(String, Vec<u8>)>> = Mutex::new(Vec::new());

#[tauri::command]
fn load_file(request: tauri::ipc::Request<'_>) -> Result<(), String> {
    let path = request
        .headers()
        .get("x-path")
        .and_then(|v| v.to_str().ok())
        .map(percent_decode)
        .ok_or("load_file needs an x-path header")?;
    match request.body() {
        tauri::ipc::InvokeBody::Raw(bytes) => {
            PICKED.lock().unwrap().push((path, bytes.clone()));
            Ok(())
        }
        _ => Err("load_file takes the file bytes".into()),
    }
}

#[tauri::command]
fn load_commit() {
    let files = std::mem::take(&mut *PICKED.lock().unwrap());
    if !files.is_empty() {
        bridge::load_files(files);
    }
}

fn percent_decode(s: &str) -> String {
    let bytes = s.as_bytes();
    let mut out = Vec::with_capacity(bytes.len());
    let mut i = 0;
    while i < bytes.len() {
        if bytes[i] == b'%'
            && i + 2 < bytes.len()
            && let Ok(b) = u8::from_str_radix(&s[i + 1..i + 3], 16)
        {
            out.push(b);
            i += 3;
            continue;
        }
        out.push(bytes[i]);
        i += 1;
    }
    String::from_utf8_lossy(&out).into_owned()
}

fn main() {
    let mut tauri_app = tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![ui_command, load_file, load_commit])
        .build(tauri::generate_context!())
        .expect("the Tauri application");
    // Configured windows appear once the event loop has started.
    let window = loop {
        if let Some(w) = tauri_app.get_webview_window("main") {
            break w;
        }
        #[allow(deprecated)]
        tauri_app.run_iteration(|_, _| {});
    };
    let assets = asset_root(&tauri_app);
    let events = tauri_app.handle().clone();
    bridge::set_sink(move |json| {
        let _ = events.emit("status", json);
    });

    let size = window.inner_size().expect("window size");
    let scale = window.scale_factor().expect("scale factor") as f32;
    let mut app = App::new();
    app.add_plugins(bevy::window::WindowPlugin {
        primary_window: Some(Window {
            title: "bevy3Danimation".into(),
            resolution: WindowResolution::new(size.width, size.height).with_scale_factor_override(scale),
            ..default()
        }),
        ..default()
    });
    // Bevy draws into the Tauri window, under the webview: the primary window carries
    // the handle of the drawing surface.
    let handle = RawHandleWrapper::new(&WindowWrapper::new(surface::under(&window))).expect("a native window handle");
    let world = app.world_mut();
    let (entity, holder) = world
        .query_filtered::<(Entity, &RawHandleWrapperHolder), With<PrimaryWindow>>()
        .single(world)
        .map(|(e, h)| (e, h.clone()))
        .expect("the primary window");
    *holder.0.lock().unwrap() = Some(handle.clone());
    world.entity_mut(entity).insert(handle);
    app.add_plugins(DefaultPlugins.build().disable::<bevy::window::WindowPlugin>())
        .add_plugins(MmdPlugin { config: ViewerConfig::defaults(), assets: Source::Disk(assets) })
        .set_runner(move |app| run(app, tauri_app));
    app.run();
}

/// The view Bevy draws into. wgpu attaches its layer on top of the view it is given,
/// so on macOS Bevy gets a view of its own, ordered below the webview; elsewhere the
/// webview is a child of the window and Bevy draws into the window itself.
mod surface {
    #[cfg(target_os = "macos")]
    pub fn under(window: &tauri::WebviewWindow) -> View {
        use objc2::MainThreadMarker;
        use objc2_app_kit::{NSAutoresizingMaskOptions, NSView, NSWindowOrderingMode};
        let mtm = MainThreadMarker::new().expect("the main thread");
        let content = window.ns_view().expect("the content view") as *const NSView;
        // SAFETY: Tauri returns the window's live content view.
        let content = unsafe { &*content };
        let view = NSView::initWithFrame(mtm.alloc(), content.bounds());
        view.setAutoresizingMask(NSAutoresizingMaskOptions::ViewWidthSizable | NSAutoresizingMaskOptions::ViewHeightSizable);
        content.addSubview_positioned_relativeTo(&view, NSWindowOrderingMode::Below, None);
        View(view)
    }

    #[cfg(target_os = "macos")]
    pub struct View(objc2::rc::Retained<objc2_app_kit::NSView>);

    // SAFETY: the handle is only used to create the surface; AppKit calls stay on the
    // main thread, where the Tauri loop runs Bevy.
    #[cfg(target_os = "macos")]
    unsafe impl Send for View {}
    #[cfg(target_os = "macos")]
    unsafe impl Sync for View {}

    #[cfg(target_os = "macos")]
    impl raw_window_handle::HasWindowHandle for View {
        fn window_handle(&self) -> Result<raw_window_handle::WindowHandle<'_>, raw_window_handle::HandleError> {
            use raw_window_handle::{AppKitWindowHandle, RawWindowHandle, WindowHandle};
            let raw = RawWindowHandle::AppKit(AppKitWindowHandle::new(std::ptr::NonNull::from(&*self.0).cast()));
            // SAFETY: the view lives as long as `self`.
            Ok(unsafe { WindowHandle::borrow_raw(raw) })
        }
    }

    #[cfg(target_os = "macos")]
    impl raw_window_handle::HasDisplayHandle for View {
        fn display_handle(&self) -> Result<raw_window_handle::DisplayHandle<'_>, raw_window_handle::HandleError> {
            Ok(raw_window_handle::DisplayHandle::appkit())
        }
    }

    #[cfg(not(target_os = "macos"))]
    pub fn under(window: &tauri::WebviewWindow) -> tauri::WebviewWindow {
        window.clone()
    }
}

#[derive(Default)]
struct Pending {
    size: Option<tauri::PhysicalSize<u32>>,
    scale: Option<f32>,
    dropped: Vec<String>,
}

/// One Tauri event iteration, then one Bevy frame, until the window closes.
fn run(mut app: App, mut tauri_app: tauri::App) -> AppExit {
    while app.plugins_state() == PluginsState::Adding {
        tick_global_task_pools_on_main_thread();
    }
    app.finish();
    app.cleanup();
    let pending = Rc::new(RefCell::new(Pending::default()));
    loop {
        let sink = pending.clone();
        // `run_iteration` warns about busy loops; this loop is paced by the
        // vsync-blocked present of every Bevy frame.
        #[allow(deprecated)]
        tauri_app.run_iteration(move |_, event| {
            if let RunEvent::WindowEvent { event, .. } = event {
                let mut p = sink.borrow_mut();
                match event {
                    WindowEvent::Resized(s) => p.size = Some(s),
                    WindowEvent::ScaleFactorChanged { scale_factor, new_inner_size, .. } => {
                        p.size = Some(new_inner_size);
                        p.scale = Some(scale_factor as f32);
                    }
                    WindowEvent::DragDrop(DragDropEvent::Drop { paths, .. }) => {
                        p.dropped.extend(paths.iter().map(|p| p.to_string_lossy().into_owned()));
                    }
                    _ => {}
                }
            }
        });
        let Pending { size, scale, dropped } = std::mem::take(&mut *pending.borrow_mut());
        if tauri_app.webview_windows().is_empty() {
            tauri_app.cleanup_before_exit();
            return AppExit::Success;
        }
        if !dropped.is_empty() {
            bridge::queue(bridge::Command::LoadPaths { paths: dropped });
        }
        if let Some(size) = size {
            resize(&mut app, size, scale);
        }
        app.update();
        if let Some(exit) = app.should_exit() {
            tauri_app.cleanup_before_exit();
            return exit;
        }
    }
}

fn resize(app: &mut App, size: tauri::PhysicalSize<u32>, factor: Option<f32>) {
    let world = app.world_mut();
    let mut windows = world.query_filtered::<(Entity, &mut Window), With<PrimaryWindow>>();
    let Ok((entity, mut window)) = windows.single_mut(world) else {
        return;
    };
    window.resolution.set_physical_resolution(size.width, size.height);
    if let Some(f) = factor {
        window.resolution.set_scale_factor_override(Some(f));
    }
    let (width, height) = (window.width(), window.height());
    if let Some(f) = factor {
        world.write_message(WindowScaleFactorChanged { window: entity, scale_factor: f as f64 });
    }
    world.write_message(WindowResized { window: entity, width, height });
}
