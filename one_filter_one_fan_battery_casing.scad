use <screw_with_nut.scad>
use <top_screws_with_nuts.scad>
use <shoulder_strap_support_screws.scad>
use <battery_door.scad>
use <battery_door_with_switch.scad>
use <noctua_speed_controller.scad>
use <usbc_female.scad>
use <smoothed_cube.scad>
use <speed_controller_support.scad>
use <tcore_powerbank.scad>

$fn = 100;

depth = 5;
fan_radius = 60;
oset = 1;
battery_height = 30 + 5 * 2 ;
battery_width = 100;

module second_removables(battery_width=100, depth=5) {
  // battery door right
  translate([123,1, 3]) {
    rotate([0, 0, 0]) battery_door_with_switch(type="spacing");
  }

  // battery door left
  translate([8,1, battery_height + depth -3]) {
    rotate([0, 180, 0]) battery_door(type="spacing");
  }
}

module removables(battery_width=100, depth=5, battery_height=29 + 5 * 2) {
  // space for battery
  translate([0, depth, 3]) {
    color([1, 0, 0]) cube([(fan_radius * 2 + depth * 2 + oset), battery_width - depth * 2 - 0, battery_height]);
  }

  // hole for fan wiring
  translate([10 , 80, -depth]) {
    color([0,0,1]) cube([20, 10, 20]);
  }

  // hex nuts at the bottom right
  translate([-10, 70, -132]) {
    rotate([90,0,0]) top_screws_with_nuts();
  }

  // hex nuts at the bottom left
  translate([-100, 70, -132]) {
    rotate([90,0,0]) top_screws_with_nuts();
  }

  // screws for shoulder strap ring left

  // screws for shoulder strap ring right
  translate([fan_radius * 2 + 1 - depth * 3,55,53]) {
    rotate([-90,0,0])  shoulder_strap_support_screws();
  }

  // hole for noctua speed controller
  translate([fan_radius - depth * 2 ,15,10]) {
    color([1,0,0]) rotate([90,0,0]) noctua_speed_controller();
  }

  // usbc hole
  translate([fan_radius * 2 - depth * 3,battery_width - depth, battery_height / 2 + depth + depth / 2 - 1 / 2 ]) {
    color([1,0,0]) rotate([0,90,0])
      usbc_female();
  }

  // hole for battery meter
  translate([fan_radius + depth / 4 + 5 , fan_radius ,battery_height]) {
    color([1,0,0]) cylinder(h=10, r=10);
  }

}



module one_filter_one_fan_battery_casing(battery_width=100, battery_height=30 + 5 * 2, depth=5, oset=1, fan_radius=60 ) {
  difference() {
    difference() {
      smoothed_cube(
          x=fan_radius * 2 + depth * 2+ oset,
          y=battery_width,
          z=battery_height + 2 * 3 + oset,
          radius_1=5,
          radius_4=5,
          radius_5=5,
          radius_8=5,
          edge_1_2_radius=5,
          edge_3_4_radius=5,
          edge_4_1_radius=5,
          edge_1_5_radius=5,
          edge_5_6_radius=5,
          edge_7_8_radius=5,
          edge_4_8_radius=5,
          edge_8_5_radius=5
          );

          // edge_smoothers(fan_radius, battery_height, depth);
      removables();
    }



    second_removables();
  }
}

one_filter_one_fan_battery_casing(battery_width, battery_height);
translate([+70,-1,0]) {
//
  speed_controller_support();
}

translate([10,25,12]) {
  color([0,0,1])
  tcore_powerbank();
}
  // battery door left
  // translate([8,1, battery_height + depth -3]) {
    // rotate([0, 180, 0]) battery_door(type="object");
  // }
// second_removables();
// removables();


  // hex nuts at the bottom left

  // battery door left

  // translate([fan_radius * 2 + depth / 2, 0, 19]) {
    // color([0,1,0]) cube([10, depth, 10]);
  // }

  // battery door left
  // translate([8,1, battery_height + depth ]) {
    // rotate([0, 180, 0]) battery_door();
  // }
  // battery door right
  // translate([123,1, 3]) {
    // rotate([0, 0, 0]) battery_door_with_switch(type="object");
  // }
// text('AirGo');

  // translate([fan_radius - depth * 2 ,15,10]) {
    // color([1,0,0]) rotate([90,0,0]) noctua_speed_controller();
  // }
  // hole for battery meter
