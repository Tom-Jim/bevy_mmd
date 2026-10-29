//! The Bevy viewer: loads a model and a motion, animates and simulates them every
//! frame with the real frame time (no fixed-step judder at any refresh rate), and
//! draws them with MikuMikuDance's shading.

pub mod bridge;
pub mod camera;
pub mod config;
pub mod load;
pub mod material;
pub mod model;
pub mod source;
pub mod texture;

use bevy::camera_controller::pan_orbit_camera::prelude::PanOrbitCamera;
use bevy::mesh::skinning::SkinnedMeshInverseBindposes;
use bevy::prelude::*;

use crate::anim::motion::Motion;
use bridge::Command;
use camera::ViewerCamera;
use config::ViewerConfig;
use load::{FileRef, LoadRequest, PendingLoad};
use material::{OutlineMaterial, PmxMaterial};
use model::{Assets3d, MmdModel, OutlinePart};
use source::{MemoryFiles, Source};

pub struct MmdPlugin {
    pub config: ViewerConfig,
    /// Where the configured default model and motion are read from.
    pub assets: Source,
}

#[derive(Resource, Clone)]
pub struct AssetRoot(pub Source);

#[derive(Resource)]
pub struct Playback {
    pub time: f32,
    pub playing: bool,
    pub speed: f32,
    pub looping: bool,
    pub physics: bool,
    pub outline: bool,
    pub jiggle: crate::anim::jiggle::JiggleSettings,
    pub motion: Option<(String, Motion)>,
    pub notice: Option<(String, bool)>,
    fps: f32,
    status_age: f32,
    last_status: String,
}

impl Playback {
    fn new(config: &ViewerConfig) -> Self {
        Self {
            time: 0.0,
            playing: true,
            speed: config.playback.speed,
            looping: config.playback.looping,
            physics: true,
            outline: config.render.outline,
            jiggle: config.jiggle.clone(),
            motion: None,
            notice: None,
            fps: 0.0,
            status_age: f32::MAX,
            last_status: String::new(),
        }
    }

    fn report(&mut self, text: impl Into<String>, fault: bool) {
        let text = text.into();
        if fault {
            error!("{text}");
        } else {
            info!("{text}");
        }
        self.notice = Some((text, fault));
    }
}

impl Plugin for MmdPlugin {
    fn build(&self, app: &mut App) {
        let bg = self.config.render.background;
        material::register(app);
        app.insert_resource(self.config.clone())
            .insert_resource(AssetRoot(self.assets.clone()))
            .insert_resource(Playback::new(&self.config))
            .insert_resource(ClearColor(Color::srgb(bg[0], bg[1], bg[2])))
            .init_resource::<PendingLoad>()
            .add_plugins(camera::CameraPlugin)
            .add_systems(Startup, setup)
            .add_systems(First, bridge::forward_pointer)
            .add_systems(Update, (apply_commands, finish_load, animate, publish_status).chain());
    }
}

fn setup(mut commands: Commands, config: Res<ViewerConfig>, root: Res<AssetRoot>, mut pending: ResMut<PendingLoad>) {
    camera::spawn(&mut commands, config.render.msaa);
    let file = |path: &str| (!path.is_empty()).then(|| FileRef { source: root.0.clone(), path: path.to_string() });
    load::start(&mut pending, LoadRequest { model: file(&config.scene.model), motion: file(&config.scene.motion) });
}

