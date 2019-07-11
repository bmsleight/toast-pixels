include <globals.scad>;

use <pin.scad>;
use <holes.scad>;


module slide(n_y=3)
{
    union()
        {
            for(s_y = [0 : n_y-1])
            {
                //# -1 as we want overlap to make as thin as possible
                translate([0, -(n_y-1)*(slidesSection_y-unit)/2,0])
                translate([0, s_y*(slidesSection_y-unit),0])
                slideSecton();
            }
            //# Extend towards the boarder
            translate([0, -(n_y)*(slidesSection_y-unit)/2+-unit/2,0])
            translate([0, -boarder/2,0])
            cube([slidesSection_x, boarder, slidesSection_z], center=true);
            translate([0, (n_y)*(slidesSection_y-unit)/2+unit/2,0])
            translate([0, boarder/2,0])
            cube([slidesSection_x, boarder, slidesSection_z], center=true);
            //# Blockers each end
            translate([0, (n_y)*(slidesSection_y-unit)/2+unit/2,0])
            translate([0, boarder,0])
            translate([0, slidesSection_y/2,0])
            blocker();            
            translate([0, -((n_y)*(slidesSection_y-unit)/2+unit/2),0])
            translate([0, -boarder,0])
            translate([0, -slidesSection_y/2,0])
            blocker();            
        }
}

module blocker()
{
    cube([slidesSection_x, slidesSection_y, slidesSection_z], center=true);
    translate([0, slidesSection_y/4, slidesSection_z]) 
    cube([slidesSection_x, slidesSection_y/2, slidesSection_z*3], center=true);
}


    
module slideSecton()
{
    difference()
    {
        cube([slidesSection_x, slidesSection_y, slidesSection_z], center=true);
        pinHole();
    }
}



//slideSecton();
slide(n_y=3);
//yHoles(n_y=3);

#gridHoles(n_x=3,n_y=3);

echo(slidesSection_y, slidesSection_x, unit, slidesSection_y-unit, pin_z, hole_x, space);