// Infiniground SCAD Generator
// Forked from https://github.com/DanielJoyce/ultimate_base_generator
// Under CC-BY-SA-4.0

/* [Block] */

// base block
block_specification = 15; // [3:Skin, 15:Low, 60:High]

// texture
height_map = "crater_tex_01.png"; // [image_surface:150x150]
texture_scale = 20; // [1:100]
raise_texture = 1; // [-100:100]

// logo
logo_text = "INFINIGROUND";
logo_size = 3; // [0:100]
logo_offset_x = 76; // [0:152]
logo_offset_y = 76; // [0:152]
logo_emboss = 5.2; // [0:100]

/* [Hidden] */

// block dimensions
block_width = 152;
block_edge_indent = 1.6;
block_reserved_base = 5;

// pegs
boolean_offset = 2;
peg_diameter = 6.5;
peg_depth = 16.5 + boolean_offset;
peg_blank_diameter = 7.7;
peg_blank_depth = 17.7;
peg_centre_height = 6;
cylinder_faces = 48;

// Build It

difference() {
    difference() {
        union() {
            // model the texture
            translate([block_edge_indent,block_edge_indent,raise_texture]) {
                scale([1,1,texture_scale/100]) {
                    // the texture surface
                    surface(file=height_map, convexity=10);
                }
            }
            // add the logo if specified
            if (logo_emboss > 0 && logo_size > 0) {
                translate([logo_offset_x, logo_offset_y, 0]) {
                    linear_extrude(logo_emboss) {
                        text(logo_text, size=logo_size, halign="center", valign="center");
                    }
                }
            }
            // add the peg blanks except on skins
            if (block_specification > 10) {
                // south blank
                translate([block_width / 2, 0, peg_centre_height]) {
                    rotate([270,0,0]) {
                        cylinder(h=peg_blank_depth, r=peg_blank_diameter/2, $fn=cylinder_faces);
                    }
                }
                // east blank
                translate([block_width, block_width / 2, peg_centre_height]) {
                    rotate([270,0,90]) {
                        cylinder(h=peg_blank_depth, r=peg_blank_diameter/2, $fn=cylinder_faces);
                    }
                }
                // north blank
                translate([block_width / 2, block_width, peg_centre_height]) {
                    rotate([90,0,0]) {
                        cylinder(h=peg_blank_depth, r=peg_blank_diameter/2, $fn=cylinder_faces);
                    }
                }
                // west blank
                translate([0, block_width / 2, peg_centre_height]) {
                    rotate([90,0,90]) {
                        cylinder(h=peg_blank_depth, r=peg_blank_diameter/2, $fn=cylinder_faces);
                    }
                }
            }
            difference() {
                // the basic cube
                cube([block_width, block_width, block_specification]);
                // subtract the cut cube
                translate([block_edge_indent,block_edge_indent,block_reserved_base]) {
                    // the cut cube
                    cube([block_width - (2 * block_edge_indent), block_width - (2 * block_edge_indent), block_width]);
                }
            }
        }
        // cut off anything below y=0    
        translate([0,0,-200]) {
            // bottom cut cube
            cube([block_width, block_width, 200]);
        }
    }
    // cut the pegs except on skins
    if (block_specification > 10) {
        // south peg
        translate([block_width / 2, -1 * boolean_offset, peg_centre_height]) {
            rotate([270,0,0]) {
                cylinder(h=peg_depth, r=peg_diameter/2, $fn=cylinder_faces);
            }
        }
        // east peg
        translate([block_width + boolean_offset, block_width / 2, peg_centre_height]) {
            rotate([270,0,90]) {
                cylinder(h=peg_depth, r=peg_diameter/2, $fn=cylinder_faces);
            }
        }
        // north peg
        translate([block_width / 2, block_width + boolean_offset, peg_centre_height]) {
            rotate([90,0,0]) {
                cylinder(h=peg_depth, r=peg_diameter/2, $fn=cylinder_faces);
            }
        }
        // west peg
        translate([-1 * boolean_offset, block_width / 2, peg_centre_height]) {
            rotate([90,0,90]) {
                cylinder(h=peg_depth, r=peg_diameter/2, $fn=cylinder_faces);
            }
        }
    }
}
