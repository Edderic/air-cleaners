use <../common/screw.scad>

function get_screw_knob_radius() = 25 / 2;
function get_screw_knob_threaded_height() = 28;
function get_screw_diameter() = 6.3 / 2;
function get_screw_knob_head_height() = 10.8;
function get_threaded_knob_center_to_wall_distance() = get_screw_knob_radius() * 2 - 3;
function get_blah() = get_screw_knob_head_height() + get_screw_knob_head_height() / 2;

module screw_knob(
  screw_knob_diameter=25 / 2,
  screw_length=28,
  screw_diameter=6.3 / 2,
  screw_head_height=10.8
) {
  screw(
    screw_head_radius=screw_knob_diameter,
    screw_head_height=screw_head_height,
    threaded_height=screw_length,
    threaded_radius=screw_diameter
  );
}

