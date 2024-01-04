use <filter_louvers_container.scad>

// height_offset should be one-off from the height offset in filter_louvers_container

difference() {
  translate([132,0,12]) {
    color([1,0,0]) cube([10,10,10], center=true);
  }

  louver(radius=get_louver_radius() + get_louver_radius_offset(), height_offset=get_height_offset() - 1);

}
