use <filter_louvers_container.scad>
use <methods.scad>

filter_x = get_filter_dim()[0];
filter_y = get_filter_dim()[1];
filter_z = get_filter_dim()[2];

module right_deletion_block() {
  translate([filter_x / 2,0,5]) {
    cube([filter_x,filter_y + get_wall_depth() * 2 + 2 * get_square_side_length(),filter_z], center=true);
  }
}

module bottom_left_filter_p1(z_offset=-5) {
  difference() {
    filter_louvers_container();
    union() {
      right_deletion_block();

      rotate([0,0,90]) right_deletion_block();

      mirror([1,0,0]) translate([0,0,z_offset]) {
        right_deletion_block();
      }
    }
  }
}

bottom_left_filter_p1();
