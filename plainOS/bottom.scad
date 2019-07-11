module bottom()
{
    b_x = 3;
    b_y = 3;
    difference()
    {
 //       cube([b_x*1,1,1]);
    }
}


module bottomHole()
{
    hole_x = 2.5; // 1 + 0.75 each side
    hole_y = 7.5; // 6 + 0.75 each side
    hole_z = 12.75; // 12 + 0.75 
    cube([hole_x, hole_y, hole_z], center=true);
}

module bottomHoleS(n_x, n_y)
{
    x_spacing = 0;
    for (x =[0:n_x-1])
    {
        for (y =[0:n_y-1])
        {
            translate([
        }
    }
}

//bottom();
bottomHole();