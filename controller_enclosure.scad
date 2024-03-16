include <lib/round_anything/polyround.scad>;
include <config.scad>;

include <led_pcb.scad>;

pcb_slot_height = 1.8;
pcb_slot_width = 27;
pcb_notch_scale = 0.02485593;

$fn = 128;

// Default screw length for the LED are 3 millimeters.
led_screw_length = 3.0;
bottom_screw_length = 3.0;

// The height of the controller base in millimeters, not including the LED base and diffusor attachment.
controller_height = 135;
// The radius of the controller base.
controller_radius = 15;
// The height of the LED cylinder.
led_base_height = 10;
// The diameter of the LED cylinder.
led_base_diameter = 23;
// The center of the o-ring can be translated inwards using this variable to adjust the pressure to a functional setting when the diffusor is attached.
led_oring_deepness = 2.0 * 1.35;

circle_resolution_fn = 512;

screw_diameter = 2.0;
// Ratio for sel-cutting plastic screws in brittle SLA printing materials like the ones from JLCPCB.
screw_hole_diameter = 0.83 * screw_diameter;

translate([0, 0, 165])
led_pcb();

/// PCB Mockup
union () {
    translate([0, -(26.70 / 2), -135 - 20])
    cube([1.0, 26.70, 135]);

    translate([0, -(11 / 2), -20])
cube([1.0, 11, 15]);
}


difference() {
    translate([10 - 9, -(9.3 / 2), -20])
    color([0.7, 0.7, 0.7])
    linear_extrude(height = 7.35) polygon(polyRound(usbcProfile(), $fn));

    translate([10 - 9, -(9.3 / 2), -19])
    color([0.7, 0.7, 0.7])
    linear_extrude(height = 8) polygon(polyRound(usbcProfileCutout(), $fn));
}

translate([11.3 - 9.3, -(6.4 / 2), -19])
color([0.7, 0.7, 0.7])
cube([0.6, 6, 6]);

function usbcProfile(extension=0,edgeRadius=10)=translateRadiiPoints(
    [
      [0, 0, 1],
      [3.26, 0, 1],
      [3.26, 9, 1],
      [0, 9, 1],
    ],
  [0,0]
);

function usbcProfileCutout(extension=0,edgeRadius=10)=translateRadiiPoints(
    [
      [0.3, 0.3, 0.7],
      [3.26 - 0.3, 0.3, 0.7],
      [3.26 - 0.3, 9 - 0.3, 0.7],
      [0.3, 9 - 0.3, 0.7],
    ],
  [0,0]
);

function braceProfile(extension=0,edgeRadius=10)=translateRadiiPoints(
    [
      [17, 0, 0],
      [20, 0, 0],
      [20, 5, 24],
      [15, 15, 24],
      [15, 20, 0],
      [12, 20, 0],
      [12, 15, 24],
      [17, 5, 24],
    ],
  [0,0]
);

module topExtender() {
  rotate_extrude(angle = 360, convexity = 2)
    polygon(polyRound(braceProfile(), $fn));
}

// Diffusor
//    translate([0, 0, controller_height + 30])
//    color([0.7, 0.7, 0.7])
//    ring(40, 34, 40);

difference() {
    translate([0, 0, controller_height + 15.5])
    color([0, 0.9, 0.6])
    ring(34, 13, 4.99);

    translate([0, 0, controller_height + 19.5])
    color([0, 0.8, 0.5])
    cylinder(h=3, r=10.5);

    translate([8.5, 0, controller_height + 16])
    color([0, 0.8, 0.5])
    cylinder(h=4, r=1);

    translate([-8.5, 0, controller_height + 16])
    color([0, 0.8, 0.5])
    cylinder(h=4, r=1);
}


color([0, 0.5, 0.7])
difference() {
    union () {
        rotate([0, 180, 0])
        translate([0, 0, -155])
        topExtender();

        difference() {
          $fn=circle_resolution_fn;

          cylinder(h=controller_height, r=15);  // This is the main cylinder
          translate([0,0, -20]) cylinder(h=controller_height * 1.5, r=12.5); // The cylinder to be subtracted. The 'translate' function is used to ensure that this cylinder is centered properly.
           translate([
            pcb_slot_height / 2 * (-1),
            pcb_slot_width / 2 * (-1),
            -10,
           ])
           cube([
            pcb_slot_height,
            pcb_slot_width,
            controller_height * 1.2,
           ]);
        }
        
        // Bottom Screw Support Right
        translate([12, 0, 0])
        scale([0.5, 2.0, 1])
            cylinder(h = controller_height, r = 3.0, $fn = 100);
        
        // Bottom Screw Support Left
        translate([-12, 0, 0])
        scale([0.5, 2.0, 1])
            cylinder(h = controller_height, r = 3.0, $fn = 100);
    }
    
    // Subtract the screw holes from the final case
    translate([
        controller_radius - 2 * 1.25,
        0,
        -4,
    ])
        cylinder(h=10, r=screw_hole_diameter);
    
    // Subtract the screw holes from the final case
    translate([
        (controller_radius - 2 * 1.25) * -1,
        0,
        -4,
    ])
        cylinder(h=10, r=screw_hole_diameter);
}

module ring(outer_diameter, inner_diameter, height) {
    difference() {
        cylinder(h=height, r=outer_diameter/2);
        translate([0, 0, -5])
        cylinder(h=height + 10, r=inner_diameter/2);
    }
}

// O-Ring diffusor attachment
module diffusor_oring_mount() {
    color([0.9, 0.6, 0.6])
    translate([0, 0, 20])
    difference() {
        translate([0, 0, controller_height])
        ring(34 - 0.5, 26, 7);

        // O-Ring Cutout (Torus)
        translate([0, 0, controller_height + 2])
        ring(
            36,
            30.25,
            2.5 + 0.2
        );
    }
}

diffusor_oring_mount();