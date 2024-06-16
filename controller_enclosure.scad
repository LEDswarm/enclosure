include <lib/round_anything/polyround.scad>;
include <config.scad>;

include <src/enclosure/base.scad>;
include <src/controller_pcb.scad>;
//include <src/top_lens.scad>;
//include <src/diffusor.scad>;

include <../NeoPixelRing/openscad/board/board.scad>;
include <../NeoPixelRing/openscad/config.scad>;

// LED PCB Mockup
//
//translate([0, 0, 160])
//rotate([0, 0, 90])
//BoardPcb();

color([0.8, 0.8, 0.8])
ControllerPcb();

//TopCover();

// 3mm Wall Thickness Measuring Cube
// translate([0, 16.5, 155])
// color([0.8, 0.8, 0.8])
// cube([3, 3, 3]);


//color([0, 0.5, 0.7])
translate([30, -30, 0])
rotate([90, 0, 90])
scale([0.1, 0.1, 0.1])
linear_extrude(height = 20, center = true, scale=1.0)
import(file = "logo.svg", center = true, dpi = 96);

//translate([0, 0, 0])
//import("./top_cover2.stl", convexity=3);

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
        controller_height + 10,
    ]);

    //
    // LED Screw Holes
    //
    translate([0, -led_pcb_screw_hole_center_distance, 155 - 2])
    cylinder(h=6.5, r=led_screw_hole_diameter / 2);

    translate([0, led_pcb_screw_hole_center_distance, 155 - 2])
    cylinder(h=6.5, r=led_screw_hole_diameter / 2);

    // Cut-out so we can look inside
    //translate([-100, -100, -10])
    //cube([200, 200, 130 + 10]);
}

difference() {
    translate([0, -led_pcb_screw_hole_center_distance, 155 - 5.5])
    cylinder(h=4.0, r=led_screw_hole_diameter / 2 + 1);

    translate([0, -led_pcb_screw_hole_center_distance, 155 - 8.5])
    cylinder(h=8.0, r=led_screw_hole_diameter / 2);
}

difference() {
    translate([0, led_pcb_screw_hole_center_distance, 155 - 5.5])
    cylinder(h=4.0, r=led_screw_hole_diameter / 2 + 1);

    translate([0, led_pcb_screw_hole_center_distance, 155 - 8.5])
    cylinder(h=8.0, r=led_screw_hole_diameter / 2);
}
