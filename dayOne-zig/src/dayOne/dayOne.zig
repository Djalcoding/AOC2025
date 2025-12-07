const std = @import("std");
const fs = std.fs;

pub fn solve() !u32 {
    const file = try fs.cwd().openFile("file.txt", .{});
    defer file.close();

    var file_buffer: [1 << 16]u8 = undefined;
    var reader = file.reader(&file_buffer);
    var dial_pos: i32 = 50;
    var ans: u32 = 0;

    while (try reader.interface.takeDelimiter('\n')) |line| {
        if (line.len == 0) {
            continue;
        }
        var sign: i32 = -1;
        if (line[0] == 'R') {
            sign = 1;
        }
        var number: i32 = 0;
        for (line[1..]) |num| {
            number *= 10;
            number += num - '0';
        }
        while (number > 0) {
            number-=1;
            dial_pos += sign;
            if (@mod(dial_pos,100) == 0) {
                ans+=1;
            }
        }
        dial_pos = @mod(dial_pos, 100);
    }
    return ans;
}
