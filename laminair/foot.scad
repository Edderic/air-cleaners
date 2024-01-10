use <../common/screw_with_nut.scad>
$fn = 100;

module cone(width=5, height=10, cone_top_radius=8) {
  rotate_extrude(convexity=10, angle=360)
    polygon([[0,0], [width,0], [cone_top_radius, height], [0,height]]);
}

module foot(fan_size=120, screw=false, height=10, screw_head_height=5) {
  if (screw) {
    rotate([-90,0,0]) screw_with_nut(nut_type="hex", threaded_height=10, screw_head_height=screw_head_height);
  } else {
    rotate([-90,0,0]) difference() {
      cone(height=height);
      screw_with_nut(nut_type="hex", threaded_height=10, screw_head_height=screw_head_height);
    }
  }
}


foot();
// screw_with_nut(nut_type="none", threaded_height=10);
