use <top_diffuser_part_1.scad>
use <top_diffuser_part_2.scad>
use <diffuser.scad>

module top_diffuser(height=80) {

  top_diffuser_part_1(
      height=height,
      points_1=get_points_1(),
      points_2=get_points_2(),
      diffuser_wall_points_1=get_diffuser_points_1(),
      diffuser_wall_points_2=get_diffuser_points_2()
      );
  top_diffuser_part_2(
      );

}
