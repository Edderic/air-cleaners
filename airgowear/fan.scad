$fn=100;

function gdstime_blower_outlet_hole_dim() = [62, 33, 10];
module fan_hole(depth=5, padding_radius=0) {

  color([0,1,1])
    rotate([90,0,0])
    cylinder(h=depth, r=40 + padding_radius);
}

module exhaust(depth=2, height=10) {
  difference() {
    cube([gdstime_blower_outlet_hole_dim()[0],gdstime_blower_outlet_hole_dim()[1],height]);

    translate([depth,depth,0]) {
      cube([gdstime_blower_outlet_hole_dim()[0] - depth * 2,gdstime_blower_outlet_hole_dim()[1] - depth * 2,height]);
    }
  }
}
module outlet_hole() {
  translate([0,0, 120]) {
    cube(gdstime_blower_outlet_hole_dim());
  }
}

module fan(outlet_x_width=1.5, outlet_y_width=1.5, outlet_hole=false) {
  outlet_x = gdstime_blower_outlet_hole_dim()[0];
  outlet_y = gdstime_blower_outlet_hole_dim()[1];

  cube([120, gdstime_blower_outlet_hole_dim()[1], 120]);

  if (outlet_hole) {
    difference() {
      outlet_hole();

      translate([outlet_y_width, outlet_x_width, 120]) {
        cube([outlet_x - 2 * outlet_x_width, outlet_y - 2 * outlet_y_width,10]);
      }
    }
  } else {
    outlet_hole();
  }

  translate([65,38,60]) {
    color([1,0,0])
    fan_hole();
  }
}

fan();


