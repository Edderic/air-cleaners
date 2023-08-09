use <top_screws_with_nuts.scad>
use <smoothed_edge.scad>
use <smoothed_cube.scad>

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
  translate([0,0,0]) {
    color([0,0,1]) smoothed_cube(
        x=36,
        y=3,
        z=64,
        radius_1=3,
        radius_2=3,
        radius_3=3,
        radius_4=3,
        edge_1_2_radius=3,
        edge_2_3_radius=3,
        edge_3_4_radius=3,
        edge_4_1_radius=3
    );
  }

  // mid
  translate([14,-3,2]) {
    color([1,0,0]) cube([8, 4, 61]);
  }

  // top
  translate([11.5,-7.5,0]) {
    color([0, 1,0]) smoothed_cube(
        x=13,
        y=5,
        z=64,
        radius_1=5,
        radius_2=5,
        radius_3=5,
        radius_4=5,
        edge_1_2_radius=5,
        edge_2_3_radius=5,
        edge_3_4_radius=5,
        edge_4_1_radius=5
    );
  }

  // stopper
  translate([11.5,-3,0]) {
    color([0,1,0])
      smoothed_cube(
        x=13,
        y=3,
        z=5,
        edge_2_6_radius=5,
        edge_3_7_radius=5
      );
  }
}

module c_clamp_m() {
  difference() {
    c_clamp_m_without_holes();
    translate([150, 135, -4]) {
      rotate([0,0,180]) c_clamp_m_screws_and_nuts();
    }
  }

  // translate([3,3,0]) {
    // smoothed_edge(radius=3);
  // }
  // translate([33,3,0]) {
    // rotate([0,0,90]) smoothed_edge(radius=3);
  // }

}



c_clamp_m();

// translate([14,-10,0]) {


