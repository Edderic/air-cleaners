use <filter.scad>
use <fan.scad>
use <../smoothed_cube.scad>
use <../tcore_powerbank.scad>
use <../screw_with_nut.scad>
use <../switch.scad>
use <../noctua_speed_controller.scad>
use <../back_cover.scad>

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

module wear_switch() {
  translate([filter_x / 2 + depth, 70 , -90]) {
    rotate([-90,0,0])
    rotate([0,0,-90])
      rotate([90,0,0])
      switch();
  }
}

module speed_controller() {
  translate([-filter_x / 2 + 12, filter_y / 2 + depth * 2, -30]) {
    rotate([0,-90,0])
    rotate([0,0,180])
    color([0,1,0])
    noctua_speed_controller();
  }
}

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
  translate([77,0,-depth]) {
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
//
      translate([-(filter_x ) / 2, 0, -depth - fan_z]) {
        color([1,0,0])
        cube([filter_x,filter_y,fan_x]);
      }
//
      translate([-filter_x / 2, 0, 0]) {
        filter_spacing();
      }

      translate([-fan_x / 2, filter_y - fan_y - 20,-fan_x - depth]) {
        color([0,0,1]) fan();
      }

      intake_vent(debug);
      wear_switch();
      power_bank();


      speed_controller();
    }
  }
}

// translate([0,100,0]) {
  // rotate([90,0,0])
  // cylinder(h=depth, r=fan_x / 2);
// }

module intake_vent(debug=false) {
  y = debug ? 100 : 10;

  // if (debug) {
    translate([0,90,-115 - 2 * depth]) {
      color([0, 1, 1]) cube([filter_x, 20, 10], center=true);
    }
  // }
}



// fan
// translate([-fan_x / 2, filter_y - fan_y - 18,-fan_x - depth]) {
  // color([0,0,1]) fan();
// }


// intake_vent();
// exterior(debug=false);

module fan_support_screw_container() {
  difference() {
    color([1,0,0])
      cube([8,15,5], center=true);
    translate([0,0,-8]) {
      screw_with_nut(threaded_height=8);
    }
  }
}

module fan_support_screw_containers() {
  // back-left screw_container
  translate([40, 38, -fan_z-2.5]) {
    fan_support_screw_container();
  }

  // front-left screw_container
  translate([70, 57, -fan_z-2.5]) {
    fan_support_screw_container();
  }

  // back-right screw_container
  translate([-40, 38, -fan_z-2.5]) {
    fan_support_screw_container();
  }

  // front-right screw_container
  translate([-70, 57, -fan_z-2.5]) {
    fan_support_screw_container();
  }
}

module support() {
  difference() {
    union() {

      // support power bank
      translate([76,0,-80]) {
        cube([5,100,75]);
      }

      // support fan
      translate([-84, filter_y - fan_y - 23,-fan_x - depth]) {
        color([0,1,1])
          cube([160, 5, 120]);
      }

      // switch support
      translate([76,70,-95]) {
        color([0,0,1])
          cube([20,30,70]);
      }

      // speed controller support
      translate([-94,33,-72]) {
        cube([10, 30, 45]);
      }
    }

    union() {
      fan_screw_nuts(x_offset=0, y_offset=2, z_offset=-2);
      power_bank();
      wear_switch();
      speed_controller();
    }
  }
}


support();
power_bank();
wear_switch();
speed_controller();
fan_support_screw_containers();
exterior(debug=false);
// intake_vent();

translate([-fan_x / 2, filter_y - fan_y - 20,-fan_x - depth]) {
  color([0,0,1]) fan();
}

// rotate([90,0,0]) grill();

