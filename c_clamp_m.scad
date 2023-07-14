use <top_screws_with_nuts.scad>
use <smoothed_edge.scad>

depth = 5;
$fn = 100;

module c_clamp_m_screws_and_nuts() {
  top_screws_with_nuts();
  translate([22.5, 0, 0]) {
    top_screws_with_nuts();
  }
}

module remove_from_left_cylinder() {
  // bottom half
  translate([-2.5, 0, 0]) {
    color([0, 1, 0]) cube([5,5,64]);
  }

  // top right corner
  translate([0, -2.5, 0]) {
    color([0, 1, 0]) cube([2.5,2.5,64]);
  }
}

module remove_from_right_cylinder() {
  // bottom half
  translate([-2.5, 0, 0]) {
    color([0, 1, 0]) cube([5,5,64]);
  }

  // top right corner
  translate([-2.5, -2.5, 0]) {
    color([0, 1, 0]) cube([2.5,2.5,64]);
  }
}


module c_clamp_m_without_holes() {
  // base
  translate([3,0,0]) {
    color([0,0,1]) cube([30,3, 64]);
  }

  // mid
  translate([14,-5,0]) {
    color([1, 0,0]) cube([8, 5, 64]);
  }

  // top
  translate([14,-7.5,0]) {
    color([0, 0,0]) cube([8, 5, 64]);
  }

  // stopper
  translate([11.5,-5,0]) {
    color([0,1,0]) cube([13,5, 5]);
  }

  // remove from left cylinder
  translate([14, -5, 0]) {
    difference() {
      color([1, 0, 0]) cylinder(h=64, r=2.5);
      remove_from_left_cylinder();
    }
  }

  // remove from right cylinder
  translate([22, -5, 0]) {
    difference() {
      color([1, 0, 0]) cylinder(h=64, r=2.5);
      remove_from_right_cylinder();
    }
  }
// }
}

module c_clamp_m() {
  difference() {
    c_clamp_m_without_holes();
    translate([150, 135, 4]) {
      rotate([0,0,180]) c_clamp_m_screws_and_nuts();
    }
  }

  translate([3,3,0]) {
    smoothed_edge(radius=3);
  }
  translate([33,3,0]) {
    rotate([0,0,90]) smoothed_edge(radius=3);
  }

}



c_clamp_m();

// translate([14,-10,0]) {


