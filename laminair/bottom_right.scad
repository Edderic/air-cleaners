use <../cr_boxes/three_by_three/fan_container.scad>



depth = 5;
// filter_x = 366; // millimeters
// filter_y = 286 + depth * 2; // millimeters
// filter_z = 37; // millimeters

// SmartAir S
filter_x = 10.5 * 25.4; // millimeters
filter_y = 10.5 * 25.4 ; // millimeters
filter_z = 2 * 25.4; // millimeters
grid_z=27 * 1.25;
num_fan_rows = 2;
num_fan_cols = 2;
width = get_width(filter_x, depth, num_fan_rows);
length = get_length(filter_y, depth, num_fan_cols);
fan_diameter = 120;

x_spacing = get_x_spacing(width, fan_diameter);
y_spacing = get_y_spacing(length, fan_diameter);
z_spacing = grid_z + 14;


module bottom_right(
  width,
  length,
  filter_x,
  filter_y,
  filter_z,
  grid_z,
  x_spacing,
  y_spacing,
  z_spacing,
  fan_diameter
) {
  difference() {
    translate([width / 2, -length / 2,0]) {
      fan_container(
          fan_size=120,
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
}


bottom_right(
  width,
  length,
  filter_x,
  filter_y,
  filter_z,
  grid_z,
  x_spacing,
  y_spacing,
  z_spacing,
  fan_diameter
);