use <two_filter_left_side.scad>
use <two_filter_right_side.scad>

side_offset = 0.75;
depth = 5;
fan_radius = 60;
x = 0;
height = 50;
threaded_height = 6;

translate([-2 * (2 * fan_radius + 2 * depth),-(2 * fan_radius + 2 * depth) -1, 0]) {
  two_filter_right_side();
}
rotate([0,0,180]) {
  two_filter_left_side();

}
