use <../airgowear_ff/body.scad>
use <../airgowear/fan.scad>
use <../common/smoothed_cube.scad>
use <../common/screw_with_nut.scad>

$fn=200;


module battery_fan_enclosure() {
  difference() {
    translate([0.75,0,0]) {
      rotate([0,180,0]) {
        battery_controls_casing(with_filter_enclosure_removal=false, with_elbow_holders=false);
        // local_fan();
      }
    }

    union() {
      translate([0,102,35]) {
        cube([119 + 12,112,44], center=true);
      }
      top_half_ring_right_side(screws_only=true);

      translate([-1,0,0]) {
        mirror([1,0,0])
          top_half_ring_right_side(screws_only=true);
      }
    }
  }

}

module filter(x=119, y=112,z=44) {
  translate([0,107,75]) {
    cube([119,112,44], center=true);
  }
}


module hollow_cube(x,y,z, radius=5) {
  difference() {
    smoothed_cube(
        x=x,
        y=y,
        z=z,
        edge_1_2_radius=radius,
        edge_3_4_radius=radius,
        edge_5_6_radius=radius,
        edge_7_8_radius=radius
        );
    translate([radius,radius,0]) {
      smoothed_cube(
          x=x - radius * 2,
          y=y - radius * 2,
          z=z,
          edge_1_2_radius=radius,
          edge_3_4_radius=radius,
          edge_5_6_radius=radius,
          edge_7_8_radius=radius
          );

    }
  }
}

module filter_enclosure(inside_x=119, inside_y=112, inside_z=44, radius=5, x=130, y=124, z=44, edge_1_2_radius="none", edge_3_4_radius="none") {
  edge_1_2_radius_ = edge_1_2_radius == "none" ? radius : edge_1_2_radius;
  edge_3_4_radius_ = edge_3_4_radius == "none" ? radius : edge_3_4_radius;

  difference() {
    translate([-65, 46,53]) {
      smoothed_cube(
          x=x,
          y=y,
          z=z,
          edge_1_2_radius=edge_1_2_radius_,
          edge_3_4_radius=edge_3_4_radius_,
          edge_5_6_radius=radius,
          edge_7_8_radius=radius
          );

    }
    filter(x=inside_x, y=inside_y, z=inside_z);
  }
}

module qt3_filter_adapter(num_iter=80, threaded_height=9, with_battery_enclosure_adapter=true, radius=5) {
  for (i=[0:1:num_iter]) {
    if (!with_battery_enclosure_adapter && i == 0) {
      translate([-65,46,13 + i / 2]) {
        color([1,0,0])
        smoothed_cube(
          x=118 + 12,
          y=72,
          z=5,
          edge_1_2_radius=radius,
          edge_3_4_radius=radius,
          edge_5_6_radius=radius,
          edge_7_8_radius=radius
        );
      }
    } else {
      color([1,0,0])
      translate([-65,46,13 + i / 2]) {
        hollow_cube(
            x=118 + 12,
            y=72 + i / num_iter * (112 + 10 - 70),
            z=1
            );
      }
    }
  }
  if (with_battery_enclosure_adapter) {
    difference() {
      union() {
        battery_enclosure_to_adapter_right();
        mirror([1,0,0]) battery_enclosure_to_adapter_right();
      }
      union() {
        top_half_ring_right_side(screws_only=true, threaded_height=threaded_height);

        mirror([1,0,0])
          top_half_ring_right_side(screws_only=true, threaded_height=threaded_height);

      }
    }
  }
}


module top_half_ring_right_side(
  screws_only=false, threaded_height=8, nut_type="hex",
  x_offset=0, y_offset=0, z_offset=-110
) {
  translate([x_offset, y_offset, z_offset]) {
    half_ring_right_side(
        screws_only=screws_only,
        threaded_height=threaded_height,
        nut_type="hex");
  }
}


module battery_enclosure_to_adapter_right() {
  translate([55,52,0]) {
    cube([5,60,20]);
  }
}

module upper_chest_stabilizer(radius=5) {
  num_iter = 83;

