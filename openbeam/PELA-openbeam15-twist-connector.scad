/*
PELA Parametric LEGO-compatible Openbeam15 Connector

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

include <../parameters.scad>
include <../print-parameters.scad>
use <../PELA-block.scad>
use <../socket-panel/PELA-socket-panel.scad>
use <../knob-panel/PELA-knob-panel.scad>


///////////// Parameters /////////////////////

w = 2;
l = 2;
block_height=9.6;

top_width = block_width(w);
top_length = block_width(l);
top_height = panel_height(block_height=block_height);

throat_length = block_width();
throat_width = 2.7;
throat_height = 1.9;

foot_width = throat_width;
foot_length = throat_length + 2*1.6;
foot_height = 2;

toe_length = 1;




///////////////////////////////
// Display
///////////////////////////////

openbeam15();



///////////////////////////////////
// Modules
///////////////////////////////////

module openbeam15() {
	PELA_knob_panel(l=l, w=w, corner_bolt_holes=false, sockets=false, block_height=block_height);

	translate([top_width/2, top_length/2, 0]) {
		cylinder(r=block_width(1/3), h=top_height);
	}

	translate([0, top_length, 0]) {
		rotate([180, 0, 0]) {
			hull() {
				openbeam15_neck();
				openbeam15_foot_back();
			}

			color("white") translate([0, block_width(1), 0])
				openbeam15_insert();
		}
	}
}


module openbeam15_neck() {
	translate([(top_width - throat_width) / 2, 0, 0]) {
		cube([throat_width, throat_length, throat_height]);
	}
}


module openbeam15_foot_back() {
		translate([(top_width + throat_height/2) / 2, top_length / 2, throat_height*3/2]) {
			rotate([90, 0, 0]) {
				cylinder(h=throat_length, d=throat_height);
			}
		}
}

module openbeam15_insert() {
//	intersection() {
		translate([top_width / 2, top_length / 2, throat_height]) {
			cylinder(h=throat_height, d=foot_length);
		}

//		translate([top_width/2 - throat_width/2, 0, 0]) {
//			cube([throat_width, 1000, 1000]);
//		}
//	}
}