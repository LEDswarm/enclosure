include <../config.scad>;

module ControllerPcb () {
  union () {
    translate([0, -(26.70 / 2), 0])
    cube([1.0, 26.70, controller_mainboard_height]);

    translate([0, -(11 / 2), controller_mainboard_height])
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
}

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