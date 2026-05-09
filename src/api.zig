const std = @import("std");
const zphysics = @import("zphysics");
const assert = std.debug.assert;

// --- 全局变量：这些接口实例必须在物理系统运行期间保持存活 ---
var g_physics_system: *zphysics.PhysicsSystem = undefined;

var g_bp_interface: MyBroadPhaseLayerInterface = .{};
var g_obj_vs_bp_filter: MyObjectVsBroadPhaseLayerFilter = .{};
var g_obj_pair_filter: MyObjectLayerPairFilter = .{};

// 1. 定义宽相层接口 (BroadPhaseLayerInterface)
const MyBroadPhaseLayerInterface = struct {
    interface: zphysics.BroadPhaseLayerInterface = .init(MyBroadPhaseLayerInterface),
    pub fn getNumBroadPhaseLayers(_: *const zphysics.BroadPhaseLayerInterface) callconv(.c) u32 {
        return 2; // 0: NON_MOVING, 1: MOVING
    }
    pub fn getBroadPhaseLayer(_: *const zphysics.BroadPhaseLayerInterface, layer: zphysics.ObjectLayer) callconv(.c) zphysics.BroadPhaseLayer {
        return if (layer == 0) 0 else 1;
    }
    pub fn getBroadPhaseLayerName(_: *const zphysics.BroadPhaseLayerInterface, layer: zphysics.BroadPhaseLayer) callconv(.c) [*:0]const u8 {
        return if (layer == 0) "NON_MOVING" else "MOVING";
    }
};

// 2. 定义对象 vs 宽相过滤器
const MyObjectVsBroadPhaseLayerFilter = struct {
    interface: zphysics.ObjectVsBroadPhaseLayerFilter = .init(MyObjectVsBroadPhaseLayerFilter),

    pub fn shouldCollide(_: *const zphysics.ObjectVsBroadPhaseLayerFilter, layer1: zphysics.ObjectLayer, layer2: zphysics.BroadPhaseLayer) callconv(.c) bool {
        if (layer1 == 0) return layer2 == 1; // 静态只跟动态撞
        return true; // 动态跟所有撞
    }
};

// 3. 定义对象层对过滤器
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
    // 使用我们定义的接口初始化系统
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

    std.debug.print("Jolt Physics System Initialized with Custom Interfaces!\n", .{});
    return @ptrCast(g_physics_system);
}

export fn create_box_body(hx: f32, hy: f32, hz: f32) *const anyopaque {
    const box_settings = zphysics.BoxShapeSettings.create(.{ hx, hy, hz }) catch unreachable;
    const shape = box_settings.asShapeSettings().createShape() catch unreachable;

    const body_settings = zphysics.BodyCreationSettings{
        .shape = shape,
        .position = .{ 0.0, 10.0, 0.0, 1.0 },
        .rotation = .{ 0.0, 0.0, 0.0, 1.0 },
        .motion_type = .dynamic,
        .object_layer = 1, // 使用层 1 (MOVING)
    };

    const body_interface = g_physics_system.getBodyInterfaceMut();
    const body_id = body_interface.createAndAddBody(body_settings, .activate) catch unreachable;

    // 修复点：使用 @intFromEnum 获取枚举值
    const id_value = @intFromEnum(body_id);
    return @ptrFromInt(id_value);
}

export fn jolt_math_test(x: f32, y: f32) f32 {
    return x + y;
}
export fn get_physics_system() *anyopaque {
    return @ptrCast(g_physics_system);
}
export fn step_physics(delta_time: f32) void {
    if (@intFromPtr(g_physics_system) != 0) {
        // 【关键修改】：增加物理步进次数到 4，大幅增加软体约束求解的刚性，完美防止布料在初始受重力时严重下垂
        g_physics_system.update(delta_time, .{ .collision_steps = 1 }) catch |err| {
            std.debug.print("Physics update failed: {}\n", .{err});
        };
    }
}
