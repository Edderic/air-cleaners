use <louver_fan_casing.scad>
use <two_filter_one_fan_main.scad>
use <screw.scad>
use <louvers.scad>

module filter_casing_two_filter(filter_width=110, fan_radius=60, filter_y=116, filter_z=44, louver_holder_z=10) {
  z = louver_holder_z / 2 + filter_z;
  bottom_x = filter_width * 2;
  bottom_y = (fan_radius * 2 - filter_y) / 2;

  // top
  translate([0, fan_radius * 2 - bottom_y + 1, 0]) {
    cube([bottom_x, bottom_y, z]);
  }

  // bottom
  cube([bottom_x, bottom_y, z]);
}

module two_filter_holes_left_side(screw_offset=2.5, depth=5, threaded_height=6) {
  // bottom-left square hole
  translate([-screw_offset + depth / 3 ,-screw_offset + depth * 4.5, depth * 8 + 4]) {
    color([1,0,0]) screw(threaded_height=threaded_height);
  }

  // top-left square hole
  translate([-screw_offset + depth / 3 ,-screw_offset + depth * 20.5, depth * 8 + 4]) {
    color([1,0,0]) screw(threaded_height=threaded_height);
  }
}

module two_filter_holes(filter_x=110) {
  two_filter_holes_left_side();
  translate([filter_x * 2, 0, 0]) {
    two_filter_holes_left_side();
  }
}


module two_filter_casing_enclosure(
  depth=5,
  filter_x=110,
  filter_z=44,
  fan_radius=60,
  louver_holder_z=10,
  top_bottom=true,
  louver_offset=0,
  filter_holes_offset=0,
) {
  z = louver_holder_z / 2 + filter_z;

  difference() {
    union() {
      union() {
        if (top_bottom) {
          filter_casing_two_filter();
        }
        translate([depth + filter_x * 2,-depth, -depth * 2]) {
          rotate([0,0,90]) translate([0,0,z]) {
            // get a slice of the main casing
            difference() {
              two_filter_one_fan_main(with_screws=false);
              union() {
                cube([400,400,5]);
                translate([0,0,10]) {
                    cube([400,400,100]);
                }
              }
            }
          }
        }
      }

      difference() {
        union() {
            // reinforce left side
            translate([-1,0,z - depth]) {
              color([1,0,0]) cube([depth,fan_radius * 2 + depth,depth]);
            }
            // reinforce right side
            translate([filter_x * 2 - depth,0,z - depth]) {
              color([1,0,0]) cube([depth,fan_radius * 2 + depth,depth]);
            }
        }
        // subtract louvers
        translate([0,0,depth * 8 + depth / 2 + louver_offset]) {
          louvers(filter_x=110 * 2 - 2 * depth, casing_cylinder_length=110 * 2, depth=5, louver_separation=20, num_louvers=6);
        }
      }
    }

    translate([0, 0, filter_holes_offset]) {
      two_filter_holes();
    }
  }
}

two_filter_casing_enclosure();
