use <screw_with_nut.scad>
module shoulder_strap_support_screws() {
  // left hole
  translate([30,0,5]) {
    color([1, 0, 0]) rotate([-90,0,0]) screw_with_nut(threaded_height=6);
  }

  // right hole
  translate([-30,0,5]) {
    color([1, 0, 0]) rotate([-90,0,0]) screw_with_nut(threaded_height=6);
  }
}

