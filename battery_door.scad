$fn = 100;
use <smoothed_cube.scad>

module stuff(
    depth=5,
    battery_height = 30 + 5 * 2,
    fan_radius = 60,
    oset = 1,
    smoothing_factor=1.5,
    type="object",
    y=9,
    z = 9
) {
  // door knob

  z_offset = battery_height / 2 - z / 2;
  translate([depth, -3, z_offset]) {
    if (type == "object")  {
      color([1,0,0]) smoothed_cube(
          x=3,
          y=y,
          z=z,
          radius_1 = smoothing_factor,
          radius_2=smoothing_factor,
          radius_3=smoothing_factor,
          radius_4=smoothing_factor,
          edge_1_2_radius=smoothing_factor,
          edge_2_3_radius=smoothing_factor,
          edge_3_4_radius=smoothing_factor,
          edge_1_5_radius=smoothing_factor,
          edge_2_6_radius=smoothing_factor,
          edge_3_7_radius=smoothing_factor,
          edge_4_8_radius=smoothing_factor
      );
    } else {
      // add some spacing so that it just fits
      color([1,0,0]) cube([3,y,9]);
    }
  }

  // body
  object_offset = type == "object" ? 1 : 0;

  translate([5,4,0]) {
    smoothed_cube(
      x=3,
      y=100 - depth - 5 - object_offset,
      z= battery_height,
      edge_1_2_radius=3
    );
  }


}

// stuff();
module battery_door(
    depth=5,
    battery_height = 29 + 5 * 2,
    fan_radius = 60,
    oset = 1,
    type="object"
) {
  // union() {
    color([1,0,1])
    stuff(battery_height=battery_height, type=type);

    // translate([4, -3, 19]) {
      // color([0,1,0]) cylinder(h=9, r=4);
    // }
  // }
}
//
// battery_door(type="spacing");
battery_door();
// remove();
  // to smoothen
