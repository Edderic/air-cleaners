$fn = 100;
module switch_hole() {
  translate([0,0,-6.5]) {
    color([1,0,0]) cube([5,10,13]);
  }
  rotate([0,90,0]) cylinder(h=5, r=6.5);
  translate([0,10,0]) {
    rotate([0,90,0]) cylinder(h=5, r=6.5);
  }
}

module switch() {
  cube([65,27,15]);
  // switch_hole();
  translate([65 / 2 + 5, 12.5,0]) {
    rotate([0,90,90]) { switch_hole(); }
  }
}

switch();
