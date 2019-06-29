#! /usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import division
import os
import sys

# Assumes SolidPython is in site-packages or elsewhwere in sys.path
from solid import *
from solid.utils import *

SEGMENTS = 48

def racks(pins=2, cell=10):
    racks = union()
    for x in range(pins):
        racks = racks + right(cell*0.5)(forward(x*cell)(rack(pins=pins)))
    racks = translate([0, -(pins-1)*cell/2, 0])(racks)
    return racks

def rackHole(pins=2, boarder=24, cell=10):
    rack_hole = cube([ ((pins+1) *cell) + 1 , 7.5,5.5], center=True)
    return rack_hole
    


def rack(pins=2, boarder=24):
    cell = 10
    central_y = 1.5
    central_z = 2.25
    central_x = ((pins+1)*cell)+boarder 
    rack = cube([central_x, central_y, central_z], center=True)

    rack_blocker = down(1.375)(cube([6,7,5], center=True))
    for x in range(pins+1):
        rack =  rack + right( (-(pins-1)*cell/2) + (x*cell) - cell/2 )(rack_blocker)

    return rack



def assembly():
    # Your code here!
    a = union()
    a = a + rack()

    return a

if __name__ == '__main__':
    a = assembly()
    scad_render_to_file(a, file_header='$fn = %s;' % SEGMENTS, include_orig_code=True)
