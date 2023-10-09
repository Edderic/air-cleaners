use <../row_fan.scad>
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
  left_wall_long=false,
  right_wall_long=false,
  top_wall_long=false,
  bottom_wall_long=false,
  top_screw_hole=false,
  bottom_screw_hole=false,
  left_screw_hole=false,
  right_screw_hole=false
) {

  difference() {
    union() {

      left_wall(long=left_wall_long);

      mirror([1,0,0])
        left_wall(long=right_wall_long);



      top_wall(long=top_wall_long);

      mirror([0,1,0])
        top_wall(long=bottom_wall_long);

      top_spaced(
          depth=depth,
          width=width,
          length=length,
          x_spacing=x_spacing,
          y_spacing=y_spacing
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

fan_container();

