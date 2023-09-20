use <diffuser.scad>
use <top_diffuser_part_1.scad>

module top_left_screw_holder() {
  translate([-105.5,42,74.55]) {
    cube([4,44,18]);
  }
}


module top_diffuser_part_2() {
  difference() {
    union() {
      scale([1.025,1,1]) {
        union() {
          translate([0,0,90]) {
            color([0,0,1])
              scale([1,1,1.2]) {
                diffuser_wall(
                    points_1=get_diffuser_points_1(),
                    points_2=get_diffuser_points_2()
                    );
              }
          }
          // filter_box wall
          translate([0,64,91]) {
            cube([203,44,3], center=true);
          }
        }

      }

      top_left_screw_holder();
      mirror([1,0,0])
        top_left_screw_holder();
    }

    union() {
      left_side_screw();
      left_side_screw_bottom();
      mirror([1,0,0]) {
        left_side_screw();
        left_side_screw_bottom();
      }
      left_screw_front();
      right_screw_front();
    }
  }
}
top_diffuser_part_2();
