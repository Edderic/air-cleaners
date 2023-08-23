$fn = 100;
module noctua_speed_controller(led_height=16.5) {
  cube([40,25,14]);
  // speed dial
  translate([16,25 / 2,14]) {
    cylinder(h=7, r=3.75);
  }

  // left LED
  translate([8, 4, 0]) {
    cylinder(h=led_height, r=2);
  }

  // right LED
  translate([8, 25 - 4, 0]) {
    cylinder(h=led_height, r=2);
  }
}

noctua_speed_controller();
  // translate([8, 3.5, 0]) {
    // cylinder(h=3, r=1.5);
  // }
