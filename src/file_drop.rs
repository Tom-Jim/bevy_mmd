use bevy::ecs::system::SystemParam;
use bevy::mesh::skinning::SkinnedMeshInverseBindposes;
use bevy::prelude::*;
use bevy::window::FileDragAndDrop;

use crate::{components::*, config::Config, physics, pmx, vmd::VmdMotionClip};

#[derive(SystemParam)]
pub struct FileDropParams<'w, 's> {
    meshes: ResMut<'w, Assets<Mesh>>,
    materials: ResMut<'w, Assets<PmxMaterial>>,
    inverse_bindposes: ResMut<'w, Assets<SkinnedMeshInverseBindposes>>,
    cfg: ResMut<'w, Config>,
    model_entities: Query<'w, 's, Entity, With<SubMeshInfo>>,
    bone_entities: Query<'w, 's, Entity, With<PmxBone>>,
    hair: Option<ResMut<'w, HairPhysicsData>>,
    playback: Option<ResMut<'w, VmdPlayback>>,
}

/// Consume every drop in order; a failed parse leaves the active scene intact.
pub fn reload_dropped_files(
    mut drops: MessageReader<FileDragAndDrop>,
    mut commands: Commands,
    asset_server: Res<AssetServer>,
    mut params: FileDropParams,
) {
    // One model replacement per frame prevents stale queries from missing newly queued entities.
    let mut model_path = None;
    let mut motion_path = None;
    for event in drops.read() {
        let FileDragAndDrop::DroppedFile { path_buf, .. } = event else {
            continue;
        };
        match path_buf
            .extension()
            .and_then(|s| s.to_str())
            .map(str::to_ascii_lowercase)
            .as_deref()
        {
            Some("pmx") => model_path = Some(path_buf.clone()),
            Some("vmd") => motion_path = Some(path_buf.clone()),
            _ => {}
        }
    }
    if let Some(path) = model_path {
        let mut next = params.cfg.clone();
        next.paths.pmx = path.to_string_lossy().into_owned();
        match pmx::init_pmx(
            &mut commands,
            &asset_server,
            &mut params.meshes,
            &mut params.materials,
            &mut params.inverse_bindposes,
            &next,
        ) {
            Ok(()) => {
                if let Some(old) = params.hair.as_ref() {
                    // Animation and reload run in separate schedules; no FFI access overlaps.
                    unsafe {
                        physics::destroy_soft_body(
                            physics::PHYSICS_SYSTEM_PTR.load(std::sync::atomic::Ordering::SeqCst),
                            old.ptr,
                        );
                    }
                }
                for entity in &params.model_entities {
                    commands.entity(entity).despawn();
                }
                for entity in &params.bone_entities {
                    commands.entity(entity).despawn();
                }
                if let Some(pb) = params.playback.as_mut() {
                    pb.time_sec = 0.0;
                }
                *params.cfg = next;
                info!("Loaded model: {}", path.display());
            }
            Err(e) => error!("Model replacement failed: {e}"),
        }
    }
    if let Some(path) = motion_path {
        match VmdMotionClip::from_file(&path) {
            Ok(clip) => {
                commands.insert_resource(VmdPlayback {
                    clip,
                    fps: 30.0,
                    time_sec: 0.0,
                });
                if let Some(hair) = params.hair.as_mut() {
                    hair.is_initialized = false;
                }
                params.cfg.paths.vmd = path.to_string_lossy().into_owned();
                info!("Loaded motion: {}", path.display());
            }
            Err(e) => error!("Motion replacement failed: {e}"),
        }
    }
}
