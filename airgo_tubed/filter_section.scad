use <tubing.scad>
use <cylindrical_diffuser.scad>
use <../shoulder_strap_half_ring.scad>

$fn=100;
radius = 120;
filter_z = 40;

module local_tubing(hole) {
  translate([0,45,-90]) {
    rotate([90,0,0])
      tubing(hole=hole);
  }
}

module filter_box() {
  translate([0,-2,-filter_z / 2]) {
    cube([200,100,filter_z], center=true);
  }
}

module stuff() {
  difference() {
    sphere(120);
    union() {
      translate([0,0,radius / 2]) {
        cube([radius * 2, radius * 2, radius], center=true);
      }
      filter_box();

    }
  }
}


module smoothen_back() {
  translate([0,-110,-110]) {
    scale([2,0.5,1]) {
      sphere(120);
    }
  }
}

module main() {
  difference() {
    intersection() {
      intersection() {
        translate([0,-38,0]) {
          cube([300,200,300],center=true);
        }
        stuff();
      }
      union() {
        scale([2.9,1,2]) {
          sphere(64);
        }

        translate([0,-50,-50]) {
          cube([300,150,150], center=true);
        }
      }
    }
    smoothen_back();

  }
}

scaler = 0.98;

module filter_section() {
  difference() {
    main();

    union() {

      translate([0,0,0]) {

        scale([scaler, scaler, scaler]) {
          difference() {
            main();
            translate([0,0,-filter_z / 2]) {
              cube([240,150, filter_z], center=true);
            }
          }
        }
      }
      local_tubing(hole=true);

      half_ring_right(screws_only=true);
      mirror([1,0,0]) half_ring_right(screws_only=true);
    }
  }

  local_tubing(hole=false);

  // translate([0,0,-118]) {
    // cylindrical_diffuser();
  // }
}

filter_section();

// translate([0,0,10]) {
// half_ring_right(screws_only=true);
// }

module half_ring_right(screws_only=false, nut_type="square") {
  translate([111,-49,-8]) {
    rotate([0,0,65]) {
      shoulder_strap_half_ring(screws_only=screws_only, nut_type=nut_type);
    }
  }
}



// smoothen_back();
