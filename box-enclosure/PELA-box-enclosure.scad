/*
Parametric PELA Box Enclosure Generator

Create a bottom and 4 walls of a rectangle for enclosing objects


By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution-ShareAlike 4.0 International License
    https://creativecommons.org/licenses/by-sa/4.0/legalcode

Open source design, Powered By Futurice. Come work with the best.
    https://www.futurice.com/

Import this into other design files:
    use <anker-usb-PELA-enclosure.scad>
*/

include <../parameters.scad>
include <../print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../socket-panel/PELA-socket-panel.scad>
use <../knob-panel/PELA-knob-panel.scad>


/* [PELA Enclosure Option] */

// Length of the enclosure including two for walls [blocks]
l = 6;

// Width of the enclosure including two for walls [blocks]
w = 4;

// Height of the enclosure [mm]
h = 1;

// Presence of bottom connector sockets
sockets = true;

// Add full width through holes spaced along the length for PELA Techics connectors
side_holes = 2;  // [0:disabled, 1:short air vents, 2:full width connectors, 3:short connectors]

// Add a shell around side holes (disable for extra ventilation, enable for lock notch fit)
side_sheaths = true;

// Add short end holes spaced along the width for PELA Techics connectors
end_holes = 3;  // [0:disabled, 1:short air vents, 2:full length connectors, 3:short connectors]

// Add a shell around end holes  (disable for extra ventilation, enable for connector lock notches)
end_sheaths = true;

// Add holes in the top deck to improve airflow and reduce weight
top_vents = false;

// Add holes in the bottom deck to improve airflow and reduce weight (only used with bottom_type==3, knob panel)
bottom_vents = true;

// Size of a hole in the top of each knob to keep the cutout as part of the outside surface (slicer-friendly if knob_slice_count=0). Use a larger number for air circulation or to drain resin from the cutout, or 0 to disable.
knob_vent_radius = 0;

// There is usually no need or room for corner mounting M3 bolt holes
corner_bolt_holes = true;

// Bottom of enclosure
bottom_type = 2; // [0:open bottom, 1:solid bottom, 2:socket-panel bottom, 3:knob-panel bottom]

// Create the left wall
left_wall_enabled = true;

// Shoud there be knobs on top of the left wall
left_wall_knobs = true;

// Create the right wall
right_wall_enabled = true;

// Shoud there be knobs on top of the right wall
right_wall_knobs = true;

// Create the front wall
front_wall_enabled = true;

// Shoud there be knobs on top of the front wall
front_wall_knobs = true;

// Create the back wall
back_wall_enabled = true;

// Shoud there be knobs on top of the back wall
back_wall_knobs = true;

// Interior fill for layers above the bottom
solid_upper_layers = true;

// Interior fill for layers above the bottom
solid_bottom_layer = false;

// Should the middle of the box be a solid block or empty. Other designs will typically then cut from this solid block to support something inside the enclosure.
center_type = 0; //[0:empty, 1:solid, 2:solid with side holes, 3:solid with end holes, 4:solid with both side and end holes]

// Number of knobs at the edge of a bottom panel to omit (this will leave space for example for a nearby top wall or technic connectors)
skip_edge_knobs = 1;

// Height of each block
block_height = 9.6;



///////////////////////////////////
// Functions
///////////////////////////////////

// Find the optimum enclosing horizontal dimension in block units for an object of width/length i
function fit_mm_to_pela_blocks(i, tightness) = ceil((i+(tightness*block_width())) / block_width());

// Find the optimum enclosing vertical dimension in block units for an object of height i
function fit_mm_to_pela_block_height(i, tightness, block_height=block_height) = ceil((i+(tightness*block_height(1, block_height=block_height))) / block_height(1, block_height=block_height));



///////////////////////////////////
// Modules
///////////////////////////////////

module PELA_box_enclosure(l=l, w=w, h=h, bottom_type=bottom_type, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, shell=shell, ridge_z_offset=ridge_z_offset, center_type=center_type, block_height=block_height) {

