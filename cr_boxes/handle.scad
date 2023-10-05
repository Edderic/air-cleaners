use <../smoothed_cube.scad>
use <../screw_with_nut.scad>

$fn = 100;
x = 50.2;
y = 25.4;
z = 5;
h = 127;
threaded_height = 20;


module top() {
  translate([-x / 2 ,-y / 2,-z / 2]) {
    smoothed_cube(x=x, y = y, z=z);
  }
}

module screw_holder(x=10, y=y, z=y) {
  translate([-x / 2 ,-y / 2,-z / 2]) {
    smoothed_cube(x=x, y = y, z=z);
  }
}

module handle() {
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

module screws_for_handle() {
  screw_handle();
  mirror([0,0,1])
    screw_handle();
}

module screw_handle() {
  translate([-x + threaded_height - 11,0,h / 2 + y /2  -2]) {
    color([1,0,0])
      rotate([0,-90,0])
      screw_with_nut(threaded_radius=2.5, hex_nut_side_length=4.5, threaded_height=threaded_height);
  }
}

handle();
