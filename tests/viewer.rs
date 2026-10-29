//! The viewer's engine-side pieces that need no GPU: configuration, file resolution,
//! texture decoding, load requests and the UI command protocol.

use bevy3d_animation::viewer::bridge;
use bevy3d_animation::viewer::config::ViewerConfig;
use bevy3d_animation::viewer::source::{self, MemoryFiles, Source};
use bevy3d_animation::viewer::texture::{self, Alpha, Wrap};
use bevy3d_animation::viewer::{request_for_files, request_for_paths};

#[test]
fn defaults_parse_and_validate() {
    let config = ViewerConfig::defaults();
    assert!(config.scene.model.ends_with(".pmx"));
    assert_eq!(config.physics.gravity, 98.0);
    assert!(config.jiggle.enabled);
    let bad = bevy3d_animation::viewer::config::DEFAULTS.replace("msaa = 4", "msaa = 3");
    assert!(ViewerConfig::parse(&bad).is_err());
    // Missing sections take their defaults.
    assert_eq!(ViewerConfig::parse("").unwrap().physics.gravity, 98.0);
}

#[test]
fn paths_normalise_like_windows_wrote_them() {
    assert_eq!(source::normalize("tex\\..\\Tex/./body.PNG"), "Tex/body.PNG");
    assert_eq!(source::join("model", "..\\shared\\toon.bmp"), "shared/toon.bmp");
    assert_eq!(source::parent("a/b/c.pmx"), "a/b");
    assert_eq!(source::file_name("a\\b\\c.vmd"), "c.vmd");
}

#[test]
fn memory_files_resolve_case_folders_and_bare_names() {
    let files = MemoryFiles::new([
        ("Miku/miku.pmx".to_string(), b"pmx".to_vec()),
        ("Miku/Tex/Body.png".to_string(), b"body".to_vec()),
        ("Miku/spa/s.spa".to_string(), b"sphere".to_vec()),
        ("Other/a.png".to_string(), b"a1".to_vec()),
        ("Miku/a.png".to_string(), b"a2".to_vec()),
    ]);
    assert_eq!(files.get("Miku\\tex\\body.PNG"), Some(b"body".as_slice()));
    // A folder upload adds a top directory the PMX does not know.
    assert_eq!(files.get("spa/s.spa"), Some(b"sphere".as_slice()));
    // A bare file name matches only when it is unique.
    assert_eq!(files.get("x/s.spa"), Some(b"sphere".as_slice()));
    assert_eq!(files.get("y/a.png"), None);
    assert_eq!(files.get("missing.png"), None);
}

#[test]
fn disk_reads_ignore_letter_case() {
    let dir = std::env::temp_dir().join(format!("bevy3d_viewer_{}", std::process::id()));
    std::fs::create_dir_all(dir.join("Tex")).unwrap();
    std::fs::write(dir.join("Tex/Body.png"), b"body").unwrap();
    let source = Source::Disk(dir.clone());
    let bytes = bevy::tasks::block_on(source.read("tex\\BODY.png")).unwrap();
    assert_eq!(bytes, b"body");
    assert!(bevy::tasks::block_on(source.read("tex/none.png")).is_err());
    std::fs::remove_dir_all(dir).unwrap();
}

/// A 2×2 BMP (32-bit, bottom-up) with one transparent texel.
fn bmp() -> Vec<u8> {
    let pixels: [[u8; 4]; 4] = [[0, 0, 255, 255], [0, 255, 0, 255], [255, 0, 0, 0], [255, 255, 255, 255]];
    let mut out = Vec::new();
    let data_len = 16u32;
    out.extend_from_slice(b"BM");
    out.extend_from_slice(&(54 + 68 + data_len).to_le_bytes());
    out.extend_from_slice(&[0; 4]);
    out.extend_from_slice(&(54u32 + 68).to_le_bytes());
    // BITMAPV4HEADER with channel masks, so the alpha channel is read.
    out.extend_from_slice(&108u32.to_le_bytes());
    out.extend_from_slice(&2i32.to_le_bytes());
    out.extend_from_slice(&2i32.to_le_bytes());
    out.extend_from_slice(&1u16.to_le_bytes());
    out.extend_from_slice(&32u16.to_le_bytes());
    out.extend_from_slice(&3u32.to_le_bytes());
    out.extend_from_slice(&data_len.to_le_bytes());
    out.extend_from_slice(&[0; 16]);
    for mask in [0x00ff0000u32, 0x0000ff00, 0x000000ff, 0xff000000] {
        out.extend_from_slice(&mask.to_le_bytes());
    }
    out.extend_from_slice(b"BGRs");
    out.extend_from_slice(&[0; 48]);
    out.truncate(54 + 68);
    for p in pixels {
        out.extend_from_slice(&p);
    }
    out
}

