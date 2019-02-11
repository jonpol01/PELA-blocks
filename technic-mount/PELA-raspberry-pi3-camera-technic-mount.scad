/*
Raspberry Pi3 Camera Mount - 3D Printed LEGO-compatible PCB mount with the board held in place by technic bars

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
include <../material.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../pin/PELA-technic-pin.scad>
use <../box-enclosure/PELA-box-enclosure.scad>
use <../knob-mount/PELA-knob-mount.scad>
use <../technic-bar/PELA-technic-bar.scad>
use <../technic-bar/PELA-technic-twist-bar.scad>
include <PELA-technic-board-mount.scad>


/* [Raspberry Pi3 Camera Mount] */

// Show the inside structure [mm]
cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
large_nozzle = true;

length = 39.5; // Board space length [mm]

width = 39.5; // Board space width [mm]

l_pad = 1; // [0:tight, 1:+1 block, 2:+2 blocks] // Closeness of board fit lengthwise inside a ring of blocks [ratio - increase to make outer box slightly larger]

w_pad = 1; // [0:tight, 1:+1 block, 2:+2 blocks] // Closeness of board fit widthwise inside a ring of blocks [ratio - increase to make outer box slightly larger]

// Height of the model [blocks]
h = 1;

twist_l = 2; // How many blocks in from length ends do the technic holes rotate 90 degrees [blocks]

twist_w = 2; // How many blocks in from width ends do the technic holes rotate 90 degrees [blocks]

thickness = 1.8; // Board space height [mm]

// Step in from board space edges to support the board [mm]
innercut = 2;



///////////////////////////////
// DISPLAY
///////////////////////////////

pi_camera_technic_mount(material=material, large_nozzle=large_nozzle, cut_line=cut_line, length=length, width=width, l_pad=l_pad, w_pad=w_pad, h=h, twist_l=twist_l, twist_w=twist_w, thickness=thickness, innercut=innercut);



///////////////////////////////////
// MODULES
///////////////////////////////////

module pi_camera_technic_mount(material=undef, large_nozzle=undef, cut_line=undef, length=undef, width=undef, l_pad=undef, w_pad=undef, h=undef, twist_l=undef, twist_w=undef, thickness=undef, innercut=undef) {

    technic_board_mount(material=material, large_nozzle=large_nozzle, cut_line=cut_line, length=length, width=width, twist_l=twist_l, twist_w=twist_w, l_pad=l_pad, w_pad=w_pad, h=h, thickness=thickness, innercut=innercut);
}