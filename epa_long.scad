use <two_filter_casing_enclosure.scad>
module epa_long(bottom_x=110 * 2, bottom_y=(60 * 2 - 116) / 2, z=33) {
  cube([bottom_x, bottom_y, z]);
  cube([3, 120 - 2, z]);
}

translate([0,2,0]) {
  color([1,0,0]) epa_long();

}

// two_filter_casing_enclosure();
