use <usbc_female.scad>
difference() {
  translate([-6.5,0,-5]) {
    cube([20,6,10]);
  }

  usbc_female();
}
