include <lib/round_anything/polyround.scad>;

include <config.scad>;
include <src/enclosure/base.scad>;

// Width and height of the square base plate.
baseplate_size = 20.0;
baseplate_height = 2.5;

// Configure here
groove_offset = 0.0;

text_deepness = 0.6;

translate([0, 0, baseplate_height])
diffusor_oring_mount(groove_offset= 0.0);

// 12, 7, 4.0

difference () {
    // Base plate
    translate([0, 0, 0])
    linear_extrude(height=baseplate_height)
    polygon(polyRound(baseplateProfile(), 20), $fn = subdivisions);

    translate([0, 0, baseplate_height - text_deepness])
    linear_extrude(height=text_deepness + 0.2) 
    text(str(groove_offset), size=6, font="Basier Circle Mono", halign="center", valign="center");
}

function baseplateProfile(extension=0,edgeRadius=10)=translateRadiiPoints(
    [
        [-baseplate_size, baseplate_size, 7],
        [baseplate_size, baseplate_size, 7],
        [baseplate_size, -baseplate_size, 7],
        [-baseplate_size, -baseplate_size, 7],
    ],
[0,0]
);
