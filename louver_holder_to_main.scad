use <hex_nut.scad>
use <screw.scad>

filter_x = 110;
filter_z = 44;
top_z = 15;

difference() {

  difference() {
    difference() {
      difference() {
        cube([filter_x * 2, 3, 3 * top_z]);
        translate([filter_x, 0, top_z / 2]) {
          rotate([-90,0,0]) color([1,0,0]) hex_nut();
        }
      }
      translate([filter_x, 0, top_z + top_z / 2]) {
        rotate([-90,0,0]) color([1,0,0]) hex_nut();
      }
    }
    translate([filter_x, 10, top_z / 2]) {
      rotate([90,0,0]) screw(
          screw_head_radius=3,
          screw_head_height=3,
          threaded_radius=1.5,
          threaded_height=10
          );
    }
  }

  translate([filter_x, 10, top_z + top_z / 2]) {
    rotate([90,0,0]) screw(
        screw_head_radius=3,
        screw_head_height=3,
        threaded_radius=1.5,
        threaded_height=10
    );
  }
}

