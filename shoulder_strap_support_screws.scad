use <screw_with_nut.scad>
module shoulder_strap_support_screws(wideness=15) {
  // left hole
  translate([wideness,0,5]) {
    color([1, 0, 0]) rotate([-90,0,0]) screw_with_nut(threaded_height=8);
  }

  // right hole
  translate([-wideness,0,5]) {
    color([1, 0, 0]) rotate([-90,0,0]) screw_with_nut(threaded_height=8);
  }
}
