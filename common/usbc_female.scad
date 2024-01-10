$fn=100;
function usbc_radius() = 3.25;
function usbc_middle_width() = 6.5;
function usbc_width() = 2 * usbc_radius() + usbc_middle_width();

module usbc_female() {
  // left half cylinder
  rotate([-90,0,0]) cylinder(h=20, r=usbc_radius());

  translate([0,0,-usbc_radius()]) {
    cube([7,20,usbc_middle_width()]);
  }

  // right half cylinder
  translate([7,0,0]) {
    rotate([-90,0,0]) cylinder(h=20, r=usbc_radius());
  }
}

usbc_female();

