use <battery_door_with_switch.scad>
use <battery_door.scad>
use <one_filter_one_fan_main.scad>
use <one_filter_one_fan_battery_casing.scad>
use <louver_fan_casing.scad>
use <louver_fan_casing_p2.scad>
use <c_clamp_m.scad>


one_filter_one_fan_main();
fan_radius = 60;
depth = 5;

translate([0,fan_radius * 2 + depth * 2,70]) {
  rotate([-90,0,0]) one_filter_one_fan_battery_casing();
}

// right door
translate([fan_radius * 2 + depth / 2 ,fan_radius * 2 + depth * 2,68]) {
  rotate([-90,0,0]) battery_door_with_switch();
}

// left door
translate([8, fan_radius * 2 + depth * 2 + 46.5,67.5]) {
  rotate([-90,0,180]) battery_door();
}

translate([47.5,fan_radius * 2 + depth * 2 + 46 + 6, 69.5]) {
  rotate([0,180,180]) c_clamp_m();
}

// filter enclosure p1
translate([depth,depth,depth * 3]) {
  color([1,0,0]) filter_casing_with_holes();
}

translate([depth,depth,70]) {
  filter_casing_with_holes_p2();

}