/// A request for the files named in `paths` (desktop drag and drop).
#[cfg(not(target_arch = "wasm32"))]
pub fn request_for_paths(paths: &[String]) -> LoadRequest {
    use std::path::{Path, PathBuf};
    fn find(dir: &Path, ext: &str, depth: u32) -> Option<PathBuf> {
        let mut entries: Vec<PathBuf> = std::fs::read_dir(dir).ok()?.flatten().map(|e| e.path()).collect();
        entries.sort();
        let hit = entries.iter().find(|p| p.extension().is_some_and(|e| e.eq_ignore_ascii_case(ext)));
        if let Some(hit) = hit {
            return Some(hit.clone());
        }
        if depth == 0 {
            return None;
        }
        entries.iter().filter(|p| p.is_dir()).find_map(|p| find(p, ext, depth - 1))
    }
    let file = |path: &Path| {
        let dir = path.parent().unwrap_or(Path::new("/")).to_path_buf();
        FileRef { source: Source::Disk(dir), path: path.file_name().unwrap_or_default().to_string_lossy().into_owned() }
    };
    let mut request = LoadRequest::default();
    for p in paths {
        let path = Path::new(p);
        let (pmx, vmd) = if path.is_dir() {
            (find(path, "pmx", 3), find(path, "vmd", 3))
        } else {
            let ext = path.extension().and_then(|e| e.to_str()).unwrap_or("").to_ascii_lowercase();
            ((ext == "pmx").then(|| path.to_path_buf()), (ext == "vmd").then(|| path.to_path_buf()))
        };
        if request.model.is_none() {
            request.model = pmx.as_deref().map(file);
        }
        if request.motion.is_none() {
            request.motion = vmd.as_deref().map(file);
        }
    }
    request
}

/// A request for dropped or picked files held in memory.
pub fn request_for_files(files: Vec<(String, Vec<u8>)>) -> LoadRequest {
    let has = |ext: &str| {
        let mut names: Vec<&String> = files.iter().map(|(p, _)| p).filter(|p| p.to_ascii_lowercase().ends_with(ext)).collect();
        names.sort();
        names.first().map(|p| p.to_string())
    };
    let (pmx, vmd) = (has(".pmx"), has(".vmd"));
    let source = Source::Memory(std::sync::Arc::new(MemoryFiles::new(files)));
    LoadRequest {
        model: pmx.map(|path| FileRef { source: source.clone(), path }),
        motion: vmd.map(|path| FileRef { source, path }),
    }
}

#[allow(clippy::too_many_arguments)]
fn apply_commands(
    mut playback: ResMut<Playback>,
    mut pending: ResMut<PendingLoad>,
    mut models: Query<&mut MmdModel>,
    mut outlines: Query<&mut Visibility, With<OutlinePart>>,
    mut cameras: Query<(&mut Transform, &mut PanOrbitCamera), With<ViewerCamera>>,
) {
    for files in bridge::take_files() {
        let request = request_for_files(files);
        if request.model.is_none() && request.motion.is_none() {
            playback.report("No .pmx or .vmd among the files", true);
        } else {
            load::start(&mut pending, request);
        }
    }
    for command in bridge::take_commands() {
        match command {
            Command::Play { playing } => playback.playing = playing,
            Command::Seek { time } => {
                playback.time = time.max(0.0);
                models.iter_mut().for_each(|mut m| m.animator.reset_dynamics());
                models.iter_mut().filter_map(|m| m.into_inner().rig.as_mut()).for_each(|r| r.request_reset());
            }
            Command::Speed { value } => playback.speed = value.clamp(0.0, 4.0),
            Command::Loop { on } => playback.looping = on,
            Command::Physics { on } => {
                playback.physics = on;
                models.iter_mut().filter_map(|m| m.into_inner().rig.as_mut()).for_each(|r| r.request_reset());
            }
            Command::ResetPhysics => {
                for mut m in &mut models {
                    m.animator.reset_dynamics();
                    if let Some(r) = m.rig.as_mut() {
                        r.request_reset();
                    }
                }
            }
            Command::Jiggle { on, strength } => {
                playback.jiggle.enabled = on;
                if let Some(s) = strength {
                    playback.jiggle.strength = s.clamp(0.0, 3.0);
                }
            }
            Command::Outline { on } => {
                playback.outline = on;
                let v = if on { Visibility::Inherited } else { Visibility::Hidden };
                outlines.iter_mut().for_each(|mut vis| *vis = v);
            }
            Command::ResetView => {
                if let (Some(model), Ok((mut tf, mut cam))) = (models.iter().next(), cameras.single_mut()) {
                    camera::frame_model(&mut tf, &mut cam, model.bounds);
                }
            }
            #[cfg(not(target_arch = "wasm32"))]
            Command::LoadPaths { paths } => {
                let request = request_for_paths(&paths);
                if request.model.is_none() && request.motion.is_none() {
                    playback.report("No .pmx or .vmd in the dropped items", true);
                } else {
                    load::start(&mut pending, request);
                }
            }
            #[cfg(target_arch = "wasm32")]
            Command::LoadPaths { .. } => playback.report("The browser cannot open paths; drop the files", true),
            Command::Pointer { .. } | Command::Wheel { .. } => {}
        }
    }
}

