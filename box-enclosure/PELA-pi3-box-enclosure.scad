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
    http://futurice.com

Import this into other design files:
    use <anker-usb-PELA-enclosure.scad>
*/

include <../PELA-parameters.scad>
include <../PELA-print-parameters.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../socket-panel/PELA-socket-panel.scad>
use <../knob-panel/PELA-knob-panel.scad>
use <PELA-box-enclosure.scad>


/* [PELA Box Option] */

// Length of the enclosure including two for walls (PELA knob count)
l = 6;

// Width of the enclosure including two for walls (PELA knob count)
w = 4;

// Height of the enclosure including one for floor (PELA block layer count)
h = 2;

// Board length, including some extra
board_l = 33.3;

// Board width, including some extra
board_w = 18.3;

// Distance from box bottom to mount the board
board_h = 3.2;

// Thickness, including some extra for insertion
board_thickness = 1.7;

// Add full width through holes spaced along the length for PELA Techics connectors
side_holes = 0;  // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Add a sheath around side holes (disable for extra ventilation, enable for connector lock notches)
side_sheaths = 1; // [0:disabled, 1:enabled]

// Add short end holes spaced along the width for PELA Techics connectors
end_holes = 0;  // [0:disabled, 1:short air vents, 2:short connectors, 3:full length connectors]

// Add a sheath around end holes  (disable for extra ventilation, enable for connector lock notches)
end_sheaths = 1; // [0:disabled, 1:enabled]

// Add holes in the top deck to improve airflow and reduce weight
top_vents = false;

// Add holes in the bottom deck to improve airflow and reduce weight (only used with bottom_type==2, knob panel)
bottom_vents = false;

// Size of a hole in the top surface of each knob to keep the cutout as part of the outside surface (slicer-friendly if knob_slice_count=0). Use a larger number for air circulation or to drain resin from the cutout, or 0 to disable.
knob_vent_radius = 0;

// There is usually no need or room for corner mounting M3 bolt holes
bolt_holes = true;

// Bottom of enclosure
bottom_type = 2; // [0:open bottom, 1:solid bottom, 2:socket-panel bottom, 3:knob-panel bottom]

// Height of the bottom to the enclosure (by default this is shorter then a normal panel so there is room on the enclosure sides for technic holes)
bottom_height = panel_height();

// Create the left wall
left_wall_enabled = false;

// Create the right wall
right_wall_enabled = true;

// Create the front wall
front_wall_enabled = true;

// Create the back wall
back_wall_enabled = true;

// Bottom of the enclosure is a panel below the edges of the wall (if true, box is 1/3 of a block taller)
drop_bottom = false;

// Side snap size, block units. Longer is stronger/stiffer
flexture_width = 1;

// Width of flexture spacings from the rest of the side wall
side_snap_cut_width = 0.5;

// Depth into the side walls of the cut (block units, larger value means thicker/stiffer flexture)
side_snap_cut_depth = 0.3;

// Block with units in from board ends where the side snaps are placed
side_snap_end_inset = 1.5;

// Size of the bump which holds the board down (part of the snap inset flexture)
retainer_tab_radius = 0.6;

// Size of the space for cable access on the enclosure end
connector_hole_radius = 0;

// Height of the flexture which allows the board to slide past the retainer tab (block height count)
side_fexture_cut_height = 1.5;

solid_upper_layers = true;

/////////////////////////////////////
// PELA Box Enclosure Display

PELA_stmf4discovery_box_enclosure();


///////////////////////////////////
// Modules
///////////////////////////////////


module PELA_stmf4discovery_box_enclosure(l=l, w=w, h=h, bottom_type=bottom_type, bottom_height=bottom_height, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, drop_bottom=drop_bottom, solid_upper_layers=solid_upper_layers, retainer_tab_radius=retainer_tab_radius) {

    difference() {
        union() {
            PELA_box_enclosure(l=l, w=w, h=h, bottom_type=bottom_type, bottom_height=bottom_height, top_vents=top_vents, side_holes=side_holes, side_sheaths=side_sheaths, end_holes=end_holes, end_sheaths=end_sheaths, skin=skin, left_wall_enabled=left_wall_enabled, right_wall_enabled=right_wall_enabled, front_wall_enabled=front_wall_enabled, back_wall_enabled=back_wall_enabled, drop_bottom=drop_bottom, solid_upper_layers=solid_upper_layers);

            board_insertion_space_shell(l=l, w=w, h=h, board_l=board_l, board_w=board_w, board_h=board_h, board_thickness=board_thickness);
        }

        union() {
            board_insertion_space(l=l, w=w, h=h, board_l=board_l, board_w=board_w, board_h=board_h, board_thickness=board_thickness);
            
            connector_holes();
            
            right_side_snap_cuts(side_snap_end_inset=side_snap_end_inset, flexture_width=flexture_width, side_snap_cut_width=side_snap_cut_width, side_snap_cut_depth=side_snap_cut_depth, retainer_tab_radius=retainer_tab_radius);

            left_side_snap_cuts(side_snap_end_inset=side_snap_end_inset, flexture_width=flexture_width, side_snap_cut_width=side_snap_cut_width, side_snap_cut_depth=side_snap_cut_depth, retainer_tab_radius=retainer_tab_radius);
        }
    }

