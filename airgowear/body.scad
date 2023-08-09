use <filter.scad>
use <fan.scad>
use <../smoothed_cube.scad>
use <../tcore_powerbank.scad>
use <../screw_with_nut.scad>

$fn=100;

filter_x = 209;
filter_y = 101;
filter_to_floor_spacing = 15;
fan_x = 120;
fan_y = 33;
fan_z = 120;
// difference() {
  // sphere(filter_x / 2);
  // translate([0,0,filter_x / 2]) {
    // cube([filter_x, filter_x, filter_x], center=true);
  // }
// }

depth = 5;
sphere_radius = 500;

module bottom_right_screw(x_offset=0, y_offset=0, z_offset=0) {
  // translate([55,54,-118]) {
  // bottom right screw
  translate([53 + x_offset, 54 + y_offset,-116 + z_offset]) {
    rotate([90,0,0])
    screw_with_nut(threaded_height=8);
  }
}

module fan_screw_nuts(x_offset=0, y_offset=0, z_offset=0) {
  bottom_right_screw(x_offset=x_offset, y_offset=y_offset, z_offset=z_offset);

  // bottom left screw
  translate([-106 + x_offset,0 + y_offset,0 + z_offset]) {
    bottom_right_screw();
  }

  // top right screw
  translate([0 + x_offset, 0 + y_offset, 106 + z_offset]) {
    bottom_right_screw();
  }
}

module power_bank() {
  translate([77,13,-depth]) {
    rotate([0,90,0])
      color([0,1,0]) tcore_powerbank();
  }
}


module front() {
  difference() {

  // add some depth so the circle is not too sharp

    for (x=[0:1:10]) {
      translate([0,-370 - x,-15]) {
        difference() {
          sphere(sphere_radius);
          translate([0,-17,0]) {
            cube([sphere_radius * 2,sphere_radius * 2,sphere_radius * 2], center=true);
          }
        }
      }
    }

    translate([0,100, 155]) {
      color([1,0,0]) cube([filter_x * 2, 100, filter_x], center=true);
    }
  }
}

module exterior(debug=false) {
  difference() {
    translate([-(filter_x + depth * 2) / 2, -depth, -2 * depth - fan_z]) {
      smoothed_cube(
          x=209 + depth * 2 ,
          y = 101 + depth * 2,
          z = 35 + filter_to_floor_spacing + 2 * depth + fan_z,
          radius_1 = depth,
          radius_2 = depth,
          radius_3 = depth,
          radius_4 = depth,
          radius_5 = depth,
          radius_6 = depth,
          radius_7 = depth,
          radius_8 = depth,
          edge_1_2_radius=depth,
          edge_2_3_radius=depth,
          edge_3_4_radius=depth,
          edge_4_1_radius=depth,
          edge_1_5_radius=depth,
          edge_5_6_radius=depth,
          edge_6_7_radius=depth,
          edge_7_8_radius=depth,
          edge_2_6_radius=depth,
          edge_3_7_radius=depth,
          edge_4_8_radius=depth,
          edge_8_5_radius=depth
      );
    }
    union() {

      translate([-(filter_x ) / 2, 0, -depth - fan_z]) {
        color([1,0,0])
        cube([filter_x,filter_y,fan_x]);
      }

      translate([-filter_x / 2, 0, 0]) {
        filter_spacing();
      }

      translate([-fan_x / 2, filter_y - fan_y - 20,-fan_x - depth]) {
        color([0,0,1]) fan();
      }

      intake_vent(debug);

      power_bank();
    }
  }
}


module intake_vent(debug=false) {
  y = debug ? 100 : 16;

  translate([0,93,-60 - depth]) {
    color([1,1, 0]) cube([filter_x + depth * 2, y, fan_z], center=true);
  }
}



// fan
// translate([-fan_x / 2, filter_y - fan_y - 18,-fan_x - depth]) {
  // color([0,0,1]) fan();
// }


exterior(debug=true);
// fan support
module fan_support() {
  difference() {
    translate([-fan_x / 2, filter_y - fan_y - 23,-fan_x - depth]) {
      color([0,1,1])
        cube([140, 5, 120]);
    }

    union() {
      fan_screw_nuts(x_offset=0, y_offset=2, z_offset=-2);
      power_bank();
    }
  }
}

fan_support();
power_bank();


// power bank
// translate([77,13,-depth]) {
  // rotate([0,90,0])
  // color([0,1,0]) tcore_powerbank();
// }
