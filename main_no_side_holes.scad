use <filler.scad>;
use <fan.scad>;
use <louver.scad>
use <louvers.scad>
use <smoothed_cube.scad>

$fn = 100;

module main_no_side_holes(
  depth=5,
  filter_x=110,
  filter_y=116,
  fan_radius=60,
  top_z=60,
  screw_radius=2.5,
  screw_radius_holder=2.5,
  louver_holder=false,
  num_fans = 1,
  num_rows=1,
  num_cols=2,
  side_offset=0,
  radius_3=0,
  radius_7=0,
  edge_1_2_radius=0,
  edge_2_3_radius=0,
  edge_3_7_radius=0,
  edge_6_7_radius=0,
  edge_7_8_radius=0
) {
  distance_to_middle_of_circle_x = 62 / 70 * fan_radius;
  distance_to_middle_of_circle_y = distance_to_middle_of_circle_x;
  // Take the number of filters (rows and columns) into account
  depth_multiplier = num_fans == 2 ? 4 : 2;

  larger_x = num_fans > num_cols ? num_fans : num_cols;
  larger_y = num_fans > num_rows ? num_fans : num_rows;
  multiplier = num_rows == 2 ? filter_x : fan_radius;
  multiplier_x = num_cols == 2 ? filter_x : fan_radius * 2;
  back_x = larger_x * multiplier_x + depth * depth_multiplier + 1;
  back_y =  2 * multiplier + depth * depth_multiplier + 1;

  if (!louver_holder) {
    if (num_fans == 1) {
      // the back
      difference() {
        smoothed_cube(
            x=back_x,
            y=back_y,
            z=top_z,
            radius_3=radius_3,
            edge_1_2_radius=edge_1_2_radius,
            edge_3_7_radius=edge_3_7_radius,
            edge_2_3_radius=edge_2_3_radius,
            edge_3_4_radius=depth,
            edge_7_8_radius=edge_7_8_radius,
            edge_6_7_radius=edge_6_7_radius,
            radius_7=radius_7
        );
        union() {
          // centered in the middle
          translate([back_x / 2 , back_y / 2 , 0]) {
            fan(fan_radius, depth, distance_to_middle_of_circle_x, distance_to_middle_of_circle_y, screw_radius);
          }
          // add space
          translate([depth, depth, depth]) {
            cube([back_x - 2 * depth, back_y - 2 * depth, top_z - depth]);
          }
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
}

main_no_side_holes();
