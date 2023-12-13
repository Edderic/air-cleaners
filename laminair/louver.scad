use <filter_louvers_container.scad>

// height_offset should be one-off from the height offset in filter_louvers_container
louver(radius=1.5, height_offset=get_height_offset() - 1);
