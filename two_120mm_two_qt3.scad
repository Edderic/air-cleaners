
use <filler.scad>;
use <fan.scad>;
use <louver.scad>
use <louvers.scad>
use <pac_p1.scad>

$fn = 100;

num_rows = 1;
num_cols = 2;

num_filters = num_rows * num_cols;
num_fans = 2;
depth = 5;
filter_x = 110;
filter_z = 44;
filter_y = 116;
fan_radius = 60;
top_z = 60; // fan/filter
//top_z = 15; // filter/louver section
screw_radius = 2.5;
screw_radius_holder = 2.5;
louver_holder = false;

// 62 / old radius * new_radius
distance_to_middle_of_circle_x = 62 / 70 * 60 ;
distance_to_middle_of_circle_y = distance_to_middle_of_circle_x;


p1(depth, filter_x, filter_y, fan_radius, top_z, screw_radius, screw_radius_holder, louver_holder, num_fans=2);
