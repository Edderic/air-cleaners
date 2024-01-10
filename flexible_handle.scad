use <common/screw_with_nut.scad>

module left_screw_nut() {
  translate([-93,0,5.5]) {
    rotate([180,0,0])
    screw_with_nut();
  }
}

module flexible_handle(screw) {
  if (!screw) {
    cube([246, 22, 5], center=true);
  }
  left_screw_nut();
  mirror([1,0,0])
    left_screw_nut();
}

module flexible_handle_for_laminair(fan_diameter, y_spacing, depth, filter_z, grid_z, screw=true) {
  translate([0,fan_diameter + y_spacing + depth + 6,(filter_z + grid_z)/ 2]) {
    rotate([-90,0,0])
      flexible_handle(screw=screw);
  }
}

flexible_handle();


