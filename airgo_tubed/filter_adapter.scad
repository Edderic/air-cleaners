use <../airgo_qt3/body.scad>
use <tube_m.scad>
use <../smoothed_cube.scad>
// use <../smoothed_cube.scad>

module half_rings(screws_only=true, z_offset=-23, y_offset=-50) {
  top_half_ring_right_side(z_offset=z_offset, y_offset=y_offset, screws_only=screws_only);
  // top_half_ring_right_side(z_offset=-90, y_offset=-10, screws_only=screws_only);

  mirror([1,0,0]) {
    top_half_ring_right_side(z_offset=z_offset, y_offset=y_offset, screws_only=screws_only);
    // top_half_ring_right_side(z_offset=-90, y_offset=-10, screws_only=screws_only);
  }
}

radius = 5;
difference() {
  qt3_filter_enclosure_and_adapter(with_battery_enclosure_adapter=false, edge_1_2_radius=0, edge_3_4_radius=0);
  // filter_enclosure(edge_1_2_radius=0, edge_3_4_radius=0);

  union() {
    translate([0,85,0]) {
      color([0,1,0])
        cylinder(h=20, r=20);
    }
    half_rings();

  }
}

translate([0,85,0]) {
  tube_m();
}