    right_side_retainer_tabs(flexture_width=flexture_width, side_snap_end_inset=side_snap_end_inset, side_snap_cut_width=side_snap_cut_width, board_h=board_h, board_thickness=board_thickness, retainer_tab_radius=retainer_tab_radius);

    left_side_retainer_tabs(flexture_width=flexture_width, side_snap_end_inset=side_snap_end_inset, side_snap_cut_width=side_snap_cut_width, board_h=board_h, board_thickness=board_thickness, retainer_tab_radius=retainer_tab_radius);

    translate([0, 0, board_thickness + 2*retainer_tab_radius]) {
        right_side_retainer_tabs(flexture_width=flexture_width, side_snap_end_inset=side_snap_end_inset, side_snap_cut_width=side_snap_cut_width, board_h=board_h, board_thickness=board_thickness, retainer_tab_radius=retainer_tab_radius);
    
        left_side_retainer_tabs(flexture_width=flexture_width, side_snap_end_inset=side_snap_end_inset, side_snap_cut_width=side_snap_cut_width, board_h=board_h, board_thickness=board_thickness, retainer_tab_radius=retainer_tab_radius);
    }
}


// Two bumps on the two right side flextures to keep the board from moving upwards
module right_side_retainer_tabs(flexture_width=flexture_width, side_snap_end_inset=side_snap_end_inset, side_snap_cut_width=side_snap_cut_width, board_h=board_h, board_thickness=board_thickness, retainer_tab_radius=retainer_tab_radius) {

    side_snap_board_retainer_tab(flexture_width=flexture_width, side_snap_end_inset=side_snap_end_inset, side_snap_cut_width=side_snap_cut_width, board_h=board_h, board_thickness=board_thickness, retainer_tab_radius=retainer_tab_radius);

    translate([block_width(l - flexture_width - 2*side_snap_end_inset), 0, 0]) {
        side_snap_board_retainer_tab(flexture_width=flexture_width, side_snap_end_inset=side_snap_end_inset, side_snap_cut_width=side_snap_cut_width, board_h=board_h, board_thickness=board_thickness, retainer_tab_radius=retainer_tab_radius);
    }        
}


// Two bumps on the left side to hold the board down
module left_side_retainer_tabs(flexture_width=flexture_width, side_snap_end_inset=side_snap_end_inset, side_snap_cut_width=side_snap_cut_width, board_h=board_h, board_thickness=board_thickness, retainer_tab_radius=retainer_tab_radius) {

    translate([block_width(l), block_width(w), 0]) {
        rotate([0, 0, 180]) {
            right_side_retainer_tabs(flexture_width=flexture_width, side_snap_end_inset=side_snap_end_inset, side_snap_cut_width=side_snap_cut_width, board_h=board_h, board_thickness=board_thickness, retainer_tab_radius=retainer_tab_radius);
        }
    }
}


// A bump sticking inward from the side flexture- keeps the board down
module side_snap_board_retainer_tab(flexture_width=flexture_width, side_snap_end_inset=side_snap_end_inset, flexture_width=flexture_width, side_snap_cut_width=side_snap_cut_width, board_h=board_h, board_thickness=board_thickness, retainer_tab_radius=retainer_tab_radius) {

    translate([block_width(side_snap_end_inset) + side_snap_cut_width, block_width(0.5) + 3, board_h + board_thickness + retainer_tab_radius]) {

        rotate([0, 90, 0]) {
            cylinder(r=retainer_tab_radius, h=block_width(flexture_width) - 2*side_snap_cut_width);
        }
    }
}


// Access points in the back panel for parts of the board which have wires attached
module connector_holes() {
    translate([0, block_width(w/2), block_height(h/2)]) {
        rotate([0, 90, 0]) {
            cylinder(r=connector_hole_radius, h=block_width(l));
        }
    }
}


// The shape of the board (excluding top and bottom coponents and connectors) which is being enclosed
module board(l=l, w=w, board_l=board_l, board_w=board_w, board_h=board_h, board_thickness=board_thickness) {
    x = (block_width(l) - board_l)/2;
    y = (block_width(w) - board_w)/2;

