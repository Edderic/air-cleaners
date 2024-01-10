use <screw_with_nut.scad>
module left_support_screw(wideness, threaded_height, nut_type) {
  translate([wideness,0,5]) {
    color([1, 0, 0]) rotate([-90,0,0]) screw_with_nut(
        threaded_height=threaded_height,
        nut_type=nut_type
    );
  }

}

module shoulder_strap_support_screws(wideness=15, threaded_height=8, nut_type="hex") {
  // left hole
  left_support_screw(wideness, threaded_height, nut_type);

  // right hole
  translate([-wideness,0,5]) {
    color([1, 0, 0]) rotate([-90,0,0]) screw_with_nut(
      threaded_height=threaded_height,
      nut_type=nut_type
    );
  }
}

