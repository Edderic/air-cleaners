use <builder.scad>
use <row_fan.scad>

filter_y = filter_dim()[1];
fan_size = get_fan_size();
depth = get_depth();
corner_z = get_corner_z();



module corner() {
  difference() {

    // translate([-depth, -(filter_y * 2 + fan_size) / 2, 0]) {
    union() {

      cube([depth,filter_y * 2 + fan_size,corner_z], center=true);

      mirror([0,1,0])
      translate([(get_spacing_x() + get_fan_size()) / 2 + 0.5,0, -corner_z / 2 + depth / 2]) {
        cylinder_cube_screw(cyl=false, screw=false, cube_support=true);
      }

      // cylinder 2
      translate([get_spacing_x() - 0.5,0,0]) {
        translate([(get_spacing_x() + get_fan_size()) / 2 + 0.5,0, -corner_z / 2 + depth / 2]) {
          cylinder_cube_screw(cyl=true, screw=false, cube_support=false);
        }
      }

      // cylinder 3 top
      translate([22,0,40]) {
        rotate([0,90,0])
          mirror([0,1,0])
          translate([get_spacing_x() - 0.5,0,0]) {
            translate([(get_spacing_x() + get_fan_size()) / 2 + 0.5,0, -corner_z / 2 + depth / 2]) {
              cylinder_cube_screw(cyl=true, screw=false, cube_support=false);
            }
          }
      }

      // cube top
    }
    union() {


      // cylinder screw hole 1
      mirror([0,1,0])
        translate([(get_spacing_x() + get_fan_size()) / 2 + 0.5,0, -corner_z / 2 + depth / 2]) {
          cylinder_cube_screw(cyl=true, screw=true, cube_support=false);
        }

      // cylinder 2 screw hole
      translate([get_spacing_x() - 0.5,0,0]) {
        translate([(get_spacing_x() + get_fan_size()) / 2 + 0.5,0, -corner_z / 2 + depth / 2]) {
          cylinder_cube_screw(cyl=false, screw=true, cube_support=false);
        }
      }

      // cylinder 3 screw hole
      translate([22,0,40]) {
        rotate([0,90,0])
          mirror([0,1,0])
          translate([get_spacing_x() - 0.5,0,0]) {
            translate([(get_spacing_x() + get_fan_size()) / 2 + 0.5,0, -corner_z / 2 + depth / 2]) {
              cylinder_cube_screw(cyl=false, screw=true, cube_support=false);
            }
          }
      }

      // cylinder 4 screw hole and cylinder
      translate([22,0,23]) {
        rotate([0,90,0])
          translate([(get_spacing_x() + get_fan_size()) / 2 + 0.5,0, -corner_z / 2 + depth / 2]) {
            cylinder_cube_screw(cyl=true, screw=true, cube_support=false);
          }
      }
    }
  }
}

corner();

