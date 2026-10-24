leg_bottom_width = 5;
leg_top_width = 6;
leg_height = 8;
leg_thickness = 2;

sleeve_wall = 0.8;
sleeve_clearance = 0.1;
sleeve_height = 2;
sleeve_overlap = 1.2;
sleeve_extra_width = 1.5;
sleeve_extra_thickness = 3;

module polygon_leg(
    bottom_width = leg_bottom_width,
    top_width = leg_top_width,
    height = leg_height,
    thickness = leg_thickness
) {
    linear_extrude(height = thickness) {
        polygon(points = [
            [-bottom_width / 2, 0],
            [bottom_width / 2, 0],
            [top_width / 2, height],
            [-top_width / 2, height]
        ]);
    }
}

module top_sleeve(
    wall = sleeve_wall,
    clearance = sleeve_clearance,
    height = sleeve_height,
    overlap = sleeve_overlap,
    extra_width = sleeve_extra_width,
    extra_thickness = sleeve_extra_thickness
) {
    inner_width = leg_top_width + extra_width + (2 * clearance);
    outer_width = inner_width + (2 * wall);
    inner_thickness = leg_thickness + extra_thickness + (2 * clearance);
    outer_thickness = inner_thickness + (2 * wall);
    inner_z = (leg_thickness - inner_thickness) / 2;
    outer_z = (leg_thickness - outer_thickness) / 2;

    difference() {
        translate([-outer_width / 2, leg_height - overlap, outer_z]) {
            cube([outer_width, height + overlap, outer_thickness]);
        }

        translate([-inner_width / 2, leg_height, inner_z]) {
            cube([inner_width, height, inner_thickness]);
        }
    }
}

union() {
    polygon_leg();
    top_sleeve();
}
