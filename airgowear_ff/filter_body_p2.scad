use <body.scad>

rotate([-45,0,0])
difference() {
  filter_body();
  translate([0, -200, -200]) {
    cube([200,400,400]);
  }
}
  // translate([0, -200, -200]) {
