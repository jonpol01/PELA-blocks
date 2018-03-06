/*
Parametric PELA LEGO-compatible technic cross-shaped rotational drive Axle

PELA Parametric Blocks - 3D Printed LEGO-compatible parametric blocks

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Design work kindly sponsored by
    http://futurice.com
*/

include <PELA-parameters.scad>
include <PELA-print-parameters.scad>
use <PELA-block.scad>
use <PELA-technic-axle.scad>

/* [Technic Pin Options] */

// Axle length
axle_length = block_width(3);

// Outside radius of an axle which fits loosely in a technic bearing hole
axle_radius = 2.2;

// Cross axle inside rounding radius
axle_rounding=0.63;

// Size of the hollow inside an axle
axle_center_radius=2*axle_radius/3;

///////////////

cross_axle();
    
//////////////////


// A rotation axle with a "+" cross section
module cross_axle(axle_rounding=axle_rounding, axle_radius=axle_radius, axle_length=axle_length) {

    rotate([90, 45, 0])
        difference() {
            axle(axle_radius=axle_radius, axle_center_radius=0, length=axle_length);        
            axle_cross_negative_space(axle_rounding=axle_rounding, axle_radius=axle_radius, axle_length=axle_length);
        }
}


// That which is cut away four times from a solid to create a cross axle
module axle_cross_negative_space(axle_rounding=axle_rounding, axle_radius=axle_radius, axle_length=axle_length) {
    
    for (rot=[0:90:270]) {
        rotate([0, 0, rot])
            hull() {
                translate([axle_rounding*2, axle_rounding*2, -defeather]) {
                    cylinder(r=axle_rounding, h=axle_length+2*defeather);

                    translate([axle_radius, 0, 0])
                        cylinder(r=axle_rounding, h=axle_length+2*defeather);

                    translate([0, axle_radius, 0])
                        cylinder(r=axle_rounding, h=axle_length+2*defeather);
                }
            }
    }
}