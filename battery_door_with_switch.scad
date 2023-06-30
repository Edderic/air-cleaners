use <battery_door.scad>
use <switch.scad>
use <screw_with_nut.scad>
$fn = 100;


module removables() {
  // switch
  translate([5,80,10]) {
    color([1, 0,0]) rotate([0,0,-90]) rotate([90,0,0]) switch();
  }

  // hole top
  translate([9,47.5,7]) {
    rotate([0,-90,0]) color([0,0,1]) screw_with_nut(threaded_height=6);
  }

  // hole bottom
  translate([9,47.5,39.5]) {
    rotate([0,-90,0]) color([0,0,1]) screw_with_nut(threaded_height=6);
  }

}
module battery_door_with_switch() {
  difference() {
    battery_door();
    removables();
  }
}

battery_door_with_switch();
// rotate([90,0,0]) rotate([0,90,0]) switch();
