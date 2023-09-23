use <../fan.scad>
use <../airgo_qt3/body.scad>
use <../switch.scad>
use <../noctua_speed_controller.scad>
use <../tcore_powerbank.scad>
$fn = 100;

module axial_fan() {
  color([0,1,1])
  cube([120,120, 25], center=true);
}

translate([0,-107,-40]) {
  filter();
}

translate([60,14,57]) {
  rotate([0,90,0])
  rotate([0,0,-90])
  tcore_powerbank();
}

translate([-70,20,0]) {
  rotate([0,-90,0])
  rotate([0,0,-90]) {
    noctua_speed_controller();
  }
}

axial_fan();
fan(radius=60, depth=5, distance_to_middle_of_circle_x=62/70 * 60, distance_to_middle_of_circle_y=62/70 * 60);
translate([-87,-32,28]) {
  rotate([0,-90,0])
  rotate([0,0,-90])
  rotate([0,180,0]) {
    switch();
  }
}

// scale([1,1,0.5]) {
// difference() {
  // translate([0,0,25]) {
    // sphere(110);
  // }
  // union() {
    // translate([0,0,131]) {
      // cube([200,200,150], center=true);
    // }
    // translate([0,0,-88]) {
      // cube([200,200,150], center=true);
    // }
  // }
// }

