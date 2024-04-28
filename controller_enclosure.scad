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

//color([0, 0.5, 0.7])
translate([30, -30, 0])
rotate([90, 0, 90])
scale([0.1, 0.1, 0.1])
linear_extrude(height = 20, center = true, scale=1.0)
import(file = "logo.svg", center = true, dpi = 96);

difference() {
    EnclosureBase();

    translate([
        pcb_slot_height / 2 * (-1),
        pcb_slot_width / 2 * (-1),
        -10,
    ])
    cube([
        pcb_slot_height,
        pcb_slot_width,
        controller_height + 12,
    ]);
}

module ring(outer_diameter, inner_diameter, height) {
    difference() {
        cylinder(h=height, r=outer_diameter/2);
        translate([0, 0, -5])
        cylinder(h=height + 10, r=inner_diameter/2);
    }
}