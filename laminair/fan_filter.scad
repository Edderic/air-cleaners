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
use <methods.scad>


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

module battery_attachment(
    screw,
    filter_x=filter_x,
    filter_y=filter_y,
    filter_z=filter_z,
    depth=depth,
    threaded_height=7
) {
  translate([-filter_x / 2 - 2 * depth,filter_y / 4 +9, 0]) {
    screwable_and_screw(threaded_height=threaded_height, screw=screw, screwable=!screw);
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

// power_switch(
  // depth,
  // filter_x,
  // filter_y,
  // filter_z,
  // grid_z
// );

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