#[allow(clippy::too_many_arguments)]
fn finish_load(
    mut commands: Commands,
    mut pending: ResMut<PendingLoad>,
    mut playback: ResMut<Playback>,
    config: Res<ViewerConfig>,
    existing: Query<Entity, With<MmdModel>>,
    mut models: Query<&mut MmdModel>,
    mut meshes: ResMut<Assets<Mesh>>,
    mut materials: ResMut<Assets<PmxMaterial>>,
    mut outlines: ResMut<Assets<OutlineMaterial>>,
    mut images: ResMut<Assets<Image>>,
    mut bindposes: ResMut<Assets<SkinnedMeshInverseBindposes>>,
) {
    let Some(result) = load::poll(&mut pending) else { return };
    if let Some(motion) = result.motion {
        match motion {
            Ok(loaded) => {
                let motion = Motion::from_vmd(&loaded.motion);
                let name = source::file_name(&loaded.path).to_string();
                for mut model in &mut models {
                    model.animator.set_motion(Some(motion.clone()));
                    if let Some(rig) = model.rig.as_mut() {
                        rig.request_reset();
                    }
                }
                playback.time = 0.0;
                playback.report(format!("Motion {name}: {} bone keys, {} morph keys", loaded.motion.bones.len(), loaded.motion.morphs.len()), false);
                playback.motion = Some((name, motion));
            }
            Err(e) => playback.report(e, true),
        }
    }
    if let Some(model) = result.model {
        match model {
            Ok(loaded) => {
                for e in &existing {
                    commands.entity(e).despawn();
                }
                let warnings = loaded.warnings.len();
                let name = loaded.name.clone();
                let mut assets = Assets3d {
                    meshes: &mut meshes,
                    materials: &mut materials,
                    outlines: &mut outlines,
                    images: &mut images,
                    bindposes: &mut bindposes,
                };
                let entity = model::spawn(&mut commands, &mut assets, loaded, &config.render, &config.physics);
                let motion = playback.motion.as_ref().map(|(_, m)| m.clone());
                playback.time = 0.0;
                let text = if warnings > 0 { format!("Model {name} ({warnings} textures missing)") } else { format!("Model {name}") };
                playback.report(text, warnings > 0);
                // The model component exists once the commands apply: bind the current
                // motion and frame the camera then.
                commands.queue(move |world: &mut World| {
                    let Some(mut model) = world.get_mut::<MmdModel>(entity) else { return };
                    model.animator.set_motion(motion);
                    let bounds = model.bounds;
                    if let Ok((mut tf, mut cam)) = world
                            .query_filtered::<(&mut Transform, &mut PanOrbitCamera), With<ViewerCamera>>()
                            .single_mut(world)
                    {
                        camera::frame_model(&mut tf, &mut cam, bounds);
                    }
                });
            }
            Err(e) => playback.report(e, true),
        }
    }
}

