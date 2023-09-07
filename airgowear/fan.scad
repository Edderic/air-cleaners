$fn=100;
module fan_hole(depth=5, padding_radius=0) {

  color([0,1,1])
    rotate([90,0,0])
    cylinder(h=depth, r=40 + padding_radius);
}

module exhaust(depth=2, height=10) {
  difference() {
    cube([60,33,height]);

    translate([depth,depth,0]) {
      cube([60 - depth * 2,33 - depth * 2,height]);
    }
  }
}
module fan() {
  cube([120, 33, 120]);

  translate([0,0, 120]) {
    cube([60,33,10]);
  }
  translate([65,38,60]) {
    color([1,0,0])
    fan_hole();
  }
}

fan();


