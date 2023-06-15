module filler(num_rows, num_cols, back_x, depth, back_y, filter_x, filter_y, filter_z, top_z) {

  if (num_rows == 1 && num_cols == 1) {
    difference() {
      translate([depth, depth, top_z - filter_z]) {
        cube([back_x - depth * 2, back_y - depth * 2, filter_z]);
      }

      translate([back_x / 2 - filter_x / 2, back_y / 2 - filter_y / 2, top_z - filter_z]) {
        cube([filter_x, filter_y, filter_z]);
      }
    }
  }

  if (num_rows == 1 && num_cols > 1){
    translate([depth, filter_y + depth, top_z - filter_z]) {
      cube([back_x - 2 * depth, back_y - 2 * depth - filter_y, filter_z]);
    }
  }
}

// filler(1, 1, 151, 5, 151, 110, 116, 44, 54.4);

