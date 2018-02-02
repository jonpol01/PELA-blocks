/*
Parametric PELA Shotgun Rib Mount

A "rib" is a rectantular metal bar to reinforce the barrel of a gun. See
also the "PELA-gunrail-mount.scad" for an alternative design.

The current design omits top knobs which would interfere with the
matching "PELA-vive-tracker-mount.scad".


Published at http://PELAblocks.org







By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution ShareAlike NonCommercial License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Design work kindly sponsored by
    http://futurice.com

Import this into other design files:
    use <PELA-block.scad>
*/

include <../PELA-parameters.scad>
include <../PELA-print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../knob-panel/PELA-knob-panel.scad>
use <PELA-gunrail-mount.scad>

/* [PELA Panel Options] */

// Eliminate knobs that are in the way of PELA-vive-tracker-mount.scad sitting on top of this part
hide_vive_mount_knobs = 1;

// Length of the block (PELA unit count)
l = 6; 

// Width of the block (PELA unit count)
w = 9;

top_vents = 0;

// Interior fill for layers above the bottom
solid_bottom_layer = 0; // [0:empty, 1:solid]

// Place holes in the corners for mountings screws (0=>no holes, 1=>holes)
bolt_holes=0; // [0:no holes, 1:holes]

// Size of corner holes for M3 mountings bolts
bolt_hole_radius=1.5;

// Presence of top connector knobs
knobs=1; // [0:disabled, 1:enabled]

body_length = block_width(l-1);

// Winchester Ranger Model 120 Shotgun Rail Dimensions (adjust for others)
winchester_rail_w = 9.55;
winchester_rail_h = 3.15;
winchester_rail_clearance = 7; // top to barrel

// Shotgun Square Rib Mount Dimensions (these are not standardized and may taper down towards the tip, measure the gun)
rib_width = 9.55;

rib_thickness = 25.4/4;

//rib_holder_height = 25.4;

rib_body_width = 18;

rib_body_thickness = 8;

rib_base_width = rib_width - 1;



// Display
top_panel(hide_vive_mount_knobs=hide_vive_mount_knobs);
rib_mount();

module rib_mount() {
    difference() {
        rib_body();
        rib();
    }
}

module rib() {
    translate([-body_length/2, -rib_width/2, -rib_thickness])
        cube([body_length, rib_width, rib_thickness]);

    translate([-body_length/2, -rib_base_width/2, -rib_body_thickness])
        cube([body_length, rib_base_width, rib_body_thickness]);
}

module rib_body() {
    translate([-body_length/2, -rib_body_width/2, -rib_body_thickness])
        cube([body_length, rib_body_width, rib_body_thickness]);
}
