const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const simple_dependency = b.dependency("simple_lib", .{
        .target = target,
        .optimize = optimize,
    });

    const simple_module = simple_dependency.module("SimpleFile");

    // const simple_module = b.dependency("simple_lib", .{
    //     .target = target,
    //     .optimize = optimize,
    // }).module("SimpleFile");

    const exe = b.addExecutable(.{
        .name = "examples",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    exe.root_module.addImport("SimpleFile", simple_module);
    b.installArtifact(exe);
}
