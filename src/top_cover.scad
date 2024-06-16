include <../lib/round_anything/polyround.scad>;
include <../config.scad>;


glue_flange_height = 5;
glue_flange_outer_diameter = 33.5;
glue_flange_inner_diameter = 31.5;
module TopCoverGlueFlange() {
    difference() {
        cylinder(d=glue_flange_outer_diameter, h=glue_flange_height);

        translate([0, 0, -1])
        cylinder(d=glue_flange_inner_diameter, h=glue_flange_height + 2);
    }
}

translate([0, 0, controller_height + 20 + 40 - glue_flange_height / 2])
TopCoverGlueFlange();

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

    difference () {
        translate([0, 0, controller_height + 20 + 40])
        union () {
            translate([0, 0, 8])
            rotate([180, 0, 0])
            //color([0.8, 0.8, 0.8])
            import("../lens24mm_2_5.stl", convexity=3);

            //color([0.9, 0.6, 0.6])
            //translate([0, 0, -6.5])
            //diffusor_oring_mount();

            ring(36, 33, 1);
            difference () {
                scale([1.0, 1.0, 1.0])
                rotate_extrude(angle = 360, convexity = 2, $fn = subdivisions)
                //linear_extrude(height = 2, center = true, scale=1.0)
                polygon(polyRound(topProfile(), 20), $fn = subdivisions);
                
                cylinder(r=24/2, h=40);
            }
        }
    }
/*
    translate([0, 0, 48.02])
    linear_extrude(height = 2, center = true, scale=1.0)
    polygon(polyRound(topProfile(), 20), $fn = subdivisions);
*/
}

TopCover();