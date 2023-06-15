use <filler.scad>;
use <fan.scad>;
use <louver.scad>
use <louvers.scad>

$fn = 100;

module p1(depth=5, filter_x=110, filter_y=116, fan_radius=60, top_z=60, screw_radius=2.5, screw_radius_holder=2.5, louver_holder=false, num_fans = 1, num_rows=1, num_cols=2) {
  distance_to_middle_of_circle_x = 62 / 70 * fan_radius;
  distance_to_middle_of_circle_y = distance_to_middle_of_circle_x;
  // Take the number of filters (rows and columns) into account
  depth_multiplier = num_fans == 2 ? 4 : 2;

  back_x = num_fans * 2 * fan_radius + depth * depth_multiplier + 1;
  back_y = num_rows * 2 * fan_radius + depth * depth_multiplier + 1;

  if (louver_holder) {
    // no back
  }

  if (!louver_holder) {
    if (num_fans == 1) {
      // the back
      difference() {
        cube([back_x, back_y, depth]);

        // centered in the middle
        translate([back_x / 2 , back_y / 2 , 0]) {
          fan(fan_radius, depth, distance_to_middle_of_circle_x, distance_to_middle_of_circle_y, screw_radius);
        }
      }
    }
    if (num_fans == 2) {
      // the back
      difference() {
        difference() {
          cube([back_x, back_y, depth]);

          // left
          translate([back_x / 4 , back_y / 2 , 0]) {
            fan(fan_radius, depth, distance_to_middle_of_circle_x, distance_to_middle_of_circle_y, screw_radius);
          }
        }

        // right
        translate([back_x * 3 / 4 , back_y / 2 , 0]) {
          fan(fan_radius, depth, distance_to_middle_of_circle_x, distance_to_middle_of_circle_y, screw_radius);
        }
      }
    }
  }

  // the top
  if (louver_holder) {
      cube([back_x, depth, top_z]);
  }
  else {
    difference() {
      cube([back_x, depth, top_z]);
      // hole 1 for c-clamp
      translate([back_x / 2, depth, top_z - 13]) {
        rotate([90, 0, 0]) linear_extrude(height=depth) circle(screw_radius_holder);
      }

      // hole 2 for c-clamp
      translate([back_x / 2, depth, top_z - 13 - 12]) {
        rotate([90, 0, 0]) linear_extrude(height=depth) circle(screw_radius_holder);
      }
    }
  }

  // the bottom
  translate([0, back_y - depth, 0]) {
    cube([back_x, depth, top_z]);
  }

  // the left
  cube([depth, back_y, top_z]);

  // the right
  translate([back_x - depth, 0, 0]) {
    cube([depth, back_y, top_z]);
  }
}

p1();
