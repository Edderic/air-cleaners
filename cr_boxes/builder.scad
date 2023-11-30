use <../smoothed_cube.scad>
use <../screw_with_nut.scad>
use <../fan.scad>
use <row_fan.scad>
use <corner.scad>
use <handle.scad>

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
function get_fan_holder_x() = get_spacing_x() * 2 + get_fan_size();
function num_fans_to_fit(dim) = floor(dim / get_fan_holder_x());
function get_corner_z() = (filter_z + 2 * depth - 2 * (get_spacing_x() * 2 + get_fan_size())) / 2;;

module local_fan(z_offset="None", size=140, z=27, _color=[1,1,1], depth=10) {
  _z_offset = z_offset == "None" ? filter_z : z_offset;

  translate([0,0, filter_z]) {
    color(_color)
    cube([size,size,z]);

    // translate([0,0,50]) {
      // rotate([180,0,0])
      // screw_with_nut(threaded_height=8, hex_nut_side_length=4.5);
    // }
  }

  // main cylinder plus screws
  translate([fan_size / 2, fan_size / 2,_z_offset + fan_z  + 10]) {
    rotate([180,0,0])
    fan(size / 2, depth, screw_radius=2.5);
    // color(_color)
    // cylinder(h=depth, r=size / 2);
  }
}

module filter(filter_x=635, filter_y=25, filter_z=406) {
  cube([filter_x, filter_y, filter_z]);
}

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

module fans() {
  translate([get_spacing_x() + get_fan_size() / 2, 0,0]) {
    for (x=[0:1:get_num_fans() - 1]) {
      translate([(get_spacing_x() * 2 + get_fan_size()) * x,0,0]) {
        row_fan();
      }
    }
  }
}

module vertical_wall(with_handle=false, row_wall_index=0) {

  if (!with_handle) {
    translate([- depth / 2,0, get_fan_holder_x() / 2]) {
      rotate([0,-90,0]) {
        for (x=[0:1: num_fans_to_fit(filter_z) - 1]) {
          translate([(get_spacing_x() * 2 + get_fan_size()) * x,0,0]) {
            row_fan(fan_hole=false);
          }
        }
      }
    }
  } else {
    difference() {
      translate([- depth / 2,0, get_fan_holder_x() / 2]) {
        rotate([0,-90,0]) {
          translate([(get_spacing_x() * 2 + get_fan_size()) * row_wall_index,0,0]) {
            row_fan(fan_hole=false);
          }
        }
      }

      translate([-get_x_handle() - 15,0,get_spacing_x() * 2 + get_fan_size()]) {
        color([0,0,1])
          rotate([0,0,180])
          handle(screws_only=true);
      }
    }
  }
}

module filters() {
  filter();
  translate([0,fan_size + filter_y,0]) {
    filter();
  }
}


translate([0,0,filter_z + 5 + depth]) {
  fans();
}

// bottom fans
translate([0,0,depth / 2]) {
  mirror([0,0,1])
   fans();
}

translate([0,-filter_y -get_fan_size() / 2, depth]) {
  filters();
}

// echo("get_fan_holder_x()", get_fan_holder_x());
// echo("num_fans_to_fit(filter_z)", num_fans_to_fit(filter_z));

corner_z = get_corner_z();
echo("corner_z:", corner_z);

translate([-get_depth() / 2,0, corner_z / 2]) {
  // corner();
}

translate([-get_depth() / 2, 0, corner_z + 2 * (get_spacing_x() * 2 + get_fan_size())]) {
  corner();
}

translate([0,0,corner_z]) {
  vertical_wall();
}
