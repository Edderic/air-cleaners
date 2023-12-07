use <filter_louvers_container.scad>

intersection() {
  filter_louvers_container();
  translate([0,0,-100]) {
    cube([200,200,200]);
  }
}
