include <../../config.scad>;

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

module diameterExtender() {
  rotate_extrude(angle = 360, convexity = 2, $fn = subdivisions)
    polygon(polyRound(braceProfile(), $fn));
}

module EnclosureBase() {
    difference () {
        union () {
            rotate([0, 180, 0])
            translate([0, 0, -155])
            diameterExtender();

            difference() {
            $fn=subdivisions;

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
                cylinder(h = controller_height, r = 3.0);
            
            // Bottom Screw Support Left
            translate([-12, 0, 0])
            scale([0.5, 2.0, 1])
                cylinder(h = controller_height, r = 3.0);

            translate([0, 0, 155 - 0.5])
            diffusor_oring_mount();

            // Top Plate
            translate([0, 0, 155 - 6])
            cylinder(h=6, r=18);
        }

        translate([-1 * (top_plate_cutout_height / 2), -1 * (top_plate_cutout_width / 2), 145])
        linear_extrude(height = 20) polygon(polyRound(topPlateCutoutGeometry(), $fn));

        //
        // LED Screw Holes
        //
        translate([0, -12.55, 149])
        cylinder(h=6.5, r=led_screw_hole_diameter / 2);

        translate([0, 12.55, 149])
        cylinder(h=6.5, r=led_screw_hole_diameter / 2);
    }
}

function topPlateCutoutGeometry(extension=0,edgeRadius=10)=translateRadiiPoints(
    [
      [0, 0, 3],
      [top_plate_cutout_height, 0, 3],
      [top_plate_cutout_height, top_plate_cutout_width, 3],
      [0, top_plate_cutout_width, 3],
    ],
  [0,0]
);

// O-Ring diffusor attachment
module diffusor_oring_mount() {
/*
    Old O-Ring Mount
    
    color([0.9, 0.6, 0.6])
    translate([0, 0, 20])
    difference() {
        translate([0, 0, controller_height])
        ring(34 - 0.5, 29.0, 7);

        // O-Ring Cutout
        translate([0, 0, controller_height + 2])
        ring(
            36,
            30.25,
            2.5 + 0.2
        );
    }
*/
    difference() {
        translate([0, 0, 0])
        ring(34 - 0.5, 29.0, 7);

        // O-Ring Cutout
        translate([0, 0, 2])
        ring(
            36,
            30.25,
            3
        );
    }
}
