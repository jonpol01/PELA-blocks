/*
PELA technic angle - 3D Printed LEGO-compatible 30 degree bend

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

include <../print-parameters.scad>
include <../style.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <PELA-technic-bar.scad>

/* [Technic Pin Array Options] */

// Angle between the top and bottom parts of the connector [degrees]
angle = 30;

// Length of the connector [blocks]
l = 7;



///////////////////////////////
// DISPLAY
///////////////////////////////

technic_angle_connector();



///////////////////////////////////
// MODULES
///////////////////////////////////

module technic_angle_connector(angle=angle, l=l) {
    assert(angle >= 0, "Angle connector must be 0-180 degrees")
    assert(angle <= 180, "Angle connector must be 0-180 degrees")

    translate([0, 0, block_height(1)]) {
        rotate([angle, 0, 0]) {
            translate([0, block_width(0.5), 0]) {
                technic_bar(l=l);
            }
        }
    }

    translate([0, block_width(0.5), 0]) {
            technic_bar(l=l);
    }

    increment = 5;
    for (theta = [0 : increment : angle]) {
        pie_slice(theta=theta, increment=increment, l=l);
    }
}



// theta-degree spacer between the two segments
module pie_slice(theta=0, increment=5, l=l) {
    translate([0, 0, block_width(1)]) {
        rotate([theta, 0 , 0]) {
            difference() {
                hull() {
                    technic_bar_slice(l=l);

                    rotate([increment, 0, 0]) {
                        technic_bar_slice(l=l);
                    }
                }

                for (n = [0:1:l-1]) {
                    translate([block_width(n), 0, 0]) {
                        hull() {
                            translate([0, 0, -defeather]) {
                                technic_bar_slice_negative(l=0);
                            }

                            rotate([increment, 0, 0]) {
                                translate([0, 0, defeather]) {
                                    technic_bar_slice_negative(l=0);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}