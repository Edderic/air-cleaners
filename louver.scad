use <screw.scad>
$fn = 90;
module louver(filter_x, x_offset, cylinder_radius, distance_between_cylinders, casing_cylinder_length, with_holes=false) {
  difference() {
    difference() {

      rotate([90,0,0]) {
        rotate([0, 90, 0]) {

          // cylinder that attaches the louver to some structure
          translate([0, 0, x_offset]) {
            cylinder(h=casing_cylinder_length, r=cylinder_radius);
          }

          // cylinder that is meant to be attached to the direction synchronizer
          translate([0, distance_between_cylinders, x_offset * 1.5]) {
            cylinder(h=x_offset * 1.5, r=cylinder_radius);
          }

          // triangle
          translate([0, 0, x_offset * 3]) {
            rotate([0,0,90])
              linear_extrude(height=filter_x - 2 * x_offset) polygon(points=[[0,-2.5],[20 + distance_between_cylinders,0],[0, 2.5]]);
          }
        }
      }

      // remove extra of triangle
      translate([6,-5,20]) {
        cube([casing_cylinder_length,100,100]);
      }
    }

    if (with_holes) {
      translate([6,0, 15]) {
        rotate([0,90,0]) screw(threaded_height=6);
      }
    }
  }
}

depth = 5;
filter_x = 110;
top_z = 60;


// louver(filter_x=filter_x, x_offset=depth, cylinder_radius=3, distance_between_cylinders=15, casing_cylinder_length=filter_x + depth * 2);

// louver(filter_x=filter_x * 2, x_offset=depth, cylinder_radius=3, distance_between_cylinders=15, casing_cylinder_length=filter_x * 2+ depth * 2);

