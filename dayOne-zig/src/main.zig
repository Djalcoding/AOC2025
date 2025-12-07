const aoc2026 = @import("aoc2026");
const dayTwo = @import("dayTwo/dayTwo.zig");
const std = @import("std");

pub fn main() !void {
    std.debug.print("{d}",  .{try dayTwo.solve()});
}
