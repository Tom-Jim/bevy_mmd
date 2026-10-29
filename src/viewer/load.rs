//! Loading off the frame loop: file reads, PMX/VMD parsing and texture decoding run as
//! a task; the frame that finds it finished only creates the assets.

use bevy::prelude::*;
use bevy::tasks::{IoTaskPool, Task, block_on, poll_once};

use super::source::{self, Source};
use super::texture::{self, Decoded, Wrap};
use crate::format::pmx::{PmxModel, SphereMode, Toon};
use crate::format::vmd::VmdMotion;

#[derive(Clone, Debug)]
pub struct FileRef {
    pub source: Source,
    pub path: String,
}

/// What to (re)load. `None` keeps the current model or motion.
#[derive(Clone, Debug, Default)]
pub struct LoadRequest {
    pub model: Option<FileRef>,
    pub motion: Option<FileRef>,
}

/// A decoded texture for each way a material samples it.
#[derive(Default)]
pub struct TextureSet {
    /// By PMX texture index: base and sphere maps (repeat, clamp).
    pub repeat: Vec<Option<Decoded>>,
    pub clamp: Vec<Option<Decoded>>,
    /// `toon01.bmp` … `toon10.bmp` found next to the model.
    pub shared_toons: Vec<Option<Decoded>>,
}

pub struct LoadedModel {
    pub name: String,
    pub path: String,
    pub model: PmxModel,
    pub textures: TextureSet,
    pub warnings: Vec<String>,
}

pub struct LoadedMotion {
    pub path: String,
    pub motion: VmdMotion,
}

pub struct LoadResult {
    pub model: Option<Result<LoadedModel, String>>,
    pub motion: Option<Result<LoadedMotion, String>>,
}

#[derive(Resource, Default)]
pub struct PendingLoad(pub Option<Task<LoadResult>>);

pub fn start(pending: &mut PendingLoad, request: LoadRequest) {
    if request.model.is_none() && request.motion.is_none() {
        return;
    }
    pending.0 = Some(IoTaskPool::get().spawn(async move {
        let model = match request.model {
            Some(file) => Some(load_model(&file).await),
            None => None,
        };
        let motion = match request.motion {
            Some(file) => Some(load_motion(&file).await),
            None => None,
        };
        LoadResult { model, motion }
    }));
}

pub fn poll(pending: &mut PendingLoad) -> Option<LoadResult> {
    let task = pending.0.as_mut()?;
    let result = block_on(poll_once(task))?;
    pending.0 = None;
    Some(result)
}

pub async fn load_motion(file: &FileRef) -> Result<LoadedMotion, String> {
    let bytes = file.source.read(&file.path).await?;
    let motion = VmdMotion::parse(&bytes).map_err(|e| format!("{}: {e}", file.path))?;
    Ok(LoadedMotion { path: file.path.clone(), motion })
}

pub async fn load_model(file: &FileRef) -> Result<LoadedModel, String> {
    let bytes = file.source.read(&file.path).await?;
    let mut model = PmxModel::parse(&bytes).map_err(|e| format!("{}: {e}", file.path))?;
    crate::anim::jiggle::add_hip_bones(&mut model);
    let dir = source::parent(&file.path);
    let n = model.textures.len();
    let (mut repeat_use, mut clamp_use) = (vec![false; n], vec![false; n]);
    let mark = |set: &mut Vec<bool>, i: i32| {
        if i >= 0 && (i as usize) < set.len() {
            set[i as usize] = true;
        }
    };
    for m in &model.materials {
        mark(&mut repeat_use, m.texture);
        if m.sphere_mode != SphereMode::None {
            mark(&mut clamp_use, m.sphere_texture);
        }
        if let Toon::Texture(i) = m.toon {
            mark(&mut clamp_use, i);
        }
    }
    let mut warnings = Vec::new();
    let mut textures = TextureSet { repeat: Vec::with_capacity(n), clamp: Vec::with_capacity(n), shared_toons: Vec::new() };
    for (i, name) in model.textures.iter().enumerate() {
        if !repeat_use[i] && !clamp_use[i] {
            textures.repeat.push(None);
            textures.clamp.push(None);
            continue;
        }
        let path = source::join(&dir, name);
        let bytes = match file.source.read(&path).await {
            Ok(b) => Some(b),
            Err(e) => {
                warnings.push(e);
                None
            }
        };
        let mut decode = |used: bool, wrap: Wrap| {
            let bytes = bytes.as_ref().filter(|_| used)?;
            texture::decode(bytes, name, wrap).map_err(|e| warnings.push(e)).ok()
        };
        textures.repeat.push(decode(repeat_use[i], Wrap::Repeat));
        textures.clamp.push(decode(clamp_use[i], Wrap::Clamp));
    }
    let shared: Vec<u8> = model
        .materials
        .iter()
        .filter_map(|m| if let Toon::Shared(i) = m.toon { Some(i) } else { None })
        .collect();
    for i in 0..10u8 {
        let mut found = None;
        if shared.contains(&i) {
            let path = source::join(&dir, &format!("toon{:02}.bmp", i + 1));
            if let Ok(bytes) = file.source.read(&path).await {
                found = texture::decode(&bytes, &path, Wrap::Clamp).ok();
            }
        }
        textures.shared_toons.push(found);
    }
    let name = if model.name.trim().is_empty() { source::file_name(&file.path).to_string() } else { model.name.clone() };
    Ok(LoadedModel { name, path: file.path.clone(), model, textures, warnings })
}
