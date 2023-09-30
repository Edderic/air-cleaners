use <builder.scad>
use <../smoothed_cube.scad>
use <../screw_with_nut.scad>

$fn = 100;

filter_x = filter_dim()[0];
filter_y = filter_dim()[1];
filter_z = filter_dim()[2];

width = filter_x / get_num_fans();
spacing_x = get_spacing_x();
spacing_y = filter_y;

module top(x, y, z, depth, corners_smoothed=false, x_edges_smoothed=false) {
  corner_radius = corners_smoothed ? depth : 0;
  x_edge_radius = x_edges_smoothed ? depth : 0;

  smoothed_cube(
      x=x,
      y=y,
      z=z,
      radius_2=corner_radius,
      radius_3=corner_radius,
      radius_6=corner_radius,
      radius_7=corner_radius,
      edge_2_3_radius=depth,
      edge_2_6_radius=x_edge_radius,
      edge_6_7_radius=depth,
      edge_3_7_radius=x_edge_radius
      );
}

module some_fan() {
  translate([spacing_x, spacing_y,-filter_z - 27]) {
    local_fan();
  }
}



module cylinder_cube_screw(cyl=true, screw=true, cube_support=true, cylinder_offset=0) {
  // cylinder 1 (hole)
  if (cyl) {
    translate([-spacing_x - get_fan_size() / 2,get_fan_size() / 2,0]) {
      rotate([0,90,0])
        cylinder(h=spacing_x, r=get_depth() / 2 - 2 - cylinder_offset);
    }
  }

  if (cube_support) {
    // cube support
    translate([-spacing_x / 2 - get_fan_size() / 2 ,get_fan_size() / 2, -get_depth() / 2]) {
      color([0,1,0])
        cube([8,8,8], center=true);
    }
  }

  if (screw) {
    // screw 1
    translate([-spacing_x / 2 - get_fan_size() / 2,get_fan_size() / 2,-10]) {
      screw_with_nut(nut_type="None", threaded_height=8);
    }
  }
}

// one_side();

// rotate([0,0,180]) one_side();

module top_with_fan_spacing_and_screws() {

  translate([-spacing_x - get_fan_size() / 2,-spacing_y - get_fan_size() / 2, -get_depth() / 2]) {
    difference() {
      color([1,0,0])
      top(x=width, y = get_fan_size() + spacing_y * 2, z=get_depth(), depth=get_depth());

      some_fan();
    }
  }
}

module row_fan() {
  difference() {
    union() {
      top_with_fan_spacing_and_screws();
      cylinder_cube_screw(cube_support=true, screw=false, cyl=false);

      translate([-spacing_x,-get_fan_size(),0]) {
        cylinder_cube_screw(cyl=true, screw=false, cube_support=false, cylinder_offset=0.5);
      }

      rotate([0,0,180])
        cylinder_cube_screw(cube_support=true, screw=false, cyl=false);

      rotate([0,0,180])
        translate([-spacing_x,-get_fan_size(),0]) {
          cylinder_cube_screw(cyl=true, screw=false, cube_support=false, cylinder_offset=0.5);
        }
    }

    union() {
      cylinder_cube_screw(cube_support=false, screw=true, cyl=true);

      translate([-spacing_x,-get_fan_size(),0]) {
        cylinder_cube_screw(cyl=false, screw=true, cube_support=false);
      }

      rotate([0,0,180])
        cylinder_cube_screw(cube_support=false, screw=true, cyl=true);

      rotate([0,0,180])
        translate([-spacing_x,-get_fan_size(),0]) {
          cylinder_cube_screw(cyl=false, screw=true, cube_support=false);
        }
    }
  }

  finger_guard();
}


module finger_guard() {
  translate([0,0,0]) {
    for (x=[get_fan_size() / 2:-12:0]) {
      difference() {
        cylinder(h=get_depth() / 2, r=x);
        cylinder(h=get_depth() / 2, r=x - 3);
      }
    }
  }

  translate([0,0,2.5]) {
    cube([get_fan_size(), 3, get_depth() / 2], center=true);
    rotate([0,0,90])
      cube([get_fan_size(), 3, get_depth() / 2], center=true);
  }
}

// top_with_fan_spacing_and_screws();
row_fan();