#[test]
fn textures_decode_by_content_not_extension() {
    // A sphere map is a BMP named .spa.
    use bevy::image::ImageFormat;
    assert!(matches!(texture::sniff(&bmp(), "sphere.spa"), Some(ImageFormat::Bmp)));
    assert!(matches!(texture::sniff(b"\x89PNG....", "x.bmp"), Some(ImageFormat::Png)));
    assert!(matches!(texture::sniff(b"????", "x.tga"), Some(ImageFormat::Tga)));
    assert!(texture::sniff(b"????", "x.xyz").is_none());
    let decoded = texture::decode(&bmp(), "sphere.spa", Wrap::Clamp).expect("BMP decodes");
    assert_eq!(decoded.image.texture_descriptor.size.width, 2);
    // 2×2 plus its 1×1 mip.
    assert_eq!(decoded.image.texture_descriptor.mip_level_count, 2);
    assert!(texture::decode(b"garbage", "x.png", Wrap::Repeat).is_err());
}

#[test]
fn alpha_is_classified() {
    assert_eq!(texture::classify_alpha(&[1, 2, 3, 255, 4, 5, 6, 255]), Alpha::Opaque);
    assert_eq!(texture::classify_alpha(&[1, 2, 3, 0, 4, 5, 6, 255]), Alpha::Cutout);
    assert_eq!(texture::classify_alpha(&[1, 2, 3, 128, 4, 5, 6, 255]), Alpha::Blended);
}

#[test]
fn mips_average_in_linear_light_and_respect_alpha() {
    // White and a transparent texel: the mip stays white, half covered.
    let (data, levels) = texture::mip_chain(2, 1, vec![255, 255, 255, 255, 0, 0, 0, 0]);
    assert_eq!(levels, 2);
    assert_eq!(&data[8..12], &[255, 255, 255, 128]);
    // Black and white average to linear mid-grey, not sRGB 128.
    let (data, _) = texture::mip_chain(2, 1, vec![0, 0, 0, 255, 255, 255, 255, 255]);
    assert!((186..=189).contains(&data[8]), "{}", data[8]);
}

#[test]
fn shared_toons_are_ramps_from_lit_to_shadow() {
    let toon = texture::shared_toon(0);
    let data = toon.data.as_ref().unwrap();
    assert_eq!(&data[..3], &[255, 255, 255]);
    assert!(data[31 * 4] < 255);
}

#[test]
fn dropped_files_pick_the_model_and_motion() {
    let request = request_for_files(vec![
        ("pack/b.pmx".into(), vec![]),
        ("pack/a.pmx".into(), vec![]),
        ("pack/tex/a.png".into(), vec![]),
        ("dance.VMD".into(), vec![]),
    ]);
    assert_eq!(request.model.unwrap().path, "pack/a.pmx");
    assert_eq!(request.motion.unwrap().path, "dance.VMD");
    let none = request_for_files(vec![("readme.txt".into(), vec![])]);
    assert!(none.model.is_none() && none.motion.is_none());
}

#[test]
fn dropped_folders_find_the_model_inside() {
    let dir = std::env::temp_dir().join(format!("bevy3d_drop_{}", std::process::id()));
    std::fs::create_dir_all(dir.join("Model/sub")).unwrap();
    std::fs::write(dir.join("Model/sub/m.pmx"), b"").unwrap();
    std::fs::write(dir.join("dance.vmd"), b"").unwrap();
    let request = request_for_paths(&[dir.join("Model").display().to_string(), dir.join("dance.vmd").display().to_string()]);
    assert_eq!(request.model.unwrap().path, "m.pmx");
    assert_eq!(request.motion.unwrap().path, "dance.vmd");
    std::fs::remove_dir_all(dir).unwrap();
}

#[test]
fn commands_parse_from_the_panels_json() {
    assert!(bridge::send(r#"{"cmd":"play","playing":false}"#).is_ok());
    assert!(bridge::send(r#"{"cmd":"jiggle","on":true,"strength":0.5}"#).is_ok());
    assert!(bridge::send(r#"{"cmd":"pointer","x":1,"y":2}"#).is_ok());
    assert!(bridge::send(r#"{"cmd":"explode"}"#).is_err());
    assert!(bridge::send("not json").is_err());
}
