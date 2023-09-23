use <../shoulder_strap_half_ring.scad>
width = 50;
module ring(width_offset = 2, height=10, width=38.1) {
  difference() {
    cylinder(h=height, r=width / 2);
    cylinder(h=height, r=width / 2 - width_offset);
  }
}

module ring_with_flap(width, height=10, width_offset=2) {
  for (x=[0:1:10]) {
    translate([0,0,height + x]) {
      color([1,0,0])
        ring(height=1, width_offset=width_offset, width=width + x);
    }
  }

  ring(width=width, width_offset=1, height=height);
}

module cylindrical_diffuser(num_shells=14, step_size=3) {
  for (x=[0:step_size:num_shells]) {
    ring_with_flap(width - 3 * x, height=10 + x * 1.5, width_offset=1);
  }

  translate([0,0,5]) {
    cube([width,2,10], center=true);
  }

  rotate([0,0,90])
  translate([0,0,5]) {
    cube([width,2,10], center=true);
  }
}

cylindrical_diffuser();
