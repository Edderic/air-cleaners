use <main_no_side_holes.scad>
use <smoothed_edge.scad>

$fn = 100;

module removables(fan_radius, depth) {
  // spacing for wires
  translate([0,depth,depth]) {
    color([0,1,0]) cube([depth, fan_radius * 2 + 1, 30 - depth]);
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
    main_no_side_holes(
        top_z=30,
        num_cols=num_cols,
        radius_3=depth,
        radius_7=depth,
        edge_3_7_radius=depth,
        edge_2_3_radius=depth,
        edge_6_7_radius=depth
    );

    removables(fan_radius=fan_radius, depth=depth);
  }

  factor = num_cols == 1 ? fan_radius : filter_x;

  if (num_cols == 2) {
    translate([fan_radius - depth - depth, depth/8, 0]) {
      grill();
    }

  } else {
    grill();
  }
}

back_cover();
// removables(fan_radius=60, depth=5);


fan_radius = 60;
depth = 5;
