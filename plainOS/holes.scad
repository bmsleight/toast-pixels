include <globals.scad>;

use <pin.scad>;

module yHoles(n_y=3)
{
    for(s_y = [0 : n_y-1])
    {
        //# -1 as we want overlap to make as thin as possible
        translate([0, -(n_y-1)*(slidesSection_y-unit)/2,0])
        translate([0, s_y*(slidesSection_y-unit),0])
        pinHole();
    }
}

module gridHoles(n_x=3,n_y=3)
{
    for(s_x = [0 : n_x-1])
    {
        translate([-(n_x-1)*(x_hole_spacing)/2,0,0])
        translate([s_x*(x_hole_spacing),0,0])
        yHoles(n_y=3);

        translate([-(n_x-1)*(x_hole_spacing)/2,0,0])
        translate([s_x*(x_hole_spacing),0,0]);

    }    
}

//yHoles(n_y=3);
gridHoles(n_x=3,n_y=3);