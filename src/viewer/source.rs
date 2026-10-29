//! Where model and motion files come from: a folder on disk, the web server of the
//! page, or files the user dropped (kept in memory). PMX texture paths are written on
//! Windows and resolved here forgivingly: either slash, any letter case, and as a last
//! resort a unique file name anywhere in the dropped set.

use std::collections::HashMap;
use std::sync::Arc;

#[derive(Clone, Debug)]
pub enum Source {
    /// Paths relative to this directory.
    #[cfg(not(target_arch = "wasm32"))]
    Disk(std::path::PathBuf),
    /// Paths relative to this URL (the page's `assets/`).
    #[cfg(target_arch = "wasm32")]
    Http(String),
    Memory(Arc<MemoryFiles>),
}

/// Dropped files by normalised relative path.
#[derive(Debug, Default)]
pub struct MemoryFiles {
    files: HashMap<String, Vec<u8>>,
    by_lower: HashMap<String, String>,
}

impl MemoryFiles {
    pub fn new(files: impl IntoIterator<Item = (String, Vec<u8>)>) -> Self {
        let mut out = Self::default();
        for (path, bytes) in files {
            let key = normalize(&path);
            out.by_lower.insert(key.to_lowercase(), key.clone());
            out.files.insert(key, bytes);
        }
        out
    }

    pub fn paths(&self) -> impl Iterator<Item = &str> {
        self.files.keys().map(String::as_str)
    }

    pub fn get(&self, path: &str) -> Option<&[u8]> {
        let key = normalize(path);
        if let Some(b) = self.files.get(&key) {
            return Some(b);
        }
        let lower = key.to_lowercase();
        if let Some(k) = self.by_lower.get(&lower) {
            return self.files.get(k).map(Vec::as_slice);
        }
        // Folder uploads add a top-level directory the PMX does not know about.
        let suffix = format!("/{lower}");
        let mut hits = self.by_lower.iter().filter(|(l, _)| l.ends_with(&suffix));
        if let (Some((_, k)), None) = (hits.next(), hits.next()) {
            return self.files.get(k).map(Vec::as_slice);
        }
        let name = lower.rsplit('/').next().unwrap_or(&lower);
        let mut hits = self.by_lower.iter().filter(|(l, _)| l.rsplit('/').next() == Some(name));
        match (hits.next(), hits.next()) {
            (Some((_, k)), None) => self.files.get(k).map(Vec::as_slice),
            _ => None,
        }
    }
}

/// Forward slashes, no `.` segments, `..` applied, no leading or trailing slash.
pub fn normalize(path: &str) -> String {
    let mut parts: Vec<&str> = Vec::new();
    for part in path.split(['/', '\\']) {
        match part {
            "" | "." => {}
            ".." => {
                parts.pop();
            }
            p => parts.push(p),
        }
    }
    parts.join("/")
}

/// Directory part of a relative path (`""` for a top-level file).
pub fn parent(path: &str) -> String {
    let path = normalize(path);
    path.rsplit_once('/').map(|(dir, _)| dir.to_string()).unwrap_or_default()
}

pub fn join(dir: &str, path: &str) -> String {
    if dir.is_empty() { normalize(path) } else { normalize(&format!("{dir}/{path}")) }
}

pub fn file_name(path: &str) -> &str {
    path.rsplit(['/', '\\']).next().unwrap_or(path)
}

impl Source {
    pub async fn read(&self, path: &str) -> Result<Vec<u8>, String> {
        match self {
            #[cfg(not(target_arch = "wasm32"))]
            Source::Disk(root) => read_disk(root, path),
            #[cfg(target_arch = "wasm32")]
            Source::Http(base) => fetch(&format!("{base}/{}", encode_url_path(&normalize(path)))).await,
            Source::Memory(files) => files.get(path).map(<[u8]>::to_vec).ok_or_else(|| format!("{path}: not among the dropped files")),
        }
    }
}

/// Reads `root/path`, matching each path segment without regard to case when the
/// exact name is missing (PMX files come from case-insensitive Windows).
#[cfg(not(target_arch = "wasm32"))]
fn read_disk(root: &std::path::Path, path: &str) -> Result<Vec<u8>, String> {
    let rel = normalize(path);
    let exact = root.join(&rel);
    if let Ok(bytes) = std::fs::read(&exact) {
        return Ok(bytes);
    }
    let mut dir = root.to_path_buf();
    for segment in rel.split('/') {
        let direct = dir.join(segment);
        if direct.exists() {
            dir = direct;
            continue;
        }
        let lower = segment.to_lowercase();
        let found = std::fs::read_dir(&dir)
            .ok()
            .and_then(|entries| entries.flatten().find(|e| e.file_name().to_string_lossy().to_lowercase() == lower));
        match found {
            Some(entry) => dir = entry.path(),
            None => return Err(format!("{}: not found", exact.display())),
        }
    }
    std::fs::read(&dir).map_err(|e| format!("{}: {e}", dir.display()))
}

#[cfg(target_arch = "wasm32")]
fn encode_url_path(path: &str) -> String {
    let mut out = String::with_capacity(path.len());
    for byte in path.bytes() {
        match byte {
            b'A'..=b'Z' | b'a'..=b'z' | b'0'..=b'9' | b'-' | b'_' | b'.' | b'~' | b'/' => out.push(byte as char),
            _ => out.push_str(&format!("%{byte:02X}")),
        }
    }
    out
}

#[cfg(target_arch = "wasm32")]
async fn fetch(url: &str) -> Result<Vec<u8>, String> {
    use wasm_bindgen::JsCast;
    use wasm_bindgen_futures::JsFuture;

    let window = web_sys::window().ok_or("no window")?;
    let response = JsFuture::from(window.fetch_with_str(url)).await.map_err(|e| format!("{url}: {e:?}"))?;
    let response: web_sys::Response = response.dyn_into().map_err(|_| format!("{url}: not a response"))?;
    if !response.ok() {
        return Err(format!("{url}: HTTP {}", response.status()));
    }
    let buffer = JsFuture::from(response.array_buffer().map_err(|e| format!("{url}: {e:?}"))?)
        .await
        .map_err(|e| format!("{url}: {e:?}"))?;
    Ok(js_sys::Uint8Array::new(&buffer).to_vec())
}
