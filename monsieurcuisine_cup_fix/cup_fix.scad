leg_bottom_width = 5;
leg_top_width = 6;
leg_height = 12;
leg_thickness = 2;
top_trim_left = 4;
top_trim_right = 3;
trim_margin = 1;
trim_line_width = leg_top_width + (2 * trim_margin);
trim_center_height = leg_height - ((top_trim_left + top_trim_right) / 2);
trim_angle = atan2(top_trim_left - top_trim_right, trim_line_width);
trim_cut_height = leg_height;
trim_cut_thickness = leg_thickness + 2;

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

difference() {
    polygon_leg();

    translate([0, trim_center_height, -1]) {
        rotate([0, 0, trim_angle]) {
            polygon_leg(
                bottom_width = trim_line_width,
                top_width = trim_line_width,
                height = trim_cut_height,
                thickness = trim_cut_thickness
            );
        }
    }
}
