use <filter.scad>
use <../tcore_powerbank.scad>
use <../noctua_speed_controller.scad>
use <../airgowear/fan.scad>
use <../switch.scad>
use <../usbc_female.scad>
use <../smoothed_cube.scad>

scale_value = 1.2;
module filter_enclosure() {
  translate([0,0,-150]) {
    rotate([45,0,0])
    difference() {
      translate([0,-35,0]) {
        scale([1.066, scale_value, scale_value]) {
          filter();
        }
      }
      filter();
    }
  }
}

module powerbank() {
  translate([35,80,50]) {
    rotate([0,0,90])
    rotate([0,-90,0])
      tcore_powerbank();
  }
}

module local_fan() {
  translate([60,80,120]) {
    color([0,0,1])
    rotate([0,0,180])
    rotate([180,0,0])
      fan();
  }
}

module speed_controller() {
  translate([-49,52.5,40]) {
    rotate([0,-90,0])
      noctua_speed_controller();
  }
}

module local_switch() {
  translate([62,52.5,25]) {
    rotate([0,-90,0])
      switch();
  }
}

module usbc() {
  translate([-50,62.5,0]) {
    rotate([0,0,90])
      usbc_female();
  }
}

powerbank();
local_fan();
local_switch();
speed_controller();


module battery_controls_casing(x=130,y=70,z=160) {
  difference() {
    translate([-64,45,-35]) {
      difference() {
        color([0,1,0])
        smoothed_cube(
            x=x,
            y=y,
            z=z,
            edge_1_2_radius=5,
            // edge_2_3_radius=5
            edge_3_4_radius=5,
            edge_5_6_radius=5,
            edge_7_8_radius=5,
            edge_4_1_radius=5,
            edge_1_5_radius=5,
            edge_8_5_radius=5,
            edge_4_8_radius=5,
            radius_1=5,
            radius_4=5,
            radius_5=5,
            radius_8=5
        );

        union() {

          // spacing for inside
          translate([5, 5, 5]) {
            cube([x-10,y-10,z-5]);
          }
        }
      }
    }

    union() {
      powerbank();
      speed_controller();
    }
  }
}

filter_enclosure();


battery_controls_casing();
