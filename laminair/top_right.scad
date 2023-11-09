use <../cr_boxes/three_by_three/fan_container.scad>
use <../shoulder_strap_half_ring.scad>

module top_right(
  width,
  length,
  filter_x,
  filter_y,
  filter_z,
  grid_z,
  x_spacing,
  y_spacing,
  z_spacing
) {
  difference() {
    translate([width / 2, length / 2,0]) {
      fan_container(
          filter_z=filter_z,
          z=grid_z,
          x_spacing=x_spacing,
          y_spacing=y_spacing,
          z_spacing=z_spacing,
          width=width,
          length=length,
          top_left_corner_smoothed=false,
          bottom_left_corner_smoothed=false,
          bottom_right_corner_smoothed=false,
          top_right_corner_smoothed=true,
          edge_fan_top_smoothed=true,
          edge_fan_bottom_smoothed=false,
          edge_fan_right_smoothed=true,
          edge_fan_left_smoothed=false,
          edge_top_left_smoothed=false,
          edge_top_right_smoothed=true,
          edge_bottom_left_smoothed=false,
          edge_bottom_right_smoothed=false,
          top_screw_hole=false,
          left_screw_hole=true,
          bottom_screw_hole=true,
          right_screw_hole=false,
          long_wall="top-right"
            );
    }

    translate([filter_x / 2 + 10, filter_y / 2, (filter_z + grid_z) / 2]) {
      rotate([0,0,90])
        rotate([0,-90,0])
        shoulder_strap_half_ring(screws_only=true);
    }
  }

}

