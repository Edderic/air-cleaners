use <louvers.scad>

module two_filter_louvers(filter_x = 110, depth = 5) {
  louvers(filter_x=110 * 2 - 2 * depth, casing_cylinder_length=110 * 2, depth=5, louver_separation=20, num_louvers=6, cylinder_radius=2.5, with_holes=true);
}

two_filter_louvers();
