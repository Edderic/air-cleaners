use <two_filter_one_fan_main.scad>
use <battery_door_with_switch.scad>
use <battery_door.scad>
use <one_fan_one_filter_all_together.scad>
use <one_filter_one_fan_battery_casing.scad>
use <louver_fan_casing.scad>
use <louver_fan_casing_p2.scad>
use <c_clamp_m.scad>
use <two_filter_louvers.scad>
use <two_filter_casing_enclosure.scad>
use <two_filter_casing_enclosure_p2.scad>



fan_radius = 60;
filter_x = 110;
depth = 5;
translate([0,fan_radius * 2 - 19,0]) {
  one_fan_one_filter_top();
}
two_filter_one_fan_main();
// two_filter_louvers();
translate([depth, (filter_x * 2 + depth ), depth * 3]) {
  rotate([0,0,-90]) two_filter_casing_enclosure();
}

translate([depth, (filter_x * 2 + depth ), depth * 4]) {
  rotate([0,0,-90]) two_filter_casing_enclosure_p2();
}
