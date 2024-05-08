const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const module = b.addModule("SimpleExe", .{
        .root_source_file = .{ .path = "src/main.zig"},
        .target = target,
        .optimize = optimize,
    });
    module.addImport("SimpleLib", b.dependency("simple_lib", .{
        .target = target,
        .optimize = optimize,
    }).module("SimpleLib"));
    const exe = b.addExecutable(.{
        .name = "examples",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    exe.root_module.addImport("SimpleLib", module);
    b.installArtifact(exe);
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}