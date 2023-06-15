module filler(back_length, depth, back_width, filter_height, filter_depth) {
  cube([back_length - 2 * depth, back_width - 2 * depth - filter_height, filter_depth]);
}

filler(238, 5, 156, 116, 44);

