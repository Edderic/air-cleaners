use <louver.scad>

module louvers(num_louvers=7, depth=5, louver_separation=15, filter_x=110, cylinder_radius=3, distance_between_cylinders=15, casing_cylinder_length=110 + 10, with_holes=true) {
  for (i=[0:1:num_louvers-1]) {
    translate([-depth, 2 * depth + i * louver_separation, depth]) {
      louver(
        filter_x=filter_x,
        x_offset=depth,
        cylinder_radius=cylinder_radius,
        distance_between_cylinders=distance_between_cylinders,
        casing_cylinder_length=casing_cylinder_length,
        with_holes=with_holes
      );
    }
  }
}

louvers();
