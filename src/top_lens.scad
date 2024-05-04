include <../config.scad>;

top_lens_focal_length = 39;
top_lens_cylinder_height = 5;
top_lens_cylinder_radius = (top_lens_focal_length * top_lens_cylinder_height) / 2;

module lens() {
    scale([1.0, 1.0, 1.0])
    intersection() {
    }

    translate([0, 0, 20])
        cylinder(r=12, h=2, $fn=subdivisions);
}