const std = @import("std");
const zphysics = @import("zphysics");

// These interface instances must remain alive while the physics system is running.
var g_physics_system: *zphysics.PhysicsSystem = undefined;

var g_bp_interface: MyBroadPhaseLayerInterface = .{};
var g_obj_vs_bp_filter: MyObjectVsBroadPhaseLayerFilter = .{};
var g_obj_pair_filter: MyObjectLayerPairFilter = .{};

// Broad phase layer interface.
const MyBroadPhaseLayerInterface = struct {
    interface: zphysics.BroadPhaseLayerInterface = .init(MyBroadPhaseLayerInterface),
    pub fn getNumBroadPhaseLayers(_: *const zphysics.BroadPhaseLayerInterface) callconv(.c) u32 {
        return 2; // 0: static, 1: moving.
    }
    pub fn getBroadPhaseLayer(_: *const zphysics.BroadPhaseLayerInterface, layer: zphysics.ObjectLayer) callconv(.c) zphysics.BroadPhaseLayer {
        return if (layer == 0) 0 else 1;
    }
    pub fn getBroadPhaseLayerName(_: *const zphysics.BroadPhaseLayerInterface, layer: zphysics.BroadPhaseLayer) callconv(.c) [*:0]const u8 {
        return if (layer == 0) "NON_MOVING" else "MOVING";
    }
};

// Object versus broad phase filter.
const MyObjectVsBroadPhaseLayerFilter = struct {
    interface: zphysics.ObjectVsBroadPhaseLayerFilter = .init(MyObjectVsBroadPhaseLayerFilter),

    pub fn shouldCollide(_: *const zphysics.ObjectVsBroadPhaseLayerFilter, layer1: zphysics.ObjectLayer, layer2: zphysics.BroadPhaseLayer) callconv(.c) bool {
        if (layer1 == 0) return layer2 == 1; // Static objects collide with moving objects.
        return true; // Moving objects collide with both layers.
    }
};

// Object layer pair filter.
const MyObjectLayerPairFilter = struct {
    interface: zphysics.ObjectLayerPairFilter = .init(MyObjectLayerPairFilter),

    pub fn shouldCollide(_: *const zphysics.ObjectLayerPairFilter, layer1: zphysics.ObjectLayer, layer2: zphysics.ObjectLayer) callconv(.c) bool {
        if (layer1 == 0) return layer2 == 1;
        if (layer1 == 1) return true;
        return false;
    }
};

export fn jolt_init() *anyopaque {
    zphysics.init(std.heap.c_allocator, .{}) catch unreachable;
    // Initialize the system with the interfaces above.
    g_physics_system = zphysics.PhysicsSystem.create(
        &g_bp_interface.interface,
        &g_obj_vs_bp_filter.interface,
        &g_obj_pair_filter.interface,
        .{
            .max_bodies = 1024,
            .max_body_pairs = 1024,
            .max_contact_constraints = 1024,
        },
    ) catch unreachable;
    // PMX uses Y-up coordinates; set gravity explicitly because the native
    // backend does not guarantee a non-zero default gravity.
    g_physics_system.setGravity(.{ 0.0, -9.81, 0.0 });

    std.debug.print("Jolt Physics System Initialized with Custom Interfaces!\n", .{});
    return @ptrCast(g_physics_system);
}

export fn step_physics(delta_time: f32) void {
    if (@intFromPtr(g_physics_system) != 0) {
        // Rust schedules fixed 1/60-second updates.
        g_physics_system.update(delta_time, .{ .collision_steps = 1 }) catch |err| {
            std.debug.print("Physics update failed: {}\n", .{err});
        };
    }
}

export fn jolt_shutdown() void {
    g_physics_system.destroy();
    zphysics.deinit();
}
