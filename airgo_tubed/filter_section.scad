use <tubing.scad>
use <cylindrical_diffuser.scad>
use <../shoulder_strap_half_ring.scad>
use <diffuser_screws.scad>

$fn=100;
radius = 120;
filter_z = 40;
cylindrical_diffuser_z_offset = -56;
scaler = 0.98;
z_scaler = 0.6;


module local_tubing(hole) {
  translate([0,45,-40]) {
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
  scale([1,1,0.6]) {
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
}

module filter_section() {
  difference() {
    main();

    union() {

      scale([scaler, scaler, scaler]) {
        difference() {
          main();

          translate([0,0,-filter_z / 2 * z_scaler ]) {
            cube([240,200, filter_z * z_scaler], center=true);
          }
        }
      }
      local_tubing(hole=true);

      half_ring_right(screws_only=true);
      mirror([1,0,0]) half_ring_right(screws_only=true);

      // half_ring_right(screws_only=false);
      // mirror([1,0,0]) half_ring_right(screws_only=false);
    }
  }

  difference() {
    local_tubing(hole=false);
    diffuser_screws(z_offset=cylindrical_diffuser_z_offset-5);
  }

  // translate([0,0,-118]) {
    // cylindrical_diffuser();
  // }
}

module half_ring_right(screws_only=false, nut_type="square", threaded_height=10) {
  translate([114,-49,-10]) {
    rotate([0,0,65]) {
      shoulder_strap_half_ring(
          screws_only=screws_only,
          threaded_height=threaded_height,
          nut_type=nut_type);
    }
  }
}


filter_section();
// difference() {
  // local_tubing(hole=false);
  // diffuser_screws(z_offset=cylindrical_diffuser_z_offset-5);
// }


// half_ring_right(screws_only=false);



// smoothen_back();
