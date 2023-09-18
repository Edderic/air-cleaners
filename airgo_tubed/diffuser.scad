use <../airgo_qt3/body.scad>
use <tube_m.scad>
use <small_diffuser.scad>

// filter_enclosure();
// rescale by 100 to get back to millimeters
function squared(a,b,c,d,x) = (a * (x/100) ^ 2 + b * (x/100) + c) * 100;
function cubic(a,b,c,d,x) = (a * (x/100) ^ 3 + b * (x/100) ^ 2 + c * (x/100) + d) * 100;
a = 0.1545;
b = -0.0623;
c = 0.983;
d = -0.1439;
points_1 = [ for (x=[0:1:100]) [x, cubic(a=a, b=b, c=c, d=d, x=x)]];
points_2 = [ for (x=[100:-1:0]) [x + 2, cubic(a=a, b=b, c=c, d=d, x=x)]];
mirror_points_a = [ for (x=[0:1:100]) [x + 25, cubic(a=a, b=b, c=c, d=d, x=x)]];
mirror_points_b = [ for (x=[100:-1:0]) [-x - 25, cubic(a=a, b=b, c=c, d=d, x=x)]];
height = 90;

// polygon(points=points_1);
// scale([1,10,1]) {

module top_diffuser_half(height=80) {
  for (x=[0:1:10]) {
    translate([-x * 2.5,0,0]) {
      scale([1 - x * 0.1,1,1]) {
        linear_extrude(height=height)
          polygon(points=concat(points_1, points_2));
      }
    }
  }
}

module tubing(hole=false, y=-18) {
  if (hole) {
    translate([0,y,45]) {
      rotate([90,0,0])
        cylinder(h=height, r=18);
    }

  } else {
    translate([0,y,45]) {
      rotate([90,0,0])
        tube_m();
    }
  }
}

module diffuser_wall() {
  linear_extrude(height=2)
    polygon(points=concat(mirror_points_a, mirror_points_b));
}

module top_diffuser(height=80) {
  scale([1,0.5,1]) {
    translate([25,0,0]) {
      top_diffuser_half(height=height);
    }
    mirror([1,0,0]) translate([25,0,0]) {
      top_diffuser_half(height=height);
    }
    // center line.
    translate([0,38,46]) {
      cube([2, 105,height - 2], center=true);
    }

    diffuser_wall();

    translate([0,0,88]) {
      diffuser_wall();
    }


  }
}

top_diffuser(height=90);
translate([0,10,0]) {
  small_diffuser();
}

module small_diffuser_cover() {
  difference() {
    translate([463,10,5]) {
      difference() {

        color([1,0,0])
          scale([16,1,1]) {
            trapezoid(big_side_length=102, small_side_length_offset=29, height=18, extrude_height=4);
          }

        translate([-46,-1,3]) {

          scale([0.9,0.9,0.9]) {
            scale([16,1,1]) {
              trapezoid(big_side_length=102, small_side_length_offset=29, height=18, extrude_height=4);
            }
          }
        }
      }
    }

    union() {
      translate([0,10,0]) {
        small_diffuser();
      }

      tubing(hole=true);
    }
  }

  tubing();
}

small_diffuser_cover();
// tubing();
 // tr
// tubing(hole=true);

// translate([-2,10,5]) {
  // color([1,0,0])
  // trapezoid(big_side_length=102, small_side_length_offset=29, height=18, extrude_height=4);
// }


// translate([0,68,45]) {
  // color([1,0,0])
  // difference() {
    // cube([127 * 2, 44, 90], center=true);
    // cube([127 * 2 - 6, 44, 90 - 6], center=true);
  // }
// }



// cube([60,90,height]);
