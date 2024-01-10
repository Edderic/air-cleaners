module cone(width=5, height=10, cone_top_radius=8) {
  rotate_extrude(convexity=10, angle=360)
    polygon([[0,0], [width,0], [cone_top_radius, height], [0,height]]);
}
