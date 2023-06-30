use <screw_with_nut.scad>
use <top_screws_with_nuts.scad>
use <battery_door.scad>
use <shoulder_strap_support_screws.scad>

$fn = 100;

depth = 5;
fan_radius = 60;
oset = 1;
battery_height = 30 + 5 * 2 ;



module removables() {
  // space for battery
  translate([0, 3, 3]) {
    color([1, 0, 0]) cube([(fan_radius * 2 + depth * 2+ oset), 100 - depth - 1, battery_height + oset]);
  }

  // hole for controller wiring
  translate([(fan_radius * 2 + oset) - 25, depth * 2, battery_height / 2 + 4]) {
    rotate([90,0,0]) color([0, 1, 0]) cylinder(r=10, h=20);
  }

  // speed controller nut top
  translate([(fan_radius * 2 + oset), -10, battery_height + 1]) {
    rotate([-90, 0, 0]) screw_with_nut();
  }

  // speed controller nut bottom
  translate([(fan_radius * 2 + oset), -10, depth + 1]) {
    rotate([-90, 0, 0]) screw_with_nut();
  }

  // hex nuts at the bottom left
  translate([0, 70, -132]) {
    rotate([90,0,0]) top_screws_with_nuts();
  }

  // hex nuts at the bottom right
  translate([-100,5,179]) {
    rotate([-90,0,0]) top_screws_with_nuts();
  }


  // hex nuts at the top for c-clamp
  translate([0, 5, 179]) {
    rotate([-90,0,0]) top_screws_with_nuts();
  }

  // space for the door handle
  translate([-2, 0, 18]) {
    cube([10, depth, 10]);
  }

  // screws for shoulder strap ring
  translate([0,50,-6]) {
    color([0,1,0]) rotate([90,0,0]) rotate([0,90,0]) shoulder_strap_support_screws();
  }

  // joint
  translate([5,100 - 8,1.5]) {
    cylinder(h=battery_height + 4, r=3);
  }
}

module battery_casing_right() {
  difference() {
    cube([(fan_radius * 2 + depth * 2+ oset), 100, battery_height + 2 * 3 + oset]);
    removables();
  }
}

battery_casing_right();

