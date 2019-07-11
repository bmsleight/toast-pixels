
//based around 0.4 nozzle width
// block = 
unit = 0.45*2;
space = (unit/2)*1.5;

pin_x = unit * 1;
        // tab + spoke + space + rack + space + spoke + tab
pin_y = unit + unit + space + unit + space + unit + unit; 
pin_z = unit * 12;

hole_x = pin_x + (space*2); // 1 + 0.8 each side
hole_y = pin_y + (space*2); // 6 + 0.8 each side
hole_z = pin_z + (space*2); // 12 + 0.75 

slidesSection_x = unit+hole_x+unit;
slidesSection_y = unit+hole_y+unit;
slidesSection_z = unit;

boarder = 20;

x_hole_spacing = slidesSection_x + space + unit ;