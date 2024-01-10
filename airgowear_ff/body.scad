use <filter.scad>
use <../common/tcore_powerbank.scad>
use <../common/noctua_speed_controller.scad>
use <../airgowear/fan.scad>
use <../common/switch.scad>
use <../common/usbc_female.scad>
use <../common/smoothed_cube.scad>
use <../common/shoulder_strap_half_ring.scad>
use <../common/screw_with_nut.scad>

$fn=100;
scale_value = 1.2;

module filter_enclosure_without_spacing(should_rotate=true) {
  if (should_rotate) {
    translate([0,0,-150]) {
      rotate([45,0,0])
      translate([0,-35,0]) {
        scale([1.1, scale_value, scale_value]) {
          filter();
        }
      }
    }
  } else {
      translate([0,-35,0]) {
        scale([1.066, scale_value, scale_value]) {
          filter();
        }
      }
  }
}

module filter_spacing(should_rotate=true) {
  if (should_rotate) {
    translate([0,0,-150]) {
      rotate([45,0,0])
        scale([1,1,1.15]) {
          filter();
        }
    }
  } else {
    scale([1,1,1.15]) {
      filter();
    }
  }
}

module left_side_filter_enclosure_to_elbow() {
  translate([76,140,40.5]) {
    color([1,0,0])
      cylinder(r=6, h=5);
  }
}

module horizontal_join() {
  difference() {
    cube([10,12,12], center=true);

    translate([-5,0,0]) {
      rotate([0,90,0])
        color([1,0,0])
        screw_with_nut(threaded_height=8);
    }
  }
}

module left_filler() {
  translate([75.5,1,0]) {
    cylinder(h=45, r=1);
  }
}

module filter_body() {
  difference() {
    // union() {
    translate([0,0,-150]) {
      rotate([45,0,0])
        union() {
          difference() {
            filter_enclosure_without_spacing(should_rotate=false);
            filter_spacing(should_rotate=false);
          }

          left_side_filter_enclosure_to_elbow();
          mirror([1,0,0]) {
            left_side_filter_enclosure_to_elbow();
          }

          left_filler();

          mirror([1,0,0]) {
            left_filler();
          }

          translate([0,96,39.5]) {
            horizontal_join();
          }

          translate([0,146,39.5]) {
            horizontal_join();
          }

          translate([0,194,23]) {
            horizontal_join();
          }
        }
    }

    union() {
      local_fan();
      left_remove_extra_padding();
      right_remove_extra_padding();
      top_left_half_ring(screws_only=true);
      top_right_half_ring(screws_only=true);
      right_elbow_screw_holders(screws_only=true);
      left_elbow_screw_holders(screws_only=true);
    }
  }
}

module filter_enclosure() {
  difference() {

    union() {
      difference() {
        filter_enclosure_without_spacing();
        union() {
          filter_spacing();

          local_fan();

          top_left_half_ring(screws_only=true);
          top_right_half_ring(screws_only=true);
        }
      }
      // extra space for screw hole
          translate([0,0,-150]) {
            rotate([45,0,0])
                sphere(r=5);
          }
        // sphere(r=5);
    }

    right_elbow_screw_holders(screws_only=true);
    left_elbow_screw_holders(screws_only=true);
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
  translate([-49,52.5,60]) {
    rotate([0,-90,0])
      noctua_speed_controller();
  }
}

module local_switch() {
  translate([65,52.5,35]) {
    rotate([0,-90,0])
      switch();
  }
}

module usbc() {
  translate([-50,62.5,20]) {
    rotate([0,0,90])
      usbc_female();
  }
}

module battery_controls_casing(x=130,y=72,z=160, with_filter_enclosure_removal=true, with_elbow_holders=true) {
  difference() {
    translate([-64,46,-35]) {
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
          translate([5, 5, 0]) {
            cube([x-10,y-10,z-5]);
          }
        }
      }
    }

    union() {
      if (with_filter_enclosure_removal) {
        filter_enclosure_without_spacing();
      }

      powerbank();
      speed_controller();
      local_switch();
      usbc();
      local_fan();
      logo();
      half_ring_left_side(screws_only=true);
      half_ring_right_side(screws_only=true);
      if (with_elbow_holders) {
        right_elbow_screw_holders(screws_only=true);
        left_elbow_screw_holders(screws_only=true);
      }
      // remove extra hanging material
      // translate([-100,110,-40]) {
        // cube([200, 10, 10]);
      // }
    }
  }

  powerbank_holder();
}

