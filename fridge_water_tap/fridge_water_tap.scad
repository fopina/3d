// Removable tap lever: the piece shown on the LEFT in original.png.
// Units: millimeters. Z is up; +Y faces the user when installed.

$fn = 96;

// Measured from the user's description.
fit_hole_diameter = 7;
fit_flat_length = 5;
fit_flat_offset = sqrt(pow(fit_hole_diameter / 2, 2) - pow(fit_flat_length / 2, 2));
fit_flat_angle = 90; // degrees: 0 = top; positive rotates toward +X when viewed from the front
fit_clearance = 0.4; // per side; adjust to suit the printer/material
fit_demo_mode = false; // true prints only the small fit coupon
fit_demo_side = 12;
fit_demo_thickness = 3;

// Approximate outer dimensions from the photo; refine after measuring the part.
cup_diameter = 30;
cup_depth = 12;
cup_wall = 2.5;
drive_cut_extension = 5; // length beyond the round hole
lever_length = 50;
lever_width = 12;
lever_thickness = 8;

module d_profile_2d() {
    // Nominal 7 mm round profile with a 5 mm straight flat edge.
    rotate(-fit_flat_angle) {
        intersection() {
            circle(d = fit_hole_diameter);
            translate([-fit_hole_diameter / 2, -fit_hole_diameter / 2])
                square([fit_hole_diameter,
                        fit_flat_offset + fit_hole_diameter / 2]);
        }
    }
}

module d_profile_hole() {
    // Offset the full D outline for print-in clearance, preserving its shape.
    rotate([90, 0, 0])
        linear_extrude(height = cup_depth + 0.2, center = true)
            offset(delta = fit_clearance)
                d_profile_2d();
}

module fit_demo_coupon() {
    // A small square coupon with the same D-profile, printed hole-axis-up for speed.
    difference() {
        cube([fit_demo_side, fit_demo_side, fit_demo_thickness], center = true);

        translate([0, 0, -0.1])
            linear_extrude(height = fit_demo_thickness + 0.2)
                offset(delta = fit_clearance)
                    d_profile_2d();
    }
}

module removable_tap_lever() {
    difference() {
        union() {
            // Cup-shaped round head; recess opens toward the user (+Y).
            difference() {
                rotate([90, 0, 0])
                    cylinder(h = cup_depth, d = cup_diameter, center = true);

                translate([0, cup_wall / 2 + 0.05, 0])
                    rotate([90, 0, 0])
                        cylinder(h = cup_depth - cup_wall + 0.1,
                                 d = cup_diameter - 2 * cup_wall,
                                 center = true);
            }

            // Handle hangs below the round head, as in the photo.
            translate([0, 0, -cup_diameter / 2 + 1])
                hull() {
                    translate([0, 0, lever_length / 2 - lever_width / 2])
                        cube([lever_width, lever_thickness, 0.1], center = true);
                    translate([0, 0, -lever_length / 2 + lever_width / 2])
                        cube([lever_width, lever_thickness, 0.1], center = true);
                }
        }

        d_profile_hole();
    }
}

if (fit_demo_mode)
    fit_demo_coupon();
else
    removable_tap_lever();
