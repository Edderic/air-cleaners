use <battery_door_with_switch.scad>
use <switch.scad>
use <battery_door_switch_screws.scad>

$fn = 200;


module removables() {
  // battery door
  battery_door_with_switch();

  // switch
  translate([7,80,10]) {
      rotate([90,0,0])
      rotate([0,-90,0])
      switch();
  }

  // screws
  battery_door_switch_screws();
}


module subtract_from() {
  translate([-13,45,3]) {
    color([1,0,0]) cube([18,5,39]);
  }

  translate([-13,14,20]) {
    cube([7, 67.5,5]);
  }

}
module switch_support() {
  difference() {
    translate([0,1.5,0]) {
      subtract_from();

    }
    removables();
  }
}

switch_support();
// removables();


