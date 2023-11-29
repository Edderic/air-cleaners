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

louver_sync();
