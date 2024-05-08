const std = @import("std");
const SimpleLib = @import("SimpleLib");

pub fn main() !void {
    const simple_lib = SimpleLib{};
    const message = simple_lib.getStuff();
    std.debug.print("Message: {}\n", .{message});
}