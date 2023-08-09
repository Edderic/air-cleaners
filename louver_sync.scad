use <louvers.scad>
use <smoothed_cube.scad>

depth = 5;
filter_x = 110;
filter_y = 116;
top_z = 60;
num_louvers = 6;
louver_separation = filter_y / (num_louvers + 1);

module louver_sync(depth=5) {
  difference() {
    translate([-3, depth, 15]) {
      smoothed_cube(
          x=depth,
          y=filter_y - depth,
          z=depth * 2,
          radius_1= depth / 2,
          radius_2 =  depth / 2,
          radius_3 =  depth / 2,
          radius_4 =  depth / 2,
          radius_5 =  depth / 2,
          radius_6 =  depth / 2,
          radius_7 =  depth / 2,
          radius_8 =  depth / 2 ,
          edge_1_2_radius= depth / 2,
          edge_2_3_radius= depth / 2,
          edge_3_4_radius= depth / 2,
          edge_4_1_radius= depth / 2,
          edge_1_5_radius= depth / 2,
          edge_5_6_radius= depth / 2,
          edge_8_5_radius= depth / 2,
          edge_6_7_radius= depth / 2,
          edge_7_8_radius= depth / 2,
          edge_8_4_radius= depth / 2,
          edge_2_6_radius= depth / 2,
          edge_3_7_radius= depth / 2,
          edge_4_8_radius= depth / 2
      );
    }

    translate([-7,0,0]) {
      louvers(filter_x=110 * 2 - 2 * depth, casing_cylinder_length=110 * 2, depth=5, louver_separation=20, num_louvers=6, with_holes=false);
    }
  }
}


louver_sync();
