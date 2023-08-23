use <hex_nut.scad>


difference() {
  translate([0,0,-0.4]) {
    cube([10,10,4.5], center=true);
  }
  color([1,0,0]) hex_nut(side_length=3.6);
}
