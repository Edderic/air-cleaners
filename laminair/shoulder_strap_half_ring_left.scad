use <../shoulder_strap_half_ring.scad>

module shoulder_strap_half_ring_left(filter_x, filter_y, filter_z, grid_z) {
  translate([filter_x / 2 + 10, filter_y / 2, (filter_z + grid_z) / 2]) {
    rotate([0,0,90])
      rotate([0,-90,0])
      shoulder_strap_half_ring(screws_only=true);
  }
}
