use <filler.scad>;
use <fan.scad>;

$fn = 100;

num_rows = 1;
num_cols = 2;

num_filters = num_rows * num_cols;
depth = 5;
filter_x = 110;
filter_z = 44;
filter_y = 116;
fan_radius = 70;
top_z = 60;
screw_radius = 2.5;
screw_radius_holder = 2.5;
distance_to_middle_of_circle_x = 62;
distance_to_middle_of_circle_y = 62;

// Take the number of filters (rows and columns) into account
back_x = filter_x * num_cols > fan_radius * 2 ? filter_x * num_cols + depth * 2 : fan_radius * 2 + depth * 2 + 1;

echo(back_x);

back_y = filter_y * num_rows > fan_radius * 2 ? filter_y * num_rows + depth * 2 : fan_radius * 2 + depth * 2 + 1;

echo(back_y);


// the back
difference() {
  cube([back_x, back_y, depth]);

  translate([back_x / 2, back_y / 2, 0]) {
    fan(fan_radius, depth, distance_to_middle_of_circle_x, distance_to_middle_of_circle_y, screw_radius);
  }
}

// the top
difference() {
  cube([back_x, depth, top_z]);
  // hole 1
  translate([back_x / 2, depth, top_z - 13]) {
    rotate([90, 0, 0]) linear_extrude(height=depth) circle(screw_radius_holder);
  }

  // hole 2
  translate([back_x / 2, depth, top_z - 13 - 12]) {
    rotate([90, 0, 0]) linear_extrude(height=depth) circle(screw_radius_holder);
  }
}

// the bottom
translate([0, back_y - depth, 0]) {
  cube([back_x, depth, top_z]);
}

// the left
cube([depth, back_y, top_z]);

// the right
translate([back_x - depth, 0, 0]) {
  cube([depth, back_y, top_z]);
}

// color([100, 0, 0]) filler(num_rows, num_cols, back_x, depth, back_y, filter_x, filter_y, filter_z, top_z);
