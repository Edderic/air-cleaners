use <../cr_boxes/three_by_three/fan_container.scad>

// SmartAir S filter dimensions
// in millimeters
// function get_filter_dim() = [10.5 * 25.4, 10.5 * 25.4, 96 - get_grid_z()];
function get_filter_dim() = [14.5 * 25.4, 11.25 * 25.4, 96 - get_grid_z()];

// Number of rows and number columns
function get_num_fan_enclosure_dim() = [2,2];

function get_wall_depth() = 5;

function get_fan_enclosure_width() = get_width(
    get_filter_dim()[0],
    get_wall_depth(),
    get_num_fan_enclosure_dim()[0]
);

function get_fan_enclosure_length() = get_length(
    get_filter_dim()[1],
    get_wall_depth(),
    get_num_fan_enclosure_dim()[1]
);

// How tall the walls need to be. The higher the value, the more separation
// there is between the fans and the filter.
function get_grid_z() = 15;

// function get_fan_diameter() = 120;
function get_fan_diameter() = 140;

function get_fan_to_wall_spacing_dim() = [
  get_x_spacing(get_fan_enclosure_width(), get_fan_diameter()),
  get_y_spacing(get_fan_enclosure_width(), get_fan_diameter()),
  get_grid_z() + 25
];
function z_outerwall_offset() = 27 * 1.25;

function get_square_side_length() = 8;

