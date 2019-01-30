/*
PELA Technic Board Mount - 3D Printed LEGO-compatible PCB mount used for including printed ciruit boards in technic models

This is a library module used by other models

Published at https://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution ShareAlike NonCommercial License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Design work kindly sponsored by
    https://www.futurice.com

All modules are setup for stateless functional-style reuse in other OpenSCAD files.
To this end, you can always pass in and override all parameters to create
a new effect. Doing this is not natural to OpenSCAD, so apologies for all
the boilerplate arguments which are passed in to each module or any errors
that may be hidden by the sensible default values. This is an evolving art.
*/

include <../style.scad>
include <../print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../pin/PELA-technic-pin.scad>
use <../box-enclosure/PELA-box-enclosure.scad>
use <../knob-mount/PELA-knob-mount.scad>
use <../technic-bar/PELA-technic-bar.scad>
use <../technic-bar/PELA-technic-twist-bar.scad>

/* [Technic Board Mount Options] */

// Board space length [mm]
length = 39.5; 

// Board space width [mm]
width = 39.5;

// Closeness of board fit lengthwise inside a ring of blocks [ratio] (increase to make outer box slightly larger)
length_tightness = 1.5;

// Closeness of board fit widthwise inside a ring of blocks [ratio] (increase to make outer box slightly larger)
width_tightness = 1.5;

// How many blocks in from length ends do the technic holes rotate 90 degrees
twist_length = 2;

// How many blocks in from width ends do the technic holes rotate 90 degrees
twist_width = 2;

// Board space height [mm]
thickness = 1.8;

// Step in from board space edges to support the board [mm]
innercut = 1.0;




///////////////////////////////
// DISPLAY
///////////////////////////////

technic_board_mount();



///////////////////////////////////
// MODULES
///////////////////////////////////

module technic_board_mount(length=length, width=width, length_tightness=length_tightness, width_tightness=width_tightness, twist_length=twist_length, twist_width=twist_width, thickness=thickness, innercut=innercut) {

    assert(twist_length >= 0, "twist_length must be >= 0");
    assert(twist_width >= 0, "twist_length must be >= 0");
    assert(length_tightness > 0, "length_tightness must be > 0 (usually 1 to 1.5)");
    assert(width_tightness > 0, "WIDTH_TIGHTNESS must be > 0 (usually 1 to 1.5)");
    assert(twist_length*2 <= l, "TWIST_LENGTH must <= l/2, please reduce TWIST_LENGTH or increate LENGTH");
    assert(twist_width*2 <= w, "TWIST_WIDTH must <= w/2, please reduce TWIST_WIDTH or increate WIDTH");

    l = fit_mm_to_pela_blocks(length, length_tightness);
    w = fit_mm_to_pela_blocks(width, width_tightness);
    echo("l", l);
    echo("w", l);

    assert(l - 2*twist_length, "The board length is quite small- consider decreasing twist_length or increasing length_tightness");
    assert(w - 2*twist_width, "The board width is quite small- consider decreasing twist_width or increasing width_tightness");

    l1 = twist_length;
    l3 = l1;
    l2 = l - l1 - l3;
    w1 = twist_width;
    w3 = w1;
    w2 = w - w1 - w3;
    echo("l1", l1);
    echo("l2", l2);
    echo("l3", l3);
    echo("w1", w1);
    echo("w2", w2);
    echo("w3", w3);

    difference() {
        union() {
            technic_rectangle(l1=l1, l2=l2, l3=l3, w1=w1, w2=w2, w3=w3);
            technic_rectangle_infill(l=l, w=w);
        }
        
        union() {
            main_board(l=l, w=w, length=length, width=width, thickness=thickness, block_height=block_height);
            main_board_back(l=l, w=w, length=length, width=width, innercut=innercut, block_height=block_height);
        }
    }
}


module technic_rectangle(l1, l2, l3, w1, w2, w3) {

    ll = l1+l2+l3;
    ww = w1+w2+w3;

    technic_twist_bar(left=l1, center=l2, right=l3);

    rotate([0, 0, 90]) {
        technic_twist_bar(left=w1, center=w2, right=w3);
    }

    translate([0, block_width(ww-1), 0]) {
        technic_twist_bar(left=l1, center=l2, right=l3);
    }

    rotate([0, 0, 90]) {
        translate([0, -block_width(ll-1), 0]) {
            technic_twist_bar(left=w1, center=w2, right=w3);
        }
    }
}


module technic_rectangle_infill(l=l, w=w) {
    translate([block_width(0.5, block_width=block_width)-skin, block_width(0.5, block_width=block_width)-skin, 0]) {
        cube([block_width(l-2, block_width=block_width)+2*skin, block_width(w-2, block_width=block_width)+2*skin, block_height()]);
    }
}


module main_board(l=l, w=w, length=length, width=width, thickness=thickness, block_height=block_height) {
    l2 = ((block_width(l, block_width=block_width) - length) / 2);
    w2 = ((block_width(w, block_width=block_width) - width) / 2);

    translate([l2-block_width(0.5), w2-block_width(0.5), block_height(1, block_height=block_height) - thickness]) {
        color("blue") cube([length, width, thickness]);
    }
}


module main_board_back(l=l, w=w, length=length, width=width, innercut=innercut, block_height=block_height) {
    l2 = ((block_width(l - 0.25) - length) / 2);
    w2 = ((block_width(w - 0.25) - width) / 2);

    translate([l2, w2, 0]) {
        color("green") cube([length-2*innercut-block_width(0.25), width-2*innercut-block_width(0.25), block_height(1, block_height=block_height)]);
    }
}
