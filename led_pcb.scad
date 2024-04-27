include <lib/round_anything/polyround.scad>;
include <config.scad>;

$fn=128;

led_pcb_diameter = 28.5;
led_pcb_height = 1.6;
led_pcb_screw_size = 2.0;

led_outward_translation = 7.3;

vertical_usb_port_width = 11.0;
vertical_usb_port_height = 4.1;

led_width = 5.0;
led_height = 5.0;

led_smd_pad_width = 1.5;
led_smd_pad_height = 1.0;
// How many millimeters the pad is inset from the edge of the LED.
led_smd_pad_inset = 0.4;

board_led_spacing = 0.75;

// How many LEDs to put in the ring.
num_leds = 6;

module led(rotation=0) {
    rotate_about_pt(rotation, 0, [(led_width + led_smd_pad_width - 0.3) / 2, led_width / 2, 0.2])
    led_inner();
}

module usb_c_port_smd_contact() {
    cube([0.55, 1.6, 0.035]);
}

through_hole_outer_diameter = 1.0;
through_hole_outer_width = 1.85;
through_hole_inner_diameter = 0.6;

pinhole_diameter = 0.9;
pinhole_distance = 10.8;

smd_pin_width = 0.55;
smd_pin_height = 1.6;
// The length of a single SMD contact row, from center point to center point of the first and last contacts.
smd_pins_extent_horizontal = 7.0;

usb_c_port_offset = 1.0;

module usb_c_port_pinholes () {
    cylinder(d=pinhole_diameter, h=10);

    translate([pinhole_distance, 0, 0])
    cylinder(d=pinhole_diameter, h=10);
}

module usb_c_port_smd_corner() {
    difference () {
        union () {
            hull () {
                translate([pinhole_distance - 1.175, 2.02, 0])
                cylinder(d=through_hole_outer_diameter, h=0.035);

                translate([pinhole_distance - 1.175 - through_hole_outer_width + 1, 2.02, 0])
                cylinder(d=through_hole_outer_diameter, h=0.035);
            }

            translate([pinhole_distance - 2.525, 0.4199, 0])
            usb_c_port_smd_contact();
        }
/*
        hull () {
            translate([pinhole_distance - 1.175, 2.02, -0.2])
            cylinder(d=through_hole_inner_diameter, h=3);

            translate([pinhole_distance - 1.875, 2.02, -0.2])
            cylinder(d=through_hole_inner_diameter, h=5);
        }
*/
    }
}

module usb_c_port_smd() {
    //usb_c_port_pinholes();

    usb_c_port_contact_row();
    mirror([0, 1, 0])
    usb_c_port_contact_row();
}

module usb_c_port_contact_row() {
    rightmost_pin_offset = pinhole_distance - smd_pin_width / 2 - (pinhole_distance - smd_pins_extent_horizontal) / 2;
    translate([0.35, 0, 0])
    //color([0.7, 0.2, 0.2])
    usb_c_port_smd_corner();

    //mirror([1, 0, 0])
    translate([10.45, 0, 0.035])
    rotate([0, 180, 0])
    usb_c_port_smd_corner();

    //translate([rightmost_pin_offset, 0.4199, 0])
    //color([0.8, 0.4, 0.4])
    //usb_c_port_smd_contact();

    translate([rightmost_pin_offset - 1, 0.4199, 0])
    usb_c_port_smd_contact();

    translate([rightmost_pin_offset - 2, 0.4199, 0])
    usb_c_port_smd_contact();

    translate([rightmost_pin_offset - 3, 0.4199, 0])
    usb_c_port_smd_contact();

    translate([rightmost_pin_offset - 4, 0.4199, 0])
    usb_c_port_smd_contact();

    translate([rightmost_pin_offset - 5, 0.4199, 0])
    usb_c_port_smd_contact();

    translate([rightmost_pin_offset - 6, 0.4199, 0])
    usb_c_port_smd_contact();
}

