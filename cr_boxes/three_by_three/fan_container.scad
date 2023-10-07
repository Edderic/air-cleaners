use <../row_fan.scad>
// Lennox Model HCF14-13
// Replaces Filter Parn No. 19L14

grid_z = 25.4;
depth = 5;
num_fan_rows = 3;
num_fan_cols = 3;
filter_x = 508;
filter_y = 501.65;
filter_z = 111.125;
fan_diameter = 140;
width = (depth * 2 + filter_x) / num_fan_rows;
length = (depth * 2 + filter_y) / num_fan_cols;
x_spacing = (width - fan_diameter) / 2;
y_spacing = (length - fan_diameter) / 2;

module vertical_grid_wall() {
  cube([depth, length, grid_z], center=true);
}

top_spaced(
  depth=depth,
  width=width,
  length=length,
  x_spacing=x_spacing,
  y_spacing=y_spacing
);

module left_wall() {
  translate([-width / 2 + depth / 2,0, - grid_z / 2 + depth / 2 - depth]) {
    vertical_grid_wall();
  }
}

module top_wall() {
  translate([0, length / 2 - depth / 2, -grid_z / 2 - depth / 2]) {
    cube([width, depth, grid_z], center=true);
  }
}

// left side

left_wall();

mirror([1,0,0])
left_wall();


top_wall();

mirror([0,1,0])
top_wall();
