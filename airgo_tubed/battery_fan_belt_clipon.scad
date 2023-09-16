use <../airgowear_ff/body.scad>
use <../airgo_qt3/body.scad>
use <../smoothed_cube.scad>
use <filter_adapter.scad>

//
// difference() {
module left_screw_holder(radius=5) {
  translate([-70,41,-2]) {
    smoothed_cube(
        x=radius,
        y=65,
        z=15,
        radius_1=radius,
        radius_2=radius,
        radius_5=radius,
        radius_6=radius,
        edge_1_2_radius=radius,
        edge_1_5_radius=radius,
        edge_2_6_radius=radius,
        edge_5_6_radius=radius,
        edge_8_5_radius=radius,
        edge_6_7_radius=radius,
        edge_2_3_radius=radius
        );
  }
}

module bridge_screw_holder(radius=5) {
  translate([-65,41,-2]) {
    smoothed_cube(
        x=130,
        y=5,
        z=15,
        edge_4_1_radius=radius,
        edge_2_3_radius=radius
        );
  }
}

module left_clip_on(radius=4) {
  translate([-30,41,-80]) {
    smoothed_cube(
        x=30,
        z=80,
        y=4,
        edge_1_2_radius=radius,
        radius_2=radius,
        edge_2_3_radius=radius + 1
        );
  }
}


module clip_on(radius=5) {
  difference() {
    union() {
      left_screw_holder();
      mirror([1,0,0]) {
        left_screw_holder();
        left_clip_on();
      }

      bridge_screw_holder(radius=radius);
      left_clip_on();
    }

    union() {
      half_rings(y_offset=0, z_offset=-110);

      translate([0,50,-64]) {
        rotate([90,0,0]) {
          cylinder(h=20, r=10);
        }
      }
    }
  }
}

// battery_fan_enclosure();
clip_on();