  for (i=[0:1:num_iter]) {
    translate([-65,-i / 2 + 46,i + 13]) {
      color([0,1,0])
      smoothed_cube(
        x=118 + 12,
        y=radius + i / num_iter * 39,
        z=1,
        edge_1_2_radius=radius,
        edge_3_4_radius=radius,
        edge_5_6_radius=0,
        edge_7_8_radius=0
      );
    }
  }

}

module qt3_filter_enclosure_and_adapter(
  with_battery_enclosure_adapter=true,
  edge_1_2_radius="none",
  edge_3_4_radius="none"
) {
  qt3_filter_adapter(with_battery_enclosure_adapter=with_battery_enclosure_adapter);
  filter_enclosure(
      edge_1_2_radius=edge_1_2_radius,
      edge_3_4_radius=edge_3_4_radius
  );
  upper_chest_stabilizer();
}


module qt3_adapter_bounds() {
  translate([0,118,15]) {
    rotate([0,-90,0])
      rotate([0,0,-90])
      linear_extrude(height=129)
      polygon([
          [0,0],
          [72,0],
          [72,40],
          [-52,40]
      ]);
  }
}

module air_guide(depth=5) {
  translate([60.5,113,15]) {
    rotate([0,-90,0])
      rotate([0,0,-90])
      color([0,1,1])
      linear_extrude(height=120)
      polygon([
          [0 ,0],
          [72 - depth * 2,0],
          [72 - depth * 2,40],
          [72 - depth * 2,45],
          [-52,45],
          [-52,40]
      ]);
  }
}

module air_guides_1(x_offset=-59) {
  // #1
  translate([x_offset,80,15]) {
    rotate([0,0,90])
      rotate([90,0,0])
      linear_extrude(height=120)
      polygon([
          [ 0,0 ],
          [ -15,20 ],
          [ -25,30 ],
          [ -28,40 ],
          [ -28,45 ],
          [ -30,45 ],
          [ -30,40 ],
          [ -27,30 ],
          [ -17,20 ],
          [ -17,20 ],
          [ -2,0 ]
      ]);
  }

  // #2
  translate([x_offset,88,15]) {
    rotate([0,0,90])
      rotate([90,0,0])
      linear_extrude(height=120)
      polygon([
          [ 2,0 ],
          [ 0,0 ],
          [ -8,20 ],
          [ -12,40 ],
          [ -12,45 ],
          [ -10,45 ],
          [ -10,40 ],
          [ -6,20 ]
      ]);
  }
  // #3
  translate([x_offset,95,15]) {
    rotate([0,0,90])
      rotate([90,0,0])
      linear_extrude(height=120)
      polygon([
          [ 0,0 ],
          [ 2,0 ],
          [ 8,20 ],
          [ 9,40 ],
          [ 9,45 ],
          [ 7,45 ],
          [ 6,40 ],
          [ 6,20 ],
          [ 0,0 ]
      ]);
  }

  // #4
  translate([x_offset,103,15]) {
    rotate([0,0,90])
      rotate([90,0,0])
      linear_extrude(height=120)
      polygon([
          [ 0,0 ],
          [ 2,0 ],
          [ 16,20 ],
          [ 28,40 ],
          [ 28,45 ],
          [ 26,45 ],
          [ 26,40 ],
          [ 14,20 ],
          [ 0,0 ]
      ]);
  }
}

module air_guides_2() {
  // 2
  translate([-50,151,15]) {
    rotate([90,0,0])
      linear_extrude(height=100)
      polygon([
          [0,0],
          [2,0],
          [15, 20],
          [20, 40],
          [20, 45],
          [18, 45],
          [18, 40],
          [13, 20]
      ]);
  }

  // 3
  translate([-34,151,15]) {
    rotate([90,0,0])
      linear_extrude(height=100)
      polygon([
          [0,0],
          [2,0],
          [15, 15],
          [32, 40],
          [32, 45],
          [30, 45],
          [30, 40],
          [13, 15],
          [0,2]
      ]);
  }
  // 4
  translate([-15,151,15]) {
    rotate([90,0,0])
      linear_extrude(height=100)
      polygon([
          [-4,0],
          [-2,0],
          [18, 14],
          [45, 40],
          [45, 45],
          [43, 45],
          [43, 40],
          [16, 14],
          [0,2]
      ]);
  }

