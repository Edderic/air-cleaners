module smoothed_edge(radius=1.5, height=64) {
  difference() {
    difference() {
      color([1, 0, 0]) cylinder(h=height, r=radius);
      translate([-radius, 0, 0]) {
        color([0, 1, 0]) cube([radius * 2, radius, height]);
      }
    }

    translate([0, -radius, 0]) {
      color([0, 1, 0]) cube([radius, radius * 2, height]);
    }
  }
}

