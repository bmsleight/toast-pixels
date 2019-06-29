#! /usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import division
import os
import sys

from pin import pinHole

# Assumes SolidPython is in site-packages or elsewhwere in sys.path
from solid import *
from solid.utils import *

SEGMENTS = 48

def slide(pins=2, boarder=24):
	cell = 10
	# x_pin +2 boarder + gap 1 + 2 boarder
	x_slide = 3 + 2 + 1 + 2 
	y_slide = (pins*cell)+boarder 
	slide = cube([x_slide, y_slide, 1], center=True)
	blocker_f = up(4/2-1/2)(cube([x_slide, 10, 4], center=True))
	#  slide needs to move 1/2 cell i.e. 5 mm
	blocker_b = up(4/2-1/2)(back(5)(cube([x_slide, 10, 4], center=True))) + \
                up(1/2-1/2)(forward(5)(cube([x_slide, 10, 1], center=True)))
	# Location - end of drop holes forward side
	slide = slide + forward(((pins*cell)+boarder)/2+10/2)(blocker_f)
	# Location - end of drop holes back side
	slide = slide + back(((pins*cell)+boarder)/2+10/2)(blocker_b)

	slide_hole = pinHole()
	for y in range(pins):
		slide =  slide - forward( (-(pins-1)*cell/2) + (y*cell) )(slide_hole)
	
	return slide

def slides(pins=3, cell=10):
    slides = union()
    for y in range(pins):
        slides = slides + forward(cell*0.5)(right(y*cell)(slide(pins=pins)))
    slides = translate([-(pins-1)*cell/2, 0, 0])(slides)
    return slides


def assembly():
    # Your code here!
    a = union()
    a = a + slide(pins=3)

    return a

if __name__ == '__main__':
    a = assembly()
    scad_render_to_file(a, file_header='$fn = %s;' % SEGMENTS, include_orig_code=True)
