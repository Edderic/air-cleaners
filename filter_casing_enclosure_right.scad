use <louver_fan_casing.scad>

side_offset = 0.75;
fan_radius = 60;
depth = 5;
module filter_casing_enclosure_right() {

  difference() {
    filter_casing_enclosure();

    translate([-depth, -depth, 49]) {
      color([1,0,0]) cube([side_offset, fan_radius * 2 + depth * 3, depth * 2]);
    }
  }
}


filter_casing_enclosure_right();