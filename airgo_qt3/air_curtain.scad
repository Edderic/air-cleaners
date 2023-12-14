use <body.scad>

inside_x = 119;
inside_y = 112;
depth = 5;
$fn = 100;


module slow_holes(x_lim=30, y_lim=30, r=1) {
  for (x=[0:1:x_lim]) {
    for (y=[0:1:y_lim]) {
      translate([inside_x / 2 - x * inside_x / x_lim, inside_y / 2 - y * inside_y / y_lim,21]) {
        color([0,0,1])
          // cylinder(h=10, r=r, center = true);
          cube([r,r,10], center=true);
      }
    }
  }
}


difference() {
  filter_enclosure(z=20, trans_x=-130 / 2, trans_y=-124 / 2, trans_z=0);
  union() {
    filter(x_pos=0, y_pos=0, z_pos=-5);
    air_curtains();
    slow_holes(r=1.25);
  }
}

// color([0,0,1])
// cube([500,500,10], center=true);
    // filter(x_pos=0, y_pos=0, z_pos=-5);

// air_curtains();
// difference() {
  // filter_enclosure(z=10, trans_x=-130 / 2, trans_y=-124 / 2, trans_z=10);
  // air_curtains();
// }

module air_curtains() {
    curtain_top();
    mirror([1,0,0]) curtain_top();

    curtain_left();

    mirror([0,1,0])
    curtain_left();
}

module curtain(side=119, spacing_1=5, spacing_2=5, height=2) {
  color([1,0,0])
  linear_extrude(height=height)
    polygon(
        points=[
          [0,0],
          [spacing_1, spacing_2],
          [spacing_1, spacing_2 + side],
          [0, spacing_2 + spacing_2 + side]
        ]
    );
}

module curtain_left() {
  translate([4,3,0]) {
    rotate([0,0,90])
      curtain_top(side=inside_y - 2);
  }
}


module curtain_top(side=inside_y - 12) {
    translate([-inside_x / 2 - 2 *  depth,-inside_y /2 - depth ,20]) {
      rotate([0,45,0])
      curtain(side=side, spacing_1=15, spacing_2=10, height=2);
    }
}

// curtain_left();
// curtain_top();
// translate([0,0,0]) {
//
// }
// mirror([1,0,0]) curtain_top();
