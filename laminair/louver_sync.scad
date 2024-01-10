use <methods.scad>
use <filter_louvers_container.scad>

filter_y = get_filter_dim()[1];

module louver_sync(radius_offset=0.3) {
  color([0,1,0])
    difference() {
      translate([get_filter_effective_dim()[0] / 2 - 3,0,18]) {
        cube([4, get_filter_effective_dim()[1] - 8,5], center=true);
      }
      louvers(radius=get_louver_radius() + radius_offset);
    }
}


module louver_sync_with_lever() {
  louver_sync();

  translate([get_filter_effective_dim()[0] / 2 - 5, get_filter_effective_dim()[1] / 2 - 6.5,24]) {
    cube([8,5,17], center=true);
  }

  translate([get_filter_effective_dim()[0] / 2 - 5, get_filter_effective_dim()[1] / 2 - 13,15.5]) {
    linear_extrude(height=5)
    polygon(points=[[0,0], [0, 4], [-4.25,4]]);
  }

}

louver_sync();

translate([get_filter_effective_dim()[0] / 2 - 3,0,18 + 6]) {

  cube([4,10, 8], center=true);
}
