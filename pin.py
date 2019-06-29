#! /usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import division
import os
import sys

# Assumes SolidPython is in site-packages or elsewhwere in sys.path
from solid import *
from solid.utils import *

SEGMENTS = 48

def pinHole():
	return cube([4,8,15+2], center=True)

def pin():
    x = 3
    y = 6
    z = 15
    
    pin_core = cube([x,y,z], center=True)
    #Tab of 1 by 1 extra
    tab = cube([x,y+1,1], center = True)    
    # z = 15, so middle is 7.5, 4 solid at bottom, 
    tab = down(15/2-1/2-(5-1))(tab)

    # double x to make manifold, third of the middle, up by 4
    center_hole = up(2.5)(cube([x*2,y/3,z], center=True))

    pin =   color("Green")(pin_core + tab - center_hole )
    return pin



def assembly():
    # Your code here!
    a = union()
    a = a + pin()

    return a

if __name__ == '__main__':
    a = assembly()
    scad_render_to_file(a, file_header='$fn = %s;' % SEGMENTS, include_orig_code=True)

