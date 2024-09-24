use <elbow.scad>
use <../common/screw.scad>

swivel_joint();

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
