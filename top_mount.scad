module top_mount(x) {
  translate([x, fan_radius * 2 + depth + 1, 2 * depth]) {
    rotate([-90,0,0]) color([0,0,1]) screw_with_hex_nut();
  }

  // top hole 2
  translate([x, fan_radius * 2 + depth + 1, height + depth ]) {
    rotate([-90,0,0]) color([0,1,0]) screw_with_hex_nut();
  }
}
