use <methods.scad>
use <../smoothed_cube.scad>
use <../screw_with_nut.scad>

$fn = 100;
filter_x = get_filter_dim()[0];
filter_y = get_filter_dim()[1];
filter_z = get_filter_dim()[2];

filter_effective_offset = 25.4 / 2;
filter_x_effective = filter_x - filter_effective_offset;
filter_y_effective = filter_y - filter_effective_offset;
function get_filter_effective_dim() = [
  filter_x_effective,
  filter_y_effective
];

filter_wall_depth = 2;
horizontal_wall_depth = filter_x;
filter_z_offset = 25.4 / 2;
front_cover_z = 15;

louver_radius = 1.5;
function get_louver_radius() = louver_radius;
louver_z = 7;
louver_z_start = 3;

threaded_height = 8;
square_side = 8;

// louver cylinder back
module louver_cylinder_back(front_cover_z, filter_x_effective, height, radius = 1.5) {
  translate([0,0,front_cover_z]) {
    rotate([0,90,0]) {
      cylinder(h=height, r=radius, center=true);
    }
  }
}


module louver(radius, height_offset=4) {
  translate([0,0,louver_z_start]) {
    louver_cylinder_back(front_cover_z, filter_x_effective, height = filter_x_effective - 4, radius=radius);
  }

  translate([0,0,louver_z_start + louver_z]) {
    louver_cylinder_back(front_cover_z, filter_x_effective, height=filter_x_effective + height_offset, radius=radius);
  }

  // louver body
  translate([0,0,filter_z_offset + louver_z + louver_radius]) {
    cube([filter_x_effective - 10, radius * 2, louver_z], center=true);
  }
}

module louvers(louver_z=louver_z, num_louvers = 30, radius=louver_radius) {
  for (x=[0:1:num_louvers / 2]) {
    translate([0,(x) * (louver_z + 1),0]) {
      louver(radius=radius);
    }
  }
  for (x=[0:1:num_louvers / 2]) {
    translate([0,-(x) * (louver_z + 1),0]) {
      louver(radius=radius);
    }
  }
}

module filter_louvers_container() {

  // left wall
  translate([(-filter_x + filter_wall_depth) / 2 ,0,0]) {
    cube([filter_wall_depth, filter_y, filter_z - filter_z_offset], center=true);
  }

  // right wall
  translate([(-filter_wall_depth + filter_x) / 2 ,0,0]) {
    cube([filter_wall_depth, filter_y, filter_z - filter_z_offset], center=true);
  }

  translate([0,(-filter_y + filter_wall_depth) / 2,0]) {
    cube([filter_x, filter_wall_depth, filter_z - filter_z_offset], center=true);
  }


  difference() {
    translate([
        -(get_wall_depth() * 2 + filter_x) / 2,
        -(get_wall_depth() * 2 + filter_y) / 2,
        front_cover_z]) {
      color([1,0,0])
        smoothed_cube(
            x=get_wall_depth() * 2 + filter_x,
            y=get_wall_depth() * 2 + filter_y,
            z=front_cover_z,
            radius_1=get_wall_depth(),
            radius_4=get_wall_depth(),
            radius_5=get_wall_depth(),
            radius_8=get_wall_depth(),
            edge_1_2_radius=get_wall_depth(),
            edge_4_1_radius=get_wall_depth(),
            edge_3_4_radius=get_wall_depth(),
            edge_4_8_radius=get_wall_depth(),
            edge_7_8_radius=get_wall_depth(),
            edge_8_5_radius=get_wall_depth(),
            edge_1_5_radius=get_wall_depth(),
            edge_5_6_radius=get_wall_depth()
            );
    }

    union() {

      translate([0,0,front_cover_z + get_wall_depth() * 1.5]) {
        color([0,0,1])
          cube([filter_x_effective, filter_y_effective, front_cover_z + filter_wall_depth * 2], center=true);
      }

      louvers(radius=louver_radius + 0.25);
      rotate([0,0,90]) louvers(radius=louver_radius + 0.25);

      for (x=[0:1:3]) {
        rotate([0,0,90 * x])
          top_bottom_mid_right_z_joins();
      }

    }
  }

  top_and_bottom_screw_join();

  rotate([0,0,90])
    top_and_bottom_screw_join();

}

// screw
module screw(threaded_height=8) {
    rotate([0,180,0])
      color([0,1,0])
    screw_with_nut(threaded_height=threaded_height, nut_type="hex");
}
module right_screw() {
  translate([filter_x / 2 - 2.5,0,filter_z - filter_z_offset - threaded_height]) {
    screw();
  }
}


// top-right screw
module top_right_screw() {
  translate([0,filter_y / 2 - 3,0]) {
    right_screw();
  }
}

// screw();
// left screw
// mirror([1,0,0]) screw();

// top_right_screw();
// top-left screw
// mirror([1,0,0]) top_right_screw();
// bottom-right screw
// mirror([0,1,0]) top_right_screw();

// bottom-left screw
// mirror([1,1,0]) top_right_screw();


module screw_join_p1(side=10, threaded_height=10, screw_head_height = 0) {
  height = threaded_height + screw_head_height;

  // difference() {
      difference() {
        translate([-side / 2,-side / 2,-height / 2]) {
          smoothed_cube(
              x=side,
              y=side,
              z=height,
              edge_1_2_radius=side / 2
              );
        }
        union() {
          translate([0,0,6]) {
            screw();
          }
          translate([-side / 2,-side / 2,-height]) {
            color([0,1,0])
              smoothed_cube(
                  x=side,
                  y=side,
                  z=height,
                  edge_1_2_radius=side / 2
                  );
          }
        }
      }
}

module screw_join_p2(side=10, threaded_height=10, screw_head_height = 0) {
  height = threaded_height + screw_head_height;

  // difference() {
      difference() {
        translate([-side / 2,-side / 2,-height / 2]) {
          smoothed_cube(
              x=side,
              y=side,
              z=height,
              edge_1_2_radius=side / 2
              );
        }
        union() {
          translate([0,0,6]) {
            screw();
          }
          translate([-side / 2,-side / 2,0]) {
            color([0,1,0])
              smoothed_cube(
                  x=side,
                  y=side,
                  z=height,
                  edge_1_2_radius=side / 2
                  );
          }
        }
      }
}


module screw_join(side=10, part="p1") {
  if (part=="p1") {
    screw_join_p1(side);
  } else {
    screw_join_p2(side);
  }
}


module top_screw_join(z_offset = 1, x_offset=-2, part="p1") {
  translate(
    [
      (-threaded_height) / 2 + x_offset,
      filter_y / 2 + square_side,
      front_cover_z + square_side / 2 + z_offset
    ]
  ) {
    screw_join(part=part);
  }

}

module top_and_bottom_screw_join() {
  top_screw_join();
  mirror([0,1,0]) top_screw_join();
}


module mid_right_z_joins() {
  translate([filter_x / 2 - 2, filter_y / 4,filter_z - filter_z_offset - threaded_height + 2]) {
    screw();
  }
}

module top_bottom_mid_right_z_joins() {
  mid_right_z_joins();
  mirror([0,1,0]) mid_right_z_joins();
}


filter_louvers_container();
