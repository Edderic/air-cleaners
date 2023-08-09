use <one_filter_one_fan_main.scad>
use <main_no_side_holes.scad>
use <top_screws_with_nuts.scad>
use <c_clamp_m.scad>
use <smoothed_edge.scad>
use <shoulder_strap_half_ring.scad>
use <shoulder_strap_support_screws.scad>

$fn=200;
fan_radius = 60;
depth = 5;

module remove(fan_radius=60, depth=5, with_screws=true) {
  if (with_screws) {

    // 4 screws to casing
    translate([0,fan_radius * 2 - 4 * depth,0]) {
      main_to_casing_screws();
    }

    // c_clamp_m screws and nuts
    translate([0,fan_radius * 4 + 5 * depth + depth / 2,0]) {
      rotate([0,0,-90]) c_clamp_m_screws_and_nuts();
    }

    // shoulder strap screws
    translate([fan_radius * 2 - 3 * depth, -depth, depth]) {
      shoulder_strap_support_screws(wideness=16);
    }
  }
}


module two_filter_one_fan_main(with_screws=true) {
  difference() {
    main_no_side_holes(
        num_rows=2,
        num_cols=1,
        edge_1_2_radius=5
    );
    remove(with_screws=with_screws);
  }
}

two_filter_one_fan_main();

