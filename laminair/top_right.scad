use <../cr_boxes/three_by_three/fan_container.scad>
use <../shoulder_strap_half_ring.scad>
use <shoulder_strap_half_ring_left.scad>
use <methods.scad>



// filter_x = 366; // millimeters
// filter_y = 286 + depth * 2; // millimeters
// filter_z = 37; // millimeters

depth = get_wall_depth();

// SmartAir S
filter_x = get_filter_dim()[0];
filter_y = get_filter_dim()[1];
filter_z = get_filter_dim()[2];
grid_z=get_grid_z();
num_fan_rows = get_num_fan_enclosure_dim()[0];
num_fan_cols = get_num_fan_enclosure_dim()[1];
width = get_fan_enclosure_width();
length = get_fan_enclosure_length();
fan_diameter = get_fan_diameter();

x_spacing = get_fan_to_wall_spacing_dim()[0];
y_spacing = get_fan_to_wall_spacing_dim()[1];
z_spacing = get_fan_to_wall_spacing_dim()[2];


module top_right(
  width,
  length,
  filter_x,
  filter_y,
  filter_z,
  grid_z,
  x_spacing,
  y_spacing,
  z_spacing,
  fan_size

) {
  difference() {
    translate([width / 2, length / 2,0]) {
      fan_container(
          fan_size=fan_size,
          filter_z=filter_z,
          z=grid_z,
          x_spacing=x_spacing,
          y_spacing=y_spacing,
          z_spacing=z_spacing,
          z_offset=20,
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
          bottom_right_zip_tie_hole=true,
          bottom_left_zip_tie_hole=true,
          top_screw_hole=false,
          left_screw_hole=true,
          bottom_screw_hole=true,
          right_screw_hole=false,
          long_wall="top-right",
          width=width,
          length=length,
          top_right_stabilizer="p1",
          top_right_stabilizer_axis="horizontal",
          bottom_left_stabilizer="p1",
          bottom_left_stabilizer_axis="vertical"
            );
    }

    shoulder_strap_half_ring_left(filter_x, filter_y, filter_z, grid_z);
  }

}

top_right(
  width,
  length,
  filter_x,
  filter_y,
  filter_z,
  grid_z,
  x_spacing,
  y_spacing,
  z_spacing,
  fan_size=120
);
