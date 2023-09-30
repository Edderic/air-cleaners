use <../smoothed_cube.scad>
use <../screw_with_nut.scad>
use <../fan.scad>
use <row_fan.scad>

filter_x = 635;
filter_z = 406;
filter_y = 25;
fan_z = 27;
num_fans = 4;
fan_size = 140;
depth = 10;

function filter_dim() = [filter_x, filter_y, filter_z];
function get_fan_size() = fan_size;
function get_num_fans() = num_fans;
function get_depth() = depth;
function get_spacing_x() = (filter_x / get_num_fans() - get_fan_size() )/ 2;
function get_spacing_y() = (filter_y / get_num_fans() - get_fan_size() )/ 2;

module local_fan(size=140, z=27, _color=[1,1,1]) {
  translate([0,0, filter_z]) {
    color(_color)
    cube([size,size,z]);

    // translate([0,0,50]) {
      // rotate([180,0,0])
      // screw_with_nut(threaded_height=8, hex_nut_side_length=4.5);
    // }
  }

  // main cylinder plus screws
  translate([fan_size / 2, fan_size / 2,filter_z + fan_z  + 10]) {
    rotate([180,0,0])
    fan(size / 2, depth, screw_radius=2.5);
    // color(_color)
    // cylinder(h=depth, r=size / 2);
  }
}

module filter(filter_x=635, filter_y=25, filter_z=406) {
  cube([filter_x, filter_y, filter_z]);
}

filter();
translate([0,fan_size + filter_y,0]) {
  filter();
}

module fans() {
  gap = filter_x / num_fans - fan_size;

  translate([gap / 2,0,0]) {
    for (x=[0:1:num_fans-1]) {
      echo("x:", x);
      echo("x * filter_x / num_fans:", x * filter_x / num_fans);
      translate([x * filter_x / num_fans,filter_y,-fan_z]) {
          local_fan(_color=[x/5,0,0]);
      }
    }

  }
}

// fans();

module top_or_bottom_panel() {
  smoothed_cube(
      x=filter_x + 2 * depth,
      y=2 * filter_y + fan_size,
      z=depth,
      radius_1=depth,
      radius_4=depth,
      radius_5=depth,
      radius_8=depth,
      edge_4_1_radius=depth,
      edge_1_5_radius=depth,
      edge_8_5_radius=depth,
      edge_4_8_radius=depth
      );
}

difference() {
  translate([-depth,0,filter_z]) {
    color([0,0,1]) top_or_bottom_panel();
  }
  fans();
}

fan_with_connectors();
