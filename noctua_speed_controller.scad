$fn = 100;
module noctua_speed_controller() {
  cube([40,25,14]);
  // speed dial
  translate([16,25 / 2,14]) {
    cylinder(h=7, r=3.75);
  }

  // left LED
  translate([8, 3.5, 0]) {
    cylinder(h=20, r=1.5);
  }

  // right LED
  translate([8, 25 - 3.5, 0]) {
    cylinder(h=20, r=1.5);
  }
}

noctua_speed_controller();
