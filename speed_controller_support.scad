use <one_filter_one_fan_battery_casing.scad>
use <noctua_speed_controller.scad>
use <screw_with_nut.scad>

depth = 5;
fan_radius = 60;
battery_height = 30 + 5 * 2 ;
battery_actual_height = 24;

module removables() {
  one_filter_one_fan_battery_casing();
  // hole for noctua speed controller
  translate([fan_radius - depth - 3 ,15,12]) {
    color([0,1,0]) rotate([90,0,0]) noctua_speed_controller();
  }


  // noctua speed controller screw, bottom
  // translate([fan_radius + depth, 0, depth + depth / 4]) {
    // color([0,1,0]) rotate([-90,0,0]) screw_with_nut(threaded_height=6, nut_type="none");
  // }

  // noctua speed controller screw, bottom
  // translate([fan_radius + depth, 0, battery_height + depth / 4]) {
    // color([1,0,0]) rotate([-90,0,0]) screw_with_nut(threaded_height=6, nut_type="none");
  // }
}

difference() {
  translate([fan_radius / 2 + depth * 6, 3, 0]) {
    cube([10, 20, battery_height + depth]);
  }
  removables();
}


translate([fan_radius / 2 + depth * 6, 3 + 20, 3]) {
  cube([10, 5, battery_height - battery_actual_height]);
}
