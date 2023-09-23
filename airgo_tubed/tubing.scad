use <tube_m.scad>

module tubing(hole=false, y=-18, height=50) {
  if (hole) {
    translate([0,y,45]) {
      rotate([90,0,0])
        cylinder(h=height, r=18);
    }

  } else {
    translate([0,y,45]) {
      rotate([90,0,0])
        tube_m();
    }
  }
}
