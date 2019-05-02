/*
PELA Raspberry Pi3 Technic Mount - 3D Printed LEGO-compatible PCB mount on which other technic and PELA parts can be stacked to create a complete case

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
use <../box-enclosure/PELA-box-enclosure.scad>
use <../PELA-socket-panel.scad>
use <../technic-beam/PELA-technic-beam.scad>
use <../technic-beam/PELA-technic-twist-beam.scad>
use <PELA-technic-box.scad>
use <PELA-technic-mount.scad>



/* [Render] */

// Show the inside structure [mm]
cut_line = 0; // [0:1:100]

// Select parts to render
render_modules = 3; // [0:pi mount, 1:pi cover, 2:middle layer, 3:all]

// Printing material (set to select calibrated knob, socket and axle hole fit)
material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
large_nozzle = true;


/* [Board] */

// Board space length [mm]
length = 86.8; // Board space length [mm]

// Board space width [mm]
width = 56.8; // Board space width [mm]

// Board space heilengthght [mm]
thickness = 1.9; // [0:0.1:4]

// Step in from bolengthard space edges to support the board [mm]
innercut = 1.5; //length [0:0.1:8]

// Step down from board bottom to give room board components [mm]
undercut = 4; // [0:0.1:100]

// Bevel the outside edges above the board space inward to make upper structures like knobs more printable
dome = true;


/* [Enclosure] */

// Closeness of board fit lengthwise inside a ring of blocks [ratio] (increase to make outer box slightly larger)
l_pad = 1; // [0:tight, 1:+1 block, 2:+2 blocks]

// Closeness of board fit widthwise inside a ring of blocks [ratio] (increase to make outer box slightly larger)
w_pad = 1; // [0:tight, 1:+1 block, 2:+2 blocks]

// How many blocks in from length ends do the technic holes rotate 90 degrees
twist_l = 3; // [1:18]

// How many blocks in from width ends do the technic holes rotate 90 degrees
twist_w = 4; // [1:18]

// Interior fill style
center = 2; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes, 5:socket panel, 6:knob panel]]

// Text label
text = "Pi 3B+";

// Depth of text etching into top surface
text_depth = 0.5; // [0.0:0.1:2]

// Presence of sockets if center is "socket panel"
center_sockets = true;

// Presence of knobs if center is "knob panel"
center_knobs = true;

// Size of hole in the center of knobs if "center" or "cover center" is "knob panel"
knob_vent_radius = 0.0; // [0.0:0.1:3.9]



/* [Left Cut] */

// Distance from the front of left side hole [mm]
left_cutout_y = 27.9; // [0:0.1:200]

// Width of the left side hole [mm]
left_cutout_width = 16.2; // [0:0.1:200]

// Depth of the left side hole [mm]
left_cutout_depth = 13; // [0:0.1:200]

// Distance from bottom of the left side hole [mm]
left_cutout_z = -1; // [0:0.1:200]

// Height of the left side hole [mm]
left_cutout_height = 24; // [0:0.1:200]



/* [Right Cut] */

// Distance from the front of right side hole [mm]
right_cutout_y = 4; // [0:0.1:200]

// Width of the right side hole [mm]
right_cutout_width = 0; // [0:0.1:200]

// Depth of the right side hole [mm]
right_cutout_depth = 16.1; // [0:0.1:200]

// Distance from bottom of the right side hole [mm]
right_cutout_z = 4; // [0:0.1:200]

// Height of the right side hole [mm]
right_cutout_height = 16; // [0:0.1:200]



/* [Front Cut] */

// Distance from the left of front side hole [mm]
front_cutout_x = 8; // [0:0.1:200]

// Width of the front side hole [mm]
front_cutout_width = 60; // [0:0.1:200]

// Depth of the depth side hole [mm]
front_cutout_depth = 14; // [0:0.1:200]

// Distance from bottom of the front side hole [mm]
front_cutout_z = 4; // [0:0.1:200]

// Height of the front side hole [mm]
front_cutout_height = 24; // [0:0.1:200]



/* [Back Cut] */

// Distance from the left of back side hole [mm]
back_cutout_x = 4; // [0:0.1:200]

// Width of the back side hole [mm]
back_cutout_width = 0; // [0:0.1:200]

// Depth of the back side hole [mm]
back_cutout_depth = 24; // [0:0.1:200]

// Distance from bottom of the back side hole [mm]
back_cutout_z = 4; // [0:0.1:200]

