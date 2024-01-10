$fn=100;

module screw(screw_head_radius=3, screw_head_height=3, threaded_radius=1.5, threaded_height=10) {
  // screw head
  cylinder(h=screw_head_height, r=screw_head_radius);

  translate([0, 0, screw_head_height]) {
    cylinder(h=threaded_height, r=threaded_radius);
  }
}

// m3x10
screw(screw_head_radius=3, screw_head_height=3, threaded_radius=1.5, threaded_height=10);
