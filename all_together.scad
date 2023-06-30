use <battery_casing_left.scad>
use <battery_casing_right.scad>
use <two_filter_left_side.scad>
use <two_filter_right_side.scad>
use <battery_door.scad>
use <c_clamp_m.scad>

depth = 5;
fan_radius = 60;

translate([0,fan_radius * 2 + 2 * depth, 70]) {
// translate([0,0, 80]) {
  rotate([-90,0,0]) battery_casing_left();
  translate([260, 47, 0]) {
    rotate([-90,0,180]) battery_casing_right();
  }
}
two_filter_left_side();

translate([140 * 2 - depth * 4, 140 - depth * 2 + 1,0]) {
    rotate([0,0,180])
    two_filter_right_side();

}

translate([fan_radius * 2 - depth - depth / 2 + 0.75, 180, 69]) {
  rotate([0,180,180]) c_clamp_m();

}
// translate([4 * fan_radius + 4 * depth - 8, 2 * fan_radius + 2 * depth, 70]) {
  // rotate([-90,0,0]) battery_door();
// }
