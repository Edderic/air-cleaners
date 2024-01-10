$fn=200;
module smoothed_corner(radius=5) {
  difference() {
    sphere(radius);
    union() {
      translate([0,-5,-5]) {
        cube([5,10,10]);
      }

      translate([-10,0,-5]) {
        cube([10, 10, 10]);
      }

      translate([-5,-5,0]) {
        cube([10,10,10]);
      }
    }

  }
}

smoothed_corner();
