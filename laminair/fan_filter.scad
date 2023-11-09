use <../cr_boxes/three_by_three/fan_container.scad>

filter_x = 366; // millimeters
depth = 5;
filter_y = 286 + depth * 2; // millimeters
filter_z = 37; // millimeters
grid_z=27 * 1.25;
num_fan_rows = 2;
num_fan_cols = 2;
width = get_width(filter_x, depth, num_fan_rows);
length = get_length(filter_y, depth, num_fan_cols);
fan_diameter = 140;
x_spacing = get_x_spacing(width, fan_diameter);
y_spacing = get_y_spacing(length, fan_diameter);
z_spacing = 35;


module filter() {
  cube([filter_x, filter_y, filter_z], center=true);
}
module fan(size=140, height=27) {
  color([0,1,0])
  cube([size, size, height], center=true);

}


module top_left() {
  translate([-width / 2, length / 2,0]) {
    fan_container(
      filter_z=filter_z,
      z=grid_z,
      x_spacing=x_spacing,
      y_spacing=y_spacing,
      z_spacing=z_spacing,
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
}

// top-right piece
module top_right() {
  translate([width / 2, length / 2,0]) {
    fan_container(
        filter_z=filter_z,
        z=grid_z,
        x_spacing=x_spacing,
        y_spacing=y_spacing,
        z_spacing=z_spacing,
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

}

// bottom-left
module bottom_left() {
  translate([-width / 2, -length / 2,0]) {
    fan_container(
        x_spacing=x_spacing,
        y_spacing=y_spacing,
        z_spacing=z_spacing,
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
}

// bottom-right
module bottom_right() {
  translate([width / 2, -length / 2,0]) {
    fan_container(
        x_spacing=x_spacing,
        y_spacing=y_spacing,
        z_spacing=z_spacing,
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
}

top_left();
// top_right();
// bottom_left();
// bottom_right();
// translate([0, 140 / 2 + depth + depth / 2,0]) {
  // fan();
// }
// filter();
