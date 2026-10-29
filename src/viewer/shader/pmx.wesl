// MikuMikuDance material shading. The math runs in gamma space, as MikuMikuDance's
// does: texels are re-encoded to sRGB after sampling and the result is decoded to
// linear for the sRGB render target, so colours match the original application.

import bevy_pbr::render::{
    forward_io::VertexOutput,
    mesh_view_bindings::view,
};

struct PmxUniform {
    diffuse: vec4<f32>,
    specular: vec4<f32>,
    ambient: vec4<f32>,
    texture_mul: vec4<f32>,
    texture_add: vec4<f32>,
    sphere_mul: vec4<f32>,
    sphere_add: vec4<f32>,
    toon_mul: vec4<f32>,
    toon_add: vec4<f32>,
    light_direction: vec4<f32>,
    light_color: vec4<f32>,
    flags: vec4<u32>,
}

@group(constants::MATERIAL_BIND_GROUP) @binding(0) var<uniform> material: PmxUniform;
@group(constants::MATERIAL_BIND_GROUP) @binding(1) var base_texture: texture_2d<f32>;
@group(constants::MATERIAL_BIND_GROUP) @binding(2) var base_sampler: sampler;
@group(constants::MATERIAL_BIND_GROUP) @binding(3) var sphere_texture: texture_2d<f32>;
@group(constants::MATERIAL_BIND_GROUP) @binding(4) var sphere_sampler: sampler;
@group(constants::MATERIAL_BIND_GROUP) @binding(5) var toon_texture: texture_2d<f32>;
@group(constants::MATERIAL_BIND_GROUP) @binding(6) var toon_sampler: sampler;

fn to_gamma(c: vec3<f32>) -> vec3<f32> {
    let lo = c * 12.92;
    let hi = 1.055 * pow(max(c, vec3(0.0)), vec3(1.0 / 2.4)) - 0.055;
    return select(hi, lo, c <= vec3(0.0031308));
}

fn to_linear(c: vec3<f32>) -> vec3<f32> {
    let lo = c / 12.92;
    let hi = pow((max(c, vec3(0.0)) + 0.055) / 1.055, vec3(2.4));
    return select(hi, lo, c <= vec3(0.04045));
}

@fragment
fn fragment(in: VertexOutput, @builtin(front_facing) front: bool) -> @location(0) vec4<f32> {
    var n = normalize(in.world_normal);
    if !front {
        n = -n;
    }
    let l = normalize(material.light_direction.xyz);
    let v = normalize(view.world_position - in.world_position.xyz);
    let view_normal = normalize((view.view_from_world * vec4(n, 0.0)).xyz);
    let sphere_uv = vec2(view_normal.x * 0.5 + 0.5, 0.5 - view_normal.y * 0.5);
    let toon_uv = vec2(0.5, clamp(0.5 - dot(n, l) * 0.5, 0.0, 1.0));

    // Sample before any branch: derivatives need uniform control flow.
    var uv = vec2(0.0);
@if(VERTEX_UVS_A)
    uv = in.uv;
    let tex = textureSample(base_texture, base_sampler, uv);
    let sphere = textureSample(sphere_texture, sphere_sampler, sphere_uv);
    let toon = textureSample(toon_texture, toon_sampler, toon_uv);

    var color = clamp(material.diffuse.rgb * material.light_color.rgb + material.ambient.rgb, vec3(0.0), vec3(1.0));
    color *= to_gamma(tex.rgb) * material.texture_mul.rgb + material.texture_add.rgb;
    let alpha = material.diffuse.a * (tex.a * material.texture_mul.a + material.texture_add.a);
    if alpha <= 0.002 {
        discard;
    }

    let sphere_rgb = to_gamma(sphere.rgb) * material.sphere_mul.rgb + material.sphere_add.rgb;
    if material.flags.x == 1u {
        color *= sphere_rgb;
    } else if material.flags.x == 2u {
        color += sphere_rgb;
    }
    if material.flags.y == 1u {
        color *= to_gamma(toon.rgb) * material.toon_mul.rgb + material.toon_add.rgb;
    }
    if material.specular.w > 0.0 {
        let h = normalize(v + l);
        color += pow(max(dot(h, n), 0.0), material.specular.w) * material.specular.rgb * material.light_color.rgb;
    }
    return vec4(to_linear(clamp(color, vec3(0.0), vec3(1.0))), clamp(alpha, 0.0, 1.0));
}
