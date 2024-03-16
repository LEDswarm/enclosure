include <lib/round_anything/polyround.scad>;
include <config.scad>;

$fn=64;

// The width of the PCB in its slot
pcb_width = 26.7;
// The width of the protruding USB-C connector used to connect to the LED.
pcb_arm_width = 14;
pcb_arm_height = 15;
pcb_thickness = 1.0;

usbcPortWidth = 9;
usbcPortHeight = 3.26;
usbcPortDepth = 7.35;
usbcPortWallThickness = 0.3;
usbcPortCenterBlockHeight = 0.6;
usbcPortCenterBlockWidth = 6.0;

xiao_esp32_length = 22.2;
xiao_esp32_width = 17.9;

dwm3000_width = 23.0;

usbcPort();

color([0.0, 0.6, 0.1])
pcb();

module pcb() {
    /// PCB Mockup
    union () {
        translate([0, 0, 0])
        cube([pcb_thickness, pcb_width, 135]);

        translate([0, (pcb_width - pcb_arm_width) / 2, 135])
    cube([pcb_thickness, pcb_arm_width, 15]);
    }
}

module usbcPort() {
    difference() {
        translate([1, (pcb_width - usbcPortWidth) / 2, controller_height + pcb_arm_height - usbcPortDepth])
        color([0.7, 0.7, 0.7])
        linear_extrude(height = usbcPortDepth) polygon(polyRound(usbcProfile(), $fn));

        translate([1, (pcb_width - usbcPortWidth) / 2, controller_height + pcb_arm_height - usbcPortDepth + 1])
        color([0.7, 0.7, 0.7])
        linear_extrude(height = 8) polygon(polyRound(usbcProfileCutout(), $fn));
    }

    translate([pcb_thickness + (usbcPortHeight - usbcPortCenterBlockHeight) / 2, (pcb_width - usbcPortCenterBlockWidth) / 2, controller_height + pcb_arm_height - usbcPortDepth + 1])
    color([0.7, 0.7, 0.7])
    cube([0.6, 6, 6]);

    function usbcProfile(extension=0,edgeRadius=10)=translateRadiiPoints(
        [
        [0, 0, 1],
        [usbcPortHeight, 0, 1],
        [usbcPortHeight, usbcPortWidth, 1],
        [0, usbcPortWidth, 1],
        ],
    [0,0]
    );

    function usbcProfileCutout(extension=0,edgeRadius=10)=translateRadiiPoints(
        [
        [usbcPortWallThickness, usbcPortWallThickness, 0.7],
        [usbcPortHeight - usbcPortWallThickness, usbcPortWallThickness, 0.7],
        [usbcPortHeight - usbcPortWallThickness, usbcPortWidth - usbcPortWallThickness, 0.7],
        [usbcPortWallThickness, usbcPortWidth - usbcPortWallThickness, 0.7],
        ],
    [0,0]
    );
}