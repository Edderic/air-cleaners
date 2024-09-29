use <../row_fan.scad>
use <../builder.scad>
use <../../common/screw_with_nut.scad>
use <../../common/usbc_female.scad>
use <../../laminair/filter_louvers_container.scad>
use <../../laminair/foot.scad>
// Lennox Model HCF14-13
// Replaces Filter Parn No. 19L14

grid_z = 1 * 25.4;
depth = 5;
num_fan_rows = 3;
num_fan_cols = 3;
filter_x = 508;
filter_y = 501.65;
filter_z = 111.125;
fan_diameter = 140;
function get_width(filter_x, depth, num_fan_rows) = ((depth * 2 + filter_x) / num_fan_rows);
function get_length(filter_y, depth, num_fan_cols) = ((depth * 2 + filter_y) / num_fan_cols);

function get_x_spacing(width, fan_diameter) = (width - fan_diameter) / 2;
function get_y_spacing(length, fan_diameter) = (length - fan_diameter) / 2;

width = get_width(filter_x, depth, num_fan_rows);
length = get_length(filter_y, depth, num_fan_cols);

x_spacing = get_x_spacing(width, fan_diameter);
y_spacing = get_y_spacing(length, fan_diameter);
threaded_height = 8;
cone_top_radius = 8;

function get_filter_dim() = [filter_x, filter_y, filter_z];
function get_grid_z() = grid_z;

function z_offset(long=false) = long ? -(grid_z + filter_z) / 2 - depth / 2 : -grid_z / 2 - depth / 2;

module wall_remover(long_wall, width, length, filter_z, z) {
  x_offset = long_wall == "center" ? 0 : long_wall == "top-left" || long_wall == "bottom-left" || long_wall == "left" ? depth : ((long_wall == "top" || long_wall == "bottom" || long_wall == "None") ? 0 : -depth);

  y_offset = long_wall == "top-left" || long_wall == "top" || long_wall == "top-right" ? -depth : (long_wall == "bottom-left" || long_wall == "bottom" || long_wall == "bottom-right" ? depth : 0);


  translate([x_offset,y_offset,filter_z/2]) {
    cube([width, length,filter_z], center=true);
  }


}

module top_left_zip_tie_hole(z_offset, depth, fan_size) {
  translate([fan_size / 2 - 2 * depth, fan_size / 2 - depth, z_offset + 5]) {
    usbc_female();
  }
}

module top_right_zip_tie_hole(z_offset, depth, fan_size) {
  mirror([1,0,0])
    top_left_zip_tie_hole(z_offset, depth, fan_size);
}

module bottom_right_zip_tie_hole(z_offset, fan_size, depth) {
  mirror([1,0,0])
  mirror([0,1,0])
  top_left_zip_tie_hole(z_offset, depth, fan_size);
}

module bottom_left_zip_tie_hole(z_offset, fan_size, depth) {
  mirror([0,1,0])
  top_left_zip_tie_hole(z_offset, depth, fan_size);
}

