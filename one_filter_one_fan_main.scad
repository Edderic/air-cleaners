use <main_no_side_holes.scad>
use <top_screws_with_nuts.scad>
use <c_clamp_m.scad>

fan_radius = 60;
depth = 5;

module main_to_casing_screws() {
  translate([-10,0,0]) {
    top_screws_with_nuts();
  }
  translate([-100,0,0]) {
    top_screws_with_nuts();
  }
}

module remove(fan_radius=60, depth=5) {
  main_to_casing_screws();

  // c_clamp_m screws and nuts
  translate([0,fan_radius * 3 + 7 * depth + depth / 2,0]) {
    rotate([0,0,-90]) c_clamp_m_screws_and_nuts();
  }
}


module one_filter_one_fan_main() {
  difference() {
    main_no_side_holes();
    remove();
  }
}

one_filter_one_fan_main();
