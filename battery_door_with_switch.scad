use <battery_door.scad>
use <switch.scad>
use <screw_with_nut.scad>
use <battery_door_switch_screws.scad>
$fn = 300;


module removables() {
  // switch
  translate([7.5,80,10]) {
    color([1, 0,0]) rotate([0,0,-90]) rotate([90,0,0]) switch();
  }

  battery_door_switch_screws();
}
module battery_door_with_switch() {
  difference() {
    battery_door();
    removables();
  }
}

battery_door_with_switch();
