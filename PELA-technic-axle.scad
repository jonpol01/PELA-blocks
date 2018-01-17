/*
Parametric PELA Technic-compatible Axle

Published at
    http://www.thingiverse.com/thing:XXXX
Maintained at
    https://github.com/paulirotta/parametric_PELA
See also the related files
    PELA Sign Generator - https://www.thingiverse.com/thing:2546028
    PELA Enclosure Generator - https://www.thingiverse.com/thing:2544197


By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution ShareAlike NonCommercial License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Design work kindly sponsored by
    http://futurice.com
*/

include <PELA-parameters.scad>
include <PELA-print-parameters.scad>
use <PELA-block.scad>

/* [PELA Technic-compatible Pin Options] */

// Axle length
axle_length = block_width(3);

// An axle which fits loosely in a technic bearing hole
axle_radius = 2.2;

// Size of the hollow inside an axle
axle_center_radius=2*axle_radius/3;

///////////////

axle();

    
//////////////////


// A round rotation axle
module axle(axle_radius=axle_radius, axle_center_radius=axle_center_radius, axle_length=axle_length) {

    difference() {
        cylinder(r=axle_radius, h=axle_length);
        translate([0, 0, -defeather])
            cylinder(r=axle_center_radius, h=axle_length+2*defeather);
    }
}