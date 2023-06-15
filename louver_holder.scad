use <pac_p1.scad>
use <louvers.scad>
use <screw.scad>

module louver_holder(
    depth,
    filter_x,
    filter_y,
    fan_radius,
    back_x,
    back_y,
    top_z,
    screw_radius,
    screw_radius_holder,
    louver_holder,
    num_louvers=6,
    cylinder_radius=3,
    distance_between_cylinders=15
) {

  difference() {

    difference() {
      difference() {
        p1(
            depth,
            filter_x,
            filter_y,
            fan_radius,
            top_z,
            screw_radius,
            screw_radius_holder,
            louver_holder
        );
        translate([7.5, 7.5, -12]) {
          louvers(
              num_louvers=num_louvers,
              depth=depth,
              louver_separation=filter_y / (num_louvers),
              filter_x=filter_x,
              cylinder_radius=cylinder_radius,
              distance_between_cylinders=distance_between_cylinders
          );

        }
      };


      translate([0, back_y / 2, top_z / 2]) {
        rotate([0,90,0]) screw(
            screw_head_radius=3,
            screw_head_height=3,
            threaded_radius=1.5,
            threaded_height=10
        );
      }
    }

    translate([back_x / 2, 0, top_z / 2]) {
      rotate([-90,0,0]) screw(
          screw_head_radius=3,
          screw_head_height=3,
          threaded_radius=1.5,
          threaded_height=10
      );
    }
  }
}


num_cols = 2;
num_rows = 1;

depth = 5;
filter_x = 110;
filter_y = 116;
fan_radius = 60;
// top_z = 60; // fan/filter
top_z = 15; // filter/louver section
screw_radius = 2.5;
screw_radius_holder = 2.5;
louver_holder = true;

// Take the number of filters (rows and columns) into account
back_x = filter_x * num_cols > fan_radius * 2 ? filter_x * num_cols + depth * 2 : fan_radius * 2 + depth * 2 + 1;
back_y = filter_y * num_rows > fan_radius * 2 ? filter_y * num_rows + depth * 2 : fan_radius * 2 + depth * 2 + 1;

louver_holder(
    depth,
    filter_x,
    filter_y,
    fan_radius,
    back_x,
    back_y,
    top_z,
    screw_radius,
    screw_radius_holder,
    louver_holder
);

