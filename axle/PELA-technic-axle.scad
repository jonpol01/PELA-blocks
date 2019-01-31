/*
PELA Parametric LEGO-compatible Technic Axle

PELA Parametric Blocks - 3D Printed LEGO-compatible parametric blocks

Published at https://PELAblocks.org

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    https://www.futurice.com/
*/

include <../style.scad>
include <../print-parameters.scad>
use <../PELA-block.scad>

/* [Technic Axle Options] */

// Axle length [blocks]
l = 3;

// An axle which fits loosely in a technic bearing hole [mm]
axle_radius = 2.2;

// Size of the hollow inside an axle [mm]
center_radius = 1.1;



///////////////////////////////
// DISPLAY
///////////////////////////////

axle();
  



/////////////////////////////////////
// MODULES
/////////////////////////////////////

module axle(l=l, axle_radius=axle_radius, center_radius=center_radius) {

    axle_length = block_width(l);

    difference() {
        cylinder(r=axle_radius, h=axle_length);

        translate([0, 0, -defeather])
            cylinder(r=center_radius, h=axle_length + 2*defeather);
    }
}
