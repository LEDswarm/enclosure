function bottomProfile(extension=0,edgeRadius=10)=translateRadiiPoints(
        [
        [18, 0, 0],
        [21, 0, 0],
        // Corner Bending Left-Up <->
        [21, 5, 8],
        [15, 8, 12],
        //[5, 15, 24],
        // Corner Bending Down-Right <->
        [5, 8, 0],
        [0, 8, 0],
        [0, 6, 0],
        [12, 6, 1],
        //[2, 10, 24],
        [12 + 2, 6 + 0.5, 8],
        ],
    [0,0]
);