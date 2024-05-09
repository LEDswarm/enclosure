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
    polygon(polyRound(braceProfile(), 24));
}

module EnclosureBase() {
    difference () {
        union () {
            difference() {
                $fn=subdivisions;

                cylinder(h=controller_height, r=15);  // This is the main cylinder

                translate([0,0, -20])
                cylinder(h=controller_height * 1.5, r=12.5); // The cylinder to be subtracted. The 'translate' function is used to ensure that this cylinder is centered properly.
            
            }

            rotate([0, 180, 0])
            translate([0, 0, -155])
            diameterExtender();

            translate([0, 0, 155 - 0.5])
            diffusor_oring_mount();

            // Bottom Screw Support Right
            translate([12, 0, 0])
            scale([0.5, 2.0, 1])
            cylinder(h = controller_height, r = 3.0);
            
            // Bottom Screw Support Left
            translate([-12, 0, 0])
            scale([0.5, 2.0, 1])
            cylinder(h = controller_height, r = 3.0);
            

            // Top Plate
            translate([0, 0, 153.5])
            cylinder(h=1.5, r=18);

            // Top Plate Screw Cylinder
            translate([0, 0, 155])
            cylinder(h=7, r=2);
        }

        translate([-1 * (top_plate_cutout_height / 2), -1 * (top_plate_cutout_width / 2), 145])
        linear_extrude(height = 20) polygon(polyRound(topPlateCutoutGeometry(), $fn));

        //
        // LED Screw Holes
        //
        translate([0, -led_pcb_screw_hole_center_distance, 155 - 1])
        cylinder(h=6.5, r=led_screw_hole_diameter / 2);

        translate([0, led_pcb_screw_hole_center_distance, 155 - 1])
        cylinder(h=6.5, r=led_screw_hole_diameter / 2);

        //
        // Bottom Screw Holes
        //
        translate([-13, 0, -2])
        cylinder(h=7.5, r=led_screw_hole_diameter / 2);

        translate([13, 0, -2])
        cylinder(h=7.5, r=led_screw_hole_diameter / 2);
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
module diffusor_oring_mount(groove_offset=0) {
    diffusor_flange_outer_diamater = 33.5;
    diffusor_flange_inner_diamater = 29.0;
    diffusor_flange_height = 6.75;

    diffusor_groove_outer_diameter = 36;
    diffusor_groove_inner_diameter = 30.25 + groove_offset;
    diffusor_groove_height = 3;


    difference() {
        translate([0, 0, 0])
        ring(
            diffusor_flange_outer_diamater,
            diffusor_flange_inner_diamater,
            diffusor_flange_height
        );

        // O-Ring Cutout
        translate([0, 0, 2])
        ring(
            diffusor_groove_outer_diameter,
            diffusor_groove_inner_diameter,
            diffusor_groove_height
        );
    }
}
