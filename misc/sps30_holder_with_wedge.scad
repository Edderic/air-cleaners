use <head_support.scad>
use <sps30.scad>



module sps30_for_subtraction() {
  rotate([0,90,0])
    sps30();

  translate([0,0,-2]) {
    scale([0.9,0.9,1]) {

      rotate([0,90,0])
        sps30();

    }
  }
}


module sps30_holder() {
  difference() {
    scale([1.1,1.5,1]) {
      rotate([0,90,0])
        sps30();
    }
    translate([0,0,2]) {
      sps30_for_subtraction();
    }

  }
}

module sps30_holder_with_wedge(length) {
  difference() {
    union() {

      translate([0,-length / 2 - 22,0]) {
        rotate([-45,0,0])
          sps30_holder();

      }


      // cylinder(h=10, r=5, center=true);
      translate([-5,-length / 2 - 3,-5]) {
        rotate([0,0,180])
          rotate([0,-90,0])
          linear_extrude(height=10)
          polygon(points=[[0,0], [10, 0], [0, 10]]);
      }
    }
    union() {
      screw_hole();
      head_support();
    }
  }


}

sps30_holder_with_wedge(length=get_length());
