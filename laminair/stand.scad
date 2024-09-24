use <elbow.scad>
use <../common/screw.scad>

swivel_joint();
support_height = 70;

washer_outer_diameter = 16.23;
screw_knob_threaded_height = get_screw_knob_threaded_height();
screw_knob_radius = get_screw_knob_radius();
screw_knob_head_height = get_screw_knob_head_height();
threaded_knob_center_to_wall_distance = get_threaded_knob_center_to_wall_distance();

// will handle the screw
difference() {
  translate([0, screw_knob_threaded_height / 2, threaded_knob_center_to_wall_distance]) {
    color([0,0,1])
    rotate([90,0,0])
    linear_extrude(screw_knob_threaded_height)
    circle(washer_outer_diameter / 2);
  }

  translate([0,screw_knob_head_height + screw_knob_threaded_height / 2, threaded_knob_center_to_wall_distance]) {
    rotate([90,0,0])
    screw_knob();
  }
}





translate([0,screw_knob_threaded_height / 2,  threaded_knob_center_to_wall_distance]) {
  rotate([0,90,0])
  rotate([90,0,0])
  color([0,1,0])
  linear_extrude(screw_knob_threaded_height)

  polygon(points=[
    [-washer_outer_diameter / 2,0],
    [-washer_outer_diameter / 2 - threaded_knob_center_to_wall_distance, -support_height],
    [washer_outer_diameter / 2 + threaded_knob_center_to_wall_distance * 0.5, -support_height],
    [washer_outer_diameter / 2, 0],
  ]);
}
