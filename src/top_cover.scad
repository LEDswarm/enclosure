include <../lib/round_anything/polyround.scad>;
include <../config.scad>;

//include <./top_lens.scad>;

// O-Ring diffusor attachment
module diffusor_oring_mount() {
    difference() {
        translate([0, 0, 0])
        ring(34 - 0.5, 29.0, 6.75);

        // O-Ring Cutout
        translate([0, 0, 2])
        ring(
            36,
            30.25,
            3
        );
    }
}

module TopCover() {
    function topProfile(extension=0,edgeRadius=10)=translateRadiiPoints(
        [
        [18, 0, 0],
        [21, 0, 0],
        // Corner Bending Left-Up <->
        [21, 5, 8],
        [15, 8, 12],
        //[5, 15, 24],
        // Corner Bending Down-Right <->
        [5, 8, 0],
        [0, 8, 0],
        [0, 6, 0],
        [12, 6, 1],
        //[2, 10, 24],
        [12 + 2, 6 + 0.5, 8],
        ],
    [0,0]
    );

    //translate([0, 0, controller_height + 20 + 40 - 12])
    //TopLens();

    difference () {
        translate([0, 0, controller_height + 20 + 40])
        union () {
            //translate([0, 0, 8])
            //rotate([180, 0, 0])
            //color([0.8, 0.8, 0.8])
            //import("./lens24mm_2_5.stl", convexity=3);

            color([0.9, 0.6, 0.6])
            translate([0, 0, -6.5])
            diffusor_oring_mount();

            ring(36, 33, 1);
            difference () {
                scale([1.0, 1.0, 1.0])
                rotate_extrude(angle = 360, convexity = 2, $fn = subdivisions)
                //linear_extrude(height = 2, center = true, scale=1.0)
                polygon(polyRound(topProfile(), 20), $fn = subdivisions);
                
                cylinder(r=14.5, h=40);
            }
        }

        /*translate([0, 19.25, controller_height + 20 + 40 - 2])
        cylinder(r=top_cover_screw_diameter / 2, h=20);

        translate([0, 19.25, controller_height + 20 + 40 + 2])
        cylinder(r=2.0, h=20);

        translate([0, -19.25, controller_height + 20 + 40 - 2])
        cylinder(r=top_cover_screw_diameter / 2, h=20);

        translate([0, -19.25, controller_height + 20 + 40 + 2])
        cylinder(r=2.0, h=20);*/

        // Glue Cutout for Lens Attachment
        translate([0, 0, controller_height + 20 + 40 - 2])
        color([0.3, 0.3, 0.8])
        cylinder(r=16, h=8.0);
    }
/*
    translate([0, 0, 48.02])
    linear_extrude(height = 2, center = true, scale=1.0)
    polygon(polyRound(topProfile(), 20), $fn = subdivisions);
*/
}

TopCover();