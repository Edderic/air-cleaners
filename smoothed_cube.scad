use <smoothed_corner.scad>
use <smoothed_edge.scad>
$fn=100;
//    5   8
// 1   4
//    6   7
// 2   3
module smoothed_cube(
  radius_1=0,
  radius_2=0,
  radius_3=0,
  radius_4=0,
  radius_5=0,
  radius_6=0,
  radius_7=0,
  radius_8=0,
  x=300,
  y=200,
  z=100,
  edge_1_2_radius=0,
  edge_2_3_radius=0,
  edge_3_4_radius=0,
  edge_4_1_radius=0,
  edge_1_5_radius=0,
  edge_5_6_radius=0,
  edge_8_5_radius=0,
  edge_6_7_radius=0,
  edge_7_8_radius=0,
  edge_8_4_radius=0,
  edge_2_6_radius=0,
  edge_3_7_radius=0,
  edge_4_8_radius=0,
) {

  difference() {
    cube([x, y, z]);
    union() {
      // vertex 1 spacing
      translate([0,0,z - radius_1]) {
        color([0,0,1]) cube([radius_1, radius_1, radius_1]);
      }
      // edge between vertices 1 and 2
      color([1,0,0]) cube([edge_1_2_radius, edge_1_2_radius,z]);

      // vertex 2 spacing
      translate([0,0,0]) {
        color([0,0,1]) cube([radius_2, radius_2, radius_2]);
      }
      // edge between vertices 2 and 3
      color([1,0,0]) cube([x, edge_2_3_radius, edge_2_3_radius]);

      // vertex 3 spacing
      translate([x, 0, 0]) {
        rotate([-90,0,0])
          rotate([0,0,-180]) cube(radius_3);
      }

      // edge between vertices 3 and 4
      translate([x - edge_3_4_radius, 0, 0]) {
        color([1,0,0]) cube([edge_3_4_radius, edge_3_4_radius,z]);
      }

      // vertex 4 spacing
      translate([x, 0, z]) {
        color([1,0,0])  rotate([0,180,0]) cube(radius_4);
      }

      // edge between vertices 4 and 1
      translate([0,0,z-edge_4_1_radius]) {
        color([1,0,0]) cube([x, edge_4_1_radius, edge_4_1_radius]);
      }

      // edge from vertex 1 to 5
      translate([0, edge_1_5_radius, z - edge_1_5_radius]) {
        color([1,0,0]) cube([edge_1_5_radius,y - radius_5,edge_1_5_radius]);
      }

      // vertex 5 spacing
      translate([radius_5, y - radius_5, z]) {
        color([1,0,0])  rotate([0,180,0]) cube(radius_5);
      }

      // edge from vertex 2 to 6
      translate([0, edge_2_6_radius,0]) {
        color([1,0,0]) cube([edge_2_6_radius,y - edge_2_6_radius,edge_2_6_radius]);
      }

      // edge from vertex 3 to 7
      translate([x - edge_3_7_radius, edge_3_7_radius,0]) {
        color([1,0,0]) cube([edge_3_7_radius,y - edge_3_7_radius,edge_3_7_radius]);
      }

      // edge from vertex 4 to 8
      translate([x - edge_4_8_radius, edge_4_8_radius, z - edge_4_8_radius]) {
        color([1,0,0]) cube([edge_4_8_radius,y - edge_4_8_radius, edge_4_8_radius]);
      }

      // edge between vertices 5 and 6
      translate([0,y - edge_5_6_radius,0]) {
        color([1,0,0]) cube([edge_5_6_radius, edge_5_6_radius,z]);
      }

      // vertex 6 spacing
      translate([radius_6, y - radius_6, radius_6]) {
        color([1,0,0])  rotate([0,180,0]) cube(radius_6);
      }

      // edge between vertices 7 and 8
      translate([x - edge_7_8_radius,y - edge_7_8_radius,0]) {
        color([1,0,0]) cube([edge_7_8_radius, edge_7_8_radius,z]);
      }

      // vertex 7 spacing
      translate([x, y - radius_7, radius_7]) {
        color([1,0,0])  rotate([0,180,0]) cube(radius_7);
      }

      // edge between vertices 8 and 5
      translate([0,y - edge_8_5_radius,z-edge_8_5_radius]) {
        color([1,0,0]) cube([x, edge_8_5_radius, edge_8_5_radius]);
      }

      // vertex 8 spacing
      translate([x, y - radius_8, z]) {
        color([1,0,0])  rotate([0,180,0]) cube(radius_8);
      }

      // edge between vertices 6 and 7
      translate([0,y - edge_6_7_radius,0]) {
        color([1,0,0]) cube([x, edge_6_7_radius, edge_6_7_radius]);
      }

    }
  }

  // smooth edge from vertex 1 to 2
  translate([edge_1_2_radius, edge_1_2_radius, +radius_2]) {
    smoothed_edge(radius=edge_1_2_radius, height=z - radius_2 - radius_1);
  }

  // smooth corner vertex 2
  translate([radius_2, radius_2, +radius_2]) {
    smoothed_corner(radius=radius_2);
  }

  // smooth corner vertex 1
  translate([radius_1, radius_1, z - radius_1]) {
    rotate([-90,0,0]) smoothed_corner(radius=radius_1);
  }

  // smooth edge from vertex 2 to 3
  translate([radius_2,edge_2_3_radius,edge_2_3_radius]) {
    rotate([90,0,0])
      rotate([0,90,0])
      smoothed_edge(radius=edge_2_3_radius, height=x - radius_3 - radius_2);
  }

  // smooth corner vertex 3
  translate([x - radius_3, radius_3, radius_3]) {
    rotate([-90,0,0])
    rotate([0,0,-180]) smoothed_corner(radius=radius_3);
  }

  // smooth edge from vertex 3 to 4
  translate([x - edge_3_4_radius, edge_3_4_radius, +radius_3]) {
    rotate([0,0,90])
    smoothed_edge(radius=edge_3_4_radius, height=z - radius_4 - radius_3);
  }

  // smooth corner vertex 4
  translate([x-radius_4, radius_4, z - radius_4]) {
    rotate([0,180,0]) smoothed_corner(radius=radius_4);
  }

  // smooth edge from vertex 4 to 1
  translate([radius_1,edge_4_1_radius,z - edge_4_1_radius]) {
    rotate([0,0,0])
      rotate([0,90,0])
      smoothed_edge(radius=edge_4_1_radius, height=x - radius_4 - radius_1);
  }

  // smooth edge from vertex 1 to 5
  translate([edge_1_5_radius, radius_1, z - edge_1_5_radius]) {
    rotate([-90,0,0])
      smoothed_edge(radius=edge_1_5_radius, height=y - radius_1 - radius_5);
  }

  // smooth corner vertex 5
  translate([radius_5, y - radius_5, z - radius_5]) {
    rotate([180,0,0]) smoothed_corner(radius=radius_5);
  }

  // smooth edge from vertex 2 to 6
  translate([edge_2_6_radius, radius_2, edge_2_6_radius]) {
    rotate([0,-90,0])
      rotate([-90,0,0])
      smoothed_edge(radius=edge_2_6_radius, height=y - radius_2 - radius_6);
  }

  // smooth corner vertex 6
  translate([radius_6, y - radius_6,  radius_6 ]) {
    rotate([90,0,0])
    smoothed_corner(radius=radius_6);
  }

  // smooth edge from vertex 3 to 7
  translate([x - edge_3_7_radius, radius_3, edge_3_7_radius]) {
    rotate([0,180,0])
      rotate([-90,0,0])
      smoothed_edge(radius=edge_3_7_radius, height=y - radius_3 - radius_7);
  }
  // translate([edge_1_2_radius, edge_1_2_radius, +radius_2]) {
    // smoothed_edge(radius=edge_1_2_radius, height=z - radius_2 - radius_1);
  // }

  // smooth corner vertex 7
  translate([x-radius_7, y - radius_7,  radius_7 ]) {
    rotate([0,-90,0])
    rotate([90,0,0])
    smoothed_corner(radius=radius_7);
  }

  // smooth edge from vertex 4 to 8
  translate([x - edge_4_8_radius, edge_4_8_radius, z - edge_4_8_radius]) {
    rotate([0,90,0])
      rotate([-90,0,0])
      smoothed_edge(radius=edge_4_8_radius, height=y - radius_4 - radius_8);
  }

  // smooth corner vertex 8
  translate([x-radius_8, y - radius_8,  z - radius_8 ]) {
    rotate([0,180,0])
    rotate([90,0,0])
    smoothed_corner(radius=radius_8);
  }

  // smooth edge from vertex 5 and 6
  translate([edge_5_6_radius, y - edge_5_6_radius, +radius_6]) {
    rotate([0,0,-90])
    smoothed_edge(radius=edge_5_6_radius, height=z - radius_6 - radius_5);
  }

  // smooth edge from vertex 7 to 8
  translate([x - edge_7_8_radius, y - edge_7_8_radius, +radius_7]) {
    rotate([0,0,180])
    smoothed_edge(radius=edge_7_8_radius, height=z - radius_8 - radius_7);
  }

  // smooth edge from vertex 8 to 5
  translate([radius_5,y - edge_8_5_radius,z - edge_8_5_radius]) {
    rotate([-90,0,0])
      rotate([0,90,0])
      smoothed_edge(radius=edge_8_5_radius, height=x - radius_8 - radius_5);
  }

  // smooth edge from vertex 6 to 7
  translate([radius_7,y - edge_6_7_radius,edge_6_7_radius]) {
    rotate([180,0,0])
      rotate([0,90,0])
      smoothed_edge(radius=edge_6_7_radius, height=x - radius_6 - radius_7);
  }
}