    difference() {
        union() {
            walls(l=l, w=w, h=h, bottom_type=bottom_type, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, shell=shell, ridge_z_offset=ridge_z_offset, center_type=center_type, block_height=block_height);

            enclosure_bottom(l=l, w=w, bottom_type=bottom_type, skin=skin, solid_bottom_layer=solid_bottom_layer, block_height=block_height);

            box_center(l=l, w=w, h=h, center_type=center_type, side_holes=side_holes, end_holes=end_holes, block_height=block_height);
        }

        union() {    
            bottom_connector_negative_space(l=l, w=w, h=h, side_holes=side_holes, end_holes=end_holes, axle_hole_radius=axle_hole_radius, block_width=block_width, hole_type=3, corner_bolt_holes=false, sockets=sockets, block_height=block_height);

            edge_connector_negative_space(l=l, w=w, bottom_type=bottom_type, side_holes=side_holes, end_holes=end_holes, axle_hole_radius=axle_hole_radius, hole_type=side_holes, knob_radius=knob_radius, corner_bolt_holes=corner_bolt_holes, block_height=block_height);
        }
    }
}


module walls(l=l, w=w, h=h, bottom_type=bottom_type, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, left_wall_knobs=left_wall_knobs, right_wall_knobs=right_wall_knobs, front_wall_knobs=front_wall_knobs, back_wall_knobs=back_wall_knobs, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, shell=shell, ridge_z_offset=ridge_z_offset, center_type=center_type, block_height=block_height) {

    difference() {
        union() {
            if (left_wall_enabled) {
                left_wall(l=l, w=w, h=h, top_vents=top_vents, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, shell=shell, knobs=left_wall_knobs, ridge_z_offset=ridge_z_offset, block_height=block_height);
            }

            if (right_wall_enabled) {
                right_wall(l=l, w=w, h=h, top_vents=top_vents, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, shell=shell, knobs=right_wall_knobs, ridge_z_offset=ridge_z_offset, block_height=block_height);
            }

            if (front_wall_enabled) {
                front_wall(l=l, w=w, h=h, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, shell=shell, knobs=front_wall_knobs, ridge_z_offset=ridge_z_offset, block_height=block_height);
            }

            if (back_wall_enabled) {
                back_wall(l=l, w=w, h=h, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, shell=shell, knobs=back_wall_knobs, ridge_z_offset=ridge_z_offset, block_height=block_height);
            }
        }

        if (bottom_type>0) {
            bottom_negative_space(l=l, w=w, h=h, bottom_type=1, skin=0, solid_bottom_layer=solid_bottom_layer, block_height=block_height);
        }
    }
}


// Left side of the box with corner cuts
module left_wall(l=l, w=w, h=h, top_vents=top_vents, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, shell=shell, knobs=left_wall_knobs, ridge_z_offset=ridge_z_offset, block_height=block_height) {

    difference() {
        PELA_technic_block(l=1, w=w, h=h, top_vents=top_vents, side_holes=0, side_sheaths=0, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, knobs=knobs, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, shell=shell, knobs=knobs, ridge_z_offset=ridge_z_offset, block_height=block_height);

        union() {
            if (front_wall_enabled) {
                corner_cut(angle=-45, h=h, block_height=block_height);
            }

            if (back_wall_enabled) {
                translate([0, block_width(w), 0]) {
                    corner_cut(angle=-45, h=h, block_height=block_height);
                }
            }
        }
    }
}


// A slice removed so that two wall fit together as a single whole
module corner_cut(angle, h=h, block_height=block_height) {
    translate([0, 0, -defeather]) {
        rotate([0, 0, angle]) {
            cube([block_width(2), block_width(2), block_height(h, block_height=block_height) + defeather]);
        }
    }
}


// Mirror image of the left side
module right_wall(l=l, w=w, h=h, top_vents=top_vents, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, shell=shell, knobs=right_wall_knobs, ridge_z_offset=ridge_z_offset, block_height=block_height) {

    translate([block_width(l), block_width(w), 0]) {
        rotate([0, 0, 180]) {
            left_wall(l=l, w=w, h=h, top_vents=top_vents, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, front_wall_enabled=back_wall_enabled, back_wall_enabled=front_wall_enabled, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, shell=shell, knobs=knobs, ridge_z_offset=ridge_z_offset, block_height=block_height);
        }
    }
}


