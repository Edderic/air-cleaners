use <../common/smoothed_cube.scad>


module filter(x=209, y=101, z=35) {
  color([1,0,0]) smoothed_cube(x=x,y=y,z=z);
}


module filter_spacing() {
  color([1,0,0]) filter(z=35 + 15);
}
