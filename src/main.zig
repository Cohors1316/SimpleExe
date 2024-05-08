const std = @import("std");
const SimpleFile = @import("SimpleFile");

pub fn main() !void {
    var simple_obj = SimpleFile{};
    const message = simple_obj.getStuff();
    std.debug.print("Message: {s}\n", .{message});
}

test "Testing test" {
    var sl = SimpleFile{};
    std.testing.expectEqualStrings("Hello, World!", sl.getstuff());
}