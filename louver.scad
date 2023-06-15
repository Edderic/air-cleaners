$fn = 90;
module louver(filter_x, x_offset, cylinder_radius, distance_between_cylinders) {
  rotate([90,0,0]) {
    rotate([0, 90, 0]) {

      // cylinder that is meant to be attached to the direction synchronizer
      translate([0, 0, x_offset]) {
        cylinder(h=filter_x - x_offset, r=cylinder_radius);
      }

      translate([0, distance_between_cylinders, 0]) {
        cylinder(h=filter_x + x_offset * 2, r=cylinder_radius);
      }

      // triangle
      translate([0, 0, x_offset * 2]) {
        rotate([0,0,90])
          linear_extrude(height=filter_x - 2 * x_offset) polygon(points=[[0,-2.5],[20 + distance_between_cylinders,0],[0, 2.5]]);
      }
    }
  }
}

depth = 5;
filter_x = 110;
top_z = 60;

translate([depth / 2, 2 * depth, top_z - depth * 4]) {
   louver(filter_x=(110) * 2 - depth, x_offset=depth, cylinder_radius=2.5, distance_between_cylinders=15);
}
