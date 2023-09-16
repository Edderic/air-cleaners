use <tube_connector.scad>

module tube_m(height=20) {
  color([0,0,1])
  difference() {
    difference() {
      cylinder(h=height, r=25);
      cylinder(h=height, r=18);
    }

    tube_connector();
  }
}


tube_m();
