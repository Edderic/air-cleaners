$fn=100;
radius = 120;
filter_z = 40;
module filter_box() {
  translate([0,0,-filter_z / 2]) {
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
  translate([0,-110,-80]) {
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

difference() {
  main();

  translate([0,0,0]) {

    scale([0.95, 0.95, 0.95]) {
      difference() {
        main();
        translate([0,0,-filter_z / 2]) {
          cube([240,150, filter_z], center=true);
        }
      }
    }
  }
}


// smoothen_back();
