use <screw_with_nut.scad>
module top_screws_with_nuts(fan_radius=60, depth=5, height=50) {
  // top hole 1
  translate([fan_radius * 2, fan_radius * 2 + depth + 1, 2 * depth]) {
    rotate([-90,0,0]) color([0,0,1]) screw_with_nut(threaded_height=6);
  }

  // top hole 2
  translate([fan_radius * 2, fan_radius * 2 + depth + 1, height + depth ]) {
    rotate([-90,0,0]) color([0,1,0]) screw_with_nut(threaded_height=6);
  }
}


top_screws_with_nuts();
