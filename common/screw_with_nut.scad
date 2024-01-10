use <screw.scad>
use <nut.scad>

module screw_with_nut(
  hex_nut_height=2.5,
  screw_head_height=3,
  threaded_height=10,
  threaded_radius=1.5,
  screw_head_radius=3,
  hex_nut_side_length=3.6,
  square_nut_height=2,
  square_nut_side_length=5,
  nut_type="hex"
) {
  screw(screw_head_radius=screw_head_radius, screw_head_height=screw_head_height, threaded_radius=threaded_radius, threaded_height=threaded_height);

  if (nut_type == "hex") {
    translate([0,0, screw_head_height + threaded_height - hex_nut_height]) {
      hex_nut(side_length=hex_nut_side_length, height=hex_nut_height);
    }
  }

  else if (nut_type == "square"){
    rotate([0,0,-90])
    translate([
        -square_nut_side_length / 2,
        -square_nut_side_length / 2,
        screw_head_height + threaded_height - square_nut_height
    ]) {
      square_nut(
          side_length=square_nut_side_length,
          height=square_nut_height,
          _offset=5);
    }
  }

}

screw_with_nut(nut_type="square");
