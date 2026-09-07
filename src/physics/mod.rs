use std::ffi::c_void;
use std::sync::atomic::AtomicPtr;

pub static PHYSICS_SYSTEM_PTR: AtomicPtr<c_void> = AtomicPtr::new(std::ptr::null_mut());

unsafe extern "C" {
    pub fn constrain_soft_body(
        system: *mut c_void,
        body: *mut c_void,
        capsules: *const f32,
        count: i32,
        targets: *const f32,
        max_distance: f32,
    );
    pub fn constrain_soft_body_triangles(
        system: *mut c_void,
        body: *mut c_void,
        triangles: *const f32,
        triangle_count: i32,
        targets: *const f32,
        max_distance: f32,
        thickness: f32,
    );
    pub fn jolt_shutdown();
    pub fn jolt_init() -> *mut c_void;
    pub fn destroy_soft_body(physics_system: *mut c_void, body: *mut c_void);

    pub fn create_soft_body_from_mesh(
        vertices: *const f32,
        num_vertices: i32,
        indices: *const i32,
        num_indices: i32,
        inv_masses: *const f32,
        physics_system: *mut c_void,
        stretch: f32,
        shear: f32,
        bend: f32,
        iterations: i32,
        gravity: f32,
    ) -> *mut c_void;

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

    pub fn apply_soft_body_vertex_params(
        physics_system: *mut c_void,
        body_id: *mut c_void,
        groups: *const u8,
        count: i32,
        delta_time: f32,
        base_gravity: f32,
        hair_gravity: f32,
        cloth_gravity: f32,
        hair_damping: f32,
        cloth_damping: f32,
        hair_air_drag: f32,
        cloth_air_drag: f32,
    );
}

pub fn shutdown(mut exit: bevy::prelude::MessageReader<bevy::app::AppExit>) {
    if exit.read().next().is_some()
        && !PHYSICS_SYSTEM_PTR
            .swap(std::ptr::null_mut(), std::sync::atomic::Ordering::SeqCst)
            .is_null()
    {
        unsafe {
            jolt_shutdown();
        }
    }
}
