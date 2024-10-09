use <../common/screw_with_nut.scad>

function get_screw_knob_radius() = 25 / 2;
function get_screw_knob_threaded_height() = 32;
function get_screw_diameter() = 6.3 / 2;
function get_screw_knob_head_height() = 10.8;
function get_threaded_knob_center_to_wall_distance() = get_screw_knob_radius() * 2 - 3;
function get_blah() = get_screw_knob_head_height() + get_screw_knob_head_height() / 2;
function get_hex_nut_height() = 5;
function get_hex_nut_side_length() = 7;


module screw_knob(
  screw_knob_diameter=25 / 2,
  screw_length=get_screw_knob_threaded_height(),
  screw_diameter=6.3 / 2,
  screw_head_height=10.8,
  hex_nut_height = get_hex_nut_height(),
  hex_nut_side_length = get_hex_nut_side_length()
) {
  screw_with_nut(
    nut_type="hex",
    hex_nut_height=hex_nut_height,
    hex_nut_side_length=hex_nut_side_length,
    screw_head_radius=screw_knob_diameter,
    screw_head_height=screw_head_height,
    threaded_height=screw_length,
    threaded_radius=screw_diameter
  );
}

