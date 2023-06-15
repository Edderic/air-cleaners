// 1.5^2 + y^2 = 3^2
// sqrt(3^2 - 1.5^2)
//       30
//    /   |
// 60  - 90
// cos(30) = x / 3
// x = 3 cos(30)
module hex(side_length=3) {
  points = [[0,0], [side_length, 0], [side_length / 2, side_length * cos(30)]];
  for (i=[0:1:5]) {
    rotate([0,0,i * 60]) polygon(points);
  }
}

module hex_nut(side_length=3, height=2) {
    linear_extrude(height=height) hex(side_length);

}
