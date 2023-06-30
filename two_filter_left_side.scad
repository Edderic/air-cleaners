use <main_no_side_holes.scad>
use <screw.scad>
use <side_holes.scad>
use <top_screws_with_nuts.scad>

side_offset = 0.75;
depth = 5;
fan_radius = 60;
x = depth + fan_radius * 2 + 1.5;
height = 50;

module holes_left_side() {
  translate([fan_radius * 2 + depth + 1.75, 1,0]) {
    side_holes();
  }

  // right side screws
  top_screws_with_nuts();

  // left side screws
  translate([-100,0,0]) {
    top_screws_with_nuts();
  }

}


module two_filter_left_side() {
  difference() {
    main_no_side_holes(side_offset=side_offset);
    holes_left_side();
  }
}

two_filter_left_side();


