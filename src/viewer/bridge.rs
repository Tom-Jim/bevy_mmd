//! The control layer. The React panels, in the Tauri webview or the browser page, send
//! JSON commands and read back one JSON status object; they hold no 3D code. Under
//! Tauri the webview covers the window, so it also forwards pointer input.

use std::sync::Mutex;

use bevy::input::ButtonState;
use bevy::input::mouse::{MouseButtonInput, MouseScrollUnit, MouseWheel};
use bevy::input::touch::TouchPhase;
use bevy::prelude::*;
use bevy::window::{CursorMoved, PrimaryWindow, WindowEvent};
use serde::{Deserialize, Serialize};

#[derive(Deserialize, Debug, Clone, PartialEq)]
#[serde(tag = "cmd", rename_all = "snake_case")]
pub enum Command {
    Play { playing: bool },
    /// Seconds from the start of the motion.
    Seek { time: f32 },
    Speed { value: f32 },
    Loop { on: bool },
    Physics { on: bool },
    ResetPhysics,
    /// Inertial chest and hip motion; `strength` scales it (1 = as tuned).
    Jiggle {
        on: bool,
        #[serde(default)]
        strength: Option<f32>,
    },
    Outline { on: bool },
    ResetView,
    /// Files on disk (desktop drag and drop): `.pmx`, `.vmd`, or folders holding them.
    LoadPaths { paths: Vec<String> },
    /// Pointer in logical window pixels, DOM button numbering (0 left, 1 middle, 2 right).
    Pointer {
        x: f32,
        y: f32,
        #[serde(default)]
        button: Option<u8>,
        #[serde(default)]
        down: Option<bool>,
    },
    /// Wheel in DOM pixels (positive scrolls down).
    Wheel { dy: f32 },
}

static INBOX: Mutex<Vec<Command>> = Mutex::new(Vec::new());
static POINTER: Mutex<Vec<Command>> = Mutex::new(Vec::new());
static FILES: Mutex<Vec<Vec<(String, Vec<u8>)>>> = Mutex::new(Vec::new());

type Sink = Box<dyn Fn(&str) + Send + Sync>;
static SINK: Mutex<Option<Sink>> = Mutex::new(None);

/// Queues one JSON command for the next frame.
pub fn send(json: &str) -> Result<(), String> {
    let command: Command = serde_json::from_str(json).map_err(|e| format!("command: {e}"))?;
    queue(command);
    Ok(())
}

pub fn queue(command: Command) {
    let inbox = match command {
        Command::Pointer { .. } | Command::Wheel { .. } => &POINTER,
        _ => &INBOX,
    };
    inbox.lock().unwrap().push(command);
}

/// Files the user picked or dropped, by relative path: the first `.pmx` becomes the
/// model (its textures resolved among the same files), the first `.vmd` the motion.
pub fn load_files(files: Vec<(String, Vec<u8>)>) {
    FILES.lock().unwrap().push(files);
}

/// Receiver of the status JSON (an event to the webview, a call into the page).
pub fn set_sink(sink: impl Fn(&str) + Send + Sync + 'static) {
    *SINK.lock().unwrap() = Some(Box::new(sink));
}

pub(crate) fn take_commands() -> Vec<Command> {
    std::mem::take(&mut *INBOX.lock().unwrap())
}

pub(crate) fn take_files() -> Vec<Vec<(String, Vec<u8>)>> {
    std::mem::take(&mut *FILES.lock().unwrap())
}

pub(crate) fn publish(json: &str) {
    if let Some(sink) = SINK.lock().unwrap().as_ref() {
        sink(json);
    }
}

#[derive(Serialize, Default, Clone, PartialEq)]
pub struct Status {
    pub model: Option<String>,
    pub motion: Option<String>,
    pub loading: bool,
    pub playing: bool,
    pub time: f32,
    pub duration: f32,
    pub speed: f32,
    pub looping: bool,
    pub physics: bool,
    pub outline: bool,
    pub jiggle: bool,
    pub jiggle_strength: f32,
    /// Chest and hip bones the jiggle moves.
    pub jiggle_bones: usize,
    pub vertices: usize,
    pub bones: usize,
    pub morphs: usize,
    pub bodies: usize,
    pub dynamic_bodies: usize,
    pub missing_bones: usize,
    pub fps: f32,
    /// Last error or report; the panels show it until the next one.
    pub notice: Option<String>,
    pub notice_fault: bool,
}

/// Turns forwarded pointer commands into the window input Bevy would get from winit.
pub fn forward_pointer(
    window: Query<Entity, With<PrimaryWindow>>,
    mut last: Local<Option<Vec2>>,
    mut moved: MessageWriter<CursorMoved>,
    mut buttons: MessageWriter<MouseButtonInput>,
    mut wheels: MessageWriter<MouseWheel>,
    mut events: MessageWriter<WindowEvent>,
) {
    let queued = std::mem::take(&mut *POINTER.lock().unwrap());
    let Ok(window) = window.single() else {
        return;
    };
    for command in queued {
        match command {
            Command::Pointer { x, y, button, down } => {
                let position = Vec2::new(x, y);
                let event = CursorMoved { window, position, delta: last.map(|p| position - p) };
                *last = Some(position);
                moved.write(event.clone());
                events.write(WindowEvent::CursorMoved(event));
                if let (Some(button), Some(down)) = (button, down) {
                    let event = MouseButtonInput {
                        button: match button {
                            0 => MouseButton::Left,
                            1 => MouseButton::Middle,
                            2 => MouseButton::Right,
                            n => MouseButton::Other(u16::from(n)),
                        },
                        state: if down { ButtonState::Pressed } else { ButtonState::Released },
                        window,
                    };
                    buttons.write(event);
                    events.write(WindowEvent::MouseButtonInput(event));
                }
            }
            Command::Wheel { dy } => {
                let event = MouseWheel { unit: MouseScrollUnit::Pixel, x: 0.0, y: -dy, window, phase: TouchPhase::Moved };
                wheels.write(event);
                events.write(WindowEvent::MouseWheel(event));
            }
            _ => {}
        }
    }
}
