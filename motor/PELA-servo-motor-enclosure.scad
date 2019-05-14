/*
PELA Parametric LEGO-compatible Technic N20 Gearmotor Enclosure

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
include <../material.scad>
use <../PELA-block.scad>
use <../PELA-technic-block.scad>
use <../technic-mount/PELA-technic-box.scad>


/* [Render] */

// Show the inside structure [mm]
cut_line = 0; // [0:1:100]

// Printing material (set to select calibrated knob, socket and axle hole fit)
_material = 1; // [0:PLA, 1:ABS, 2:PET, 3:Biofila Silk, 4:Pro1, 5:NGEN, 6:NGEN FLEX, 7:Bridge Nylon, 8:TPU95, 9:TPU85/NinjaFlex]

// Is the printer nozzle >= 0.5mm? If so, some features are enlarged to make printing easier
large_nozzle = true;

// Model pieces to render
render_modules = 0; // [0:top and bottom, 1:top, 2:bottom]


/* [Motor Enclosure] */

// Add interior fill for first layer
solid_first_layer = true;

// Add interior fill for upper layers
solid_upper_layers = true;


/* [Motor Enclosure Size] */

// Length of the motor enclosure [blocks]
l = 5; // [1:1:20]

// Width of the motor enclosure [blocks]
w = 4; // [1:1:20]

// Height of the bottom part of the motor enclosure (block count, the top part is always 1/3)
h = 4; // [1:1:20]

// Distance from length ends of connector twist [blocks]
twist_l = 1; // [1:18]

// Distance from width ends of connector twist [blocks]
twist_w = 2; // [1:18]

// Interior fill style
center = 0; // [0:empty, 1:solid, 2:edge cheese holes, 3:top cheese holes, 4:all cheese holes, 5:socket panel, 6:knob panel]

// Presence of sockets if center is "socket panel"
center_sockets = true;

// Presence of knobs if center is "knob panel"
center_knobs = true;

// Size of hole in the center of knobs if "center" or "cover center" is "knob panel"
knob_vent_radius = 0.0; // [0.0:0.1:3.9]

// Text label
text = "Servo";
 
// Depth of text etching into top surface
text_depth = 0.5; // [0.0:0.1:2]


/* [Motor Options] */
// Diameter of the rounded part of the motor body (if no rounding, set length as appropriate and this to 1/2 the motor width)
motor_d = 24 + skin;

// Shaft-axis ditance of the rounded part of the motor body
motor_length = 30 + 2*skin;

// Radius of the motor shaft cutout slot
motor_shaft_radius = 1.9;

// Heat ventilation holes in the sides
side_holes = 2; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors]

// Heat ventilation holes in the ends
end_holes = 2; // [0:disabled, 1:short air vents, 2:short connectors, 3:full width connectors] 

// Heat ventilation holes in the top surface
top_vents = true;

// Open the upper surface of the top holder
top_access = true;

// Motor offset on the X axis
motor_x = 8; // [0.1:0.1:16]

// Motor shaft hole diameter
shaft_d = 1.5; // [0.1:0.1:4]

// Slot diameter for electrial cabling
electric_d = 5.5; // [0.1:0.1:16]

// Vertial offset from shaft of two M2.5 mounting holes
mount_hole_y = 8; // [0.1:0.1:16]

// M2.5 mount hole diameter
mount_hole_d = 2.7; // [0.1:0.1:8]


/* [Hidden] */

// Height of the top part of the motor enclosure (block count, the top part is always 1/3)
top_h = h/2;

bottom_h = h - top_h;

shaft_l = 10;



///////////////////////////////
// DISPLAY
///////////////////////////////

motor_enclosure(material=material, large_nozzle=large_nozzle, cut_line=cut_line, render_modules=render_modules, l=l, w=w, h=h, top_h=top_h, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, top_vents=top_vents, knob_vent_radius=knob_vent_radius, side_holes=side_holes, end_holes=end_holes, corner_bolt_holes=corner_bolt_holes);

///////////////////////////////////
// MODULES
///////////////////////////////////

