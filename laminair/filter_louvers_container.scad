use <methods.scad>
use <../smoothed_cube.scad>

filter_x = get_filter_dim()[0];
filter_y = get_filter_dim()[1];
filter_z = get_filter_dim()[2];

filter_wall_depth = 2;
horizontal_wall_depth = filter_x;
filter_z_offset = 25.4 / 2;
front_cover_z = 20 * 2;

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


translate([
  -(get_wall_depth() * 2 + filter_x) / 2,
  -(get_wall_depth() * 2 + filter_y) / 2,
  front_cover_z / 2 - 1]) {
  color([1,0,0])
    smoothed_cube(
        x=get_wall_depth() * 2 + filter_x,
        y=get_wall_depth() * 2 + filter_y,
        z=front_cover_z
        );
}
