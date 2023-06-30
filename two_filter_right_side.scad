use <main_no_side_holes.scad>
use <screw_with_hex_nut.scad>
use <side_holes.scad>
use <top_screws_with_nuts.scad>

side_offset = 0.75;
depth = 5;
fan_radius = 60;
x = 0;
height = 50;
threaded_height = 6;
// fan_radius * 2
// 2 * depth + fan_radius * 2 - side_offset

module holes_right_side() {
  // hole 1
  translate([-threaded_height-0.5,0,0]) {
    side_holes();
  }
  // top hole 1
  translate([2 * depth - side_offset, fan_radius * 2 + depth, 2 * depth]) {
    rotate([-90,0,0]) color([0,0,1]) screw_with_hex_nut();
  }

  // top hole 2
  translate([2 * depth - side_offset, fan_radius * 2 + depth, height + depth ]) {
    rotate([-90,0,0]) color([0,1,0]) screw_with_hex_nut();
  }
}

module two_filter_right_side() {
  difference() {
    difference() {
      main_no_side_holes(side_offset=side_offset);

      translate([fan_radius * 2 + depth + (depth - side_offset), fan_radius * 2 + depth * 2, 0]) {
        rotate([0,0,180]) holes_right_side();

      }
    }

    translate([-fan_radius * 2 + 4 * depth,130 + 1,65]) {
      rotate([180, 0, 0]) top_screws_with_nuts();
    }
  }
}

two_filter_right_side();
