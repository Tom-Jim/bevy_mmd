//! Browser entry: `src/web/boot.js` calls [`boot`] once the module is loaded, the React
//! panels call [`command`] and [`load_files`], and the viewer's status comes back
//! through `globalThis.mmd.emit`.

use bevy::prelude::*;
use wasm_bindgen::prelude::*;

use crate::viewer::config::ViewerConfig;
use crate::viewer::source::Source;
use crate::viewer::{MmdPlugin, bridge};

#[wasm_bindgen]
extern "C" {
    #[wasm_bindgen(js_namespace = mmd, js_name = emit)]
    fn emit_status(json: &str);
}

/// Starts Bevy on the page's `#bevy` canvas; `assets` is the URL of the asset library.
#[wasm_bindgen]
pub fn boot(assets: &str) {
    std::panic::set_hook(Box::new(|info| {
        web_sys::console::error_1(&JsValue::from_str(&info.to_string()));
    }));
    bridge::set_sink(emit_status);
    let assets = assets.trim_end_matches('/').to_string();
    App::new()
        .add_plugins(plugins())
        .add_plugins(MmdPlugin { config: ViewerConfig::defaults(), assets: Source::Http(assets) })
        .run();
}

/// One JSON command (`viewer::bridge::Command`).
#[wasm_bindgen]
pub fn command(json: &str) -> Result<(), JsValue> {
    bridge::send(json).map_err(|e| JsValue::from_str(&e))
}

/// Dropped or picked files: relative paths and their bytes.
#[wasm_bindgen(js_name = loadFiles)]
pub fn load_files(paths: Vec<String>, files: Vec<js_sys::Uint8Array>) {
    bridge::load_files(paths.into_iter().zip(files.iter().map(|f| f.to_vec())).collect());
}

fn plugins() -> bevy::app::PluginGroupBuilder {
    use bevy::asset::{AssetMetaCheck, AssetPlugin};
    use bevy::render::RenderPlugin;
    use bevy::render::settings::{Backends, RenderCreation, WgpuSettings, WgpuSettingsPriority};
    use bevy::window::{PresentMode, WindowPlugin};

    DefaultPlugins
        .set(WindowPlugin {
            primary_window: Some(Window {
                canvas: Some("#bevy".into()),
                fit_canvas_to_parent: true,
                prevent_default_event_handling: true,
                present_mode: PresentMode::AutoVsync,
                ..default()
            }),
            ..default()
        })
        .set(RenderPlugin {
            render_creation: RenderCreation::Automatic(Box::new(WgpuSettings {
                backends: Some(Backends::BROWSER_WEBGPU),
                priority: WgpuSettingsPriority::WebGPU,
                ..default()
            })),
            ..default()
        })
        .set(AssetPlugin { meta_check: AssetMetaCheck::Never, ..default() })
}
