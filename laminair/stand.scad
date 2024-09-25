use <elbow.scad>
use <methods.scad>
use <screw_knob.scad>
use <../common/nut.scad>
$fn = 100;

wall_depth = get_wall_depth();
// swivel_joint();
support_height = 70;


washer_outer_diameter = 16.23;
screw_knob_threaded_height = get_screw_knob_threaded_height();
screw_knob_radius = get_screw_knob_radius();
screw_knob_head_height = get_screw_knob_head_height();
threaded_knob_center_to_wall_distance = get_threaded_knob_center_to_wall_distance();

hex_nut_height = get_hex_nut_height();
hex_nut_side_length = get_hex_nut_side_length();

// will handle the screw
difference() {
  union() {
    translate([0, screw_knob_threaded_height / 2, threaded_knob_center_to_wall_distance]) {
      color([0,0,1])
      rotate([90,0,0])
      linear_extrude(screw_knob_threaded_height)
      circle(washer_outer_diameter / 2);
    }

    translate([0,screw_knob_threaded_height / 2,  threaded_knob_center_to_wall_distance]) {
      rotate([0,90,0])
        rotate([90,0,0])
        color([0,1,0])
        linear_extrude(screw_knob_threaded_height)

        polygon(points=[
            [-washer_outer_diameter / 2,0],
            [-washer_outer_diameter / 2 - threaded_knob_center_to_wall_distance, -support_height],
            [washer_outer_diameter / 2 + threaded_knob_center_to_wall_distance * 0.5, -support_height],
            [washer_outer_diameter / 2, 0],
        ]);
    }
  }

  union() {
    swivel_joint(cylinder_scaler=0.6);

    translate([0,screw_knob_head_height + screw_knob_threaded_height / 2, threaded_knob_center_to_wall_distance]) {
      rotate([90,0,0])
        screw_knob();
    }
  }
}

difference() {
  // base
  translate([-support_height - wall_depth, 0, wall_depth]) {
    rotate([0,90,0])
      linear_extrude(wall_depth)
      circle(50);
  }
  // hex nut for tripod extension
  translate([-support_height - wall_depth -4, 0, -3]) {
    rotate([30,0,0])
    rotate([0,90,0])
      color([1,0,0])
      screw_knob(screw_head_height=0, screw_length=10);
  }
}
