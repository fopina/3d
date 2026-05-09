// https://economy-finance.ec.europa.eu/euro/euro-coins-and-notes/euro-coins/common-sides-euro-coins_en

// Letter left
LL = "X";
// ...right
LR = "X";
// ... middle (low)
LM = "X";
// ... top (small)
LT = "X";

COIN_D = 24.25;
COIN_H = 2.38;
// key ring hole
HOLE_D = 5;
// key ring hole wall
TOP_S = 1;

// circle resolution
FN = 50;

module unused_test() {
    translate([0,4,0])
        linear_extrude(5)
            text(LR);
    translate([2,-5,0])
        linear_extrude(5)
            text(LL);
    translate([5,0,0])
        linear_extrude(7)
            text(LM);
    translate([-5,0,0])
        linear_extrude(7)
            text(LT);
}

module coin() {
   difference() {
    linear_extrude(COIN_H)
        circle(d=COIN_D, $fn=FN);
    translate([0,COIN_D/2-HOLE_D/2-TOP_S,-1])
        linear_extrude(5)
            circle(d=HOLE_D, $fn=FN);
    translate([0,0,COIN_H-TOP_S])
        linear_extrude(COIN_H)
            circle(d=COIN_D-TOP_S, $fn=FN);
    }
}

union() {
    coin();
    linear_extrude(COIN_H) scale([0.8,0.8,0.8]){
        translate([3,-5,0])
            text(LR);
        translate([-13,-5,0])
            text(LL);
        translate([-4,-13,0])
            text(LM);
        translate([-3,-1,0]) scale([0.7,0.7,0.7])
            text(LT);
    }
}
