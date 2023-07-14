use <one_filter_one_fan_main.scad>
use <main_no_side_holes.scad>
use <top_screws_with_nuts.scad>
use <c_clamp_m.scad>
use <smoothed_edge.scad>

$fn=200;
fan_radius = 60;
depth = 5;

module remove(fan_radius=60, depth=5, with_screws=true) {
  if (with_screws) {

    translate([0,fan_radius * 2 - 4 * depth,0]) {
      main_to_casing_screws();
    }

    // c_clamp_m screws and nuts
    translate([0,fan_radius * 4 + 5 * depth + depth / 2,0]) {
      rotate([0,0,-90]) c_clamp_m_screws_and_nuts();
    }
  }

  // edge to be smoothed 1
  cube([5, 5, 60]);

  // edge to be smoothed 2
  translate([fan_radius * 2 + depth + 1, 0, 0]) {
    color([0,0,1]) cube([5, 5, 60]);
  }
}


module two_filter_one_fan_main(with_screws=true) {
  difference() {
    main_no_side_holes(num_rows=2, num_cols=1);
    remove(with_screws=with_screws);
  }
  translate([5,5,0]) {
    smoothed_edge(radius=5, height=60);
  }
  translate([fan_radius * 2 + depth + 1, depth, 0]) {
    rotate([0,0,90])
    smoothed_edge(radius=5, height=60);
  }
}

two_filter_one_fan_main();
