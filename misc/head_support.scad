use <sps30.scad>
use <../screw_with_nut.scad>

$fn=100;
width = 165 + 10;
length = 228 + 10;
ruler_z = 0;
// ruler
// translate([0,0,ruler_z]) {
  // cube([5,length,5], center=true);
// }

// ruler
// translate([0,0,ruler_z]) {
  // cube([width,5,5], center=true);
// }

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


module head_support() {
  difference() {
    scale([1,1.4,1]) {
      sphere(width / 2);
    }

    union() {

      scale([0.95,1.35,1]) {
        sphere(width / 2);
      }
      translate([0,0,width / 2 + 5]) {
        remove();
      }
      translate([0,0,-width / 2 - 5]) {
        remove();
      }

      screw_hole();
    }
  }
}

module remove() {
  cube([width,length + 10,width], center=true);
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

module sps30_holder_with_wedge() {
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


module screw_hole() {
  translate([0,-length / 2 + 1.5,-1]) {
    rotate([90,0,0])
    screw_with_nut(threaded_height=6, nut_type="square");

  }
}

head_support();

// sps30_holder_with_wedge();
