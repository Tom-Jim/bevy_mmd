use bevy::prelude::*;
use std::ffi::c_void;
use std::sync::atomic::AtomicPtr;

use crate::components::{JoltBody, JoltSoftBody};

pub static PHYSICS_SYSTEM_PTR: AtomicPtr<c_void> = AtomicPtr::new(std::ptr::null_mut());

unsafe extern "C" {
    pub fn jolt_init() -> *mut c_void;
    pub fn jolt_math_test(x: f32, y: f32) -> f32;
    pub fn create_box_body(x: f32, y: f32, z: f32) -> *mut c_void;

    pub fn create_soft_body_from_mesh(
        vertices: *const f32,
        num_vertices: i32,
        indices: *const i32,
        num_indices: i32,
        inv_masses: *const f32,
        physics_system: *mut c_void,
    ) -> *mut c_void;

    pub fn get_soft_body_vertex_count(physics_system: *mut c_void, body_id: *mut c_void) -> i32;

    pub fn get_soft_body_vertices(
        physics_system: *mut c_void,
        body_id: *mut c_void,
        out_vertices: *mut f32,
        max_vertices: i32,
    );

    pub fn step_physics(delta_time: f32);

    pub fn update_soft_body_roots(
        physics_system: *mut c_void,
        body_id: *mut c_void,
        all_pos: *const f32,
        all_idx: *const i32,
        count: i32,
        is_first_frame: i32,
        delta_time: f32,
        position_pull: f32,
        velocity_pull: f32,
        damping: f32,
        max_speed: f32,
    );
}

/// Draws soft-body wireframes for debug/preview.
pub fn draw_soft_bodies(mut gizmos: Gizmos, query: Query<&JoltSoftBody>) {
    unsafe {
        let physics_system =
            PHYSICS_SYSTEM_PTR.load(std::sync::atomic::Ordering::SeqCst) as *mut c_void;

        for soft_body in query.iter() {
            let mut current_vertices = vec![0.0f32; soft_body.num_vertices * 3];
            let actual_count = get_soft_body_vertex_count(physics_system, soft_body.ptr);
            if actual_count as usize > soft_body.num_vertices {
                current_vertices.resize(actual_count as usize * 3, 0.0);
            }
            get_soft_body_vertices(
                physics_system,
                soft_body.ptr,
                current_vertices.as_mut_ptr(),
                (current_vertices.len() / 3) as i32,
            );

            let max_lines = soft_body.indices.len();
            for i in (0..max_lines).step_by(3) {
                if i + 2 >= max_lines {
                    break;
                }
                let v0_idx = soft_body.indices[i] as usize * 3;
                let v1_idx = soft_body.indices[i + 1] as usize * 3;
                let v2_idx = soft_body.indices[i + 2] as usize * 3;

                if v0_idx + 2 >= current_vertices.len()
                    || v1_idx + 2 >= current_vertices.len()
                    || v2_idx + 2 >= current_vertices.len()
                {
                    continue;
                }

                let v0 = Vec3::new(
                    current_vertices[v0_idx],
                    current_vertices[v0_idx + 1],
                    current_vertices[v0_idx + 2],
                );
                let v1 = Vec3::new(
                    current_vertices[v1_idx],
                    current_vertices[v1_idx + 1],
                    current_vertices[v1_idx + 2],
                );
                let v2 = Vec3::new(
                    current_vertices[v2_idx],
                    current_vertices[v2_idx + 1],
                    current_vertices[v2_idx + 2],
                );

                gizmos.line(v0, v1, bevy::color::palettes::css::BLUE);
                gizmos.line(v1, v2, bevy::color::palettes::css::BLUE);
                gizmos.line(v2, v0, bevy::color::palettes::css::BLUE);
            }
        }
    }
}

/// Draws debug collision shapes as wireframe cuboids.
pub fn draw_debug_bodies(mut gizmos: Gizmos, query: Query<(&Transform, &JoltBody)>) {
    for (transform, body) in query.iter() {
        gizmos.cube(
            Transform::from_translation(transform.translation).with_scale(body.size * 2.0),
            bevy::color::palettes::css::LIME,
        );
    }
}
