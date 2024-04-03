use <methods.scad>
use <filter_louvers_container.scad>
use <../common/usbc_female.scad>
use <../common/smoothed_cube.scad>

filter_y = get_filter_dim()[1];
pushable_x = 4;
pushable_y = 10;
pushable_z = 8;

x_dim = 4.875;
x_offset = x_dim - 5;


module louver_sync(radius_offset=0.3125) {
  color([0,1,0])
    difference() {
      translate([get_filter_effective_dim()[0] / 2 - x_offset,0,20]) {
        cube([x_dim, get_filter_effective_dim()[1] - 8,6], center=true);
      }
      louvers(radius=get_louver_radius() + radius_offset);
    }
}


module louver_sync_with_lever() {
  louver_sync();

  translate([get_filter_effective_dim()[0] / 2 - 3,0,18 + 6 + 3]) {
    translate([-pushable_x / 2,-pushable_y / 2, -pushable_z / 2]) {

      smoothed_cube(
        x=4,
        y=10,
        z=8,
        edge_1_2_radius=2,
        edge_3_4_radius=2,
        edge_5_6_radius=2,
        edge_7_8_radius=2
      );
    }
  }

}

// louver_sync(radius_offset=get_louver_radius_offset() + 0.5);
louver_sync_with_lever();