module led_inner() {
    /// 5050 LED
    translate([led_smd_pad_width / 2 - 0.15, 0, 0.2])
    difference () {
        color([0.6, 0.6, 0.6])
        cube([5, 5, 1]);

        translate([2.5, 2.5, 0.8])
        color([1, 1, 1])
        cylinder(r=2.2, h=1);
    }

    // LED Pad Top Left
    translate([0, led_width - led_smd_pad_height - led_smd_pad_inset, 0])
    cube([led_smd_pad_width, led_smd_pad_height, 0.2]);

    // LED Pad Bottom Right
    translate([0, led_smd_pad_inset, 0])
    cube([led_smd_pad_width, led_smd_pad_height, 0.2]);

    // LED Pad Top Right
    translate([led_height + 0.10 - led_smd_pad_inset, led_width - led_smd_pad_height - led_smd_pad_inset, 0])
    cube([led_smd_pad_width, led_smd_pad_height, 0.2]);

    // LED Pad Bottom Left
    translate([led_height + 0.10 - led_smd_pad_inset, led_smd_pad_inset, 0])
    cube([led_smd_pad_width, led_smd_pad_height, 0.2]);
}

module rotate_about_pt(z, y, pt) {
    translate(pt)
        rotate([0, y, z]) // CHANGE HERE
            translate(-pt)
                children();
}

module capacitor(rotation=0) {
    rotate_about_pt(rotation, 0, [(4 / 2.54) / 2, (2 / 2.54) / 2, 0.2])
    color([0.6, 0.4, 0])
    cube([4 / 2.54, 2 / 2.54, 2 / 2.54]);
}

module led_module_screw_holes() {
    // North West Screw Hole
    translate([board_led_spacing + 2.0, led_pcb_diameter / 2 + 4.25, -1])
    cylinder(d=led_pcb_screw_size, h=3, $fn=64);

    // South West Screw Hole
    translate([board_led_spacing + 2.0, led_pcb_diameter / 2 - 4.25, -1])
    cylinder(d=led_pcb_screw_size, h=3, $fn=64);

    // South East Screw Hole
    translate([led_pcb_diameter - board_led_spacing - 2.0, led_pcb_diameter / 2 - 4.25, -1])
    cylinder(d=led_pcb_screw_size, h=3, $fn=64);

    // North East Screw Hole
    translate([led_pcb_diameter - board_led_spacing - 2.0, led_pcb_diameter - (led_pcb_diameter / 2 - 4.25), -1])
    cylinder(d=led_pcb_screw_size, h=3, $fn=64);
}

module led_module_capacitors() {
    // NorthWest Capacitor
    translate([led_pcb_diameter / 2 - 5, led_pcb_diameter - 3.5, 1.6])
    capacitor(rotation=-45 - 22.5);

    // SouthWest Capacitor
    translate([led_pcb_diameter / 2 - 5, 2.75, 1.6])
    capacitor(rotation=45 + 22.5);

    // SouthEast Capacitor
    translate([led_pcb_diameter - (led_pcb_diameter / 2 - 3.5), led_pcb_diameter - 3.5, 1.6])
    capacitor(rotation=-90 - 22.5);

    // NorthEast Capacitor
    translate([led_pcb_diameter - (led_pcb_diameter / 2 - 3.5), 2.75, 1.6])
    capacitor(rotation=-45 - 22.5);
}

module led_module_neopixels(circle_center_x = led_pcb_diameter / 2, circle_center_y = led_pcb_diameter / 2, circle_radius=led_pcb_diameter / 2 - led_width - 1.5) {
    // LED West (D1)
    led_west_x = board_led_spacing;
    led_west_y = circle_center_y - led_width / 2;
    translate([led_west_x, led_west_y, 1.6])
    led();

    // LED SouthWest (D2)
    led_sw_x = 4 - board_led_spacing + 0.2;
    led_sw_y = 4 + 0.1;
    translate([led_sw_x, led_sw_y, 1.6])
    led(rotation=45);


    // LED South (D3)
    translate([led_pcb_diameter / 2 - (led_width / 2) + led_width, 0.8, 1.6])
    rotate([0, 0, 90])
    led();

