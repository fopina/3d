// Parametric vertical laptop stand, dimensions in mm and angles in degrees.
// Inspired by tacaa: https://www.thingiverse.com/thing:6851927
// This design is licensed CC BY-SA 4.0; see README.md.

/* [Laptop fit] */
// Vertical height covered above the supporting floor (not sloping wing length).
height = 45; // [10:1:120]
// Clear gap: at the floor in apart mode; perpendicular to wings in parallel mode.
// 19 for MBP M4 16" - 22 for Acer A515 - 17 for MBP 2017 16"
width = 17; // [5:0.5:50]
// Stand size along the laptop's bottom edge.
length = 70; // [20:1:250]

/* [Support] */
// Horizontal foot extension beyond the complete wing envelope, on each side.
foot_width = 20; // [0:1:80]
// Apart = symmetric outward flare; parallel = both wings lean together.
wing_mode = "apart"; // [apart, parallel]
// Angle to desk: 90 = upright. Apart: 60-90; parallel: 60-120.
inclination = 90; // [60:1:120]
// Thickness measured perpendicular to each wing.
wing_thickness = 5; // [2:0.5:12]
// Thickness of the flat supporting floor.
base_thickness = 5; // [2:0.5:12]

/* [Hidden] */
assert(height > 0, "height must be positive");
assert(width > 0, "width must be positive");
assert(length > 0, "length must be positive");
assert(foot_width >= 0, "foot_width must be non-negative");
assert(inclination >= 60 && inclination <= 120,
       "inclination must be between 60 and 120 degrees");
assert(wing_mode == "apart" || wing_mode == "parallel", "unknown wing_mode");
assert(wing_mode != "apart" || inclination <= 90,
       "apart mode requires inclination between 60 and 90 degrees");
assert(wing_thickness > 0, "wing_thickness must be positive");
assert(base_thickness > 0, "base_thickness must be positive");

// Apart mode preserves the narrowest (floor) gap; parallel preserves normal gap.
gap_x = wing_mode == "apart" ? width : width / sin(inclination);
wall_x = wing_thickness / sin(inclination);
shift_x = height * cos(inclination) / sin(inclination);
left_shift = wing_mode == "apart" ? -shift_x : shift_x;
right_shift = shift_x;
outer_x = gap_x / 2 + wall_x;
base_left = -outer_x + min(0, left_shift) - foot_width;
base_right = outer_x + max(0, right_shift) + foot_width;

// A single 2D outline avoids coincident seams between the wings and floor.
// Profile coordinates are [across laptop thickness, vertical height].
module stand_profile() {
    polygon([
        [base_left, 0],
        [base_right, 0],
        [base_right, base_thickness],
        [outer_x, base_thickness],
        [outer_x + right_shift, base_thickness + height],
        [gap_x / 2 + right_shift, base_thickness + height],
        [gap_x / 2, base_thickness],
        [-gap_x / 2, base_thickness],
        [-gap_x / 2 + left_shift, base_thickness + height],
        [-outer_x + left_shift, base_thickness + height],
        [-outer_x, base_thickness],
        [base_left, base_thickness]
    ]);
}

// X = across slot, Y = along laptop, Z = up. Flat base sits at Z = 0.
rotate([90, 0, 0])
    linear_extrude(height = length, center = true, convexity = 4)
        stand_profile();
