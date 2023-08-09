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
use <back_cover.scad>
use <shoulder_strap_half_ring.scad>



fan_radius = 60;
filter_x = 110;
depth = 5;
translate([0,fan_radius * 2 - 19,0]) {
  one_fan_one_filter_top();
}
two_filter_one_fan_main();
// two_filter_louvers();
translate([depth, (filter_x * 2 + depth ), depth * 3 + 1]) {
  rotate([0,0,-90]) two_filter_casing_enclosure();
}

translate([depth, (filter_x * 2 + depth ), depth * 4 + 1]) {
  rotate([0,0,-90]) two_filter_casing_enclosure_p2();
}

translate([0, filter_x * 2 + depth * 2 + 1,-30]) {
  rotate([0,0,-90])
  back_cover(num_cols=2);
}

translate([135,fan_radius * 2 + 7 * depth,70]) {
  rotate([0,0,90])
    rotate([0,180,0])
    c_clamp_m();

}

// right shoulder_strap_half_ring
translate([fan_radius * 2 - 3 * depth, -depth, depth]) {
  color([1,0,0]) shoulder_strap_half_ring();
}

// left shoulder_strap_half_ring
translate([fan_radius * 2 - 2 * depth - 5, filter_x * 2 + depth * 2 + 29 + depth * 2 + depth * 3, depth]) {
  rotate([0,0,180])
    color([0,0,1]) shoulder_strap_half_ring();
}
