use <screw_with_nut.scad>
use <top_screws_with_nuts.scad>
use <shoulder_strap_support_screws.scad>
use <battery_door.scad>
use <noctua_speed_controller.scad>

depth = 5;
fan_radius = 60;
oset = 1;
battery_height = 30 + 5 * 2 ;



module removables() {
  // space for battery
  translate([0, 5, 3]) {
    color([1, 0, 0]) cube([(fan_radius * 2 + depth * 2+ oset), 100 - depth-2, battery_height + oset]);
  }

  // hole for fan wiring
  translate([10 , 80, -depth]) {
    color([0,0,1]) cube([20, 10, 20]);
  }

  // hex nuts at the bottom right
  translate([-10, 70, -132]) {
    rotate([90,0,0]) top_screws_with_nuts();
  }

  // hex nuts at the bottom left
  translate([-100, 70, -132]) {
    rotate([90,0,0]) top_screws_with_nuts();
  }

  // hex nuts at the top for c-clamp, right
  translate([-43, 5, 179]) {
    rotate([-90,0,0]) top_screws_with_nuts();
  }

  // hex nuts at the top for c-clamp, left
  translate([-65, 5, 179]) {
    rotate([-90,0,0]) top_screws_with_nuts();
  }

  // screws for shoulder strap ring left
  translate([0,50,53]) {
    rotate([-90,0,0]) rotate([0,90,0]) shoulder_strap_support_screws();
  }

  // screws for shoulder strap ring right
  translate([fan_radius * 2 + 1,52,53]) {
    rotate([-90,0,0]) rotate([0,90,0]) shoulder_strap_support_screws();
  }

  // space for the door handle, left
  translate([-2, 0, 18]) {
    cube([10, depth, 10]);
  }

  // space for the other door handle, right
  translate([fan_radius * 2 + depth / 2, 0, 18.5]) {
    cube([10, depth, 10]);
  }

  // battery door left
  translate([8,2, battery_height + depth + 1.5]) {
    rotate([0, 180, 0]) battery_door();
  }

  // battery door right
  translate([123,2, 0]) {
    rotate([0, 0, 0]) battery_door();
  }

  // noctua speed controller screw, bottom
  translate([fan_radius + depth, 0, depth + depth / 4]) {
    color([0,1,0]) rotate([-90,0,0]) screw_with_nut();
  }

  // noctua speed controller screw, bottom
  translate([fan_radius + depth, 0, battery_height + depth / 4]) {
    color([1,0,0]) rotate([-90,0,0]) screw_with_nut();
  }

  // hole for noctua speed controller
  translate([fan_radius - depth - 3 ,15,12]) {
    color([1,0,0]) rotate([90,0,0]) noctua_speed_controller();
  }



}

module one_filter_one_fan_battery_casing() {
  difference() {
    cube([(fan_radius * 2 + depth * 2+ oset), 100, battery_height + 2 * 3 + oset]);
    removables();
  }
}

one_filter_one_fan_battery_casing();

// removables();
  // hex nuts at the bottom left

  // battery door left

  // translate([fan_radius * 2 + depth / 2, 0, 19]) {
    // color([0,1,0]) cube([10, depth, 10]);
  // }
