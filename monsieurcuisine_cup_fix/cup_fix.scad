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
sleeve_wall = 0.8;
sleeve_clearance = 0.1;
sleeve_height = 4;
sleeve_overlap = 1.2;
sleeve_extra_width = 4;
sleeve_extra_thickness = 2;

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

module trim_cutter(
    height = trim_cut_height,
    thickness = trim_cut_thickness,
    local_y = 0
) {
    translate([0, trim_center_height, -1]) {
        rotate([0, 0, trim_angle]) {
            translate([0, local_y, 0]) {
                polygon_leg(
                    bottom_width = trim_line_width,
                    top_width = trim_line_width,
                    height = height,
                    thickness = thickness
                );
            }
        }
    }
}

module broken_leg() {
    difference() {
        polygon_leg();
        trim_cutter();
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
    outer_width = leg_top_width + extra_width + (2 * (wall + clearance));
    inner_width = leg_top_width + extra_width + (2 * clearance);
    outer_thickness = leg_thickness + extra_thickness + (2 * (wall + clearance));
    inner_thickness = leg_thickness + extra_thickness + (2 * clearance);
    inner_z = -(extra_thickness / 2) - clearance;
    outer_z = inner_z - wall;

    difference() {
        translate([0, trim_center_height, outer_z]) {
            rotate([0, 0, trim_angle]) {
                translate([-outer_width / 2, -overlap, 0]) {
                    cube([outer_width, height + overlap, outer_thickness]);
                }
            }
        }

        translate([0, trim_center_height, inner_z]) {
            rotate([0, 0, trim_angle]) {
                translate([-inner_width / 2, 0, 0]) {
                    cube([inner_width, height, inner_thickness]);
                }
            }
        }
    }
}

union() {
    broken_leg();
    top_sleeve();
}
