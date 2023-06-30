use <louvers.scad>

depth = 5;
filter_x = 110;
filter_y = 116;
top_z = 60;
num_louvers = 6;
louver_separation = filter_y / (num_louvers + 1);

module louver_sync() {
  difference() {
    translate([-3, depth / 2, 15]) {
      cube([depth / 2, filter_y - depth * 2, depth * 2]);
    }

    translate([-10,0,0]) {
      louvers(with_holes=false);
    }
  }
}

louver_sync();
