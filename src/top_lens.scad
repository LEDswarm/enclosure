include <../config.scad>;

module TopLens () {
    rotate([180, 0, 0])
    color([0.5, 0.5, 0.5])
    scale([0.975, 0.975, 0.975])
    import("../lens_v2.stl", convexity=3);

    //translate([0, 0, controller_height + 20 + 40 + 28 + 2.5])
    //color([0.8, 0.8, 0.6])
    //cylinder(r=14.5, h=2.5);

    // How far the screw holes are placed from the center of the top enclosure.
    lens_screw_mount_screw_hole_center_distance = 11;

    translate([0, 0, -3])
    color([0.8, 0.8, 0.8])
    cylinder(r=15.5, h=1.0);

    // Lens Screw Extension (Hull Cylinders)
/*
    color([0.8, 0.8, 0.8])
    hull () {
        translate([0, 19.25, controller_height + 20 + 40 + 28 - 3])
        cylinder(r=2, h=1.5);
        translate([0, -19.25, controller_height + 20 + 40 + 28 - 3])
        cylinder(r=2, h=1.5);
    }
*/
}

TopLens();