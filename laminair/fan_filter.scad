use <../cr_boxes/three_by_three/fan_container.scad>
use <../shoulder_strap_half_ring.scad>
use <top_right.scad>
use <top_left.scad>
use <bottom_left.scad>
use <bottom_right.scad>
use <power_switch.scad>
use <../screw_with_nut.scad>
use <../tcore_powerbank.scad>
use <../smoothed_cube.scad>
use <../switch.scad>
use <../usbc_female.scad>
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

module power_switch_screw_bottom() {
  translate([0,4,0]) {
    mirror([0,1,0]) power_switch_screw_top(screw=false);
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

// bottom_left(
  // width,
  // length,
  // filter_x,
  // filter_y,
  // filter_z,
  // grid_z,
  // x_spacing,
  // y_spacing,
  // z_spacing,
  // fan_size=fan_diameter
// );
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

// top_left(
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

power_switch(
  depth,
  filter_x,
  filter_y,
  filter_z,
  grid_z
);
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