// Height of the back side hole [mm]
back_cutout_height = 8; // [0:0.1:200]



/* [Cover] */

// Text label
cover_text = "Pi 3B+";

// Interior fill style
cover_center = 5; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes, 5:socket panel, 6:knob panel]

// Height of the cover [blocks]
cover_h = 1; // [1:1:20]

// Presence of sockets if "cover center" is "socket panel"
cover_sockets = true;

// Presence of knobs if "cover center" is "knob panel"
cover_knobs = true;


/* [Hidden] */

// Height of the enclosure [blocks]
h = 1; // [1:1:20]




///////////////////////////////
// DISPLAY
///////////////////////////////

pi3_technic_mount_and_cover(render_modules=render_modules, material=material, large_nozzle=large_nozzle, cut_line=cut_line, length=length, width=width, thickness=thickness, h=h, cover_h=cover_h, l_pad=l_pad, w_pad=w_pad, twist_l=twist_l, twist_w=twist_w, center_sockets=center_sockets, center_knobs=center_knobs, cover_sockets=cover_sockets, cover_knobs=cover_knobs, knob_vent_radius=knob_vent_radius, solid_first_layer=solid_first_layer, innercut=innercut, undercut=undercut, center=center, cover_center=cover_center, text=text, cover_text=cover_text, text_depth=text_depth, left_cutout_y=left_cutout_y, left_cutout_width=left_cutout_width, left_cutout_depth=left_cutout_depth, left_cutout_z=left_cutout_z, left_cutout_height=left_cutout_height, right_cutout_y=right_cutout_y, right_cutout_width=right_cutout_width, right_cutout_depth=right_cutout_depth, right_cutout_z=right_cutout_z, right_cutout_height=right_cutout_height, front_cutout_x=front_cutout_x, front_cutout_width=front_cutout_width, front_cutout_depth=front_cutout_depth, front_cutout_z=front_cutout_z, front_cutout_height=front_cutout_height, back_cutout_x=back_cutout_x, back_cutout_width=back_cutout_width, back_cutout_depth=back_cutout_depth, back_cutout_z=back_cutout_z, back_cutout_height=back_cutout_height, dome=dome);



///////////////////////////////////
// MODULES
///////////////////////////////////

module pi3_technic_mount_and_cover(render_modules=undef, material=undef, large_nozzle=undef, cut_line=undef, length=undef, width=undef, thickness=undef, h=undef, cover_h=undef, l_pad=undef, w_pad=undef, twist_l=undef, twist_w=undef, center_sockets=undef, center_knobs=undef, cover_sockets=undef, cover_knobs=undef, knob_vent_radius=undef, solid_first_layer=undef, innercut=undef, undercut=undef, center=undef, cover_center=undef, text=undef, cover_text=undef, text_depth=undef, left_cutout_y=undef, left_cutout_width=undef, left_cutout_depth=undef, left_cutout_z=undef, left_cutout_height=undef, right_cutout_y=undef, right_cutout_width=undef, right_cutout_depth=undef, right_cutout_z=undef, right_cutout_height=undef, front_cutout_x=undef, front_cutout_width=undef, front_cutout_depth=undef, front_cutout_z=undef, front_cutout_height=undef, back_cutout_x=undef, back_cutout_width=undef, back_cutout_depth=undef, back_cutout_z=undef, back_cutout_height=undef, dome=undef) {

    l = fit_mm_to_blocks(length, l_pad);
    w = fit_mm_to_blocks(width, w_pad);
    assert(text != undef);

