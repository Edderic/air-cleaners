use <hex_nut.scad>
$fn = 100;

// | 70
// |
// |
// |
// |        62.5
// -------------

module fan(
    radius,
    depth,
    screw_radius,
    distance_to_middle_of_circle_x = "None",
    distance_to_middle_of_circle_y = "None",
    multiplier = 70 - 7.5
) {

  _distance_to_middle_of_circle_x = (distance_to_middle_of_circle_x == "None" || distance_to_middle_of_circle_y == "None") ? multiplier / 70 * radius : distance_to_middle_of_circle_x;
  _distance_to_middle_of_circle_y = (distance_to_middle_of_circle_x == "None" || distance_to_middle_of_circle_y == "None") ? multiplier / 70 * radius : distance_to_middle_of_circle_y;

  linear_extrude(height=depth) circle(radius);
  translate([_distance_to_middle_of_circle_x, _distance_to_middle_of_circle_y, 0]) {
    linear_extrude(height=depth) circle(screw_radius);
  }

  translate([-_distance_to_middle_of_circle_x, -_distance_to_middle_of_circle_y, 0]) {
    linear_extrude(height=depth) circle(screw_radius);
  }

  translate([_distance_to_middle_of_circle_x, -_distance_to_middle_of_circle_y, 0]) {
    linear_extrude(height=depth) circle(screw_radius);
  }

  translate([-_distance_to_middle_of_circle_x, _distance_to_middle_of_circle_y, 0]) {
    linear_extrude(height=depth) circle(screw_radius);
  }

  // hex nut 1
  translate([_distance_to_middle_of_circle_x, _distance_to_middle_of_circle_y, depth - 2]) {
    hex_nut(4);
  }

  // hex nut 2
  translate([-_distance_to_middle_of_circle_x, -_distance_to_middle_of_circle_y, depth - 2]) {
    hex_nut(4);
  }

  // hex nut 3
  translate([_distance_to_middle_of_circle_x, -_distance_to_middle_of_circle_y, depth - 2]) {
    hex_nut(4);
  }

  // hex nut 4
  translate([-_distance_to_middle_of_circle_x, _distance_to_middle_of_circle_y, depth - 2]) {
    hex_nut(4);
  }
}

fan(radius=60, depth=5, distance_to_middle_of_circle_x=62/70 * 60, distance_to_middle_of_circle_y=62/70 * 60);
