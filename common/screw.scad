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

module screw_knob(
  screw_knob_diameter=25 / 2,
  screw_length=28,
  screw_diameter=6.3
) {
  screw(
    screw_head_radius=screw_knob_diameter,
    screw_head_height=10.8,
    threaded_height=screw_length,
    threaded_radius=screw_diameter
  );
}
