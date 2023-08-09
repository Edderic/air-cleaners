module tcore_powerbank() {
  cube([70,70,30]);
  translate([70 / 5, 70 / 2, 30]) {
    color([1,0,0])
    cylinder(h=5, r=10);
  }
}

tcore_powerbank();

