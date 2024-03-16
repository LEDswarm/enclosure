include <lib/round_anything/polyround.scad>

radiusExtrudefn=5;
$fn=30;

poleBraceHeight = 70;
poleBraceIR = 30;
braceThickness = 10;

armLength = 180;
armThickness=15;
boltD=3.5;
boltHeadD=6.3;
captureNutDepth=2.5;

cameraMountHoleD=6.5;
cameraMountClearance=36;
cameraMountThickness=8;
cameraMountPlatformSize=46;

wingGap=6;
wingThickness=8;
wingExtension=8;

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


main();

rotate([0, 180, 0])
translate([0, 0, -20])
poleBrace();

module poleBrace() {
  rotate_extrude(angle = 360, convexity = 2)
    polygon(polyRound(braceProfile(), $fn));
}

module main() {
  polygon(polyRound(braceProfile(), $fn));
}

module gridpattern(memberW = 3, sqW = 20, iter = 12, r = 3){
    round2d(0, r)rotate([0, 0, 45])translate([-(iter * (sqW + memberW) + memberW) / 2, -(iter * (sqW + memberW) + memberW) / 2])difference(){
		square([(iter) * (sqW + memberW) + memberW, (iter) * (sqW + memberW) + memberW]);
		for (i = [0:iter - 1], j = [0:iter - 1]){
			translate([i * (sqW + memberW) + memberW, j * (sqW + memberW) + memberW])square([sqW, sqW]);
		}
	}
}