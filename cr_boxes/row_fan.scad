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

module top(x, y, z, depth, corners_smoothed=false, x_edges_smoothed=false,
    x_spacing=10,
    y_spacing=10,
    z_spacing=10,
    edge_fan_top_smoothed=false,
    edge_fan_bottom_smoothed=false,
    edge_fan_left_smoothed=false,
    edge_fan_right_smoothed=false,
    edge_top_left_smoothed=false,
    edge_top_right_smoothed=false,
    edge_bottom_left_smoothed=false,
    edge_bottom_right_smoothed=false,
    top_left_corner_smoothed=false,
    top_right_corner_smoothed=false,
    bottom_left_corner_smoothed=false,
    bottom_right_corner_smoothed=false
) {
  corner_radius = corners_smoothed ? depth : 0;
  x_edge_radius = x_edges_smoothed ? depth : 0;

  top_edge_radius = edge_fan_top_smoothed ? depth : 0;
  bottom_edge_radius = edge_fan_bottom_smoothed ? depth : 0;
  left_edge_radius = edge_fan_left_smoothed ? depth : 0;
  right_edge_radius = edge_fan_right_smoothed ? depth : 0;

  top_left_edge_radius = edge_top_left_smoothed ? depth : 0;
  top_right_edge_radius = edge_top_right_smoothed ? depth : 0;
  bottom_right_edge_radius = edge_bottom_right_smoothed ? depth : 0;
  bottom_left_edge_radius = edge_bottom_left_smoothed ? depth : 0;

  top_left_corner_radius = top_left_corner_smoothed ? depth : 0;
  bottom_left_corner_radius = bottom_left_corner_smoothed ? depth : 0;
  top_right_corner_radius = top_right_corner_smoothed ? depth : 0;
  bottom_right_corner_radius = bottom_right_corner_smoothed ? depth : 0;


  difference() {
    smoothed_cube(
        x=x,
        y=y,
        z=z,
        radius_1=bottom_left_corner_radius,
        radius_4=bottom_right_corner_radius,
        radius_5=top_left_corner_radius,
        radius_8=top_right_corner_radius,
        edge_8_5_radius=top_edge_radius,
        edge_4_1_radius=bottom_edge_radius,
        edge_1_5_radius=left_edge_radius,
        edge_4_8_radius=right_edge_radius,
        edge_5_6_radius=top_left_edge_radius,
        edge_7_8_radius=top_right_edge_radius,
        edge_3_4_radius=bottom_right_edge_radius,
        edge_1_2_radius=bottom_left_edge_radius

        );
    translate([depth, depth,0]) {
      cube([x - 2 * depth , y - 2 * depth , z - depth]);
    }
  }
}


module some_fan(x_spacing="None", y_spacing="None", z_spacing="None") {
  _x_spacing = x_spacing == "None" ? spacing_x : x_spacing;
  _y_spacing = y_spacing == "None" ? spacing_y : y_spacing;
  _z_spacing = z_spacing == "None" ? -filter_z - 27 : z_spacing;

  translate([_x_spacing, _y_spacing,_z_spacing]) {
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

module top_spaced(
    width,
    length="None",
    fan_hole=true,
    depth="None",
    trans_x="None",
    trans_y="None",
    z="None",
    x_spacing="None",
    y_spacing="None",
    z_spacing="None",
    edge_fan_top_smoothed=false,
    edge_fan_bottom_smoothed=false,
    edge_fan_left_smoothed=false,
    edge_fan_right_smoothed=false,
    edge_top_left_smoothed=false,
    edge_top_right_smoothed=false,
    edge_bottom_left_smoothed=false,
    edge_bottom_right_smoothed=false,
    top_left_corner_smoothed=false,
    top_right_corner_smoothed=false,
    bottom_left_corner_smoothed=false,
    bottom_right_corner_smoothed=false
    ) {
      // x_spacing: the space in the x direction between the edge of a fan and edge
      // the container
      _depth = depth == "None" ? get_depth() : depth;
      _trans_x = trans_x == "None" ? -width / 2 : trans_x;
      _trans_y = trans_y == "None" ? -length / 2 : trans_y;
      _length = length == "None" ? get_fan_size() + y_spacing * 2 : length;
      _z = z == "None" ? _depth : z;

      difference() {
        translate([_trans_x,_trans_y, 0]) {
          color([1,0,0])
            top(x=width, y = _length, z=_z, depth=_depth,
                x_spacing=x_spacing,
                y_spacing=y_spacing,
                z_spacing=z_spacing,
                edge_fan_top_smoothed=edge_fan_top_smoothed,
                edge_fan_bottom_smoothed=edge_fan_bottom_smoothed,
                edge_fan_left_smoothed=edge_fan_left_smoothed,
                edge_fan_right_smoothed=edge_fan_right_smoothed,
                edge_top_left_smoothed=edge_top_left_smoothed,
                edge_top_right_smoothed=edge_top_right_smoothed,
                edge_bottom_left_smoothed=edge_bottom_left_smoothed,
                edge_bottom_right_smoothed=edge_bottom_right_smoothed,
                top_left_corner_smoothed=top_left_corner_smoothed,
                top_right_corner_smoothed=top_right_corner_smoothed,
                bottom_left_corner_smoothed=bottom_left_corner_smoothed,
                bottom_right_corner_smoothed=bottom_right_corner_smoothed
               );

        }
        if (fan_hole) {
          translate([x_spacing-width / 2, y_spacing-length / 2,z_spacing]) {
            local_fan(
              z_offset=0
            );
          }
        }
      }
    }

module row_fan(fan_hole=true) {
  rotate([180,0,0])
  difference() {
    union() {
      top_spaced(fan_hole=fan_hole, width=filter_x / get_num_fans());
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

  if (fan_hole) {
    finger_guard();
  }
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

// top_spaced();
row_fan(fan_hole=false);
