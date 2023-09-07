$fn=100;

module spiral(twist_thickness=3, num_twists_given_height=4, x_translate=20, twist_radius=3, spiral_height=20, fn=100, clockwise=false) {
  multiplier = clockwise ? -1 : 1;

  for (i=[0:1:num_twists_given_height * 360]) {
    height = i / 360 * spiral_height / num_twists_given_height;

    translate([0,0, height]) {
      rotate([0,0,i * multiplier])

      translate([x_translate,0,0]) {
        cube([twist_radius,twist_radius,twist_radius], center=true);
      }
    }
  }
}

module tube_connector(spiral_height=20, num_twists_given_height=3, tube_radius=50 / 2, fn=100) {
  spiral(spiral_height=spiral_height, num_twists_given_height=num_twists_given_height, x_translate=tube_radius - 2, clockwise=true);
  difference() {
    cylinder(h=spiral_height, r=tube_radius);
    cylinder(h=spiral_height, r=tube_radius - 2);
  }
}

tube_connector(spiral_height=20, num_twists_given_height=3);
