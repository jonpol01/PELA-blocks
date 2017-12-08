/*
Parametric LEGO Technic-compatible Pin

Published at
    http://www.thingiverse.com/thing:XXXX
Maintained at
    https://github.com/paulirotta/parametric_lego
See also the related files
    LEGO Sign Generator - https://www.thingiverse.com/thing:2546028
    LEGO Enclosure Generator - https://www.thingiverse.com/thing:2544197


By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution ShareAlike NonCommercial License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Design work kindly sponsored by
    http://futurice.com
*/

include <lego-parameters.scad>
use <lego.scad>
use <technic.scad>

/* [LEGO Technic-compatible Pin Options] */

// What type of Pin or similar object to generate
mode=1; // [1:pin, 2:axle, 3:cross axle]

// An axle which fits loosely in a technic bearing hole
axle_radius = 2.2;

// Cross axle inside rounding radius
axle_rounding=0.63;

// Size of the hollow inside of an axle
axle_center_radius=2*axle_radius/3;

// Size of the hollow inside of an axle
pin_center_radius=2*axle_radius/3;

// Size of the connector lock-in bump at the ends of a Pin
pin_tip_length = 0.4;

// Width of the long vertical flexture slots in the side of a pin
slot_thickness = 0.9;

defeather=0.01;

counterbore_holder_radius = counterbore_inset_radius - skin;

counterbore_holder_height = counterbore_inset_depth * 2;

///////////////

if (mode == 1) {
    pin();
} else if (mode == 2) {
    axle();
} else if (mode == 3) {
    cross_axle();
} else {
    echo("<b>Unsupported mode: please check <i>mode</i> variable is 1-3</b>");
}
    
//////////////////


// A round rotation axle
module axle(axle_radius=axle_radius, axle_center_radius=axle_center_radius, length=15) {

    difference() {
        cylinder(r=axle_radius, h=length);
        translate([0, 0, -defeather])
            cylinder(r=axle_center_radius, h=length+2*defeather);
    }
}


// A rotation axle with a "+" cross section
module cross_axle(axle_rounding=axle_rounding, axle_radius=axle_radius, length=15) {

    rotate([90, 45, 0])
    difference() {
        axle(axle_radius=axle_radius, axle_center_radius=0, length=length);        
        axle_cross_negative_space(axle_rounding=axle_rounding, axle_radius=axle_radius, length=length);
    }
}


// That which is cut away four times from a solid to create a cross axle
module axle_cross_negative_space(axle_rounding=axle_rounding, axle_radius=axle_radius, length=length) {
    
    defeather = 0.01;
    
    for (rot=[0:90:270]) {
        rotate([0, 0, rot])
            hull() {
                translate([axle_rounding*2, axle_rounding*2, -defeather]) {
                    cylinder(r=axle_rounding, h=length+2*defeather);

                    translate([axle_radius, 0, 0])
                        cylinder(r=axle_rounding, h=length+2*defeather);

                    translate([0, axle_radius, 0])
                        cylinder(r=axle_rounding, h=length+2*defeather);
                }
            }
    }
}

// A connector pin between two sockets
module pin(axle_radius=axle_radius, pin_center_radius=pin_center_radius, peg_length=peg_length, pin_tip_length=pin_tip_length, counterbore_holder_height=counterbore_holder_height) {

    length=(peg_length+pin_tip_length)*2 + counterbore_holder_height;

    slot_length=length/1.2;

    difference() {
        union() {
            cylinder(r=axle_radius, h=length);
            
            translate([0, 0, peg_length+pin_tip_length])
                cylinder(r=counterbore_holder_radius, h=counterbore_holder_height);
            
            tip(axle_radius=axle_radius, pin_tip_length=pin_tip_length);
            
            translate([0, 0, length-pin_tip_length])
                tip(axle_radius=axle_radius, pin_tip_length=pin_tip_length);
        }
        
        union() {
            translate([0, 0, -defeather])
                cylinder(r=pin_center_radius, h=length+2*defeather);

            translate([0, 0, slot_thickness])
                rounded_slot(thickness=slot_thickness, slot_length=slot_length);
            
            translate([0, 0, length-slot_thickness])
                rounded_slot(thickness=slot_thickness, slot_length=slot_length);
            
            translate([0, 0, length/2])
                rotate([0, 0, 90])
                rounded_slot(thickness=slot_thickness, slot_length=slot_length);
        }
    }
}


// An end ridge to allow a Pin to lock in to a Technic-compatible block
module tip(axle_radius=axle_radius, pin_tip_length=pin_tip_length) {
    rounded_disc(radius=axle_radius+pin_tip_length, thickness=pin_tip_length);
}


// A disc with rounded outer edge
module rounded_disc(radius=10, thickness=1) {
    translate([0, 0, thickness/2])
        minkowski() {
            cylinder(r=radius-thickness, h=defeather);
        
            sphere(r=thickness/2, $fn=16);
        }
}

module rounded_slot(thickness=2, slot_length=10) {
    width = 20;
    
    hull() {
        translate([-width/2, 0, slot_length/2 - thickness])
            rotate([0, 90, 0])
                cylinder(r=thickness/2, h=width, $fn=16);
            
        translate([-width/2, 0, -slot_length/2 + thickness])
            rotate([0, 90, 0])
                cylinder(r=thickness/2, h=width, $fn=16);
    }
}
