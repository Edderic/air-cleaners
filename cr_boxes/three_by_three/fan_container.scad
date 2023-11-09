use <../row_fan.scad>
use <../builder.scad>
use <../../screw_with_nut.scad>
// Lennox Model HCF14-13
// Replaces Filter Parn No. 19L14

grid_z = 1 * 25.4;
depth = 5;
num_fan_rows = 3;
num_fan_cols = 3;
filter_x = 508;
filter_y = 501.65;
filter_z = 111.125;
fan_diameter = 140;
function get_width(filter_x, depth, num_fan_rows) = ((depth * 2 + filter_x) / num_fan_rows);
function get_length(filter_y, depth, num_fan_cols) = ((depth * 2 + filter_y) / num_fan_cols);

function get_x_spacing(width, fan_diameter) = (width - fan_diameter) / 2;
function get_y_spacing(length, fan_diameter) = (length - fan_diameter) / 2;

width = get_width(filter_x, depth, num_fan_rows);
length = get_length(filter_y, depth, num_fan_cols);

x_spacing = get_x_spacing(width, fan_diameter);
y_spacing = get_y_spacing(length, fan_diameter);
threaded_height = 8;

function get_filter_dim() = [filter_x, filter_y, filter_z];
function get_grid_z() = grid_z;

function z_offset(long=false) = long ? -(grid_z + filter_z) / 2 - depth / 2 : -grid_z / 2 - depth / 2;

module wall_remover(long_wall, width, length, filter_z, z) {
  x_offset = long_wall == "center" ? 0 : long_wall == "top-left" || long_wall == "bottom-left" || long_wall == "left" ? depth : ((long_wall == "top" || long_wall == "bottom" || long_wall == "None") ? 0 : -depth);

  y_offset = long_wall == "top-left" || long_wall == "top" || long_wall == "top-right" ? -depth : (long_wall == "bottom-left" || long_wall == "bottom" || long_wall == "bottom-right" ? depth : 0);

  translate([x_offset,y_offset,z]) {
    cube([width, length,filter_z], center=true);
  }


}

module fan_container(
  long_wall,
  filter_z,
  z,
  x_spacing=x_spacing,
  y_spacing=y_spacing,
  z_spacing=filter_z,
  left_wall_long=false,
  right_wall_long=false,
  top_wall_long=false,
  bottom_wall_long=false,
  top_screw_hole=false,
  bottom_screw_hole=false,
  left_screw_hole=false,
  right_screw_hole=false,
  edge_fan_top_smoothed=false,
  edge_fan_bottom_smoothed=false,
  edge_fan_left_smoothed=false,
  edge_fan_right_smoothed=false,
  edge_top_left_smoothed=false,
  edge_top_right_smoothed=false,
  edge_bottom_left_smoothed=false,
  edge_bottom_right_smoothed=false,
  top_left_corner_smoothed=false,
  top_right_corner_smoothed=false,
  bottom_left_corner_smoothed=false,
  bottom_right_corner_smoothed=false,
  width=width,
  length=length
) {

  difference() {
    union() {

        top_spaced(
            z=z + filter_z,
            depth=depth,
            width=width,
            length=length,
            x_spacing=x_spacing,
            y_spacing=y_spacing,
            z_spacing=z_spacing - 14,
            edge_fan_top_smoothed=edge_fan_top_smoothed,
            edge_fan_bottom_smoothed=edge_fan_bottom_smoothed,
            edge_fan_left_smoothed=edge_fan_left_smoothed,
            edge_fan_right_smoothed=edge_fan_right_smoothed,
            edge_top_left_smoothed=edge_top_left_smoothed,
            edge_top_right_smoothed=edge_top_right_smoothed,
            edge_bottom_left_smoothed=edge_bottom_left_smoothed,
            edge_bottom_right_smoothed=edge_bottom_right_smoothed,
            top_left_corner_smoothed=top_left_corner_smoothed,
            top_right_corner_smoothed=top_right_corner_smoothed,
            bottom_left_corner_smoothed=bottom_left_corner_smoothed,
            bottom_right_corner_smoothed=bottom_right_corner_smoothed
            );

        translate([0,0,filter_z + z - depth - depth / 2]) {
          finger_guard();
        }
    }
    union() {
      if (top_screw_hole) {
        top_screw_and_nut(length=length);
      }
      if (bottom_screw_hole) {
        bottom_screw_and_nut(length=length);
      }
      if (left_screw_hole) {
        left_screw_and_nut(
            length=length,
            width=width,
            grid_z=grid_z,
            threaded_height=threaded_height
            );
      }
      if (right_screw_hole) {
        right_screw_and_nut(
            length=length,
            width=width,
            grid_z=grid_z,
            threaded_height=threaded_height
            );

      }
      wall_remover(long_wall, width, length, filter_z, z);
    }
  }
}

module top_screw_and_nut(length) {
  screw_height = length / 2 + threaded_height -2.1;
  translate([0, screw_height, -grid_z + 5 + filter_z]) {
    rotate([90,0,0])
      color([0,0,1])
      screw_with_nut(threaded_height=threaded_height);
  }
}

module bottom_screw_and_nut(length) {
  translate([0,-length,0]) {
    top_screw_and_nut(length=length);
  }
}

module left_screw_and_nut(length, width, grid_z, threaded_height) {
  translate([-width / 2 - threaded_height + 2,0,-grid_z + 5 + filter_z]) {
    rotate([0,90,0])
    color([0,1,0])
    screw_with_nut(threaded_height=threaded_height);
  }
}

module right_screw_and_nut(length, width, grid_z, threaded_height) {
  translate([width - 0.1,0,0]) {
    left_screw_and_nut(
        length=length,
        width=width,
        grid_z=grid_z,
        threaded_height=threaded_height
        );
  }
}

fan_container(
  filter_z=filter_z,
  z=grid_z,
  top_left_corner_smoothed=true,
  bottom_left_corner_smoothed=true,
  bottom_right_corner_smoothed=true,
  top_right_corner_smoothed=true,
  edge_fan_top_smoothed=true,
  edge_fan_bottom_smoothed=true,
  edge_fan_right_smoothed=true,
  edge_fan_left_smoothed=true,
  edge_top_left_smoothed=true,
  edge_top_right_smoothed=true,
  edge_bottom_left_smoothed=true,
  edge_bottom_right_smoothed=true,
  top_screw_hole=true,
  left_screw_hole=true,
  bottom_screw_hole=true,
  right_screw_hole=true,
  left_wall_long=true,
  long_wall="top-left"
);

