back_length = 238;
back_width = 156;
depth = 5;
top_length = 80;
screw_radius = 2.5;
distance_to_middle_of_circle_x = 62;
distance_to_middle_of_circle_y = 62;

// the back
difference() {
  cube([back_length, back_width, depth]);

  translate([back_length / 2, back_width / 2, 0]) {
    linear_extrude(height=5) color([256, 0, 0]) circle(70);
    translate([distance_to_middle_of_circle_x, distance_to_middle_of_circle_y, 0]) {
      linear_extrude(height=depth) circle(screw_radius);
    }

    translate([-distance_to_middle_of_circle_x, -distance_to_middle_of_circle_y, 0]) {
      linear_extrude(height=depth) circle(screw_radius);
    }

    translate([-distance_to_middle_of_circle_x, -distance_to_middle_of_circle_y, 0]) {
      linear_extrude(height=depth) circle(screw_radius);
    }

    translate([distance_to_middle_of_circle_x, -distance_to_middle_of_circle_y, 0]) {
      linear_extrude(height=depth) circle(screw_radius);
    }

    translate([-distance_to_middle_of_circle_x, distance_to_middle_of_circle_y, 0]) {
      linear_extrude(height=depth) circle(screw_radius);
    }
  }
}

// the top
cube([back_length, depth, top_length]);

// the bottom
translate([0, back_width - depth, 0]) {
  cube([back_length, depth, top_length]);
}

// the left
cube([depth, back_width, top_length]);

// the right
translate([back_length - depth, 0, 0]) {
  cube([depth, back_width, top_length]);
}



