use <methods.scad>
use <../smoothed_cube.scad>
use <../screw_with_nut.scad>

$fn = 100;

// louver cylinder back
module louver_cylinder_back(front_cover_z, filter_x_effective, height, radius = 1.5) {
  translate([0,0,front_cover_z]) {
    rotate([0,90,0]) {
      cylinder(h=height, r=radius, center=true);
    }
  }
}


module louver() {
  translate([0,0,louver_z_start]) {
    louver_cylinder_back(front_cover_z, filter_x_effective, height = filter_x_effective - 4);
  }

  translate([0,0,louver_z_start + louver_z]) {
    louver_cylinder_back(front_cover_z, filter_x_effective, height=filter_x_effective + 4);
  }

  // louver body
  translate([0,0,filter_z_offset + louver_z + louver_radius]) {
    cube([filter_x_effective - 10, louver_radius * 2, louver_z], center=true);
  }
}

module louvers(louver_z=louver_z, num_louvers = 30) {
  for (x=[0:1:num_louvers / 2]) {
    translate([0,(x) * (louver_z + 1),0]) {
      louver();
    }
  }
  for (x=[0:1:num_louvers / 2]) {
    translate([0,-(x) * (louver_z + 1),0]) {
      louver();
    }
  }
}

filter_x = get_filter_dim()[0];
filter_y = get_filter_dim()[1];
filter_z = get_filter_dim()[2];

filter_effective_offset = 25.4 / 2;
filter_x_effective = filter_x - filter_effective_offset;
filter_y_effective = filter_y - filter_effective_offset;

filter_wall_depth = 2;
horizontal_wall_depth = filter_x;
filter_z_offset = 25.4 / 2;
front_cover_z = 15;

louver_radius = 1.5;
louver_z = 7;
louver_z_start = 3;
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

  translate([0,0,front_cover_z + get_wall_depth() * 1.5]) {
    color([0,0,1])
      cube([filter_x_effective, filter_y_effective, front_cover_z + filter_wall_depth * 2], center=true);
  }
}

louvers();
threaded_height = 8;
// screw
translate([filter_x / 2 - 5,0,filter_z - filter_z_offset - threaded_height]) {
  rotate([0,180,0])
    color([0,1,0])
  screw_with_nut(threaded_height=10, nut_type="None");
}