// Front side of the box with corner cuts
module front_wall(l=l, w=w, h=h, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, shell=shell, knobs=front_wall_knobs, ridge_z_offset=ridge_z_offset, block_height=block_height) {

    difference() {
        PELA_technic_block(l=l, w=1, h=h, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=0, end_sheaths=0, skin=skin, knobs=knobs, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, shell=shell, knobs=knobs, ridge_z_offset=ridge_z_offset, block_height=block_height);

        union() {
            if (left_wall_enabled) {
                corner_cut(angle=45, h=h, block_height=block_height);
            }

            if (right_wall_enabled) {
                translate([block_width(l), 0, 0]) {
                    corner_cut(angle=45, h=h, block_height=block_height);
                }
            }
        }
    }
}


// Mirror image of the front wall
module back_wall(l=l, w=w, h=h, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, shell=shell, knobs=back_wall_knobs, ridge_z_offset=ridge_z_offset, block_height=block_height) {

    translate([block_width(l), block_width(w), 0]) {
        rotate([0, 0, 180]) {
            front_wall(l=l, w=w, h=h, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, skin=skin, left_wall_enabled=right_wall_enabled, right_wall_enabled=left_wall_enabled, solid_bottom_layer=solid_bottom_layer, solid_upper_layers=solid_upper_layers, shell=shell, knobs=knobs, ridge_z_offset=ridge_z_offset, block_height=block_height);
        }
    }
}


// Cutout for the box bottom
module bottom_negative_space(l=l, w=w, bottom_type=bottom_type, skin=skin, solid_bottom_layer=solid_bottom_layer, block_height=block_height) {
    
    if (bottom_type > 0) {
        enclosure_bottom(l=l, w=w, bottom_type=bottom_type, skin=skin, solid_bottom_layer=solid_bottom_layer, block_height=block_height);
    }
}


// Space for the edge connectors
module edge_connector_negative_space(l=l, w=w, bottom_type=bottom_type, side_holes=side_holes, end_holes=end_holes, axle_hole_radius=axle_hole_radius, block_width=block_width, hole_type=side_holes, knob_radius=knob_radius, block_width=block_width, corner_bolt_holes=corner_bolt_holes, block_height=block_height) {

    if (bottom_type > 0) {
        bottom_connector_negative_space(l=l, w=w, side_holes=side_holes, end_holes=end_holes, axle_hole_radius=axle_hole_radius, hole_type=side_holes, knob_radius=knob_radius, corner_bolt_holes=corner_bolt_holes, sockets=sockets, block_height=block_height);
    }
}


// The optional bottom layer of the box
module enclosure_bottom(l=l, w=w, bottom_type=bottom_type, skin=skin, skip_edge_knobs=skip_edge_knobs, solid_bottom_layer=solid_bottom_layer, block_height=block_height) {

    if (bottom_type==1) {
        translate([skin, skin, 0]) {
            cube([block_width(l)-2*skin, block_width(w)-2*skin, panel_height(block_height=block_height)]);
        }
    } else if (bottom_type==2) {
        socket_panel_one_sided(l=l, w=w, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, skin=skin, block_height=block_height);    
    } else if (bottom_type==3) {
        PELA_knob_panel(l=l, w=w, top_vents=bottom_vents, solid_bottom_layer=solid_bottom_layer, corner_bolt_holes=corner_bolt_holes, bolt_hole_radius=bolt_hole_radius, knobs=knobs, sockets=sockets, skin=skin, skip_edge_knobs=skip_edge_knobs, block_height=block_height);
   }
}


// The middle "cheese" from which enclosure supports are cut
module box_center(l=l, w=w, h=h, center_type=center_type, side_holes=side_holes, end_holes=end_holes, block_height=block_height) {
    if (center_type > 0 && l > 2 && w > 2) {
        l2 = block_width(l-2) + 2*skin;
        w2 = block_width(w-2) + 2*skin;

        translate([block_width(1) - skin, block_width(1) - skin, panel_height(block_height=block_height)]) {
            cube([l2, w2, block_height(h, block_height=block_height) - panel_height(block_height=block_height)]);
        }
    }
}
