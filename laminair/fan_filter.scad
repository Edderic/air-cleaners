use <../cr_boxes/three_by_three/fan_container.scad>

filter_x = 366; // millimeters
filter_y = 286; // millimeters
// filter_z = 37; // millimeters
filter_z = 111.125;
grid_z=25.4;
depth = 5;
num_fan_rows = 2;
num_fan_cols = 2;
width = get_width(filter_x, depth, num_fan_rows);
length = get_length(filter_y, depth, num_fan_cols);
fan_diameter = 140;
x_spacing = get_x_spacing(width, fan_diameter);
y_spacing = get_y_spacing(length, fan_diameter);


module filter() {
  cube([filter_x, filter_y, filter_z], center=true);
}


// top-left piece
translate([-width / 2, length / 2,0]) {
  fan_container(
    filter_z=filter_z,
    z=grid_z,
    x_spacing=x_spacing,
    y_spacing=y_spacing,
    top_left_corner_smoothed=true,
    bottom_left_corner_smoothed=false,
    bottom_right_corner_smoothed=false,
    top_right_corner_smoothed=false,
    edge_fan_top_smoothed=true,
    edge_fan_bottom_smoothed=false,
    edge_fan_right_smoothed=false,
    edge_fan_left_smoothed=true,
    edge_top_left_smoothed=true,
    edge_top_right_smoothed=false,
    edge_bottom_left_smoothed=false,
    edge_bottom_right_smoothed=false,
    top_screw_hole=false,
    left_screw_hole=false,
    bottom_screw_hole=true,
    right_screw_hole=true,
    long_wall="top-left",
    width=width,
    length=length
  );
}

// top-right piece
translate([width / 2, length / 2,0]) {
  fan_container(
    filter_z=filter_z,
    z=grid_z,
    x_spacing=x_spacing,
    y_spacing=y_spacing,
    width=width,
    length=length,
    top_left_corner_smoothed=false,
    bottom_left_corner_smoothed=false,
    bottom_right_corner_smoothed=false,
    top_right_corner_smoothed=true,
    edge_fan_top_smoothed=true,
    edge_fan_bottom_smoothed=false,
    edge_fan_right_smoothed=true,
    edge_fan_left_smoothed=false,
    edge_top_left_smoothed=false,
    edge_top_right_smoothed=true,
    edge_bottom_left_smoothed=false,
    edge_bottom_right_smoothed=false,
    top_screw_hole=false,
    left_screw_hole=true,
    bottom_screw_hole=true,
    right_screw_hole=false,
    long_wall="top-right"
  );
}

// bottom-left
translate([-width / 2, -length / 2,0]) {
  fan_container(
    x_spacing=x_spacing,
    y_spacing=y_spacing,
    width=width,
    length=length,
    filter_z=filter_z,
    z=grid_z,
    top_left_corner_smoothed=false,
    bottom_left_corner_smoothed=true,
    bottom_right_corner_smoothed=false,
    top_right_corner_smoothed=false,
    edge_fan_top_smoothed=false,
    edge_fan_bottom_smoothed=true,
    edge_fan_right_smoothed=false,
    edge_fan_left_smoothed=true,
    edge_top_left_smoothed=false,
    edge_top_right_smoothed=false,
    edge_bottom_left_smoothed=true,
    edge_bottom_right_smoothed=false,
    top_screw_hole=true,
    left_screw_hole=false,
    bottom_screw_hole=false,
    right_screw_hole=true,
    long_wall="bottom-left"
  );
}

// bottom-right
translate([width / 2, -length / 2,0]) {
  fan_container(
    x_spacing=x_spacing,
    y_spacing=y_spacing,
    width=width,
    length=length,
    filter_z=filter_z,
    z=grid_z,
    top_left_corner_smoothed=false,
    bottom_left_corner_smoothed=false,
    bottom_right_corner_smoothed=true,
    top_right_corner_smoothed=false,
    edge_fan_top_smoothed=false,
    edge_fan_bottom_smoothed=true,
    edge_fan_right_smoothed=true,
    edge_fan_left_smoothed=false,
    edge_top_left_smoothed=false,
    edge_top_right_smoothed=false,
    edge_bottom_left_smoothed=false,
    edge_bottom_right_smoothed=true,
    top_screw_hole=true,
    left_screw_hole=true,
    bottom_screw_hole=false,
    right_screw_hole=false,
    long_wall="bottom-right"
  );
}
// filter();
