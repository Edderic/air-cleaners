function get_tcore_powerbank_z() = 29;
function get_tcore_powerbank_x() = 70;
function get_tcore_powerbank_y() = 70;

module tcore_powerbank() {
  cube([get_tcore_powerbank_x(),get_tcore_powerbank_y(),get_tcore_powerbank_z()]);
  translate([get_tcore_powerbank_x() / 5, get_tcore_powerbank_y() / 2, 20]) {
    color([1,0,0])
    cylinder(h=50, r=10);
  }
}

tcore_powerbank();

