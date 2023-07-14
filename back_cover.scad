use <main_no_side_holes.scad>
use <smoothed_edge.scad>

$fn = 100;

module removables(fan_radius, depth) {
  // spacing for wires
  translate([depth,0,depth]) {
    color([0,1,0]) cube([fan_radius * 2 + 1, depth, 30 - depth]);
  }

  // edge to be smoothened, left back side
  translate([0,0,depth]) {
    rotate([-90,0,0]) color([1,0,0]) cube([depth, depth, fan_radius * 2 + depth * 2 + 1]);
  }

  // edge to be smoothened, right back side
  translate([fan_radius * 2 + depth + 1,0,depth]) {
    rotate([-90,0,0]) color([0,1,0]) cube([depth, depth, fan_radius * 2 + depth * 2 + 1]);
  }

  // edge to be smoothened, right back side
  translate([0,fan_radius * 2 + depth + 1,0]) {
    color([0,1,0]) cube([fan_radius * 2 + depth * 2 + 1, depth, depth]);
  }
}

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


module back_cover(fan_radius=60, depth=5, num_cols=1, filter_x=110) {
  difference() {
    main_no_side_holes(top_z=30, num_cols=num_cols);
    if (num_cols == 1) {
      removables(fan_radius=60, depth=5);
    } else {
      translate([depth * 2 + fan_radius * 2 + 1, 0, 0]) {
        rotate([0,0,90]) removables(fan_radius=60, depth=5);
      }
    }
  }

  factor = num_cols == 1 ? fan_radius : filter_x;

  // if (num_cols == 1) {
  // }

  // smoothen edge left
  // translate([2.5,0,2.5]) {
    // rotate([-90,0,0]) color([1,0,0])  cylinder(h=factor * 2 + depth * 2 + 1, r=depth / 2);
  // }

  // smoothen edge right
  // translate([fan_radius * 2 + depth + depth - 2 + 0.5,  0, depth / 2]) {
    // rotate([-90,0,0]) color([1,0,0])  cylinder(h=factor * 2 + depth * 2 + 1, r=depth / 2);
  // }
//
  if (num_cols == 2) {
    translate([fan_radius, 0, 0]) {
      grill();
    }

  } else {
    grill();
  }
}

back_cover();


fan_radius = 60;
depth = 5;