module screw_joins(
    bottom_right_stabilizer,
    bottom_right_stabilizer_axis,
    top_right_stabilizer,
    top_right_stabilizer_axis,
    bottom_left_stabilizer,
    bottom_left_stabilizer_axis,
    top_left_stabilizer,
    top_left_stabilizer_axis,
    depth,
    x_spacing,
    y_spacing,
    side,
    fan_size,
    filter_x,
    filter_y
) {
  // TODO: The code currently assumes depth (wall depth) is the same as the
  // screw_join depth. Might be good to decouple them at some point.
  if (bottom_right_stabilizer != "none" && bottom_right_stabilizer_axis == "horizontal") {
      if (bottom_right_stabilizer == "p1") {

        translate([-(filter_x + 2 * depth) / 4, -(filter_y + 2 * depth) / 4 - depth, side / 2]) {
          mirror([1,0,0])
            rotate([0,-90,0])
            rotate([0,0,90])
            screw_join_p1();
        }
      } else {
        translate([-(filter_x + 2 * depth) / 4,-(filter_y + 2 * depth) / 4 + 2 * depth,side / 2]) {
          rotate([0,-90,0])
          rotate([0,0,-180])
          screw_join_p2();
        }
      }
   }

  // TODO: use num_rows and num_cols to do the proper division
  if (bottom_right_stabilizer != "none" && bottom_right_stabilizer_axis == "vertical") {
    translate([-(filter_x + 2 * depth) / 4  + 2 * depth, -(filter_y + 2 * depth) / 4, side / 2]) {

        rotate([90,0,0])

        mirror([0,0,1])
        rotate([0,0,-180])
          screw_join_p1();
    }
   }
  if (top_left_stabilizer != "none" && top_left_stabilizer_axis == "vertical") {
    translate([(filter_x + 2 * depth) / 4 - depth * 2,(filter_y + 2 * depth) / 4,side / 2]) {
      // rotate([0,0,90])
      rotate([-90,0,0])
        mirror([0,0,1])
          screw_join_p1();
    }
  }

  if (top_left_stabilizer != "none" && top_left_stabilizer_axis == "horizontal") {
    translate([(filter_x + 2 * depth) / 4,(filter_y + 2 * depth) / 4 - depth - 5,side / 2]) {
      // mirror([1,0,0])
      // rotate([0,0,-90])
      rotate([0,90,0])
          screw_join_p2();
    }
  }


  if (top_right_stabilizer != "none" && top_right_stabilizer_axis == "horizontal") {
    translate([-(filter_x + 2 * depth) / 4, filter_y / 4 - depth - 2.5, side / 2]) {
      rotate([0,-90,0])
      rotate([0,0,90])
      mirror([0,0,1])
        screw_join_p1();
    }
  }

  if (top_right_stabilizer != "none" && top_right_stabilizer_axis == "vertical") {
    translate([-(filter_x + 2 * depth) / 4 + depth * 2, (filter_y + 2 * depth) / 4,side / 2]) {
      rotate([0,90,0])
      rotate([-90,0,0])
          screw_join_p2();
    }
  }

  if (bottom_left_stabilizer != "none" && bottom_left_stabilizer_axis == "vertical") {
    translate([(filter_x + 2 * depth) / 4 - depth - 5,-(filter_y + 2 * depth) / 4, side / 2]) {
      rotate([90,0,0])
      rotate([0,0,-90])
          screw_join_p2();
    }
  }

  if (bottom_left_stabilizer != "none" && bottom_left_stabilizer_axis == "horizontal") {
    translate([(filter_x + 2 * depth) / 4, -(filter_y + 2 * depth) / 4 + depth * 2, side / 2]) {
      rotate([-90,0,0])
      rotate([0,90,0])
        mirror([0,0,1])
          screw_join_p1();
    }
  }

}

