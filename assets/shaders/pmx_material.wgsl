#import bevy_pbr::forward_io::VertexOutput

@group(#{MATERIAL_BIND_GROUP}) @binding(1) var base_color_texture: texture_2d<f32>;
@group(#{MATERIAL_BIND_GROUP}) @binding(2) var base_color_sampler: sampler;
@group(#{MATERIAL_BIND_GROUP}) @binding(3) var sphere_texture: texture_2d<f32>;
@group(#{MATERIAL_BIND_GROUP}) @binding(4) var sphere_sampler: sampler;
@group(#{MATERIAL_BIND_GROUP}) @binding(5) var toon_texture: texture_2d<f32>;
@group(#{MATERIAL_BIND_GROUP}) @binding(6) var toon_sampler: sampler;

struct PmxUniform {
    diffuse: vec4<f32>,
    ambient: vec4<f32>,
    edge_color: vec4<f32>,
    // x: sphere mode (0 none / 1 mul / 2 add)
    // y: disable culling flag (预留，当前在 CPU 侧处理)
    // z: edge flag
    // w: toon flag
    flags: vec4<u32>,
    emissive_strength: f32,
    _pad0: vec3<f32>,
};

@group(#{MATERIAL_BIND_GROUP}) @binding(0) var<uniform> pmx: PmxUniform;

@fragment
fn fragment(in: VertexOutput) -> @location(0) vec4<f32> {
    let uv = in.uv;

    var color = textureSample(base_color_texture, base_color_sampler, uv) * pmx.diffuse;
    let sphere = textureSample(sphere_texture, sphere_sampler, uv);

    // sphere mode
    if (pmx.flags.x == 1u) {
        color = vec4<f32>(color.rgb * sphere.rgb, color.a);
    } else if (pmx.flags.x == 2u) {
        color = vec4<f32>(color.rgb + sphere.rgb * sphere.a, color.a);
    }

    // toon ramp
    if (pmx.flags.w == 1u) {
        let n = normalize(in.world_normal);
        let l = normalize(vec3<f32>(0.3, 0.8, 0.4));
        let nl = clamp(dot(n, l) * 0.5 + 0.5, 0.0, 1.0);
        let toon_uv = vec2<f32>(0.5, 1.0 - nl);
        let toon = textureSample(toon_texture, toon_sampler, toon_uv);
        color = vec4<f32>(color.rgb * toon.rgb, color.a);
    }

    // edge (轻量近似：rim tint)
    if (pmx.flags.z == 1u) {
        let n = normalize(in.world_normal);
        let v = vec3<f32>(0.0, 0.0, 1.0);
        let rim = pow(1.0 - abs(dot(n, v)), 3.0);
        let mixed = mix(color.rgb, pmx.edge_color.rgb, rim * pmx.edge_color.a * 0.35);
        color = vec4<f32>(mixed, color.a);
    }

    // emissive + ambient
    color = vec4<f32>(color.rgb + color.rgb * pmx.emissive_strength, color.a);
    color = vec4<f32>(color.rgb + pmx.ambient.rgb * 0.15, color.a);
    return color;
}
