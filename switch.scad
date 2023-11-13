$fn = 200;
module switch_hole() {
  translate([0,0,-6.5]) {
    color([1,0,0]) cube([5,8,13]);
  }
  rotate([0,90,0]) cylinder(h=5, r=6.5);
  translate([0,8,0]) {
    rotate([0,90,0]) cylinder(h=5, r=6.5);
  }
}

function get_switch_x() = 62.5;
function get_switch_y() = 27;

module switch() {
  // make the front curvy
  intersection() {
    // remove a cylinder from the back to add a curve
    difference() {
      cube([get_switch_x(),get_switch_y(),18]);

      translate([30,27,345]) {
        rotate([90,0,0])
        color([1,0,0])
        cylinder(h=27, r=330.2);
      }
    }

    translate([30,27,331]) {
      rotate([90,0,0])
      color([1,0,0])
      cylinder(h=27, r=330.2);
    }
  }

  // switch_hole();
  translate([65 / 2 + 2.5, 12.5,1.5]) {
    rotate([0,90,90]) { switch_hole(); }
  }
}

// translate([30,27,345]) {
  // rotate([90,0,0])
  // color([1,0,0])
  // cylinder(h=27, r=330.2);
// }
switch();
