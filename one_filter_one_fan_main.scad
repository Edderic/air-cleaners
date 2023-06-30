use <main_no_side_holes.scad>
use <top_screws_with_nuts.scad>

module remove() {
  translate([-10,0,0]) {
    top_screws_with_nuts();
  }
  translate([-100,0,0]) {
    top_screws_with_nuts();
  }
}


module one_filter_one_fan_main() {
  difference() {
    main_no_side_holes();
    remove();
  }
}

one_filter_one_fan_main();
