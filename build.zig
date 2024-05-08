const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const simple_dependency = b.dependency("simple_lib", .{
        .target = target,
        .optimize = optimize,
    });

    const simple_module = simple_dependency.module("SimpleFile");

    const exe = b.addExecutable(.{
        .name = "examples",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    exe.root_module.addImport("SimpleFile", simple_module);
    b.installArtifact(exe);

    const exe_tests = b.addTest(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    const run_exe_tests = b.addRunArtifact(exe_tests);
    const test_step = b.step("name", "run tests");
    test_step.dependOn(&run_exe_tests.step);
}
