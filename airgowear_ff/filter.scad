$fn = 200;

module filter() {
  linear_extrude(height=38.1)
  difference() {
    difference() {
      // outer circle
      scale([1,1.4,1]) {
        translate([2.5,-50,0]) {
          color([0,1,0])  circle(192);
        }
      }

      // inner circle (stretched)
      scale([1,1.3,1]) {
        translate([0,-5,0]) {
          color([1,0,0])  circle(75);
        }
      }
    }


    union() {

      // remove extra left side
      translate([-75,-205,0]) {
      rotate([0,0,78])
        color([1,0,0])
        square(200);
      }

      // remove extra right side
      translate([75,0,0]) {
      rotate([0,0,-78])
        color([1,0,0])
        square(1000);
      }

      // remove extra top side
      translate([-200,-350, 0]) {
        color([1,0,0])
          square(350);
      }
    }
  }
}

filter();
