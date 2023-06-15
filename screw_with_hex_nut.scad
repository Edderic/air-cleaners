use <screw.scad>
use <hex_nut.scad>

module screw_with_hex_nut(hex_nut_height=2, screw_head_height=3, threaded_height=10, threaded_radius=1.5, screw_head_radius=3, hex_nut_side_length=3) {
  screw(screw_head_radius=screw_head_radius, screw_head_height=screw_head_height, threaded_radius=threaded_radius, threaded_height=threaded_height);

  translate([0,0, screw_head_height + threaded_height - hex_nut_height]) {
    hex_nut(side_length=hex_nut_side_length, height=hex_nut_height);
  }
}

screw_with_hex_nut();