edge_1_2_radius = 5;
edge_2_3_radius = 5;
edge_3_4_radius = 5;
edge_4_1_radius = 5;
edge_1_5_radius = 5;
edge_2_6_radius = 5;
edge_3_7_radius = 5;
edge_4_8_radius = 5;
edge_5_6_radius = 5;
edge_7_8_radius = 5;
edge_8_5_radius = 5;
edge_6_7_radius = 5;
radius_1 = 5;
radius_2 = 5;
radius_3 = 5;
radius_4 = 5;
radius_5 = 5;
radius_6 = 5;
radius_7 = 5;
radius_8 = 5;
x=300;
y = 200;
z=100;

// smoothed_cube(edge_1_2_radius=5, radius_2=5, radius_1=5, edge_2_3_radius=5);
// smoothed_cube(edge_1_2_radius=5, radius_2=5, radius_1=5, edge_2_3_radius=5, edge_3_4_radius=5, radius_3=5, radius_4=5, edge_4_1_radius=5, radius_5=5, edge_1_5_radius=5, edge_2_6_radius=5, radius_6=5, edge_3_7_radius=5, radius_7=5, edge_4_8_radius=5, radius_8 = 5, edge_5_6_radius=5, edge_7_8_radius=5, edge_8_5_radius=5, edge_6_7_radius=5);
  // smooth edge from vertex 6 to 7
// smoothed_cube(radius_1=5, radius_2=5, edge_1_2_radius=5, edge_2_3_radius=5, edge_4_1_radius=5, edge_1_5_radius=5, edge_2_6_radius=5);
// smoothed_cube(radius_1=5, radius_2=5, radius_3=5);
smoothed_cube(radius_1=5, radius_2=5, radius_3=5, radius_4=5, radius_5=5, radius_6=5, radius_7=5, radius_8=5);

  // smooth corner vertex 4
  // translate([x-radius_4, radius_4, z - radius_4]) {
    // rotate([0,180,0]) cube(radius_4);
  // }

  // smooth corner vertex 6
  // translate([radius_6, y - radius_6,  radius_6 ]) {
    // rotate([90,0,0])
    // smoothed_corner(radius=radius_6);
  // }

