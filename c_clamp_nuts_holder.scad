use <c_clamp_f.scad>

module c_clamp_nuts_holder() {
  difference() {
    color([1,0,0]) cube([25.4,4,30]);
    translate([-5.5,20.5,0]) {
      c_clamp_f_holes();
    }
  }
}

c_clamp_nuts_holder();
