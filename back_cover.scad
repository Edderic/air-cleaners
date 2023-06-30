use <main_no_side_holes.scad>

$fn = 100;

module grill(fan_radius=60, depth=5) {

  // grills
  for (i=[1:2:11]) {
    difference() {
      translate([fan_radius + 5, fan_radius + 5, 0]) {
        cylinder(h=depth, r=fan_radius - 5 * i);
      }

      translate([fan_radius + 5, fan_radius + 5, 0]) {
        color([1, 0, 0]) cylinder(h=depth, r=fan_radius - (5 * i) - 2.5);
      }
    }
  }


  // left grill connector
  translate([fan_radius + 5, fan_radius + 5, 0]) {
    rotate([0,0,45]) translate([-1, -(fan_radius * 2 + 2 * 5) / 2, 0]) {
      color([0,0,1]) cube([2,fan_radius * 2 + 2 * 5, depth]);
    }
  }

  // right grill connector
  translate([fan_radius + 5, fan_radius + 5, 0]) {
    rotate([0,0,-45]) translate([-1, -(fan_radius * 2 + 2 * 5) / 2, 0]) {
      color([0,0,1]) cube([2,fan_radius * 2 + 2 * 5, depth]);
    }
  }
}

module back_cover(fan_radius=60, depth=5) {
  difference() {
    main_no_side_holes(top_z=30);
    translate([depth,0,depth]) {
      color([0,1,0]) cube([fan_radius * 2 + 1, depth, 30 - depth]);
    }
  }
  grill();
}

back_cover();