    // LED SouthEast (D4)
    translate([led_pcb_diameter - (10.25 - board_led_spacing + 0.2), 4 + 0.1, 1.6])
    //rotate([0, 0, 45])
    led(rotation=135);

    // LED East (D5)
    led_east_x = led_pcb_diameter - 7;
    led_east_y = circle_center_y - led_width / 2;
    translate([led_east_x, led_east_y, 1.6])
    //rotate([0, 0, 0 + (45 * i)])
    led(rotation=180);

    // LED NorthEast (D6)
    translate([led_pcb_diameter - (10.25 - board_led_spacing + 0.2), led_pcb_diameter - 9.1, 1.6])
    //rotate([0, 0, 45])
    led(rotation=225);

    // LED North (D7)
    led_north_x = led_pcb_diameter / 2 - (led_width / 2) + led_width;
    led_north_y = led_pcb_diameter - 7;
    translate([led_north_x, led_north_y, 1.6])
    rotate([0, 0, 90])
    led();


    // LED NorthWest (D8)
    translate([4 - board_led_spacing + 0.2, led_pcb_diameter - 9.1, 1.6])
    //rotate([0, 0, 45])
    led(rotation=315);
}

translate([(led_pcb_diameter - 10.8) / 2, led_pcb_diameter / 2 - usb_c_port_offset, -0.035])
usb_c_port_smd();

module led_module() {
    circle_center_x = led_pcb_diameter / 2;
    circle_center_y = led_pcb_diameter / 2;
    circle_radius = led_pcb_diameter / 2 - led_width - 1.5;

    led_module_capacitors();
    led_module_neopixels();
    

    difference () {
        translate([led_pcb_diameter / 2, led_pcb_diameter / 2, 0])
        color([0.2, 0.2, 0.2])
        cylinder(d=led_pcb_diameter, h=led_pcb_height, $fn=64);
        
        led_module_screw_holes();

        translate([(led_pcb_diameter - 10.8) / 2, led_pcb_diameter / 2 - usb_c_port_offset, -1])
        usb_c_port_pinholes();

        hull () {
            translate([pinhole_distance - 1.175, led_pcb_diameter / 2, -0.2])
            cylinder(d=through_hole_inner_diameter, h=3);

            translate([pinhole_distance - 1.875, led_pcb_diameter / 2, -0.2])
            cylinder(d=through_hole_inner_diameter, h=5);
        }
    }
}

module led_pcb() {
    cylinder(d=led_pcb_diameter, h=led_pcb_height, $fn=64);

    color([1, 0, 0])
    translate([led_outward_translation,-2.5, led_pcb_height])
    cube([5, 5, 1]);

    color([0, 1, 0])
    translate([-led_outward_translation - 5,-2.5, led_pcb_height])
    cube([5, 5, 1]);

    color([0, 0, 1])
    translate([-2.5,led_outward_translation, led_pcb_height])
    cube([5, 5, 1]);

    color([1, 1, 0])
    translate([-2.5,-led_outward_translation - 5, led_pcb_height])
    cube([5, 5, 1]);

    color([0, 1, 1])
    rotate([0, 0, 45])
    translate([-led_outward_translation - 5,-2.5, led_pcb_height])
    cube([5, 5, 1]);

    color([0, 1, 1])
    rotate([0, 0, 45])
    translate([-2.5,-led_outward_translation - 5, led_pcb_height])
    cube([5, 5, 1]);

    color([1, 1, 1])
    rotate([0, 0, 45])
    translate([-2.5,led_outward_translation, led_pcb_height])
    cube([5, 5, 1]);

    color([1, 1, 1])
    rotate([0, 0, -45])
    translate([-2.5,led_outward_translation, led_pcb_height])
    cube([5, 5, 1]);

    color([1, 1, 1])
    translate([-vertical_usb_port_height / 2, -vertical_usb_port_width / 2, 0])
    cube([vertical_usb_port_height, vertical_usb_port_width, 10]);
}

//led_pcb();

led_module();