function get_tcore_powerbank_z() = 29;
module tcore_powerbank() {
  cube([70,70,get_tcore_powerbank_z()]);
  translate([70 / 5, 70 / 2, 20]) {
    color([1,0,0])
    cylinder(h=50, r=10);
  }
}

tcore_powerbank();

