use <louver.scad>

module louvers(num_louvers, depth, louver_separation, filter_x, cylinder_radius=3, distance_between_cylinders=15) {
  for (i=[0:1:num_louvers-1]) {
    translate([-depth, 2 * depth + i * louver_separation, depth]) {
      louver(
        filter_x=(filter_x) * 2 - depth,
        x_offset=depth,
        cylinder_radius=cylinder_radius,
        distance_between_cylinders=distance_between_cylinders
      );
    }
  }
}
