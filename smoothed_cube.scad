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
      // edge between vertices 1 and 2
      color([1,0,0]) cube([edge_1_2_radius, edge_1_2_radius,z]);
      // edge between vertices 2 and 3
      color([1,0,0]) cube([x, edge_1_2_radius, edge_1_2_radius]);

      // edge between vertices 3 and 4
      translate([x - edge_3_4_radius, 0, 0]) {
        color([1,0,0]) cube([edge_3_4_radius, edge_3_4_radius,z]);
      }

      // edge between vertices 4 and 1
      translate([0,0,z-edge_4_1_radius]) {
        color([1,0,0]) cube([x, edge_4_1_radius, edge_4_1_radius]);
      }

      // edge from vertex 1 to 5
      translate([0, radius_1,z - edge_1_5_radius]) {
        color([1,0,0]) cube([edge_1_5_radius,y - radius_5,edge_1_5_radius]);
      }

      // edge from vertex 2 to 6
      translate([0, radius_1,0]) {
        color([1,0,0]) cube([edge_1_5_radius,y - radius_5,edge_1_5_radius]);
      }
    }
  }

  // smooth edge from vertex 1 to 2
  translate([edge_1_2_radius, edge_1_2_radius, +radius_2]) {
    smoothed_edge(radius=edge_1_2_radius, height=z - radius_2 - radius_1);
  }

  // smooth corner vertex 2
  translate([edge_1_2_radius, edge_1_2_radius, +radius_2]) {
    smoothed_corner(radius=radius_2);
  }

  // smooth corner vertex 1
  translate([edge_1_2_radius, edge_1_2_radius, z - radius_1]) {
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
  translate([edge_1_5_radius, y - radius_5, z - radius_5]) {
    rotate([180,0,0]) smoothed_corner(radius=radius_1);
  }

  // smooth edge from vertex 2 to 6
  translate([edge_2_6_radius, radius_2, edge_2_6_radius]) {
    rotate([0,-90,0])
      rotate([-90,0,0])
      smoothed_edge(radius=edge_2_6_radius, height=y - radius_1 - radius_5);
  }


  // smooth corner vertex 6
  translate([radius_6, y - radius_6,  radius_6 ]) {
    rotate([90,0,0])
    smoothed_corner(radius=radius_6);
  }
  // translate([edge_1_2_radius, edge_1_2_radius, +radius_2]) {
    // smoothed_edge(radius=edge_1_2_radius, height=z - radius_2 - radius_1);
  // }

}


edge_1_2_radius = 5;
edge_2_3_radius = 5;
edge_3_4_radius = 5;
edge_4_1_radius = 5;
edge_1_5_radius = 5;
edge_2_6_radius = 5;
radius_1 = 5;
radius_2 = 5;
radius_3 = 5;
radius_4 = 5;
radius_5 = 5;
radius_6 = 5;
x=300;
y = 200;
z=100;

// smoothed_cube(edge_1_2_radius=5, radius_2=5, radius_1=5, edge_2_3_radius=5);
smoothed_cube(edge_1_2_radius=5, radius_2=5, radius_1=5, edge_2_3_radius=5, edge_3_4_radius=5, radius_3=5, radius_4=5, edge_4_1_radius=5, radius_5=5, edge_1_5_radius=5, edge_2_6_radius=5, radius_6=5);
