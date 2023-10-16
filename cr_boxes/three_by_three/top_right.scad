use <fan_container.scad>
use <../handle.scad>

filter_z = get_filter_dim()[2];
grid_z = get_grid_z();


fan_container(
  filter_z=filter_z,
  z=grid_z,
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
