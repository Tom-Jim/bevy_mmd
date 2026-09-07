const std = @import("std");
pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const zphysics = b.dependency("zphysics", .{
        .target = target,
        .optimize = optimize,
    });
    const lib_mod = b.createModule(.{
        .root_source_file = b.path("src/api.zig"),
        .target = target,
        .optimize = optimize,
    });
    lib_mod.addImport("zphysics", zphysics.module("root"));
    const lib = b.addLibrary(.{
        .linkage = .static,
        .name = "zig_physics",
        .root_module = lib_mod,
    });
    lib.root_module.addCSourceFile(.{
        .file = b.path("src/jolt_softbody.cpp"),
        .flags = &[_][]const u8{ "-std=c++17", "-DJPH_CROSS_PLATFORM_DETERMINISTIC" },
    });
    lib.root_module.addIncludePath(zphysics.path("libs"));
    lib.root_module.linkLibrary(zphysics.artifact("joltc"));
    lib.root_module.linkSystemLibrary("c", .{});
    lib.root_module.linkSystemLibrary("c++", .{});
    b.installArtifact(lib);
    b.installArtifact(zphysics.artifact("joltc"));
}
