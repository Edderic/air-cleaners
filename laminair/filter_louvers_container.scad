use <methods.scad>
use <../smoothed_cube.scad>
use <../screw_with_nut.scad>
use <../cone.scad>

$fn = 100;
filter_x = get_filter_dim()[0];
filter_y = get_filter_dim()[1];
filter_z = 10;

filter_x_with_offset = filter_x - 0.5;
filter_y_with_offset = filter_y - 0.5;

filter_effective_offset = 25.4 / 2;
filter_x_effective = filter_x - filter_effective_offset;
filter_y_effective = filter_y - filter_effective_offset;
function get_filter_effective_dim() = [
  filter_x_effective,
  filter_y_effective
];

filter_wall_depth = 2;
wall_offset = filter_wall_depth / 2;

horizontal_wall_depth = filter_x;
filter_z_offset = 0;
front_cover_z = 15;

louver_radius = 1.5;
function get_louver_radius() = louver_radius;
louver_z = 7;
louver_z_start = -10;

height_offset = 8;
function get_height_offset() = height_offset - 1;
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

module louvers(
    louver_z=louver_z,
    num_louvers = 30,
    radius=louver_radius,
    height_offset=height_offset
) {
  translate([0,0,-louver_z_start+3]) {
    for (x=[0:1:num_louvers / 2]) {
      translate([0,(x) * (louver_z + 1),0]) {
        louver(radius=radius, height_offset=height_offset);
      }
    }
    for (x=[0:1:num_louvers / 2]) {
      translate([0,-(x) * (louver_z + 1),0]) {
        louver(radius=radius, height_offset=height_offset);
      }
    }
  }
}

module filter_louvers_container(height_offset=height_offset) {
  translate([0,0,-filter_z_offset]) {

    // left wall
    translate([-(filter_x_with_offset) /2 + wall_offset, 0, 10]) {
      cube([filter_wall_depth, filter_y_with_offset, filter_z - filter_z_offset], center=true);
    }

    // right wall
    translate([-wall_offset + filter_x_with_offset / 2 ,0,10]) {
      cube([filter_wall_depth, filter_y_with_offset, filter_z - filter_z_offset], center=true);
    }

    // bottom wall
    translate([0,-filter_y_with_offset / 2 + wall_offset,10]) {
      cube([filter_x_with_offset, filter_wall_depth, filter_z - filter_z_offset], center=true);
    }

    // top wall
    translate([0,filter_y_with_offset / 2 - wall_offset,10]) {
      cube([filter_x_with_offset, filter_wall_depth, filter_z - filter_z_offset], center=true);
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

        louvers(radius=louver_radius + 0.1875, height_offset=height_offset);
        // rotate([0,0,90]) louvers(radius=louver_radius + 0.25);

        for (x=[0:1:3]) {
          rotate([0,0,90 * x])
            top_bottom_mid_right_z_joins();
        }

      }
    }
  }

  top_and_bottom_screw_join();

  rotate([0,0,90])
    top_and_bottom_screw_join();

  // screw_joins(
    // bottom_right_stabilizer=bottom_right_stabilizer,
    // bottom_right_stabilizer_axis=bottom_right_stabilizer_axis,
    // top_right_stabilizer=top_right_stabilizer,
    // top_right_stabilizer_axis=top_right_stabilizer_axis,
    // bottom_left_stabilizer=bottom_left_stabilizer,
    // bottom_left_stabilizer_axis=bottom_left_stabilizer_axis,
    // top_left_stabilizer=top_left_stabilizer,
    // top_left_stabilizer_axis=top_left_stabilizer_axis,
    // depth=depth,
    // x_spacing=x_spacing,
    // y_spacing=y_spacing,
    // side=side,
    // fan_size=fan_size
//
  // );

}

module top_screw_and_nut(length, filter_z) {
  screw_height = length / 2 + threaded_height -2.1;
  translate([0, screw_height,  filter_z]) {
    rotate([90,0,0])
      color([0,0,1])
      screw_with_nut(threaded_height=threaded_height);
  }
}

module bottom_screw_and_nut(length, filter_z=filter_z) {
  translate([0,-length,0]) {
    top_screw_and_nut(length=length, filter_z=filter_z);
  }
}

module left_screw_and_nut(length, width, grid_z, threaded_height, filter_z, depth=5) {
  translate([0,0,-depth * 2]) {
    rotate([0,0,90])
    top_screw_and_nut(length=length, filter_z=filter_z);
  }
}

module right_screw_and_nut(length, width, grid_z, threaded_height, filter_z) {
  translate([width - 0.1,0,0]) {
    left_screw_and_nut(
        length=length,
        width=width,
        grid_z=grid_z,
        threaded_height=threaded_height,
        filter_z=filter_z,
        depth=depth
        );
  }
}

module foot(fan_size=120, screw=false, height=10) {
  if (screw) {
    rotate([-90,0,0]) screw_with_nut(nut_type="none", threaded_height=10);
  } else {
    rotate([-90,0,0]) difference() {
      cone(height=height);
      screw_with_nut(nut_type="none", threaded_height=10);
    }
  }
}

module southeast_foot(fan_size=120, y_spacing=y_spacing, height=10, cone_top_radius=8, screw=false) {
  translate([-fan_size / 2 + depth / 2,-fan_size / 2 - y_spacing - (height), cone_top_radius]) {
    foot(fan_size, screw=screw, height=height);
  }
}

module southwest_foot(fan_size=120, y_spacing=y_spacing, height=10, cone_top_radius=8, screw=false) {
  translate([fan_size - depth,0,0]) {
    southeast_foot(fan_size=fan_size, y_spacing=y_spacing, height=height, cone_top_radius=cone_top_radius, screw=screw);
  }
}

module northeast_foot(z, fan_size=120, y_spacing=y_spacing, height=10, cone_top_radius=8, screw=false, depth=5) {
  translate([0,0,z - depth]) {
    southeast_foot(fan_size=fan_size, y_spacing=y_spacing, height=height, cone_top_radius=cone_top_radius, screw=screw);
  }
}

module northwest_foot(z, fan_size=120, x_spacing=x_spacing, y_spacing=y_spacing, height=10, cone_top_radius=8, screw=false, depth=5) {
  translate([fan_size - depth,0,0]) {
    northeast_foot(z, fan_size=fan_size, y_spacing=y_spacing, height=height, cone_top_radius=cone_top_radius, screw=screw, depth=depth);
  }
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
  // translate(
    // [
      // (-threaded_height) / 2 + x_offset,
      // filter_y / 2 + square_side,
      // front_cover_z + square_side / 2 + z_offset
    // ]
  // ) {

  translate([0,filter_y / 2 + square_side + 2,2.5 * square_side]) {
    rotate([-90,0,0])
    rotate([0,90,0])
      screw_join(part="p1");
  }

  mirror([1,0,0])
  translate([0,filter_y / 2 + square_side + 2,2.5 * square_side]) {
    rotate([-90,0,0])
    rotate([0,-90,0])
    rotate([0,0,90])
        screw_join(part="p2");
  }

}

module top_and_bottom_screw_join(part="p1") {
  top_screw_join(part=part);
  mirror([0,1,0]) top_screw_join(part=part);
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
// top_and_bottom_screw_join(part="p1");
louvers();