#[allow(clippy::too_many_arguments)]
fn animate(
    time: Res<Time>,
    config: Res<ViewerConfig>,
    mut playback: ResMut<Playback>,
    mut models: Query<&mut MmdModel>,
    mut transforms: Query<&mut Transform, Without<ViewerCamera>>,
    mut meshes: ResMut<Assets<Mesh>>,
    mut materials: ResMut<Assets<PmxMaterial>>,
    mut outlines: ResMut<Assets<OutlineMaterial>>,
) {
    let dt = time.delta_secs();
    if dt > 0.0 {
        let fps = 1.0 / dt;
        playback.fps = if playback.fps > 0.0 { playback.fps * 0.95 + fps * 0.05 } else { fps };
    }
    let duration = models.iter().map(|m| m.animator.duration_secs()).fold(0.0, f32::max);
    let mut wrapped = false;
    if playback.playing && duration > 0.0 {
        playback.time += dt * playback.speed;
        if playback.time > duration {
            if playback.looping {
                playback.time %= duration;
                wrapped = true;
            } else {
                playback.time = duration;
                playback.playing = false;
            }
        }
    }
    let t = playback.time;
    for mut model in &mut models {
        let model = &mut *model;
        if wrapped && let Some(rig) = model.rig.as_mut() {
            rig.request_reset();
        }
        model.animator.animate(t);
        let overrides = match model.rig.as_mut() {
            Some(rig) if playback.physics => Some(rig.step(&model.animator.pose, dt)),
            _ => None,
        };
        if wrapped {
            model.animator.reset_dynamics();
        }
        model.animator.jiggle_settings = playback.jiggle.clone();
        model.animator.finish(overrides, dt);
        let pose = &model.animator.pose;
        for (i, &entity) in model.bones.iter().enumerate() {
            if let Ok(mut tf) = transforms.get_mut(entity) {
                tf.translation = pose.world_pos[i];
                tf.rotation = pose.world_rot[i];
            }
        }
        model.update_morphs(&mut meshes);
        model.update_materials(&mut materials, &mut outlines, config.render.outline_scale);
    }
}

fn publish_status(time: Res<Time>, mut playback: ResMut<Playback>, pending: Res<PendingLoad>, models: Query<&MmdModel>) {
    playback.status_age += time.delta_secs();
    if playback.status_age < 0.1 {
        return;
    }
    let model = models.iter().next();
    let status = bridge::Status {
        model: model.map(|m| m.name.clone()),
        motion: playback.motion.as_ref().map(|(n, _)| n.clone()),
        loading: pending.0.is_some(),
        playing: playback.playing,
        time: playback.time,
        duration: model.map_or(0.0, |m| m.animator.duration_secs()),
        speed: playback.speed,
        looping: playback.looping,
        physics: playback.physics,
        outline: playback.outline,
        jiggle: playback.jiggle.enabled,
        jiggle_strength: playback.jiggle.strength,
        jiggle_bones: model.map_or(0, |m| m.animator.jiggle.bones().count()),
        vertices: model.map_or(0, |m| m.vertex_count),
        bones: model.map_or(0, |m| m.animator.skeleton.len()),
        morphs: model.map_or(0, |m| m.animator.morphs.len()),
        bodies: model.and_then(|m| m.rig.as_ref()).map_or(0, |r| r.body_count()),
        dynamic_bodies: model.and_then(|m| m.rig.as_ref()).map_or(0, |r| r.dynamic_count()),
        missing_bones: model.and_then(|m| m.animator.binding()).map_or(0, |b| b.missing_bones),
        fps: (playback.fps * 10.0).round() / 10.0,
        notice: playback.notice.as_ref().map(|(t, _)| t.clone()),
        notice_fault: playback.notice.as_ref().is_some_and(|(_, f)| *f),
    };
    let json = serde_json::to_string(&status).unwrap_or_default();
    // Unchanged statuses are resent every two seconds, for panels that attach late.
    if json != playback.last_status || playback.status_age > 2.0 {
        bridge::publish(&json);
        playback.last_status = json;
        playback.status_age = 0.0;
    }
}
