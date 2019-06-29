#! /usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import division
import os
import sys

# Assumes SolidPython is in site-packages or elsewhwere in sys.path
from solid import *
from solid.utils import *

SEGMENTS = 48

from pin import pin
from slide import slides
from bottom import bottom
from top import top
from rack import racks



def assembly():
    # Your code here!
    a = union()
    pins = right(5)(pin())
    s = union() + down(1/2)(slides(pins=5))
    r = union() + up(3.875)(forward(0)(racks(pins=5)))
    a = a + up(15/2)(pins) + s + down(19/2)(bottom(pins=5)) + \
            up(7.5/2)(top(pins=5)) + r


#    a = up(7.5/2)(top(pins=4)) + r 

    return a

if __name__ == '__main__':
    a = assembly()
    scad_render_to_file(a, file_header='$fn = %s;' % SEGMENTS, include_orig_code=True)
