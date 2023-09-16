use <../airgo_qt3/body.scad>

// filter_enclosure();
// rescale by 100 to get back to millimeters
function squared(a,b,c,d,x) = (a * (x/100) ^ 2 + b * (x/100) + c) * 100;
function cubic(a,b,c,d,x) = (a * (x/100) ^ 3 + b * (x/100) ^ 2 + c * (x/100) + d) * 100;
a = 0.40;
b = -0.98;
c = 1.316;
d = -0.198;
points_1 = [ for (x=[0:1:150]) [x, cubic(a=a, b=b, c=c, d=d, x=x)]];
points_2 = [ for (x=[150:-1:0]) [x + 2, cubic(a=a, b=b, c=c, d=d, x=x)]];
mirror_points_a = [ for (x=[0:1:150]) [x + 25, cubic(a=a, b=b, c=c, d=d, x=x)]];
mirror_points_b = [ for (x=[150:-1:0]) [-x - 25, cubic(a=a, b=b, c=c, d=d, x=x)]];
height = 80;

// polygon(points=points_1);
// scale([1,10,1]) {

module one_side_diffuser(height=80) {
  for (x=[0:1:10]) {
    translate([-x * 2.5,0,0]) {
      scale([1 - x * 0.1,1,1]) {
        linear_extrude(height=80)
          polygon(points=concat(points_1, points_2));
      }
    }
  }
}

translate([25,0,0]) {
  one_side_diffuser(height=height);
}
mirror([1,0,0]) translate([25,0,0]) {
  one_side_diffuser(height=height);
}

translate([0,35,40]) {
  cube([2, 110,height], center=true);
}

linear_extrude(height=2)
polygon(points=concat(mirror_points_a, mirror_points_b));

translate([0,0,78]) {
  linear_extrude(height=2)
    polygon(points=concat(mirror_points_a, mirror_points_b));

}
