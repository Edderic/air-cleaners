use <screw_with_nut.scad>

module battery_door_switch_screws() {
  // hole top
  translate([9,47.5,7]) {
    rotate([0,-90,0]) color([0,0,1]) screw_with_nut(threaded_height=6, nut_type="none");
  }

  // hole bottom
  translate([9,47.5,39.5]) {
    rotate([0,-90,0]) color([0,0,1]) screw_with_nut(threaded_height=6, nut_type="none");
  }
}
