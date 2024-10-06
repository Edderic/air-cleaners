$fn=100;

probe_diameter = 6.1;
stand_height = 145;
base_diameter = 25.4 * 5;

module probe_end() {
  cylinder(r=probe_diameter / 2, h=10);
}

module pole() {
  translate([0,0,5]) {
    rotate([90,0,0])
      scale([1.3, 1.3, 1]) {
        cylinder(r=probe_diameter / 2, h=stand_height);
      }
  }
}

translate([0, -stand_height, 0]) {
  rotate([90,0,0])
  cylinder(h=5, r=base_diameter / 2);
}

difference() {
  union() {
    scale([1.3, 1.3, 1]) {
      probe_end();
    }

    pole();
  }
  probe_end();
}
