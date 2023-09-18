module diffuser_fan_b(num_iters=5) {
  for (x=[0:1:num_iters]) {
    translate([0,-23,-33 + 6 * x]) {
      scale([1,1,1 -  x / num_iters])
      rotate([-60,0,0])
          cube([54,25,2], center=true);
    }
  }

}

module trapezoid(big_side_length=92, small_side_length_offset=23, height=14, extrude_height=2) {
  translate([-27,-16,91]) {
    rotate([0,0,180])
      rotate([0,90,0]) {
        linear_extrude(height=extrude_height)
          polygon(points=[
              [0,0],
              [big_side_length,0],
              [big_side_length-small_side_length_offset,height],
              [small_side_length_offset,height],
          ]);
      }
  }

}
module small_diffuser() {
  translate([0,0,45]) {
    diffuser_fan_b();
    mirror([0,0,1]) diffuser_fan_b();
  }

  trapezoid();


  module middle_blade() {
    cube([55,14,1], center=true);
  }
  translate([0,-23,42]) {
    middle_blade();
  }

  translate([0,-23,48]) {
    middle_blade();
  }
}

small_diffuser();