  // 5
  translate([0,151,15]) {
    rotate([90,0,0])
      linear_extrude(height=100)
      polygon([
          [0,0],
          [2,0],
          [30, 6],
          [60, 40],
          [60, 45],
          [58, 45],
          [58, 40],
          [28, 8],
          [0,2]
      ]);
  }

}

module air_expander() {
  intersection() {
    air_guide();
    air_guides_2();
  }

  // air_guides_1();
  intersection() {
    air_guide();
    air_guides_1();
  }

  translate([-59,80,0]) {
    exhaust(height=16);
  }
}

module diff_two_smoothed_cubes(radius=5, x=130, y=119, z=8) {
  difference() {
    translate([-radius, -radius, 0]) {
      smoothed_cube(
          x=x + radius * 2,
          y=y + radius * 2,
          z=z,
          edge_1_2_radius=radius,
          edge_3_4_radius=radius,
          edge_5_6_radius=radius,
          edge_7_8_radius=radius
      );
    }

    smoothed_cube(
        x=x,
        y=y,
        z=z,
        edge_1_2_radius=radius,
        edge_3_4_radius=radius,
        edge_5_6_radius=radius,
        edge_7_8_radius=radius
    );
  }
}

// translate([-10,0,0]) {
// translate([-10,0,0]) {
  // rotate([0,70,0])
// }
// qt3_adapter_bounds();


// filter_enclosure();


// inner layer
module face_shield_inner_layer() {
  difference() {
    translate([0,0, 42]) {
      filter_enclosure(z=8, inside_z=8);
    }
    face_shield_screws();
  }
}

module face_shield_outer_layer() {
  difference() {
    translate([-65,51,90]) {
      color([0,1,0])
        diff_two_smoothed_cubes(z=13);
    }
    union() {
      translate([-65,46,90]) {
        cube([130,10,13]);
      }

      face_shield_screws();

    }
  }
}

module right_face_shield_screw() {
  translate([59.5,62,99]) {
    rotate([0,90,0])
      color([1,0,0])
    screw_with_nut(threaded_height=6, nut_type="");
  }
}

module face_shield_screws() {
  right_face_shield_screw();
  mirror([1,0,0]) right_face_shield_screw();

  translate([0,90, 0]) {
    right_face_shield_screw();
    mirror([1,0,0]) right_face_shield_screw();

  }

}

// face_shield_outer_layer();


// for (i=[0:1:30 * 360]) {
  // height = i / 360;
//
  // translate([0,0, height]) {
    // rotate([0,0,i])
//
    // translate([20,0,0]) {
      // sphere(r=2);
    // }
  // }
// }




// linear_extrude(height = 30, center = false, convexity = 10, twist = 360 * 5, $fn = 100)
// translate([20, 0, 0])
// circle(r = 2);
// face_shield_inner_layer();
// face_shield_screws();

  // translate([0,0, 35]) {
    // filter_enclosure(z=5, inside_z=5);
  // }
// }

// translate([0,0, 37]) {
  // filter_enclosure(z=8, inside_z=5);
// }
// filter(x=130, y=124, z=8);
// translate([-5,-5,40]) {
  // color([0,0,1])
  // filter_enclosure(x=130+10, y=124+10, z=8, inside_x=130, inside_y=124, inside_z=8);
// }
// filter();
// top_half_ring_right_side(screws_only=false, threaded_height=10);


// translate([0.75,0,0]) {
  // rotate([0,180,0]) {
    // local_fan();
  // }
// }
// translate([-2,0,0]) {
  // air_expander();
// }
battery_fan_enclosure();
// translate([0,120,0]) {
  rotate([0,180,0])
  local_fan();
// }
// qt3_filter_enclosure_and_adapter();
