use <../screw.scad>
module clavicle_screw_holes() {
  translate([90,48,-10]) {
    screw(screw_head_height=5);
  }

  translate([-90,48,-10]) {
    screw(screw_head_height=5);
  }

}

