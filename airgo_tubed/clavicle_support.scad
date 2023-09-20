use <diffuser.scad>
use <clavicle_screw_holes.scad>

module clavicle_support() {
  difference() {
    translate([-101.5,42,0]) {
      rotate([0,90,0])
        linear_extrude(height=get_filter_x())
        polygon(
            points=[
            [0,0],
            [0,44],
            [25.4 * 1.5, 44]
            ]
            );
    }

    clavicle_screw_holes();
  }
}

