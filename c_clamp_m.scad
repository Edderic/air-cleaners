use <top_screws_with_nuts.scad>

depth = 5;

module removables() {
  top_screws_with_nuts();
  translate([22.5, 0, 0]) {
    top_screws_with_nuts();
  }
}

module c_clamp_m_without_holes() {
  // base
  color([0,0,1]) cube([36,5, 64]);

  // mid
  translate([14,-5,0]) {
    color([1, 0,0]) cube([8, 5, 64]);
  }

  // top
  translate([10,-10,0]) {
    cube([16,5, 64]);
  }

  translate([10,-5,0]) {
    color([0,1,0]) cube([16,5, 5]);
  }
}

module c_clamp_m() {
  difference() {
    c_clamp_m_without_holes();
    translate([-120 + 7,-120 - depth - 1,4]) {
      removables();
    }
  }
}

c_clamp_m();
