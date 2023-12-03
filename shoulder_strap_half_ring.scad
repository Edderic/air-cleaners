use <screw_with_nut.scad>
use <smoothed_cube.scad>
use <shoulder_strap_support_screws.scad>

$fn = 200;

function screwable_width() = 5;

module screwable(x=15) {
    smoothed_cube(
      x=x,
      y=screwable_width(),
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

module to_remove(r, remove_radius=4) {
  cylinder(h=10, r=r-remove_radius);
  translate([-8,0,0]) {
    cube([16, 100, 100]);
  }
  translate([-25,5,0]) {
    cube([50, 50, 50]);
  }
}


module half_ring_without_holes(r=25.4, half_ring=true) {
  if (half_ring) {
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
      to_remove(r, remove_radius=6);

    }

  }
  x = 17;
  x_offset = 13;
  // left side support
  translate([x - x_offset,0,0]) {
    screwable(x=x);
  }

  // right side support
  translate([-(x - x_offset),0,10]) {
    rotate([0,180,0])
    screwable(x=x);
  }
}

module shoulder_strap_half_ring(screws_only=false, threaded_height=8, nut_type="hex") {
  if (screws_only) {
    shoulder_strap_support_screws(
      wideness=16,
      threaded_height=threaded_height,
      nut_type=nut_type
    );
  } else {
    difference() {
      half_ring_without_holes(r=12);
      shoulder_strap_support_screws(
          wideness=16,
          threaded_height=threaded_height,
          nut_type=nut_type
      );
    }
  }
}


shoulder_strap_half_ring();


// to_remove();