module fan_container(
  long_wall,
  filter_z,
  z,
  x_spacing=x_spacing,
  y_spacing=y_spacing,
  z_spacing=filter_z,
  z_offset=15,
  left_wall_long=false,
  right_wall_long=false,
  top_wall_long=false,
  bottom_wall_long=false,
  top_screw_hole=false,
  bottom_screw_hole=false,
  left_screw_hole=false,
  right_screw_hole=false,
  edge_fan_top_smoothed=false,
  edge_fan_bottom_smoothed=false,
  edge_fan_left_smoothed=false,
  edge_fan_right_smoothed=false,
  edge_top_left_smoothed=false,
  edge_top_right_smoothed=false,
  edge_bottom_left_smoothed=false,
  edge_bottom_right_smoothed=false,
  left_front_edge_smoothed=false,
  right_front_edge_smoothed=false,
  top_left_corner_smoothed=false,
  top_right_corner_smoothed=false,
  top_right_front_corner_smoothed=false,
  bottom_left_corner_smoothed=false,
  bottom_right_corner_smoothed=false,
  bottom_left_front_corner_smoothed=false,
  bottom_right_front_corner_smoothed=false,
  bottom_front_edge_smoothed=false,
  top_left_front_corner_smoothed=false,
  top_front_edge_smoothed=false,
  bottom_right_zip_tie_hole=false,
  bottom_left_zip_tie_hole=false,
  top_right_zip_tie_hole=false,
  top_left_zip_tie_hole=false,
  width=width,
  length=length,
  fan_size=140,
  grid_z=25.4,
  depth=5,
  top_right_stabilizer="none",
  top_left_stabilizer="none",
  bottom_left_stabilizer="none",
  bottom_right_stabilizer="none",
  filter_x=filter_x,
  filter_y=filter_y,
  bottom_right_stabilizer_axis="horizontal",
  bottom_left_stabilizer_axis="horizontal",
  top_left_stabilizer_axis="vertical",
  top_right_stabilizer_axis="vertical",
  northeast_foot=false,
  southeast_foot=false,
  northwest_foot=false,
  southwest_foot=false,
  cone_top_radius=10

) {
  height = 10;
  side = 35 * 2 + 10;
  threaded_height = 8;
  stabilizer_height = threaded_height + 2;

  difference() {
    union() {

      difference() {

        top_spaced(
            z=z + filter_z,
            depth=depth,
            width=width,
            length=length,
            x_spacing=x_spacing,
            y_spacing=y_spacing,
            z_spacing=z_spacing,
            z_offset=z_offset,
            bottom_front_edge_smoothed=bottom_front_edge_smoothed,
            edge_fan_top_smoothed=edge_fan_top_smoothed,
            edge_fan_bottom_smoothed=edge_fan_bottom_smoothed,
            edge_fan_left_smoothed=edge_fan_left_smoothed,
            edge_fan_right_smoothed=edge_fan_right_smoothed,
            edge_top_left_smoothed=edge_top_left_smoothed,
            edge_top_right_smoothed=edge_top_right_smoothed,
            edge_bottom_left_smoothed=edge_bottom_left_smoothed,
            edge_bottom_right_smoothed=edge_bottom_right_smoothed,
            top_left_front_corner_smoothed=top_left_front_corner_smoothed,
            top_left_corner_smoothed=top_left_corner_smoothed,
            top_right_corner_smoothed=top_right_corner_smoothed,
            bottom_left_corner_smoothed=bottom_left_corner_smoothed,
            bottom_right_corner_smoothed=bottom_right_corner_smoothed,
            bottom_left_front_corner_smoothed=bottom_left_front_corner_smoothed,
            bottom_right_front_corner_smoothed=bottom_right_front_corner_smoothed,
            left_front_edge_smoothed=left_front_edge_smoothed,
            right_front_edge_smoothed=right_front_edge_smoothed,
            top_front_edge_smoothed=top_front_edge_smoothed,
            top_right_front_corner_smoothed=top_right_front_corner_smoothed,

            fan_diameter=fan_size
          );
          wall_remover(long_wall, width, length, filter_z, z);
      }

        translate([0.5,0.5,filter_z + z - depth ]) {
          // Add 2 to make sure there is awkward spacing
          finger_guard(fan_size=fan_size+3, depth=depth);
        }
    }
    union() {
      if (top_left_zip_tie_hole) {
        top_left_zip_tie_hole(fan_size=fan_size, z_offset=filter_z, depth=depth);
      }

      if (bottom_right_zip_tie_hole) {
        bottom_right_zip_tie_hole(fan_size=fan_size, z_offset=filter_z, depth=depth);
      }

      if (bottom_left_zip_tie_hole) {
        bottom_left_zip_tie_hole(fan_size=fan_size, z_offset=filter_z, depth=depth);
      }

      if (top_right_zip_tie_hole) {
        top_right_zip_tie_hole(fan_size=fan_size, z_offset=filter_z, depth=depth);
      }

      if (top_screw_hole) {
        top_screw_and_nut(length=length, filter_z=filter_z + 5);
      }

      if (bottom_screw_hole) {
        bottom_screw_and_nut(length=length, filter_z=filter_z + 5);
      }

      if (left_screw_hole) {
        left_screw_and_nut(
            length=length,
            width=width,
            grid_z=grid_z,
            threaded_height=threaded_height,
            filter_x=filter_x,
            filter_z=z + filter_z
            );
      }
      if (right_screw_hole) {
        right_screw_and_nut(
            length=length,
            width=width,
            grid_z=grid_z,
            threaded_height=threaded_height,
            filter_x=filter_x,
            filter_z=z + filter_z,
            depth=depth
            );

      }

      if (northeast_foot) {
        northeast_foot(filter_x=filter_x, filter_y=filter_y, z=filter_z, cone_top_radius=cone_top_radius, screw=true, height=height);
      }
      if (northwest_foot) {
        northwest_foot(filter_x=filter_x, filter_y=filter_y, z=filter_z, cone_top_radius=cone_top_radius, screw=true, height=height);
      }
      if (southeast_foot) {
        southeast_foot(filter_x=filter_x, filter_y=filter_y, z=filter_z, cone_top_radius=cone_top_radius, screw=true, height=height);
      }
      if (southwest_foot) {
        southwest_foot(filter_x=filter_x, filter_y=filter_y, z=filter_z, cone_top_radius=cone_top_radius, screw=true, height=height);
      }

    }
  }

  screw_joins(
    bottom_right_stabilizer=bottom_right_stabilizer,
    bottom_right_stabilizer_axis=bottom_right_stabilizer_axis,
    top_right_stabilizer=top_right_stabilizer,
    top_right_stabilizer_axis=top_right_stabilizer_axis,
    bottom_left_stabilizer=bottom_left_stabilizer,
    bottom_left_stabilizer_axis=bottom_left_stabilizer_axis,
    top_left_stabilizer=top_left_stabilizer,
    top_left_stabilizer_axis=top_left_stabilizer_axis,
    depth=depth,
    x_spacing=x_spacing,
    y_spacing=y_spacing,
    side=side,
    fan_size=fan_size,
    filter_x=filter_x,
    filter_y=filter_y
  );

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

module left_screw_and_nut(length, width, grid_z, threaded_height, filter_x, filter_z, depth=5) {
  translate([-(filter_x + 2 * depth) / 4 - depth ,0,filter_z - depth * 2]) {
    rotate([0,0,90])
    rotate([90,0,0])
      color([0,0,1])
      screw_with_nut(threaded_height=threaded_height);
  }
}

module right_screw_and_nut(length, width, grid_z, threaded_height, filter_x, filter_z, depth) {
  translate([width - 0.1,0,0]) {
    left_screw_and_nut(
        length=length,
        width=width,
        grid_z=grid_z,
        threaded_height=threaded_height,
        filter_x=filter_x,
        filter_z=filter_z,
        depth=depth
    );
  }
}

module southeast_foot(filter_x, filter_y, z=0, height=10, cone_top_radius=8, screw=false, num_rows=2, num_cols=2) {
  translate([
  -(filter_x + 2 * depth) / num_rows / 2 + cone_top_radius + depth / 2,
  -(filter_y + 2 * depth) / num_cols / 2 - cone_top_radius,
  cone_top_radius - depth / 2]) {
    foot(screw=screw, height=height);
  }
}

module southwest_foot(filter_x, filter_y, z=0, height=10, cone_top_radius=8, screw=false, num_rows=2, num_cols=2) {
  translate([
      (filter_x + 2 * depth) / num_rows / 2 - cone_top_radius - depth / 2,
      -(filter_y + 2 * depth) / num_cols / 2 - cone_top_radius,
      cone_top_radius - depth / 2]) {
    foot(screw=screw, height=height);
  }
}

module northeast_foot(filter_x, filter_y, z=0, cone_top_radius=8, screw=true, height=10, num_rows=2, num_cols=2) {
  translate([0,0,z - depth]) {
    southeast_foot(filter_x, filter_y, z=z, height=height, cone_top_radius=cone_top_radius, screw=screw, num_rows=num_rows, num_cols=num_cols);
  }
}

module northwest_foot(filter_x, filter_y, z=0, height=10, cone_top_radius=8, screw=false, num_rows=2, num_cols=2) {
  translate([0,0,z - depth]) {
    southwest_foot(filter_x, filter_y, z=z, height=height, cone_top_radius=cone_top_radius, screw=screw, num_rows=num_rows, num_cols=num_cols);
  }
}



fan_container(
  filter_z=filter_z,
  z=grid_z,
  top_left_corner_smoothed=true,
  bottom_left_corner_smoothed=true,
  bottom_right_corner_smoothed=true,
  top_right_corner_smoothed=true,
  edge_fan_top_smoothed=true,
  edge_fan_bottom_smoothed=true,
  edge_fan_right_smoothed=true,
  edge_fan_left_smoothed=true,
  edge_top_left_smoothed=true,
  edge_top_right_smoothed=true,
  edge_bottom_left_smoothed=true,
  edge_bottom_right_smoothed=true,
  top_screw_hole=true,
  left_screw_hole=true,
  bottom_screw_hole=true,
  right_screw_hole=true,
  left_wall_long=true,
  long_wall="top-left"
);

