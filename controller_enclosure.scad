include <lib/round_anything/polyround.scad>;
include <config.scad>;

include <src/enclosure/base.scad>;
include <src/controller_pcb.scad>;

include <../NeoPixelRing/openscad/board/board.scad>;

// LED PCB Mockup
//
// translate([0, 0, 165])
// rotate([0, 0, 90])
// BoardPcb();

color([0, 0.5, 0.7])
difference() {
    EnclosureBase();

}

module ring(outer_diameter, inner_diameter, height) {
    difference() {
        cylinder(h=height, r=outer_diameter/2);
        translate([0, 0, -5])
        cylinder(h=height + 10, r=inner_diameter/2);
    }
}