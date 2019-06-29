#! /usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import division
import os
import sys

# Assumes SolidPython is in site-packages or elsewhwere in sys.path
from solid import *
from solid.utils import *

SEGMENTS = 48

from bottom import bottomHoles, screwHoles
from rack import rackHole

def top(pins=2):
    boarder = 24
    cell = 10
    # base of 2, z_pin + 1 clearance + 1 z_slide
    z = 7.5
    top = cube([(pins*cell)+boarder, (pins*cell)+boarder,z], 
                    center=True)
    central = cube([((pins+1)*cell)+boarder, 2, 7.5], center=True)
    rack_hole = right(cell/4)(rackHole(pins=pins, boarder=boarder, cell=cell))

    pin_holes = up(5)(cube([((pins+0.5)*cell), 6, 7.5], center=True))
    for y in range(pins):
        top =  top - down(2.5)(forward( (-(pins-1)*cell/2) + (y*cell)  )\
               (central + rack_hole + pin_holes))

    top -= screwHoles(pins,cell, boarder, z)
    return color("Blue")(top)

def assembly():
    # Your code here!
    a = union()
    a = a + top(pins=3)

    return a

if __name__ == '__main__':
    a = assembly()
    scad_render_to_file(a, file_header='$fn = %s;' % SEGMENTS, include_orig_code=True)
