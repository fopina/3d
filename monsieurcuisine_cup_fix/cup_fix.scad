leg_bottom_width = 5;
leg_top_width = 6;
leg_height = 12;
leg_thickness = 2;

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

polygon_leg();
