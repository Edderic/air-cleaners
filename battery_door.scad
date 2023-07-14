$fn = 100;

module remove() {
  translate([0, 0, 29]) {
    color([1,1,0]) cube([8, 2, 20]);
  }

  translate([0, 0, -2]) {
    color([0,1,1]) cube([8, 2, 20]);
  }

  // make it easier to open the battery door
  translate([0, -3, 19]) {
    color([0,0,1]) cube([4, 4.5, 9]);
  }
}

module stuff(
    depth=5,
    battery_height = 30 + 5 * 2,
    fan_radius = 60,
    oset = 1,
) {
  // door knob
  translate([0, -3, 19]) {
    color([1,0,0]) cube([8, 9, 9]);
  }

  // door knob connection
  translate([0, 0, 19]) {
    color([0,1,0]) cube([3, 6, 9]);
  }

  translate([-3, 3, 19]) {
    color([0,0,1]) cube([3, 3, 9]);
  }
  // door knob connection 2
  translate([-3, 5, 19]) {
    cube([8, 2, 9]);
  }

  // door knob connection 3
  translate([5, 5, 19]) {
    cube([3, 5, 9]);
  }

  // body
  difference() {
    translate([5,4,3]) {
      cube([3, 100 - depth - 5, battery_height ]);
    }
    translate([0, 0, 17]) {
      cube([10, 10, 12]);
    }
  }


  // joint
  translate([5,100 - 8,1.5]) {
    cylinder(h=battery_height + 3, r=3);
  }
}

// stuff();
module battery_door(
    depth=5,
    battery_height = 30 + 5 * 2,
    fan_radius = 60,
    oset = 1,
) {
  // union() {
    difference() {
      stuff();

      remove();
    }
    // translate([4, -3, 19]) {
      // color([0,1,0]) cylinder(h=9, r=4);
    // }
  // }
}
//
battery_door();
// remove();
  // to smoothen
