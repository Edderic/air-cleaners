use <../screw.scad>

module diffuser_screw(z_offset=-57) {
  translate([0,28,z_offset]) {
    rotate([90,0,0])
      screw();
  }
}

module diffuser_screws(z_offset) {
  rotate([0,0,90]) {
    diffuser_screw(z_offset);
    mirror([0,1,0]) diffuser_screw(z_offset);
  }
}

