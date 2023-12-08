use <../airgowear/fan.scad>
use <../airgo_qt3/body.scad>
use <../cone.scad>

$fn = 100;

module outer_cone(width=64, height=50, cone_top_radius=32) {
  translate([0,0,170]) {
    rotate([180,0,0])
      color([1,0,0])
      cone(width=width, height=height, cone_top_radius=cone_top_radius);
  }
}

module neck_section(height=50, width=50) {
  difference() {
    outer_cone(height=height, width=width);

    translate([0,-90,150]) {
      cylinder(r = 7 * 25.4 / 2, h=100, center=true);
    }
  }
}

module neck_section_air_space(height=50) {
  translate([0,20,20]) {
    scale([0.97,0.85,0.9]) {
      neck_section(height=height);
    }
  }
}

module fan_filter(outlet_hole=false) {
  translate([-32,-17,0]) {
    translate([119 / 2,-20,165 ]) {
      rotate([-90,0,0])
        color([0,0,1]) filter();

    }
    fan(outlet_hole=outlet_hole);
  }
}

// difference() {
  // neck_section();
  // neck_section_air_space();
// }

// neck_section();

module outer_cone_with_hole(r=10, height=50, width=50, cone_top_radius=32) {
  difference() {
    outer_cone(height=height, width=width, cone_top_radius=cone_top_radius);
    cylinder_hole(r=r);
  }
}

module cylinder_hole(r=10, height=50) {
  translate([0,0,145]) {
    cylinder(h=height, r=r, center=true);
  }
}

module cylinder_hole_perimeter(outer_r=10, inner_r=8, height=50) {
  difference() {
    cylinder_hole(r=outer_r, height=height);
    cylinder_hole(r=inner_r, height=height);
  }
}

module support() {
  translate([0,0,150]) {
    cube([200, 3,100], center=true);
  }
}

module supports(cylinder_r=10, height=50, width=50, cone_top_radius=32) {
  intersection() {
    outer_cone_with_hole(r=cylinder_r, height=height, width=width, cone_top_radius=cone_top_radius);
    support();
  }

  intersection() {
    outer_cone_with_hole(r=cylinder_r, height=height, width=width, cone_top_radius=cone_top_radius);
    rotate([0,0,90])
      support();
  }

  intersection() {
    outer_cone_with_hole(r=cylinder_r, height=height, width=width, cone_top_radius=cone_top_radius);
    rotate([0,0,45])
      support();
  }

  intersection() {
    outer_cone_with_hole(r=cylinder_r, height=height, width=width, cone_top_radius=cone_top_radius);
    rotate([0,0,-45])
      support();
  }
}

module outer_cone_perimeter(scaler=0.95, height=50, width=64, cone_top_radius=32) {
  difference(){
    outer_cone(height=height, width=width, cone_top_radius=cone_top_radius);
    translate([0,0,3]) {
      scale([scaler,scaler,1]) {
        outer_cone(height=height, width=width, cone_top_radius=cone_top_radius);
      }
    }
  }
}


module air_curtain(middle_hole_radius=7, height=50, width=55, cone_top_radius=32) {
  difference() {
    translate([0,0,-15]) {
      union() {
        // fan outlet
        translate([0,0,140]) {
          color([0,0,1])
          cube([gdstime_blower_outlet_hole_dim()[0] + 6, gdstime_blower_outlet_hole_dim()[1] + 6, 5], center=true);
        }

        outer_cone_perimeter(height=height, width=width, cone_top_radius=cone_top_radius);
        supports(cylinder_r=middle_hole_radius, height=height, width=width - 2, cone_top_radius=cone_top_radius);
        translate([0,0,10]) {
          cylinder_hole_perimeter(
              outer_r=middle_hole_radius,
              inner_r=middle_hole_radius-2,
              height=height
              );
        }

        translate([0,0,3]) {
          difference() {
            outer_cone(width=width - 7, height=height - 8);
            translate([0,0,3]) {
              outer_cone(width=width - 10, height=height - 8);
            }
          }
        }

      }
    }
    union() {
      fan_filter();
      cylinder_hole(r=middle_hole_radius-1);

    }
  }

// outer_cone_with_hole();

}

air_curtain(middle_hole_radius=5, height=30, width=gdstime_blower_outlet_hole_dim()[0] + 4, cone_top_radius=gdstime_blower_outlet_hole_dim()[0] / 2 + 15);
// outer_cone_perimeter(height=30, width=gdstime_blower_outlet_hole_dim()[0] + 4, cone_top_radius=gdstime_blower_outlet_hole_dim()[0] / 2 + 15);
// supports(cylinder_r=7, height=30, width=gdstime_blower_outlet_hole_dim()[0] + 4 - 2, cone_top_radius=gdstime_blower_outlet_hole_dim()[0] / 2 + 15);
// fan_filter();
