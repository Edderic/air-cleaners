use <two_filter_casing_enclosure.scad>
use <smoothed_edge.scad>
use <smoothed_corner.scad>
use <louvers.scad>
$fn = 200;

fan_radius = 60;
filter_x = 110;
depth = 5;
louver_offset=-4;


// }
module two_filter_casing_enclosure_p2(louver_offset=-4) {
  difference() {
    // two_filter_casing_enclosure(top_bottom=false, louver_offset=-4, filter_holes_offset=-5);
    union() {
      difference() {
        two_filter_casing_enclosure(top_bottom=false, louver_offset=louver_offset, filter_holes_offset=-5);
        union() {
          // top to smooth
          translate([-depth - 1,fan_radius * 2 + 1,depth * 9 - 1]) {
            color([0,0,1]) cube([filter_x * 2 + depth * 2+ 1, depth, depth]);
          }
          // bottom to smooth
          translate([-depth - 1,-depth,depth * 9 - 1]) {
            color([0,0,1]) cube([filter_x * 2 + depth * 2+ 1, depth, depth]);
          }

          // right to smooth
          translate([filter_x * 2, 0, depth * 9 - 1]) {
            cube([depth, fan_radius * 2 + 1, depth]);
          }

          // holes
          translate([0,0,-depth]) {
            two_filter_holes();
          }
        }
      }

      union() {
        // smoothed edge bottom
        translate([-depth - 1,0,depth * 9 - 1]) {
          rotate([0,90,0]) smoothed_edge(radius=5, height=filter_x * 2 + depth + 1);
        }

        // smoothed edge top
        translate([-depth - 1,fan_radius * 2 + 1,depth * 9 - 1]) {
          rotate([-90,0,0])
            rotate([0,90,0]) smoothed_edge(radius=5, height=filter_x * 2 + depth + 1);
        }

        // smoothed edge right
        translate([filter_x * 2,0,depth * 9 - 1]) {
          rotate([0,90,0]) rotate([-90,0,0]) smoothed_edge(radius=5, height=fan_radius * 2 + 1);
        }

        // top-right corner to smooth
        translate([filter_x * 2, fan_radius * 2 + 1, depth * 9 - 1]) {
          rotate([-180,0,0]) rotate([0,0,90]) smoothed_corner();
        }

        // smoothed corner bottom right
        translate([filter_x * 2, 0, depth * 9 - 1]) {
          rotate([-90,0,0]) rotate([0,0,90]) smoothed_corner();
        }
      }
    }

    // remove sections to hold the louvers
    translate([0,0,depth * 8 + depth / 2 + louver_offset]) {
      louvers(filter_x=110 * 2 - 2 * depth, casing_cylinder_length=110 * 2, depth=5, louver_separation=20, num_louvers=6);
    }
  }
}

two_filter_casing_enclosure_p2();
    // translate([0,0,depth * 8 + depth / 2 + louver_offset]) {
      // louvers(filter_x=110 * 2 - 2 * depth, casing_cylinder_length=110 * 2, depth=5, louver_separation=20, num_louvers=6);
    // }
