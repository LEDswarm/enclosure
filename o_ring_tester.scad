include <config.scad>;
include <src/enclosure/base.scad>;

top_right = [41, 20, 0];
bottom_right = [41, -20, 0];

translate([0, 0, 1])
diffusor_oring_mount();

// -0.1
translate(top_right)
translate([0, 0, 1.5])
diffusor_oring_mount(groove_offset= -0.1);

// -0.2
translate(bottom_right)
translate([0, 0, 1.5])
diffusor_oring_mount(groove_offset= -0.2);



// 12, 7, 4.0

difference () {
    // Base plate
    color([0.1, 0.1, 0.7])
    cube([120, 80, 3], center=true);

    translate([0, 0, 0])
    linear_extrude(height=5) 
    text("0", size=6, font="Basier Circle Mono", halign="center", valign="center");

    translate(top_right)
    linear_extrude(height=5) 
    text("-0.1", size=6, font="Basier Circle Mono", halign="center", valign="center");

    translate(bottom_right)
    linear_extrude(height=5) 
    text("-0.2", size=6, font="Basier Circle Mono", halign="center", valign="center");
}
