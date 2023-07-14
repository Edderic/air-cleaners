$fn=100;
module usbc_female() {
  // left half cylinder
  rotate([-90,0,0]) cylinder(h=20, r=3.25);

  translate([0,0,-3.25]) {
    cube([7,20,6.5]);
  }

  // right half cylinder
  translate([7,0,0]) {
    rotate([-90,0,0]) cylinder(h=20, r=3.25);
  }
}

usbc_female();

