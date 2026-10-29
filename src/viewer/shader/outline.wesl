// MikuMikuDance's edge pass: the skinned mesh is pushed out along its screen-space
// normal by a constant number of pixels, and only its back faces are drawn.

import bevy_pbr::render::{
    mesh_functions,
    skinning,
    forward_io::{Vertex, VertexOutput, decompress_vertex},
    view_transformations::position_world_to_clip,
    mesh_view_bindings::view,
};

struct OutlineUniform {
    color: vec4<f32>,
    width: f32,
}

@group(constants::MATERIAL_BIND_GROUP) @binding(0) var<uniform> outline: OutlineUniform;

@vertex
fn vertex(vertex_in: Vertex) -> VertexOutput {
    var out: VertexOutput;
    let vertex = decompress_vertex(vertex_in, vertex_in.instance_index);
@if(SKINNED)
    let world_from_local = skinning::skin_model(vertex.joint_indices, vertex.joint_weights, vertex_in.instance_index);
@else
    let world_from_local = mesh_functions::get_world_from_local(vertex_in.instance_index);
    let world_position = world_from_local * vec4(vertex.position, 1.0);
@if(SKINNED)
    let world_normal = skinning::skin_normals(world_from_local, vertex.normal);
@else
    let world_normal = mesh_functions::mesh_normal_local_to_world(vertex.normal, vertex_in.instance_index);
    var clip = position_world_to_clip(world_position.xyz);
    let clip_normal = (view.clip_from_world * vec4(world_normal, 0.0)).xy;
    let length_sq = dot(clip_normal, clip_normal);
    if length_sq > 1.0e-12 {
        // Physical pixels: the width is in logical pixels of a 1x display.
        let pixels = 2.0 / max(view.viewport.zw, vec2(1.0));
        clip = vec4(clip.xy + clip_normal * inverseSqrt(length_sq) * pixels * outline.width * clip.w, clip.zw);
    }
    out.position = clip;
    out.world_position = world_position;
    out.world_normal = world_normal;
    return out;
}

fn to_linear(c: vec3<f32>) -> vec3<f32> {
    let lo = c / 12.92;
    let hi = pow((max(c, vec3(0.0)) + 0.055) / 1.055, vec3(2.4));
    return select(hi, lo, c <= vec3(0.04045));
}

@fragment
fn fragment(in: VertexOutput) -> @location(0) vec4<f32> {
    return vec4(to_linear(outline.color.rgb), outline.color.a);
}
