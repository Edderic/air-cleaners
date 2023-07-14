use <screw_with_nut.scad>
use <top_screws_with_nuts.scad>
use <shoulder_strap_support_screws.scad>
use <battery_door.scad>
use <battery_door_with_switch.scad>
use <noctua_speed_controller.scad>
use <usbc_female.scad>

$fn = 100;

depth = 5;
fan_radius = 60;
oset = 1;
battery_height = 30 + 5 * 2 ;
battery_width = 100;

module second_removables(battery_width=100, depth=5) {
  // space for the door handle, left
  translate([-2, 0, 18]) {
    cube([10, depth, 10]);
  }

  // space for the other door handle, right
  translate([fan_radius * 2 + depth / 2, 0, 18.5]) {
    cube([10, depth, 10]);
  }

  // battery door right
  translate([123,2, 0.5]) {
    rotate([0, 0, 0]) battery_door_with_switch();
  }

  // battery door left
  translate([8,2, battery_height + depth + 1.5]) {
    rotate([0, 180, 0]) battery_door();
  }
}

module removables(battery_width=100, depth=5) {
  // space for battery
  translate([0, depth, 3]) {
    color([1, 0, 0]) cube([(fan_radius * 2 + depth * 2 + oset), battery_width - depth * 2, battery_height + oset]);
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
  translate([0,50,53]) {
    rotate([-90,0,0]) rotate([0,90,0]) shoulder_strap_support_screws();
  }

  // screws for shoulder strap ring right
  translate([fan_radius * 2 + 1,52,53]) {
    rotate([-90,0,0]) rotate([0,90,0]) shoulder_strap_support_screws();
  }

  // hole for noctua speed controller
  translate([fan_radius - depth * 2 ,15,12]) {
    color([1,0,0]) rotate([90,0,0]) noctua_speed_controller();
  }

  // edge 1 to smooth
  color([0,0,1]) cube([depth / 2, depth / 2, battery_height + depth * 2]);

  // edge 2 to smooth
  translate([fan_radius * 2 + depth + 3.5,0,0]) {
    color([0,0,1]) cube([depth / 2, depth / 2, battery_height + depth * 2]);
  }

  // edge 3 to smooth
  translate([fan_radius * 2 + depth + 3.5, battery_width - depth / 2,0]) {
    color([0,0,1]) cube([depth / 2, depth / 2, battery_height + depth * 2]);
  }

  // edge 4 to smooth
  translate([0, battery_width - depth / 2,0]) {
    color([0,0,1]) cube([0, depth / 2, battery_height + depth * 2]);
  }

  // usbc hole
  translate([fan_radius * 2 - depth * 3,battery_width - depth, battery_height / 2 + depth + depth / 2 - 1 / 2 ]) {
    color([1,0,0]) rotate([0,90,0])
      usbc_female();
  }

  // hole for battery meter
  translate([fan_radius + depth / 4 + 5 , fan_radius ,battery_height + depth - 1]) {
    color([1,0,0]) cylinder(h=5, r=10);
  }

}

module edge_smoothers(fan_radius, battery_height, depth) {


  // edge 1 smoother
  translate([depth / 2, depth / 2, 0]) {
    cylinder(h=battery_height + depth + 2, r=depth / 2);
  }

  // edge 2 smoother
  translate([fan_radius * 2 + depth + 3.5, depth / 2, 0]) {
    cylinder(h=battery_height + depth + 2, r=depth / 2);
  }


  // edge 3 smoother
  translate([fan_radius * 2 + depth + 3.5, battery_width - depth / 2, 0]) {
    cylinder(h=battery_height + depth + 2, r=depth / 2);
  }

  // edge 4 smoother
  translate([depth / 2, battery_width - depth / 2, 0]) {
    cylinder(h=battery_height + depth + 2, r=depth / 2);
  }
}


module one_filter_one_fan_battery_casing(battery_width=100, battery_height=30 + 5 * 2, depth=5, oset=1, fan_radius=60 ) {
  difference() {
    intersection() {
      union() {
        difference() {
          cube([(fan_radius * 2 + depth * 2+ oset), battery_width, battery_height + 2 * 3 + oset]);
          removables();
        }

        edge_smoothers(fan_radius, battery_height, depth);

      }
    }

    second_removables();
  }
}

one_filter_one_fan_battery_casing(battery_width, battery_height);

          // edge_smoothers(fan_radius, battery_height, depth);

// removables();
  // hex nuts at the bottom left

  // battery door left

  // translate([fan_radius * 2 + depth / 2, 0, 19]) {
    // color([0,1,0]) cube([10, depth, 10]);
  // }

