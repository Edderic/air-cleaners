use <filter.scad>
use <fan.scad>
use <../smoothed_cube.scad>
use <../tcore_powerbank.scad>
use <../common/screw_with_nut.scad>
use <../switch.scad>
use <../common/noctua_speed_controller.scad>
use <../back_cover.scad>
use <../shoulder_strap_half_ring.scad>
use <../common/usbc_female.scad>

$fn=100;

filter_x = 209;
filter_y = 50;
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
  translate([-108, 12, -40]) {
      rotate([0,90,0])
      switch();
  }
}

module usbc_hole() {
  translate([-100,21,-10]) {
    rotate([0,0,90])
      color([0,0,1]) usbc_female();
  }
}

module speed_controller() {
  translate([-72, filter_y / 2 + depth * 2 + 4, -10]) {
    rotate([-90,0,0])
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

module wear_fan(x_pos=-15) {

  translate([x_pos, filter_y - fan_y,-fan_x - depth]) {
    color([0,0,1]) fan();
  }
}


module power_bank() {
  translate([-21,22,-55]) {
    rotate([0,0,90])
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

module fan_support_screw_container(screw_only=false, reverse_screw=false) {
  if (screw_only && !reverse_screw) {
    translate([0,3,-8]) {
      color([1,1,1]) screw_with_nut(threaded_height=8);
    }
  } else if (screw_only && reverse_screw) {
    translate([0,0,2.5]) {
      rotate([180,0,0])
        screw_with_nut(threaded_height=8);
    }
  } else if (!screw_only && !reverse_screw){
    color([1,0,0])
      cube([8,15,depth], center=true);
  } else {
    color([1,0,0])
      cube([8,15,5], center=true);
  }
}
module fan_hole(padding_radius=2.5, depth=5) {
  // fan hole
  translate([48,filter_y + depth,-65]) {
    color([0,1,1])
      rotate([90,0,0])
      cylinder(h=depth, r=40 + padding_radius);
  }
}



module exterior(debug=false) {
  difference() {

    translate([-(filter_x + depth * 2) / 2, -depth, -2 * depth - fan_z]) {
      smoothed_cube(
          x=filter_x + depth * 2 ,
          y = filter_y + depth * 2,
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
        cube([filter_x,filter_y,fan_x * 2]);
      }
//
      // translate([-filter_x / 2, 0, 0]) {
        // filter_spacing();
      // }

      // wear_fan();
      usbc_hole();
      intake_vent(debug);
      wear_switch();
      power_bank();


      speed_controller();

      // screw hole for filter screw holder 2
      translate([-65,38,-8]) {
        rotate([180,0,0])
          fan_support_screw_container(screw_only=true);
      }


      fan_hole();

      shoulder_strap_half_rings(screws_only=true);
    }
  }

}


module intake_vent(debug=false) {
  y = debug ? 100 : 0;

  if (debug) {
    translate([0,53,-115 - 2 * depth]) {
      color([0, 1, 1]) cube([filter_x, 10, 300], center=true);
    }
  }
}


// intake_vent(debug=true);

// fan
// translate([-fan_x / 2, filter_y - fan_y - 18,-fan_x - depth]) {
  // color([0,0,1]) fan();
// }


module filter_base_support(screw_only=false) {
  // z-wise
  translate([0,0,10]) {
    rotate([-90,0,0])
      fan_support_screw_container(screw_only=screw_only);

  }


  if (!screw_only) {
    cube([8,5,5], center=true);
  }
}

module filter_base(screw_only=false, front_y = 47) {
  difference() {
    translate([0,0,-3]) {
      // back
      translate([50,3,3]) {
        filter_base_support(screw_only=screw_only);
      }

      translate([-50,3,3]) {
        filter_base_support(screw_only=screw_only);
      }

      // front
      translate([50,front_y,3]) {
        filter_base_support(screw_only=screw_only);
      }

      translate([-50,front_y,3]) {
        filter_base_support(screw_only=screw_only);
      }
      if (!screw_only) {
        // base
        translate([0,filter_y / 2,0]) {
          color([1,0,1])
            cube([filter_x - 1, filter_y - 1, 3], center=true);
        }
      }
    }

    wear_fan();

  }
}




power_bank();
wear_switch();
speed_controller();
usbc_hole();




// translate([0,-50,0]) {
  // exterior(debug=true);

// }

module shoulder_strap_half_rings(screws_only=false, y=25.5) {
  // top left shoulder strap half ring
  translate([115,y,35]) {
    rotate([0,0,90]) {
      shoulder_strap_half_ring(screws_only=screws_only);
    }
  }

  // bottom left shoulder strap half ring
  translate([115,y,-125]) {
    rotate([0,0,90]) {
      shoulder_strap_half_ring(screws_only=screws_only);
    }
  }

  // top right shoulder strap half ring
  translate([-115,y,35]) {
    rotate([0,0,-90]) {
      shoulder_strap_half_ring(screws_only=screws_only);
    }
  }

  // bottom right shoulder strap half ring
  translate([-115,y,-125]) {
    rotate([0,0,-90]) {
      shoulder_strap_half_ring(screws_only=screws_only);
    }
  }
}

module fan_holders(x_pos=-15, y_pos=0, z_pos = -125, y=17) {
  difference() {
    union() {
      difference() {
        translate([x_pos,y_pos,z_pos]) {
          cube([fan_x,y, fan_z]);
        }

        translate([x_pos + 3, y_pos,z_pos]) {
          cube([fan_x - 6,y - 3, fan_z]);
        }
      }
    }

    union() {
      wear_fan();
    }
  }
}

module powerbank_holders(x=74, y=49, z_pos=-125, x_pos=-93, z = 85) {
  difference() {
    union() {
      // back
      translate([x_pos,0,z_pos]) {
        cube([x,y, z]);
      }

    }

    union() {
      // difference() {
        // back spacing
        translate([x_pos + 3, 0, z_pos]) {
          cube([x - 2, 18, z]);
        }
        // Remove the top so there's space for wiring
        // translate([x_pos + 3, 0, z_pos]) {
          // cube([2 * x, 18, z]);
        // }
      // }
      // front spacing
      translate([x_pos + 2, 20, z_pos]) {
        cube([x - 3, 30, z]);
      }

      power_bank();
      wear_switch();

    }
  }
}

module speed_controller_holder() {
  difference() {
    translate([-20,0,0]) {
      cube([30, 38, 10]);
    }
    translate([-17,3,0]) {
      cube([24, 32, 10]);
    }

  }
}

fan_holders();
powerbank_holders();
wear_fan();
// filter_base();
fan_hole();
speed_controller_holder();
// shoulder_strap_half_rings();
// shoulder_strap_half_rings(screws_only=true);

