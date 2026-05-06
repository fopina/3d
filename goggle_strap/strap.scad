// Replacement sliding clip/buckle for an existing swimming-goggle rubber strap.
// Print in PETG/ABS/ASA for springiness and water resistance.

$fn = 48;

STRAP_WIDTH = 17.5;
STRAP_THICKNESS = 2.4;
CLEARANCE = 0.7;

SLOT_LENGTH = 10.5;
SLOT_WIDTH = STRAP_WIDTH + CLEARANCE;
SLOT_RADIUS = 1.5;

CENTER_BAR_WIDTH = 4.2;
END_RAIL_WIDTH = 4.6;
SLOT_SPACING = SLOT_LENGTH + CENTER_BAR_WIDTH;

CLIP_LENGTH = 2 * SLOT_LENGTH + CENTER_BAR_WIDTH + 2 * END_RAIL_WIDTH;
CLIP_WIDTH = STRAP_WIDTH + 8;
CLIP_THICKNESS = 4.2;
CORNER_RADIUS = 3;

SIDE_RELIEF_DEPTH = 1.2;
SIDE_RELIEF_LENGTH = 18;

module rounded_rect(size, radius) {
    x = size[0];
    y = size[1];

    hull() {
        for (px = [-x / 2 + radius, x / 2 - radius])
            for (py = [-y / 2 + radius, y / 2 - radius])
                translate([px, py])
                    circle(r = radius);
    }
}

module rounded_box(size, radius) {
    linear_extrude(size[2])
        rounded_rect([size[0], size[1]], radius);
}

module strap_slot(xpos) {
    translate([xpos, 0, -0.1])
        linear_extrude(CLIP_THICKNESS + 0.2)
            rounded_rect([SLOT_LENGTH, SLOT_WIDTH], SLOT_RADIUS);
}

module side_relief(ypos) {
    translate([0, ypos, CLIP_THICKNESS - SIDE_RELIEF_DEPTH])
        linear_extrude(SIDE_RELIEF_DEPTH + 0.1)
            rounded_rect([SIDE_RELIEF_LENGTH, 2.4], 1.2);
}

module underside_bevel() {
    bevel = 1.1;

    for (y = [-CLIP_WIDTH / 2, CLIP_WIDTH / 2])
        translate([0, y, -0.1])
            rotate([0, 0, 0])
                linear_extrude(bevel + 0.1)
                    polygon([
                        [-CLIP_LENGTH / 2, 0],
                        [CLIP_LENGTH / 2, 0],
                        [CLIP_LENGTH / 2 - bevel, -sign(y) * bevel],
                        [-CLIP_LENGTH / 2 + bevel, -sign(y) * bevel]
                    ]);
}

module clip() {
    difference() {
        rounded_box([CLIP_LENGTH, CLIP_WIDTH, CLIP_THICKNESS], CORNER_RADIUS);

        strap_slot(-SLOT_SPACING / 2);
        strap_slot(SLOT_SPACING / 2);

        side_relief(-CLIP_WIDTH / 2 + 2.2);
        side_relief(CLIP_WIDTH / 2 - 2.2);

        underside_bevel();
    }
}

clip();
