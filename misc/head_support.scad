use <../common/screw_with_nut.scad>

$fn=100;
width = 165 + 10;
length = 228 + 10;
ruler_z = 0;

function get_length() = length;
// ruler
// translate([0,0,ruler_z]) {
  // cube([5,length,5], center=true);
// }

// ruler
// translate([0,0,ruler_z]) {
  // cube([width,5,5], center=true);
// }


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


module screw_hole() {
  translate([0,-length / 2 + 1.5,-1]) {
    rotate([90,0,0])
    screw_with_nut(threaded_height=6, nut_type="square");

  }
}

head_support();

// sps30_holder_with_wedge();
