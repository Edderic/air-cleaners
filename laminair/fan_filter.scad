use <../cr_boxes/three_by_three/fan_container.scad>
use <../shoulder_strap_half_ring.scad>
use <top_right.scad>
use <top_left.scad>
use <bottom_right.scad>
use <../screw_with_nut.scad>
use <../tcore_powerbank.scad>
use <../smoothed_cube.scad>
use <shoulder_strap_half_ring_left.scad>


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


module filter() {
  cube([filter_x, filter_y, filter_z], center=true);
}
module fan(size=140, height=27) {
  color([0,1,0])
  cube([size, size, height], center=true);

}

module screw_right() {
  translate([filter_x / 2 + depth, - filter_y / 2 + depth,5]) {
    rotate([0,-90,0])
    screw_with_nut(nut_type="None");
  }
}

module screw_bottom_right() {
  translate([depth,-filter_y / 2 - depth, depth]) {
    rotate([-90,0,0]) {
      screw_with_nut(nut_type="None");
    }
  }
}


// top-right piece

// bottom-left
module bottom_left() {
  translate([-width / 2, -length / 2,0]) {
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

module filter_offset() {
  difference() {
    translate([filter_x / 4, +depth-filter_y / 2, depth]) {
      cube([filter_x / 2, depth * 2, depth * 2], center=true);
    }
    union() {

      screw_bottom_right();
      screw_right();
    }
  }
}

// filter_offset();

module power_switch() {
  power_switch_screw_top(screw=false);

  translate([0,4,0]) {
    mirror([0,1,0]) power_switch_screw_top(screw=false);
  }

  difference() {
    translate([-depth - 30 - filter_x / 2, -filter_y / 4,0]) {
      color([0,0,1])
        smoothed_cube(
            x=30,
            y=filter_y / 2 + depth,
            z=filter_z + grid_z - depth,
            radius_1=5,
            edge_1_2_radius=5,
            edge_4_1_radius=5,
            edge_1_5_radius=5,
            radius_5=5,
            edge_5_6_radius=5,
            edge_8_5_radius=5
            );
    }
    union() {

      translate([-filter_x / 2 - depth,depth * 2,depth]) {
        rotate([0,-90,0])
          rotate([0,0,-90])
          tcore_powerbank();
      }
    }
  }
}

module battery_attachment(screw) {
  translate([-filter_x / 2 - 2 * depth,filter_y / 4 +9 , filter_z - 2 * depth]) {
    screwable_and_screw(threaded_height=7, screw=screw, screwable=!screw);
  }

}

module power_switch_screw_top(screw=true) {
  difference() {
    battery_attachment(screw=false);
    battery_attachment(screw=true);
  }
}


module screwable_and_screw(screw=true, screwable=true, threaded_height=8) {
  if (screw) {
    rotate([0,90,0])
    color([0,1,0])
    screw_with_nut(threaded_height=threaded_height);
  }

  if (screwable) {
    translate([0,6,-5]) {
      rotate([0,0,-90])
        screwable();
    }
  }
}

// bottom-right

// top_right(
  // width,
  // length,
  // filter_x,
  // filter_y,
  // filter_z,
  // grid_z,
  // x_spacing,
  // y_spacing,
  // z_spacing,
  // fan_diameter
// );

bottom_left();
// bottom_right(
  // width,
  // length,
  // filter_x,
  // filter_y,
  // filter_z,
  // grid_z,
  // x_spacing,
  // y_spacing,
  // z_spacing,
  // fan_diameter
// );

top_left(
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

power_switch();
// }
// translate([0,-52,-2]) {
  // mirror([1,0,0])
  // shoulder_strap_half_ring_left(filter_x, filter_y, filter_z, grid_z, screws_only=false);
// }

// screw_right();
// translate([0, 140 / 2 + depth + depth / 2,0]) {
  // fan();
// }
// filter();
