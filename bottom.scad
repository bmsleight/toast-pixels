$fn = 48;

union() {
	difference() {
		cube(center = true, size = [54, 54, 19]);
		translate(v = [-10.0000000000, -10.0000000000, 2]) {
			union() {
				translate(v = [0, 0, 0]) {
					translate(v = [0, 0, 0]) {
						cube(center = true, size = [4, 8, 19]);
					}
				}
				translate(v = [0, 10, 0]) {
					translate(v = [0, 0, 0]) {
						cube(center = true, size = [4, 8, 19]);
					}
				}
				translate(v = [0, 20, 0]) {
					translate(v = [0, 0, 0]) {
						cube(center = true, size = [4, 8, 19]);
					}
				}
				translate(v = [0, 0, 0]) {
					translate(v = [10, 0, 0]) {
						cube(center = true, size = [4, 8, 19]);
					}
				}
				translate(v = [0, 10, 0]) {
					translate(v = [10, 0, 0]) {
						cube(center = true, size = [4, 8, 19]);
					}
				}
				translate(v = [0, 20, 0]) {
					translate(v = [10, 0, 0]) {
						cube(center = true, size = [4, 8, 19]);
					}
				}
				translate(v = [0, 0, 0]) {
					translate(v = [20, 0, 0]) {
						cube(center = true, size = [4, 8, 19]);
					}
				}
				translate(v = [0, 10, 0]) {
					translate(v = [20, 0, 0]) {
						cube(center = true, size = [4, 8, 19]);
					}
				}
				translate(v = [0, 20, 0]) {
					translate(v = [20, 0, 0]) {
						cube(center = true, size = [4, 8, 19]);
					}
				}
			}
		}
		translate(v = [-10.0000000000, 0, 9.5000000000]) {
			union() {
				translate(v = [0, 0, 0]) {
					cube(center = true, size = [8, 108, 2]);
				}
				translate(v = [10, 0, 0]) {
					cube(center = true, size = [8, 108, 2]);
				}
				translate(v = [20, 0, 0]) {
					cube(center = true, size = [8, 108, 2]);
				}
			}
		}
		union() {
			translate(v = [21.0000000000, 21.0000000000, 0]) {
				cylinder(center = true, d = 5, h = 38);
			}
			translate(v = [21.0000000000, -21.0000000000, 0]) {
				cylinder(center = true, d = 5, h = 38);
			}
			translate(v = [-21.0000000000, 21.0000000000, 0]) {
				cylinder(center = true, d = 5, h = 38);
			}
			translate(v = [-21.0000000000, -21.0000000000, 0]) {
				cylinder(center = true, d = 5, h = 38);
			}
		}
	}
}
/***********************************************
*********      SolidPython code:      **********
************************************************
 
#! /usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import division
import os
import sys

# Assumes SolidPython is in site-packages or elsewhwere in sys.path
from solid import *
from solid.utils import *

SEGMENTS = 48

def bottomHoles(pins, cell, z, z_offset):
    bottom_holes = union()
    # center at end of process
    # pin is (x,y,z) = (3,7,15)
    bottom_hole = cube([4,8,z], center=True)
    for x in range(pins):
        for y in range(pins):
            bottom_holes = bottom_holes + forward(y*cell)(right(x*cell)(bottom_hole))
    bottom_holes = translate([-(pins-1)*cell/2, -(pins-1)*cell/2, z_offset] )(bottom_holes)
    return bottom_holes

def slideHoles(pins, cell, boarder, z, z_slide):
    # x_pin +2 boarder + gap 1 + 2 boarder; 
    x_slide = 3 + 2 + 1 + 2
    slide_hole = cube([x_slide, ((pins*cell)+boarder) *2, z_slide*2], center=True)
    slide_holes = union()
    for x in range(pins):
        slide_holes = slide_holes + right(x*cell)(slide_hole)
    slide_holes = translate([-(pins-1)*cell/2, 0, z/2])(slide_holes)
    return slide_holes

def screwHoles(pins, cell, boarder, z):
    screw_holes = union()
    screw_d = 5
    screwHole = cylinder(d=screw_d, h=z*2, center=True)
    inset_from_edge = 6
    half_side = ((pins*cell)+boarder)/2-inset_from_edge
    screw_holes = screw_holes + translate([half_side,half_side,0])(
                                          screwHole)
    screw_holes = screw_holes + translate([half_side,-half_side,0])(
                                          screwHole)
    screw_holes = screw_holes + translate([-half_side,half_side,0])(
                                          screwHole)
    screw_holes = screw_holes + translate([-half_side,-half_side,0])(
                                          screwHole)
    return screw_holes
    

def bottom(pins=2):
    boarder = 24
    cell = 10
    # base of 2, z_pin + 1 clearance + 1 z_slide
    z = 15 + 2  + 1 + 1 
    bottom = cube([(pins*cell)+boarder, (pins*cell)+boarder,z], 
                    center=True)
    bottom -= bottomHoles(pins,cell,z, z_offset = 2)
    bottom -= slideHoles(pins,cell, boarder, z, z_slide=1)
    bottom -= screwHoles(pins,cell, boarder, z)
    return bottom


def assembly():
    # Your code here!
    a = union()
    a = a + bottom(pins=3)

    return a

if __name__ == '__main__':
    a = assembly()
    scad_render_to_file(a, file_header='$fn = %s;' % SEGMENTS, include_orig_code=True)
 
 
************************************************/