module vertical_text(characters, height=2, vertical_offset=15) {
  for (x=[0:1:5]) {
    x_offset = characters[x] == "I" ? 3 : 0;
    translate([x_offset, -vertical_offset * x,0]) {
      linear_extrude(height=height)
        text(characters[x]);
    }
  }
}


module logo() {
  translate([40,116,35]) {
    rotate([-90,0,0])
      vertical_text("AIRGO", height=2);
  }
}

// left side
module half_ring_left_side(screws_only=false, threaded_height=8, nut_type="hex") {
  translate([-70,82,110]) {
    rotate([0,0,-90])
      shoulder_strap_half_ring(
          screws_only=screws_only,
          threaded_height=threaded_height,
          nut_type=nut_type
      );
  }
}


module half_ring_right_side(screws_only=false, threaded_height=8, nut_type="hex") {
  translate([70,82,110]) {
    rotate([0,0,90])
      shoulder_strap_half_ring(
          screws_only=screws_only,
          threaded_height=threaded_height,
          nut_type=nut_type
      );
  }
}

module powerbank_holder() {
  difference() {
    translate([-37.5,50,100]) {
      color([1,0,0])
        cube([75,20, 20]);
    }
    powerbank();
  }
}


module screw_with_block(threaded_height=8, screws_only=false, show_screws=false) {
  if (show_screws) {
    translate([2.5,0,0]) {
      rotate([0,-90,0])
        color([1,0,0])
        screw_with_nut(threaded_height=threaded_height);
    }
  }
  if (!screws_only) {
    difference() {
      translate([-2.5,-5,-5]) {
        cube([5,15, 10], center=false);
      }
      translate([2.5,0,0]) {
        rotate([0,-90,0])
          color([1,0,0])
          screw_with_nut(threaded_height=threaded_height);
      }
    }
  }
}


module elbow_screw_holder(screws_only, show_screws) {
  screw_with_block(screws_only=screws_only, show_screws=show_screws);
  translate([7.5,7.5,0]) {
    rotate([180,0,0])
      rotate([0,0,90])
      screw_with_block(screws_only=screws_only, show_screws=show_screws);
  }
}


module right_elbow_screw_holders(screws_only=false, show_screws) {
  // top-right elbow screw_holder
  translate([68.5,60,-11.5]) {
    rotate([-45,0,0])
      elbow_screw_holder(screws_only, show_screws);
  }

  // top-right elbow screw_holder
  // translate([68.5,85,13.5]) {
    // rotate([-45,0,0])
      // elbow_screw_holder(screws_only);
  // }
//
}

module left_elbow_screw_holders(screws_only=false, show_screws=true) {
  translate([2,0,0]) {
    mirror([1,0,0])
    right_elbow_screw_holders(screws_only=screws_only, show_screws=show_screws);
  }
}

module right_remove_extra_padding() {
  translate([80,-5,-225]) {
    rotate([45,0,0])
      rotate([0,0,12])
      color([1,0,0])
      cube([200,50, 100]);
  }
}

module left_remove_extra_padding() {
  mirror([1,0,0]) right_remove_extra_padding();
}

module top_left_half_ring(screws_only=false) {
  translate([110,-15,-140]) {
    rotate([47,0,0])
      rotate([0,0,12])
      // rotate([0,90,0])
      shoulder_strap_half_ring(screws_only=screws_only);
  }
}

module top_right_half_ring(screws_only=false) {
  mirror([1,0,0]) top_left_half_ring(screws_only=screws_only);
}

// right_elbow_screw_holders();
// left_elbow_screw_holders();




module powerbank_speed_controller_holder() {
  difference() {
    translate([-51,60,50]) {
      color([1,0,0])
      cube([16, 20, 50]);
    }
    union() {
      powerbank();
      speed_controller();
    }
  }
}

module powerbank_switch_holder() {
  difference() {
    translate([34,60,33]) {
      color([1,0,0])
      cube([16, 20, 65]);
    }

    union() {
      powerbank();
      local_switch();
    }
  }
}

// powerbank_speed_controller_holder();
// powerbank_switch_holder();

// powerbank();
// local_fan();
// local_switch();
// speed_controller();
// filter_body();
// filter_enclosure_without_spacing();
// filter();
          // translate([0,0,-150]) {
            // rotate([45,0,0])
                // sphere(r=5);
          // }


// top_left_half_ring();
// top_right_half_ring();




// filter_enclosure_without_spacing();
battery_controls_casing();
// half_ring_left_side();
// half_ring_right_side();
