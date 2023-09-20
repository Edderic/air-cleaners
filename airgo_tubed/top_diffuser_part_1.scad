use <diffuser.scad>
use <../screw.scad>
use <../shoulder_strap_half_ring.scad>
use <clavicle_screw_holes.scad>

module top_diffuser_part_1(points_1, points_2, diffuser_wall_points_1, diffuser_wall_points_2, height=80) {
  difference() {

    union() {

      top_diffuser_half(points_1=points_1, points_2=points_2, height=height);
      mirror([1,0,0]) translate([0,0,0]) {
        top_diffuser_half(points_1=points_1, points_2=points_2, height=height);
      }
      // center line.
      translate([0,19,46]) {
        cube([1, 47,height - 2], center=true);
      }

      diffuser_wall(
          points_1=diffuser_wall_points_1,
          points_2=diffuser_wall_points_2
      );
    }

    union() {
      translate([0,0,90]) {
        rotate([0,180,0])
          union() {
            left_screw_front();
            right_screw_front();
          }
      }
      left_screw_front();
      right_screw_front();
    }
  }

  difference() {
    difference() {
      filter_box();
      union() {
        translate([0,65,92]) {
          cube([203,46,4], center=true);
        }

        half_ring_left_side(screws_only=true);
        mirror([1,0,0]) half_ring_left_side(screws_only=true);

        left_side_screw();
        mirror([1,0,0]) left_side_screw();

        left_side_screw_bottom();
        mirror([1,0,0]) left_side_screw_bottom();
        // translate([0,-40,0]) {
          // left_side_screw();
        // }
      }
    }
    clavicle_screw_holes();
  }
}

module top_diffuser_half(points_1, points_2, height=80) {
  for (x=[0:1:8]) {
    translate([-x * 0.25,0,0]) {
      scale([1 - x * 0.1,1,1]) {
        linear_extrude(height=height)
          polygon(points=concat(points_1, points_2));
      }
    }
  }
}



// half_ring_left_side(screws_only=true, threaded_height=6);
// mirror([1,0,0]) half_ring_left_side(screws_only=true, threaded_height=6);

module half_ring_left_side(screws_only=false, threaded_height=6, nut_type="hex") {
  translate([-107,85,-6]) {
    rotate([90,0,0])
    rotate([0,0,-90])
      shoulder_strap_half_ring(
          screws_only=screws_only,
          threaded_height=threaded_height,
          nut_type=nut_type
      );
  }
}

module left_side_screw() {
  translate([-106,80,80]) {
    rotate([0,90,0])
      screw(threaded_height=6);
    // left_screw_front();
  }
}

module left_side_screw_bottom() {
  translate([0,-33,0]) {
    left_side_screw();
  }
}

// top_diffuser_part_1(
  // height=90,
  // points_1=get_points_1(),
  // points_2=get_points_2(),
  // diffuser_wall_points_1=get_diffuser_points_1(),
  // diffuser_wall_points_2=get_diffuser_points_2()
// );


// union() {
  // left_screw_front();
  // right_screw_front();
// }

