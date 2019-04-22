/*
Parametric PELA Strap Mount

A part for inserting strap straps to attachment PELA parts to other
objects. Other types of strap can also be used. The slots

The current design omits top knobs which would interfere with the
matching "PELA-vive-tracker-mount.scad".

Published at https://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    https://www.futurice.com/

Import this into other design files:
    use <PELA-block.scad>
*/

include <style.scad>
include <material.scad>
use <PELA-block.scad>
use <PELA-technic-block.scad>


/* [Render] */

// Show the inside structure [mm]
_cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 0; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
_large_nozzle = true;



/* [Strap Mount] */

// Model length [blocks]
_l = 4; // [1:1:20]

// Model width [blocks]
_w = 4; // [1:1:20]

// Model height [blocks]
_h = 1; // [1:1:20]

// Fraction of a normal panel height for the center section where a stap holds the block in place
_panel_height_ratio = 1.0; // [0.1:0.1:2.0]

// Add short end holes spaced along the width for techic connectors
_end_holes = 3; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Add a wrapper around end holes (disable for extra ventilation but loose lock notches)
_end_sheaths = false;

// Presence of top connector knobs
_knobs = true;

// Presence of bottom connector sockets
_sockets = false;

// How tall are top connectors [mm]
_knob_height = 2.9; // [1.8:traditional blocks, 2.9:PELA 3D print tall]

// Basic unit vertical size of each block
_block_height = 8; // [8:technic, 9.6:traditional blocks]

// Place holes in the corners for mountings screws (0=>no holes, 1=>holes)
_corner_bolt_holes = false;

// Add holes in the top deck to improve airflow and reduce weight
_top_vents = false;

// Size of a hole in the top of each knob. 0 to disable or use for air circulation/aesthetics/drain resin from the cutout, but larger holes change flexture such that knobs may not hold as well
_knob_vent_radius = 0; // [0.0:0.1:3.9]


/* [Hidden] */

// Add full width through holes spaced along the length for techic connectors
_side_holes = 0; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Add a wrapper around end holes (disable for extra ventilation but loose lock notches)
_side_sheaths = true;


///////////////////////////////
// DISPLAY
///////////////////////////////

strap_mount(material=_material, large_nozzle=_large_nozzle, cut_line=_cut_line, l=_l, w=_w, h=_h, panel_height_ratio=_panel_height_ratio, side_holes=_side_holes, end_holes=_end_holes, sockets=_sockets, knobs=_knobs, corner_bolt_holes=_corner_bolt_holes, knob_height=_knob_height, knob_vent_radius=_knob_vent_radius, top_vents=_top_vents, block_height=_block_height, side_sheaths=_side_sheaths, end_sheaths=_end_sheaths);



///////////////////////////////////
// MODULES
///////////////////////////////////

module strap_mount(material=undef, large_nozzle=undef, cut_line=undef, l=undef, w=undef, h=undef, panel_height_ratio=undef, side_holes=undef, side_sheaths=undef, end_holes=undef, end_sheaths=undef, sockets=undef, knobs=undef, knob_height=undef, knob_vent_radius=undef, top_vents=undef, corner_bolt_holes=undef, block_height=undef) {

    difference() {
        union() {
            difference() {
                PELA_technic_block(material=material, large_nozzle=large_nozzle, cut_line=0, l=l, w=w, h=h, side_holes=side_holes, end_holes=end_holes, sockets=sockets, knobs=knobs, knob_height=knob_height, knob_vent_radius=knob_vent_radius, top_vents=top_vents, corner_bolt_holes=corner_bolt_holes, end_sheaths=end_sheaths, block_height=block_height, side_sheaths=side_sheaths);

                slot(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h, block_height=block_height);
            }

            if (sockets) {
                height = max(knob_height + skin, panel_height_ratio*panel_height(block_height=block_height));

                ss = side_shell(large_nozzle);

                translate([block_width(1)- ss, 0, height]) {
                    cube([ss, block_width(w), block_height(h, block_height) - height]);
                }

                translate([block_width(l-1), 0, height]) {
                    cube([ss, block_width(w), block_height(h, block_height) - height]);
                }
            }
        }
        
        cut_space(material=material, large_nozzle=large_nozzle, l=l, w=w, cut_line=cut_line, h=h, block_height=block_height, knob_height=knob_height);

    }
}


module slot(material=undef, large_nozzle=undef, l=undef, w=undef, h=undef, block_height=undef) {
    
    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(block_height!=undef);
    
    translate([block_width(), -0.01, _panel_height_ratio*panel_height(block_height=block_height)]) {
        cube([block_width(l-2), block_width(w)+0.02, block_height(h+1, block_height=block_height)]);
    }
}
