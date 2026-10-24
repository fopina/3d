block_width = 12;
block_depth = 8;
block_height = 5;
corner_radius = 1;
$fn = 32;

module rounded_cube(size, radius) {
    translate([radius, radius, radius]) {
        minkowski() {
            cube([
                size[0] - (2 * radius),
                size[1] - (2 * radius),
                size[2] - (2 * radius)
            ]);
            sphere(r = radius);
        }
    }
}

rounded_cube([block_width, block_depth, block_height], corner_radius);