/*
module motor_enclosure(material=undef, large_nozzle=undef, cut_line=undef) {
    
    difference() {
        motor_enclosure(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h_bottom, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, top_vents=0, knob_vent_radius=knob_vent_radius, side_holes=side_holes, end_holes=end_holes, corner_bolt_holes=corner_bolt_holes);
        
        translate([0, 0, block_height(h_bottom, block_height)]) {
            motor(material=material, large_nozzle=large_nozzle);
        }
    }
}


module motor_enclosure_top(material=undef, large_nozzle=undef, cut_line=undef) {
    
    difference() {
        motor_enclosure(material=material, large_nozzle=large_nozzle, l=l, w=w, h=h_top, side_holes=side_holes, end_holes=end_holes, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, top_vents=top_vents, knob_vent_radius=knob_vent_radius, corner_bolt_holes=corner_bolt_holes);

        union() {
            motor(material=material, large_nozzle=large_nozzle);
            
            if (top_access) {
                translate([block_width(1), block_width(1), block_height(1, block_height)]) {
                    cube([block_width(l-2), block_width(w-2), block_height(2, block_height)]);
                }
            }
        }
    }
}
*/

module motor_enclosure(material=undef, large_nozzle=undef, cut_line=undef, render_modules=undef, l=undef, w=undef, h=undef, top_h=undef, solid_first_layer=undef, solid_upper_layers=undef, top_vents=undef, knob_vent_radius=undef, side_holes=undef, end_holes=undef, corner_bolt_holes=undef) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(cut_line!=undef);
    assert(render_modules!=undef);
    assert(l!=undef);
    assert(w!=undef);
    assert(h!=undef);
    assert(top_h!=undef);
    assert(solid_first_layer!=undef);
    assert(solid_upper_layers!=undef);
    assert(top_vents!=undef);
    assert(knob_vent_radius!=undef);
    assert(side_holes!=undef);
    assert(end_holes!=undef);
    assert(corner_bolt_holes!=undef);

    difference() {
        union() {
            technic_box_and_cover(material=material, large_nozzle=large_nozzle, cut_line=cut_line, render_modules=render_modules, l=l, w=w, h=h, cover_h=cover_h, twist_l=twist_l, twist_w=twist_w, sockets=cover_sockets, knobs=cover_knobs, knob_vent_radius=knob_vent_radius, solid_first_layer=solid_first_layer, center=cover_center, text=cover_text, text_depth=text_depth, block_height=block_height);

            
            
/*            PELA_technic_block(material=material, large_nozzle=large_nozzle, cut_line=cut_line, l=l, w=w, h=h_bottom, solid_first_layer=solid_first_layer, solid_upper_layers=solid_upper_layers, top_vents=0, knob_vent_radius=knob_vent_radius, side_holes=side_holes, end_holes=end_holes, corner_bolt_holes=corner_bolt_holes); 
*/
            
            translate([block_width(l)-skin-side_shell(large_nozzle), block_width((w-1)/2), 0]) {
                cube([side_shell(large_nozzle), block_width(1), block_height(h, block_height)]);
            }

            translate([skin, block_width((w-1)/2), 0]) {
                cube([side_shell(large_nozzle), block_width(1), block_height(h, block_height)]);
            }
        }
        
        cut_space(material=material, large_nozzle=large_nozzle, l=l, w=w, cut_line=cut_line, h=h, block_height=block_height, knob_height=knob_height);
    }
}
        



// Shape of the motor body
module motor(material=undef, large_nozzle=undef, w=undef, motor_x=undef, motor_d=undef, motor_length=undef, shaft_d=undef, shaft_l=undef, mount_hole_d=undef, electric_d=undef) {

    assert(material!=undef);
    assert(large_nozzle!=undef);
    assert(w!=undef);
    assert(motor_x!=undef);
    assert(motor_d!=undef);
    assert(motor_length!=undef);
    assert(shaft_d!=undef);
    assert(shaft_l!=undef);
    assert(mount_hole_d!=undef);
    assert(electric_d!=undef);
    
    translate([motor_x, block_width(w/2), 0]) {
        rotate([0, 90, 0]) {
            cylinder(d=motor_d, h=motor_length);
            
            translate([0, 0, motor_length]) {
                cylinder(d=shaft_d, h=shaft_l);
            }

            hull() {            
                translate([-motor_d/2, 0, -shaft_l]) {
                    cylinder(d=electric_d, h=shaft_l);
                }

                translate([motor_d/2, 0, -shaft_l]) {
                    cylinder(d=electric_d, h=shaft_l);
                }
            }
            
            translate([mount_hole_y, 0, motor_length]) {
                cylinder(d=mount_hole_d, h=shaft_l);
            }
            
            translate([-mount_hole_y, 0, motor_length]) {
                cylinder(d=mount_hole_d, h=shaft_l);
            }
        }
    }
}