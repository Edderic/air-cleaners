use <../cr_boxes/three_by_three/fan_container.scad>
use <fan_filter.scad>
use <methods.scad>
use <power_switch.scad>

$fn = 100;

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


module bottom_left(
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
    translate([-width / 2, -length / 2,0]) {
      fan_container(
          fan_size=fan_size,
          filter_x=filter_x,
          filter_y=filter_y,
          filter_z=filter_z,
          z=grid_z,
          x_spacing=x_spacing,
          y_spacing=y_spacing,
          z_spacing=z_spacing,
          z_offset=20,
          top_left_corner_smoothed=false,
          bottom_left_corner_smoothed=true,
          bottom_right_corner_smoothed=false,
          bottom_right_front_corner_smoothed=true,
          bottom_front_edge_smoothed=true,
          right_front_edge_smoothed=true,
          top_right_corner_smoothed=false,
          edge_fan_top_smoothed=false,
          edge_fan_bottom_smoothed=true,
          edge_fan_right_smoothed=false,
          edge_fan_left_smoothed=true,
          edge_top_left_smoothed=false,
          edge_top_right_smoothed=false,
          edge_bottom_left_smoothed=true,
          edge_bottom_right_smoothed=false,
          top_right_zip_tie_hole=true,
          top_left_zip_tie_hole=true,
          top_screw_hole=true,
          left_screw_hole=false,
          bottom_screw_hole=false,
          right_screw_hole=true,
          long_wall="bottom-left",
          width=width,
          length=length,
          top_right_stabilizer="p2",
          top_right_stabilizer_axis="vertical",
          bottom_left_stabilizer="p2",
          bottom_left_stabilizer_axis="horizontal"
            );
    }
    union() {

      // hole for wiring
      translate([-filter_x/2,-2, (filter_z + grid_z) / 2 + 8]) {
        rotate([0,-90,0])
          cylinder(h=depth * 2, r=2.5, center=true);
      }


      power_switch_screw_bottom(screw=true);
      // translate([0,4,0]) {
        // mirror([0,1,0]) battery_attachment(screw=true);
      // }
    }
  }
}

bottom_left(
  width,
  length,
  filter_x,
  filter_y,
  filter_z,
  grid_z,
  x_spacing,
  y_spacing,
  z_spacing,
  fan_size=fan_diameter
);
