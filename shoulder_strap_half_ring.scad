use <screw_with_nut.scad>
use <smoothed_cube.scad>
use <shoulder_strap_support_screws.scad>

$fn = 200;

module screwable() {
    smoothed_cube(
      x=13,
      y=5,
      z=10,

      radius_1=2,
      radius_2=2,
      edge_1_2_radius=2,
      edge_2_6_radius=2,
      edge_1_5_radius=2,
      edge_4_1_radius=2,
      edge_2_3_radius=2,
      edge_3_4_radius=2,
      edge_3_7_radius=2,
      edge_4_8_radius=2,
      radius_3=2,
      radius_4=2
      // edge_4_1_radius=2,
    );
}

module to_remove(r) {
  cylinder(h=10, r=r-4);
  translate([-8,0,0]) {
    cube([16, 100, 100]);
  }
  translate([-25,5,0]) {
    cube([50, 50, 50]);
  }
}


module half_ring_without_holes(r=25.4) {
  difference() {
    // translate([0,2,5]) {
      // rotate([180,0,0])
        // rotate_extrude(convexity = 10, angle=180)
        // translate([10, 0, 0])
        // circle(r = 2, $fn = 100);

    // }
    translate([0,1,2]) {
      cylinder(h=6, r=r);
    }
    to_remove(r);

  }

  // left side support
  translate([8,0,0]) {
    screwable();
  }

  // right side support
  translate([-8,0,10]) {
    rotate([0,180,0])
    screwable();
  }
}

module shoulder_strap_half_ring(screws_only=false) {
  if (screws_only) {
    shoulder_strap_support_screws(wideness=16);
  } else {
    difference() {
      half_ring_without_holes(r=12);
      shoulder_strap_support_screws(wideness=16);
    }
  }
}


shoulder_strap_half_ring();


// to_remove();
