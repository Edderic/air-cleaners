use <../smoothed_cube.scad>
use <../screw_with_nut.scad>

$fn = 100;
x = 40.2;
y = 25.4;
z = 5;
h = 127;

function get_x_handle() = x;
threaded_height = 8;


module top() {
  translate([-x / 2 ,-y / 2,-z / 2]) {
    smoothed_cube(x=x, y = y, z=z);
  }
}

module screw_holder(x=5, y=y, z=y, radius=5) {
  translate([-x / 2 ,-y / 2,-z / 2]) {
    smoothed_cube(
      x=x, y = y, z=z,
      radius_3=radius,
      radius_7=radius,
      edge_2_3_radius=radius,
      edge_3_7_radius=radius,
      edge_3_4_radius=radius,
      edge_6_7_radius=radius,
      edge_7_8_radius=radius
    );
  }
}

module handle(screws_only=false) {
  if (screws_only) {
    screws_for_handle();
  } else {

    cylinder(h=h, r=25.4 / 2, center=true);
    difference() {
      union() {

        translate([-x,0,-h / 2 - 8]) {
          screw_holder();
        }

        mirror([0,0,1])
          translate([-x,0,-h / 2 - 8]) {
            screw_holder();
          }

        translate([-x / 2,0, h / 2 - z / 2]) {
          top();
        }

        mirror([0,0,1])
          translate([-x / 2,0, h / 2 - z / 2]) {
            top();
          }
      }
      screws_for_handle();
    }
  }
}

module screws_for_handle() {
  screw_handle();
  mirror([0,0,1])
    screw_handle();
}

module screw_handle(screw_offset=5) {
  translate([-x + threaded_height - screw_offset,0,h / 2 + y /2  -2]) {
    color([1,0,0])
      rotate([0,-90,0])
      screw_with_nut(threaded_height=threaded_height);
  }
}

handle();
