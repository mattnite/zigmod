const std = @import("std");
const gpa = std.heap.c_allocator;

const u = @import("index.zig");

//
//

pub const Dep = struct {
    const Self = @This();

    type: u.DepType,
    path: []const u8,

    pub fn clean_path(self: Dep) ![]const u8 {
        var p = self.path;
        p = u.trim_prefix(p, "https://");
        p = u.trim_prefix(p, "https://");
        p = u.trim_suffix(u8, p, ".git");
        p = try std.fmt.allocPrint(gpa, "{}{}{}", .{@tagName(self.type), "/", p});
        return p;
    }
};