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