use <../common/smoothed_cube.scad>
use <../common/screw.scad>
use <methods.scad>
$fn = 100;

filter_dims = get_filter_dim();
wall_depth = get_wall_depth();
screw_distance = 103;

// 1/4 inch screw knob
screw_knob_diameter = 25;
screw_length = 28;
screw_diameter = 6.3;

// 1/4 inch nut

// fan_diameter = get_fan_diameter();
fan_size = 120;

x = fan_size - 5;

small_screw_distance_width = 27.25;
y = small_screw_distance_width + 3 * 5;

support_thickness = 1/2;


module fan_hole(fan_size=120) {
  linear_extrude(wall_depth)
  circle(fan_size / 2);
}

translate_fan_hole_y = 67;

module swivel_joint() {
  difference() {
    union() {
      scale([1,1,0.55]) {
        translate([0,screw_length * support_thickness / 2,0]) {
          rotate([90,0,0])
            rotate([0,0,90])

            difference() {
              linear_extrude(height=screw_length * support_thickness)
                circle(screw_distance / 2);


              translate([-screw_distance / 4, 0,0]) {
                cube([screw_distance / 2, screw_distance, screw_distance * support_thickness], center=true);
              }
            }
        }
      }

      //                        screw distance
      //           X---------------------|---------------------X
      //           X-------------------------------------------X
      // -----------------------------------------------------------------
      translate([-x/2,-y/2,0]) {
        smoothed_cube(
            x = x,
            y = y,
            z = wall_depth,
            radius_1=wall_depth,
            radius_4=wall_depth,
            radius_8=wall_depth,
            radius_5=wall_depth,
            edge_4_1_radius=wall_depth,
            edge_4_8_radius=wall_depth,
            edge_8_5_radius=wall_depth,
            edge_1_5_radius=wall_depth
            );
      }
    }

    union() {
      // to unblock air flow
      translate([0, translate_fan_hole_y, 0]) {
        fan_hole();
      }

      // to unblock air flow
      translate([0, -translate_fan_hole_y, 0]) {
        fan_hole();
      }

      translate([0,20,screw_knob_diameter - 3]) {
        rotate([90,0,0])
          color([1,0,0])
          screw_knob();
      }

      // screw hole
      translate([-fan_size / 2 + 2 * wall_depth, small_screw_distance_width / 2,0]) {
        cylinder(h=20, r=2.5);
      }

      // screw hole
      translate([fan_size / 2 - 2 * wall_depth, small_screw_distance_width / 2,0]) {
        cylinder(h=20, r=2.5);
      }

      // screw hole
      translate([-fan_size / 2 + 2 * wall_depth, -small_screw_distance_width / 2,0]) {
        cylinder(h=20, r=2.5);
      }

      // screw hole
      translate([fan_size / 2 - 2 * wall_depth, -small_screw_distance_width / 2,0]) {
        cylinder(h=20, r=2.5);
      }

    }

  }
}

swivel_joint();
