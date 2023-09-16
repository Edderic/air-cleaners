// April 14, 2018
use <../airgo_qt3/body.scad>
use <../smoothed_cube.scad>
use <tube_connector.scad>
use <tube_m.scad>
use <../screw.scad>

// rotate([0,180,0])
// battery_fan_enclosure();



module fan_enclosure_top() {

  difference() {
    translate([-35,91,13]) {
      tube_m();

      difference() {
        union() {
          translate([-30,-45,0]) {
            smoothed_cube(
                x=130,y=72,z=5,
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
          }


        }
        union() {
          screw_panel(screws_only=true);

          translate([-115,0,0]) {
            screw_panel(screws_only=true);
          }

          // hole
          color([1,0,0])
            cylinder(h=20, r=20);

        }


      }
    }

    side_screws();
  }
}

module side_screws() {
  top_half_ring_right_side(screws_only=true);

  translate([-1,0,0]) {
    mirror([1,0,0])
      top_half_ring_right_side(screws_only=true);
  }

}

fan_enclosure_top();
// battery_fan_enclosure();
// side_screws();

module panel_screws(threaded_height=8, z=5) {
  translate([92.5,19,z]) {
    rotate([180,0,0])
      screw(threaded_height=threaded_height);
  }

  translate([92.5,-37,z]) {
    rotate([180,0,0])
      screw(threaded_height=threaded_height);
  }

}

module screw_panel(screws_only=false) {
  if (screws_only) {
    color([1,0,0])
    panel_screws();
  } else {
    difference() {
      // right
      color([0,1,0])
        translate([90,-40,-12]) {
          cube([5,62,12]);
        }

      union() {
        panel_screws();
      }
    }

  }
}

// translate([-40,90,0]) {
  // screw_panel(screws_only=false);
// }
