use <main_no_side_holes.scad>
use <screw.scad>
use <side_holes.scad>

side_offset = 0.75;
depth = 5;
fan_radius = 60;
x = depth + fan_radius * 2 + 1.5;
height = 50;

module holes_left_side() {
  translate([fan_radius * 2 + depth, 1,0]) {
    side_holes();
  }


  // top hole 1
  translate([fan_radius * 2, fan_radius * 2 + depth + 1, 2 * depth]) {
    rotate([-90,0,0]) color([0,0,1]) screw();
  }

  // top hole 2
  translate([fan_radius * 2, fan_radius * 2 + depth + 1, height + depth ]) {
    rotate([-90,0,0]) color([0,1,0]) screw();
  }
}


module two_filter_left_side() {
  difference() {
    main_no_side_holes(side_offset=side_offset);
    holes_left_side();
  }
}

two_filter_left_side();