    difference() {
        union() {
            rm = render_modules == 3 ? 2 : render_modules == 2 ? 3 : render_modules;
            
            technic_mount_and_cover(render_modules=rm, material=material, large_nozzle=large_nozzle, cut_line=cut_line, length=length, width=width, thickness=thickness, h=h, cover_h=cover_h, l_pad=l_pad, w_pad=w_pad, twist_l=twist_l, twist_w=twist_w, center_sockets=center_sockets, center_knobs=center_knobs, cover_sockets=cover_sockets, cover_knobs=cover_knobs, knob_vent_radius=knob_vent_radius, solid_first_layer=solid_first_layer, innercut=innercut, undercut=undercut, center=center, cover_center=cover_center, text=text, cover_text=cover_text, text_depth=text_depth, left_cutout_y=left_cutout_y, left_cutout_width=left_cutout_width, left_cutout_depth=left_cutout_depth, left_cutout_z=left_cutout_z, left_cutout_height=left_cutout_height, right_cutout_y=right_cutout_y, right_cutout_width=right_cutout_width, right_cutout_depth=right_cutout_depth, right_cutout_z=right_cutout_z, right_cutout_height=right_cutout_height, front_cutout_x=front_cutout_x, front_cutout_width=front_cutout_width, front_cutout_depth=front_cutout_depth, front_cutout_z=front_cutout_z, front_cutout_height=front_cutout_height, back_cutout_x=back_cutout_x, back_cutout_width=back_cutout_width, back_cutout_depth=back_cutout_depth, back_cutout_z=back_cutout_z, back_cutout_height=back_cutout_height, dome=dome);

            tl = min(twist_l, ceil(l/2));
            l1 = tl;
            l3 = l1;
            l2 = max(0, l - l1 - l3);
            tw = min(twist_w, ceil(w/2));
            w1 = tw;
            w3 = w1;
            w2 = max(0, w - w1 - w3);

            if (render_modules == 0 || render_modules == 3) {
                translate([0, 0, block_height(1, block_height)]) {

                    difference() {
                        technic_rectangle(material=material, large_nozzle=large_nozzle, l1=l1, l2=l2-1, l3=l3, w1=w1, w2=w2, w3=w3, text=text, text_depth=text_depth, block_height=block_height);
                        
                        translate([0, 0, block_height(-1)]) {
                            wall_cutouts(l=l, w=w, left_cutout_y=left_cutout_y, left_cutout_width=left_cutout_width, left_cutout_depth=left_cutout_depth, left_cutout_z=left_cutout_z, left_cutout_height=left_cutout_height, right_cutout_y=right_cutout_y, right_cutout_width=right_cutout_width, right_cutout_depth=right_cutout_depth, right_cutout_z=right_cutout_z, right_cutout_height=right_cutout_height, front_cutout_x=front_cutout_x, front_cutout_width=front_cutout_width, front_cutout_depth=front_cutout_depth, front_cutout_z=front_cutout_z, front_cutout_height=front_cutout_height, back_cutout_x=back_cutout_x, back_cutout_width=back_cutout_width, back_cutout_depth=back_cutout_depth, back_cutout_z=back_cutout_z, back_cutout_height=back_cutout_height);
                        }
                    }
                }

                retaining_ridge_sd_card_side(material=material, large_nozzle=large_nozzle, l=l, w=w);
            }
            
            if (render_modules == 2 || render_modules == 3) {
                translate([0, block_width(w+1), 0]) {

                    difference() {
                        technic_rectangle(material=material, large_nozzle=large_nozzle, l1=l1, l2=l2-1, l3=l3, w1=w1, w2=w2, w3=w3, text=text, text_depth=text_depth, block_height=block_height);

                        union() {
                            translate([block_width(w), block_width(1), -skin]) {
                                cube([block_width(2), block_width(7), block_height(2)]);
                            }
                        }
                    }
                }

                translate([block_height(-0.5), block_width(w+5), block_height(1.5)]) {
                    rotate([90, 0, 90]) {
                        square_end_beam(material=material, large_nozzle=large_nozzle, l=2);
                    }
                }
            }
        }
        
        union() {
            color("green") main_board(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, length=length, width=width, thickness=thickness, dome=dome);

            ethernet_cutout(material=material, large_nozzle=large_nozzle);
        }
    }
}


module retaining_ridge_sd_card_side(material=undef, large_nozzle=undef, l=undef, w=undef) {

    assert(material != undef);
    assert(large_nozzle != undef);
    assert(l != undef);
    assert(w != undef);

    difference() {
        translate([block_width(0.5), block_width(0.5), block_height(1, block_height)]) {
            cube([block_width(0.5), block_width(w-2), block_height(1, block_height)]);
        }

        color("yellow") left_cutout(l=l, left_cutout_y=left_cutout_y, left_cutout_width=left_cutout_width, left_cutout_depth=left_cutout_depth, left_cutout_z=left_cutout_z, left_cutout_height=left_cutout_height);
    }
}


module ethernet_cutout(material=material, large_nozzle=large_nozzle) {

    translate([block_width(10), block_width(1), block_height(1, block_height)]) {
        cube([block_width(3), block_width(7), block_height(4, block_height)]);
    }
}
