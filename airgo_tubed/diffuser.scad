use <../airgo_qt3/body.scad>
use <tube_m.scad>
use <small_diffuser.scad>
use <../screw.scad>
use <top_diffuser_part_1.scad>
use <top_diffuser_part_2.scad>
use <clavicle_support.scad>
use <small_diffuser_cover.scad>

// filter_enclosure();
// rescale by 100 to get back to millimeters
function squared(a,b,c,d,x) = (a * (x/100) ^ 2 + b * (x/100) + c) * 100;
function cubic(a,b,c,d,x) = (a * (x/100) ^ 3 + b * (x/100) ^ 2 + c * (x/100) + d) * 100;
a = -0.0917;
b = -0.201;
c = 0.987;
d = -0.268;
points_1 = [ for (x=[25:1:100]) [x, cubic(a=a, b=b, c=c, d=d, x=x)]];
points_2 = [ for (x=[100:-1:25]) [x + 2, cubic(a=a, b=b, c=c, d=d, x=x)]];
mirror_points_a = [ for (x=[25:1:100]) [x, cubic(a=a, b=b, c=c, d=d, x=x)]];
mirror_points_b = [ for (x=[100:-1:25]) [-x, cubic(a=a, b=b, c=c, d=d, x=x)]];
height = 90;
filter_x = 203;
function get_filter_y() = 44;
function get_filter_x() = 203;

function get_points_1() = points_1;
function get_points_2() = points_2;
function get_diffuser_points_1() = mirror_points_a;
function get_diffuser_points_2() = mirror_points_b;

// polygon(points=points_1);
// scale([1,10,1]) {
module diffuser_wall(points_1, points_2) {
  linear_extrude(height=2)
    polygon(points=concat(points_1, points_2));
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

module left_screw_front() {
  translate([-20,0,95]) {
    rotate([180,0,0])
      screw();
  }
}

module right_screw_front() {
  translate([20,0,95]) {
    rotate([180,0,0])
      screw();
  }
}

module filter_box(filter_x=203, filter_y=44, filter_z=93) {
  translate([0,64,46.5]) {
    color([1,0,0])
      difference() {
        cube([filter_x, filter_y, filter_z], center=true);
        cube([filter_x - 6, filter_y, filter_z - 6], center=true);
      }
  }
}

// left_screw_front();
// right_screw_front();
// translate([0,0,90]) {
  // rotate([0,180,0])
    // union() {
      // left_screw_front();
      // right_screw_front();
    // }
// }
//
// top_diffuser(height=90);
translate([0,12,0]) {
  small_diffuser();
}

// clavicle_support();

small_diffuser_cover();



// tubing();
 // tr
// tubing(hole=true);

// translate([-2,10,5]) {
  // color([1,0,0])
  // trapezoid(big_side_length=102, small_side_length_offset=29, height=18, extrude_height=4);
// }



// filter_box();