    translate([x, y, board_h]) {
        cube([board_l, board_w, board_thickness]);
    } 
}


// The space needed to drop the board in from above (may cut into the side walls)
module board_insertion_space(l=l, w=w, h=h, board_l=board_l, board_w=board_w, board_h=board_h, board_thickness=board_thickness) {

    hull() {
        board(l=l, w=w, board_l=board_l, board_w=board_w, board_h=board_h, board_thickness=board_thickness);

        translate([0, 0, block_height(h) - board_h - board_thickness]) {
            board(l=l, w=w, board_l=board_l, board_w=board_w, board_h=board_h, board_thickness=board_thickness);
        }
    }
}


// A solid layer around the space removed to allow dropping the board in from above
module board_insertion_space_shell(l=l, w=w, h=h, board_l=board_l, board_w=board_w, board_h=board_h, board_thickness=board_thickness) {

    board_insertion_space(l=l, w=w, h=h, board_l=board_l, board_w=board_w + 2*shell, board_h=board_h, board_thickness=board_thickness);
}


// Four vertical cuts into the side for two flexture to move with the board retaining tab
module right_side_snap_cuts(side_snap_end_inset=side_snap_end_inset, flexture_width=flexture_width, side_snap_cut_width=side_snap_cut_width, side_snap_cut_depth=side_snap_cut_depth, retainer_tab_radius=retainer_tab_radius) {

    side_snap_board_holder_cut(side_snap_end_inset=side_snap_end_inset, flexture_width=flexture_width, side_snap_cut_width=side_snap_cut_width, side_snap_cut_depth=side_snap_cut_depth, retainer_tab_radius=retainer_tab_radius);

    translate([block_width(l - 2*side_snap_end_inset - flexture_width), 0, 0]) {
        side_snap_board_holder_cut(flexture_width=flexture_width, side_snap_end_inset=side_snap_end_inset, flexture_width=flexture_width, side_snap_cut_width=side_snap_cut_width, side_snap_cut_depth=side_snap_cut_depth, retainer_tab_radius=retainer_tab_radius);
    }
}


// Four vertical cuts into the left side
module left_side_snap_cuts(side_snap_end_inset=side_snap_end_inset, flexture_width=flexture_width, side_snap_cut_width=side_snap_cut_width, side_snap_cut_depth=side_snap_cut_depth, retainer_tab_radius=retainer_tab_radius) {

    translate([block_width(l), block_width(w), 0]) {
        rotate([0, 0, 180]) {
            right_side_snap_cuts(side_snap_end_inset=side_snap_end_inset, flexture_width=flexture_width, side_snap_cut_width=side_snap_cut_width, side_snap_cut_depth=side_snap_cut_depth, retainer_tab_radius=retainer_tab_radius);
        }
    }
}

// Two vertical cuts in the side to hold a single board retaining tab
module side_snap_board_holder_cut(flexture_width=flexture_width, side_snap_end_inset=side_snap_end_inset, flexture_width=flexture_width, side_snap_cut_width=side_snap_cut_width, side_snap_cut_depth=side_snap_cut_depth, retainer_tab_radius=retainer_tab_radius) {

    translate([block_width(side_snap_end_inset), block_width(0.5), panel_height()]) {
        
        side_snap_cut(side_snap_cut_width=side_snap_cut_width, side_fexture_cut_height=side_fexture_cut_height);

        translate([block_width(flexture_width) - side_snap_cut_width, 0, 0]) {

            side_snap_cut(side_snap_cut_width=side_snap_cut_width, side_fexture_cut_height=side_fexture_cut_height);
        }

        translate([0, block_width(0.5 - side_snap_cut_depth) - retainer_tab_radius, 0]) {

            side_snap_back_cut(flexture_width=flexture_width, retainer_tab_radius=retainer_tab_radius, side_fexture_cut_height=side_fexture_cut_height);
        }
    }
}


// A vertical slice to allow the flexture to move inward as the board is inserted past the retaining tab
module side_snap_cut(side_snap_cut_width=side_snap_cut_width, side_fexture_cut_height=side_fexture_cut_height) {

    cube([side_snap_cut_width, block_width(1), block_height(side_fexture_cut_height)]);
}


// A vertical slice to allow the flexture to move inward as the board is inserted past the retaining tab
module side_snap_back_cut(flexture_width=flexture_width, retainer_tab_radius=retainer_tab_radius, side_fexture_cut_height=side_fexture_cut_height) {

    cube([block_width(flexture_width), retainer_tab_radius, block_height(side_fexture_cut_height)]);
}