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
width = (depth * 2 + filter_x) / num_fan_rows;
length = (depth * 2 + filter_y) / num_fan_cols;
x_spacing = (width - fan_diameter) / 2;
y_spacing = (length - fan_diameter) / 2;
threaded_height = 7;

module vertical_grid_wall(long=false) {
  z = long ? grid_z + filter_z : grid_z;
  cube([depth, length, z], center=true);
}

function z_offset(long=false) = long ? -(grid_z + filter_z) / 2 - depth / 2 : -grid_z / 2 - depth / 2;

module left_wall(long=false) {
  translate([-width / 2 + depth / 2,0, z_offset(long=long)]) {
    vertical_grid_wall(long=long);
  }
}

module top_wall(long=false) {
  z = long ? grid_z + filter_z : grid_z;
  translate([0, length / 2 - depth / 2, z_offset(long=long)]) {
    cube([width, depth, z], center=true);
  }
}

module fan_container(
  filter_z,
  z,
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
  bottom_right_corner_smoothed=false
) {

  difference() {
    union() {

      // left_wall(long=left_wall_long);

      // right wall
      // mirror([1,0,0])
        // left_wall(long=right_wall_long);

      // top_wall(long=top_wall_long);

      // bottom wall
      // mirror([0,1,0])
        // top_wall(long=bottom_wall_long);

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
    }
  }
}

module top_screw_and_nut(length) {
  screw_height = length / 2 + threaded_height - 2 ;
  translate([0, screw_height, -grid_z + 5]) {
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
  translate([-width / 2 - threaded_height + 2,0,-grid_z + 5]) {
    rotate([0,90,0])
    color([0,1,0])
    screw_with_nut(threaded_height=threaded_height);
  }
}

module right_screw_and_nut(length, width, grid_z, threaded_height) {
  translate([width,0,0]) {
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
  left_wall_long=true
);
