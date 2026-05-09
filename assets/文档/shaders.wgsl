// struct VSOut {
//     @builtin(position) clip_pos : vec4<f32>,
//     @location(0) world_position : vec3<f32>,
//     @location(1) world_normal   : vec3<f32>,
//     @location(2) uv             : vec2<f32>,
// };
// @group(#{MATERIAL_BIND_GROUP}) @binding(1) var base_color_tex: texture_2d<f32>;
// @group(#{MATERIAL_BIND_GROUP}) @binding(2) var base_color_sampler: sampler;

// @fragment
// fn fs_main(in: VSOut) -> @location(0) vec4<f32> {
//      let tex_color = textureSample(base_color_tex, base_color_sampler, in.uv);
//     let output_color = vec4<f32>(tex_color.r,tex_color.g,tex_color.b, tex_color.a);
//     return output_color;


//     //let tex_color = textureSample(base_color_tex, base_color_sampler, in.uv);
//     //return tex_color;
// }
/*
struct VSOut {
    @builtin(position) clip_pos : vec4<f32>,
    @location(0) world_position : vec3<f32>,
    @location(1) world_normal   : vec3<f32>,
    @location(2) uv             : vec2<f32>,
};
@group(#{MATERIAL_BIND_GROUP}) @binding(1) var base_color_tex: texture_2d<f32>;
@group(#{MATERIAL_BIND_GROUP}) @binding(2) var base_color_sampler: sampler;
@fragment
fn fs_main(in: VSOut) -> @location(0) vec4<f32> {
    let tex_color = textureSample(base_color_tex, base_color_sampler, in.uv);
    return tex_color;
}
*/