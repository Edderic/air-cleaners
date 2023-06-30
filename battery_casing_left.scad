use <screw_with_nut.scad>
use <top_screws_with_nuts.scad>
use <shoulder_strap_support_screws.scad>
use <battery_door.scad>

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

  // hole for fan wiring
  translate([fan_radius * 2 + 2 * depth + oset - 10, 80, -depth]) {
    color([0,0,1]) cube([10, 10, 20]);
  }

  // hex nuts at the bottom
  translate([0, 70, -132]) {
    rotate([90,0,0]) top_screws_with_nuts();
  }

  // hex nuts at the bottom left
  translate([-100, 70, -132]) {
    rotate([90,0,0]) top_screws_with_nuts();
  }

  // hex nuts at the top for c-clamp
  translate([0, 5, 179]) {
    rotate([-90,0,0]) top_screws_with_nuts();
  }

  // screws for shoulder strap ring
  translate([0,50,53]) {
    rotate([-90,0,0]) rotate([0,90,0]) shoulder_strap_support_screws();
  }

  // space for the door handle
  translate([-2, 0, 18]) {
    cube([10, depth, 10]);
  }

  // battery door
  translate([8,0, battery_height + depth + 1.5]) {
    rotate([0, 180, 0]) battery_door();
  }
}

module battery_casing_left() {
  difference() {
    cube([(fan_radius * 2 + depth * 2+ oset), 100, battery_height + 2 * 3 + oset]);
    removables();
  }
}

battery_casing_left();


// removables();
  // hex nuts at the bottom left

