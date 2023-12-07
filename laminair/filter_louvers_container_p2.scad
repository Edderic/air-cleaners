use <filter_louvers_container.scad>

intersection() {
  translate([-200,0,-100]) {
    cube([200,200,200]);
  }

  filter_louvers_container();
}
