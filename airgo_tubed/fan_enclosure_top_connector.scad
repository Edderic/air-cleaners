use <../airgo_qt3/body.scad>
use <../airgowear_ff/body.scad>
use <fan_enclosure_top.scad>

module screw_panel_with_side_holes() {
  difference() {
    union() {

      translate([-35,91,13]) {
        screw_panel(screws_only=false);

        translate([-115,0,0]) {
          screw_panel(screws_only=false);
        }
      }
    }

    union() {

      top_half_ring_right_side(
          screws_only=true,
          nut_type="none",
          threaded_height=10);

      // translate([-1,0,0]) {
        mirror([1,0,0])
          top_half_ring_right_side(
              screws_only=true,
              nut_type="none",
              threaded_height=10);
      // }
    }
  }
}

// battery_fan_enclosure();
// translate([0,120,0]) {
  // rotate([0,180,0])
  // local_fan();



screw_panel_with_side_holes();
