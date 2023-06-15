use <screw_with_hex_nut.scad>

module side_holes(x=0, depth=5, height=50, fan_radius=60, threaded_height=6) {
  translate([x, 2 * depth, 2 * depth]) {
    rotate([90,0,90]) {
      color([1,0,0]) screw_with_hex_nut(threaded_height=threaded_height);
    }
  }

  // hole 2
  translate([x, 2 * depth, depth + height]){
    rotate([90,0,90]) {
      color([0,1,0]) screw_with_hex_nut(threaded_height=threaded_height);
    }
  }


  // hole 3
  translate([x, fan_radius * 2, depth + height]){
    rotate([90,0,90]) {
      color([0,0,1]) screw_with_hex_nut(threaded_height=threaded_height);
    }
  }

  // hole 4
  translate([x, fan_radius * 2, 2 * depth]){
    rotate([90,0,90]) {
      color([0,0,1]) screw_with_hex_nut(threaded_height=threaded_height);
    }
  }
}
