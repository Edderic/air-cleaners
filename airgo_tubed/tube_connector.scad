$fn=100;

module spiral(twist_thickness=3, num_twists_given_height=4, x_translate=20, twist_depth=3, twist_radius=3, spiral_height=20, fn=100, clockwise=false) {
  multiplier = clockwise ? -1 : 1;

  for (i=[0:1:num_twists_given_height * 360]) {
    height = i / 360 * spiral_height / num_twists_given_height;

    translate([0,0, height]) {
      rotate([0,0,i * multiplier])

      translate([x_translate,0,0]) {
        cube([twist_radius,twist_radius,twist_depth], center=true);
      }
    }
  }
}

module tube_connector(
    spiral_height=20,
    num_twists_given_height=3,
    tube_radius=50 / 2,
    tube_radius_offset=2,
    fn=100,
    radius_offset=2,
    twist_radius=3,
    twist_depth=3
) {
  spiral(
      spiral_height=spiral_height,
      num_twists_given_height=num_twists_given_height,
      x_translate=tube_radius - tube_radius_offset,
      twist_radius=twist_radius,
      twist_depth=twist_depth,
      clockwise=true);
  difference() {
    cylinder(h=spiral_height, r=tube_radius);
    cylinder(h=spiral_height, r=tube_radius - radius_offset);
  }
}

tube_connector(
    spiral_height=20,
    num_twists_given_height=3,
    tube_radius_offset=4,
    radius_offset=4,
    tube_radius=27,
    twist_radius=3
);
