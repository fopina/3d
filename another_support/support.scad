// plunger diameter
PD = 18;
// plunger height (out of syringe)
PH = 19;

// barrel holder height, diameters (center and edges) and width
BHH = 2;
BHD1 = 20;
BHD2 = 17;
BHW = 30;

// base size and height
BS = 120;
BH = 50;

// hole positions
BHX = 16;
BHY = 20;
THY = 22;


use <../_common/MCAD/2Dshapes.scad>

module base() {
    linear_extrude(BH)
        circle(d=BS, $fn=3);
}

module hole() {
    union() {
        translate([-BHW/2,-BHD1/2,PH-0.1])
            cube([BHW, BHD1, BHH]);
        cylinder(h=PH, d=PD);
    }
}

difference() {
    base();
    translate([0,0,BH-PH-BHH+0.2]) {
        rotate([0,0,90]) {
            translate([BHY,BHX,0]) hole();
            translate([-BHY,BHX,0]) hole();
        }
        translate([THY,0,0]) hole();
    }
}