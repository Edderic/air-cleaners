use <screw_with_nut.scad>
use <shoulder_strap_support_screws.scad>

$fn = 100;

module to_remove() {
  cylinder(h=10, r=20);
  translate([-50,0,0]) {
    cube([100, 100, 100]);
  }
}

module half_ring_without_holes() {
  difference() {
    cylinder(h=10, r=25.4);
    to_remove();
  }

  // left side support
  translate([20,0,0]) {
    cube([15,5,10]);
  }

  // right side support
  translate([-35,0,0]) {
    cube([15,5,10]);
  }
}

difference() {

  half_ring_without_holes();
  shoulder_strap_support_screws();
}


// to_remove();
