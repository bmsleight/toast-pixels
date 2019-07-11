include <globals.scad>;

module pin()
{
    //# Space of 2 middle, 1
    //# 1 of each sde
    //# Total width = 4
    // # total height is bottom tabs (2) plus projection of 10 = 12
    difference()
    {
        union()
        {
            cube([pin_x, pin_y-(unit*2), pin_z], center=true);
            translate([0,0,-pin_z/2+unit/2]) // to bottom
            translate([0,0,1]) // up by 1
            cube([unit, pin_y, unit], center=true);
        }
        translate([0,0,unit ]) cube([unit*2, space+unit+space, pin_z], center=true);
    }
}


module pinHole()
{

    cube([hole_x, hole_y, hole_z], center=true);
}


pin();
//#pinHole();
