//! Texture decoding for PMX materials.
//!
//! The format comes from the file's first bytes, not its extension: sphere maps are
//! BMPs named `.spa`/`.sph`, and many models ship PNGs named `.bmp`. Mip chains are
//! built here so distant hair and clothes do not shimmer. A texture that cannot be
//! read becomes a 1×1 stand-in, never a missing material.

use bevy::asset::RenderAssetUsages;
use bevy::image::{
    CompressedImageFormats, Image, ImageAddressMode, ImageFilterMode, ImageFormat, ImageSampler,
    ImageSamplerDescriptor, ImageType,
};
use bevy::render::render_resource::{Extent3d, TextureDimension, TextureFormat};

/// How a texture's alpha channel may be drawn.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Alpha {
    Opaque,
    /// Only fully opaque or fully transparent texels: alpha testing is exact.
    Cutout,
    Blended,
}

pub struct Decoded {
    pub image: Image,
    pub alpha: Alpha,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Wrap {
    Repeat,
    Clamp,
}

pub fn sniff(bytes: &[u8], name: &str) -> Option<ImageFormat> {
    if bytes.starts_with(b"\x89PNG") {
        Some(ImageFormat::Png)
    } else if bytes.starts_with(&[0xff, 0xd8]) {
        Some(ImageFormat::Jpeg)
    } else if bytes.starts_with(b"BM") {
        Some(ImageFormat::Bmp)
    } else {
        let ext = name.rsplit('.').next().unwrap_or("").to_ascii_lowercase();
        // TGA has no magic number.
        (ext == "tga").then_some(ImageFormat::Tga)
    }
}

fn sampler(wrap: Wrap) -> ImageSampler {
    let mode = match wrap {
        Wrap::Repeat => ImageAddressMode::Repeat,
        Wrap::Clamp => ImageAddressMode::ClampToEdge,
    };
    ImageSampler::Descriptor(ImageSamplerDescriptor {
        address_mode_u: mode,
        address_mode_v: mode,
        address_mode_w: mode,
        mag_filter: ImageFilterMode::Linear,
        min_filter: ImageFilterMode::Linear,
        mipmap_filter: ImageFilterMode::Linear,
        anisotropy_clamp: 8,
        ..Default::default()
    })
}

/// Decodes an image file to sRGB RGBA8 with a full mip chain.
pub fn decode(bytes: &[u8], name: &str, wrap: Wrap) -> Result<Decoded, String> {
    let format = sniff(bytes, name).ok_or_else(|| format!("{name}: unsupported image format"))?;
    let image = Image::from_buffer(
        bytes,
        ImageType::Format(format),
        CompressedImageFormats::NONE,
        true,
        ImageSampler::Default,
        RenderAssetUsages::RENDER_WORLD,
    )
    .map_err(|e| format!("{name}: {e}"))?;
    let image = image
        .convert(TextureFormat::Rgba8UnormSrgb)
        .ok_or_else(|| format!("{name}: cannot convert to RGBA8"))?;
    let size = image.texture_descriptor.size;
    let data = image.data.ok_or_else(|| format!("{name}: no pixel data"))?;
    Ok(rgba(size.width, size.height, data, wrap))
}

/// An sRGB RGBA8 image with mips, from raw texels.
pub fn rgba(width: u32, height: u32, data: Vec<u8>, wrap: Wrap) -> Decoded {
    let alpha = classify_alpha(&data);
    let (data, levels) = mip_chain(width, height, data);
    let mut image = Image::new(
        Extent3d { width, height, depth_or_array_layers: 1 },
        TextureDimension::D2,
        data,
        TextureFormat::Rgba8UnormSrgb,
        RenderAssetUsages::RENDER_WORLD,
    );
    image.texture_descriptor.mip_level_count = levels;
    image.sampler = sampler(wrap);
    Decoded { image, alpha }
}

pub fn classify_alpha(rgba: &[u8]) -> Alpha {
    let mut cutout = false;
    for a in rgba.iter().skip(3).step_by(4) {
        match *a {
            255 => {}
            0 => cutout = true,
            _ => return Alpha::Blended,
        }
    }
    if cutout { Alpha::Cutout } else { Alpha::Opaque }
}

fn srgb_to_linear(c: u8) -> f32 {
    let c = c as f32 / 255.0;
    if c <= 0.04045 { c / 12.92 } else { ((c + 0.055) / 1.055).powf(2.4) }
}

fn linear_to_srgb(c: f32) -> u8 {
    let c = if c <= 0.0031308 { c * 12.92 } else { 1.055 * c.powf(1.0 / 2.4) - 0.055 };
    (c.clamp(0.0, 1.0) * 255.0 + 0.5) as u8
}

/// Appends 2×2 box-filtered levels (in linear light, weighted by alpha) down to 1×1.
pub fn mip_chain(width: u32, height: u32, mut data: Vec<u8>) -> (Vec<u8>, u32) {
    let to_linear: Vec<f32> = (0..=255u8).map(srgb_to_linear).collect();
    let (mut w, mut h) = (width as usize, height as usize);
    let mut level_start = 0usize;
    let mut levels = 1;
    while w > 1 || h > 1 {
        let (nw, nh) = ((w / 2).max(1), (h / 2).max(1));
        let mut next = Vec::with_capacity(nw * nh * 4);
        for y in 0..nh {
            for x in 0..nw {
                let mut rgb = [0f32; 3];
                let mut alpha = 0f32;
                let mut count = 0f32;
                for (dx, dy) in [(0, 0), (1, 0), (0, 1), (1, 1)] {
                    let sx = (x * 2 + dx).min(w - 1);
                    let sy = (y * 2 + dy).min(h - 1);
                    let p = level_start + (sy * w + sx) * 4;
                    let a = data[p + 3] as f32 / 255.0;
                    for c in 0..3 {
                        rgb[c] += to_linear[data[p + c] as usize] * a;
                    }
                    alpha += a;
                    count += 1.0;
                }
                for c in rgb {
                    next.push(if alpha > 0.0 { linear_to_srgb(c / alpha) } else { 0 });
                }
                next.push((alpha / count * 255.0 + 0.5) as u8);
            }
        }
        level_start = data.len();
        data.extend_from_slice(&next);
        w = nw;
        h = nh;
        levels += 1;
    }
    (data, levels)
}

pub fn solid(rgba: [u8; 4], wrap: Wrap) -> Image {
    self::rgba(1, 1, rgba.to_vec(), wrap).image
}

/// Shadow colours of MikuMikuDance's shared `toon01.bmp` … `toon10.bmp`, for models
/// that rely on the application's copies.
const SHARED_TOON_SHADOWS: [[u8; 3]; 10] = [
    [205, 205, 205],
    [247, 222, 208],
    [178, 178, 178],
    [241, 214, 206],
    [228, 218, 228],
    [235, 214, 196],
    [190, 196, 214],
    [231, 199, 190],
    [216, 211, 211],
    [241, 228, 216],
];

/// A 1×32 toon ramp: lit at the top, the shadow colour below, a short soft edge.
pub fn shared_toon(index: u8) -> Image {
    let shadow = SHARED_TOON_SHADOWS[index.min(9) as usize];
    let height = 32u32;
    let mut data = Vec::with_capacity(height as usize * 4);
    for y in 0..height {
        let t = ((y as f32 + 0.5) / height as f32 - 0.45) / 0.1;
        let t = t.clamp(0.0, 1.0);
        for c in 0..3 {
            data.push((255.0 + (shadow[c] as f32 - 255.0) * t).round() as u8);
        }
        data.push(255);
    }
    rgba(1, height, data, Wrap::Clamp).image
}
