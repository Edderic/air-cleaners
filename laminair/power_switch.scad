use <../usbc_female.scad>
use <../tcore_powerbank.scad>
use <../smoothed_cube.scad>
use <fan_filter.scad>
use <../switch.scad>
use <shoulder_strap_half_ring_left.scad>
use <../shoulder_strap_half_ring.scad>
use <methods.scad>

depth = get_wall_depth();
// filter_x = 366; // millimeters
// filter_y = 286 + depth * 2; // millimeters
// filter_z = 37; // millimeters

filter_x = get_filter_dim()[0];
filter_y = get_filter_dim()[1];
filter_z = get_filter_dim()[2];
grid_z=get_grid_z();
num_fan_rows = get_num_fan_enclosure_dim()[0];
num_fan_cols = get_num_fan_enclosure_dim()[1];
width = get_fan_enclosure_width();
length = get_fan_enclosure_length();
fan_diameter = get_fan_diameter();
side_length = get_square_side_length();

x_spacing = get_fan_to_wall_spacing_dim()[0];
y_spacing = get_fan_to_wall_spacing_dim()[1];
z_spacing = get_fan_to_wall_spacing_dim()[2];

power_switch_width = get_tcore_powerbank_z() + 3;
ps_width = power_switch_width(filter_z, grid_z, depth, side_length);
switch_length = power_switch_length(filter_y, depth);
function power_switch_length(filter_y, depth) = filter_y / 2 + depth;

module power_switch_screw_bottom(screw=false) {
  translate([0,16 - switch_length, (screwable_width() + 2) / 2 + ps_width / 2 + depth - 1.6]) {
    mirror([0,1,0])
    translate([0,-72,0]) {
      battery_attachment_compound(screw=screw);
    }
  }
}

module battery_attachment_compound(screw) {
  if (screw) {
    battery_attachment(screw=true);
  } else {
    difference() {
      battery_attachment(screw=false);
      battery_attachment(screw=true);
    }
  }
}

module power_switch_screw_top(screw=true) {
  translate([0,-filter_y / 5,0]) {
    z_offset = 8;
    translate([0, 2.5, z_offset + power_switch_width(filter_z, grid_z, depth, side_length) / 2]) {
      battery_attachment_compound(screw);
    }
  }
}

function power_switch_width(filter_z, grid_z, depth, side_length) = filter_z + grid_z - depth - side_length;

module power_switch(
  depth,
  filter_x,
  filter_y,
  filter_z,
  grid_z,
  side_length=8
) {
  z = power_switch_width(filter_z, grid_z, depth, side_length);

  power_switch_screw_top(screw=false);
  power_switch_screw_bottom();
  translate([0,-filter_y / 5,0]) {

    difference() {
      translate([-depth - power_switch_width - filter_x / 2, -filter_y / 4, side_length]) {
        color([1,0,0])
          smoothed_cube(
              x=power_switch_width,
              y=switch_length,
              z=z,
              radius_1=5,
              edge_1_2_radius=5,
              edge_4_1_radius=5,
              radius_2=5,
              edge_2_3_radius=5,
              edge_2_6_radius=5,
              edge_1_5_radius=5,
              radius_5=5,
              edge_5_6_radius=5,
              edge_6_7_radius=5,
              edge_8_5_radius=5,
              radius_6=5

              );
      }
      union() {

        translate([-filter_x / 2 - depth,depth * 2, get_square_side_length() + (z  - get_tcore_powerbank_x()) / 2]) {
          rotate([0,-90,0])
            rotate([0,0,-90])
            tcore_powerbank();
        }

        // make some space for wires
        translate([-filter_x / 2 - power_switch_width - 1,0,get_square_side_length() + (z - 74) / 2]) {
          cube([power_switch_width - 4,68,74]);
        }
        // usbc hole
        translate([-filter_x / 2 - 17 ,filter_y / 4, 5 + z / 2]) {
          rotate([0,-90,0])
            usbc_female();
        }
      }

      local_switch(filter_x, power_switch_width=z);
    }
    // local_switch(filter_x, power_switch_width=z);
  }
}

module local_switch(
  filter_x,
  power_switch_width,
) {
  translate([
      -filter_x / 2 - get_switch_y() -8,
      30,
      get_switch_x() + get_square_side_length() + (power_switch_width - get_switch_x()) / 2
  ]) {
    rotate([0,90,0])
    switch();
  }
}


power_switch(
  depth,
  filter_x,
  filter_y,
  filter_z,
  grid_z
);
