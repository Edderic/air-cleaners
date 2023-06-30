use <louvers.scad>
use <screw.scad>

side_offset = 0.75;
depth = 5;
screwable_depth = depth - 1.5;
fan_radius = 60;
// x = 0;
threaded_height = 6;
filter_x = 110;
filter_y = 116;
filter_z = 44;
louver_holder_z = 10;
z = louver_holder_z / 2 + filter_z;

square_nut_height = z + threaded_height - 0.75;
screw_offset = 2.5;

diff_x = (fan_radius * 2 - filter_x) / 2;
diff_y = (fan_radius * 2 - filter_y);





module filter_casing() {
  // bottom
  cube([fan_radius * 2, diff_y, z]);
  // left filter holder side
  cube([diff_x, (fan_radius * 2), z]);

  // right filter holder side
  translate([diff_x + filter_x, 0, 0]) {
    cube([diff_x, (fan_radius * 2), z]);
  }


}


module filter_casing_enclosure() {
  difference() {
    filter_casing();
    // subtract louvers
    translate([0, depth + depth / 4, filter_z]) {
      louvers();
    }
  }

  // louver canopy
  difference() {

    translate([0, 0, -1 * depth]) {
      difference() {
        translate([-depth, -depth, z]) {
          cube([2 * depth + 2 * fan_radius, 2 * depth + 2 * fan_radius, depth]);
        }


        translate([0, 0, z]) {
          cube([2 * fan_radius, 2 * fan_radius, depth]);
        }
      }
    }
  }
}


module holes() {
  // bottom-left square hole
    translate([-screw_offset,-screw_offset,square_nut_height]) {
      rotate([180,0,0]) color([1,0,0]) screw(threaded_height=threaded_height);
    }

    // bottom-right square hole
    translate([+screw_offset + fan_radius * 2,-screw_offset,square_nut_height]) {
      rotate([180,0,0]) color([1,0,0]) screw(threaded_height=threaded_height);
    }

    // top-right square hole
    translate([+screw_offset + fan_radius * 2, +screw_offset + 2 * fan_radius, square_nut_height]) {
      rotate([180,0,0]) color([1,0,0]) screw(threaded_height=threaded_height);
    }

    // top-left square hole
  translate([-side_offset - 2, 4 * side_offset + 2 * fan_radius, square_nut_height]) {
    rotate([180,0,0]) color([1,0,0]) screw(threaded_height=threaded_height);
  }
}


module filter_casing_with_holes() {
  difference() {
    filter_casing_enclosure();
    holes();
  }
}

filter_casing_with_holes();
