use <small_diffuser.scad>
use <top_diffuser.scad>
use <diffuser.scad>

module cylinder_screw_plate(radius=32) {
  translate([0,-8,0]) {
    difference() {
      translate([0,0,-5]) {

        color([0,1,0])
          linear_extrude(height=5)
          circle(r=radius);
      }


      translate([0,-radius / 2,-2.5]) {
        color([0,0,1])
          cube([radius * 2, radius, 5], center=true);

      }

    }
  }
}

module small_diffuser_cover() {
  translate([0,6,0]) {
      difference() {
        union() {

          translate([464,10,5]) {
            difference() {

              color([1,0,0])
                scale([16,1.08,1]) {
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

          cylinder_screw_plate();
          translate([0,0,95]) {
            cylinder_screw_plate();
          }
        }


        union() {
          translate([0,12,0]) {
            small_diffuser();
          }

          top_diffuser(height=90);

          tubing(hole=true);

          left_screw_front();
          right_screw_front();

          translate([0,0,90]) {
            rotate([0,180,0])
              union() {
                left_screw_front();
                right_screw_front();
              }
          }

        }
      }

  }

  tubing();
}

small_diffuser_cover();

