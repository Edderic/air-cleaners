use <louver.scad>

depth = 5;
filter_x = 110;
filter_y = 116;
top_z = 60;
num_louvers = 6;
louver_separation = filter_y / (num_louvers + 1);

difference() {
  translate([0, depth, 0]) {
    cube([depth, filter_y - depth * 2, depth * 2]);
  }

  for (i=[0:1:num_louvers-1]) {
    translate([-depth, 2 * depth + i * louver_separation, depth]) {
      louver(filter_x=(filter_x) * 2 - depth, x_offset=depth, cylinder_radius=3, distance_between_cylinders=15);
    }
  }

}
