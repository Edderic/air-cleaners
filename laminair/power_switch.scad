use <../usbc_female.scad>
use <../tcore_powerbank.scad>
use <../smoothed_cube.scad>
use <fan_filter.scad>
use <../switch.scad>
use <../cr_boxes/three_by_three/fan_container.scad>
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
power_switch_width = get_tcore_powerbank_z() + 3;

module power_switch(
  depth,
  filter_x,
  filter_y,
  filter_z,
  grid_z
) {
  power_switch_screw_top(screw=false);

  power_switch_screw_bottom();


  difference() {
    translate([-depth - power_switch_width - filter_x / 2, -filter_y / 4,0]) {
      color([0,0,1])
        smoothed_cube(
            x=power_switch_width,
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

      // make some space for wires
      translate([-filter_x / 2 - power_switch_width - 1,0,depth - 2]) {
        cube([power_switch_width - 4,68,74]);
      }
    // usbc hole
      translate([-filter_x / 2 - 30 ,filter_y / 4, filter_z + grid_z - depth * 4]) {
        rotate([0,-90,0])
          usbc_female();
      }
    }

    local_switch();
  }
}

module local_switch() {
  translate([-filter_x / 2 - get_switch_y() -  power_switch_width + 24, 30,get_switch_x() + 1.75 *  depth]) {
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
