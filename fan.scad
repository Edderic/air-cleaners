use <hex_nut.scad>

module fan(radius, depth, distance_to_middle_of_circle_x, distance_to_middle_of_circle_y, screw_radius) {
  linear_extrude(height=depth) circle(radius);
  translate([distance_to_middle_of_circle_x, distance_to_middle_of_circle_y, 0]) {
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

  // hex nut 1
  translate([distance_to_middle_of_circle_x, distance_to_middle_of_circle_y, depth - 2]) {
    hex_nut(4);
  }

  // hex nut 2
  translate([-distance_to_middle_of_circle_x, -distance_to_middle_of_circle_y, depth - 2]) {
    hex_nut(4);
  }

  // hex nut 3
  translate([distance_to_middle_of_circle_x, -distance_to_middle_of_circle_y, depth - 2]) {
    hex_nut(4);
  }

  // hex nut 4
  translate([-distance_to_middle_of_circle_x, distance_to_middle_of_circle_y, depth - 2]) {
    hex_nut(4);
  }
}
