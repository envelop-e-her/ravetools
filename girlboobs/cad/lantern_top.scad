$fn = 80;

// More information: https://danielupshaw.com/openscad-rounded-corners/

// Set to 0.01 for higher definition curves (renders slower)
$fs = 0.15;

module roundedcube(size = [1, 1, 1], center = false, radius = 0.5, apply_to = "all") {
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate_min = radius;
	translate_xmax = size[0] - radius;
	translate_ymax = size[1] - radius;
	translate_zmax = size[2] - radius;

	diameter = radius * 2;

	obj_translate = (center == false) ?
		[0, 0, 0] : [
			-(size[0] / 2),
			-(size[1] / 2),
			-(size[2] / 2)
		];

	translate(v = obj_translate) {
		hull() {
			for (translate_x = [translate_min, translate_xmax]) {
				x_at = (translate_x == translate_min) ? "min" : "max";
				for (translate_y = [translate_min, translate_ymax]) {
					y_at = (translate_y == translate_min) ? "min" : "max";
					for (translate_z = [translate_min, translate_zmax]) {
						z_at = (translate_z == translate_min) ? "min" : "max";

						translate(v = [translate_x, translate_y, translate_z])
						if (
							(apply_to == "all") ||
							(apply_to == "xmin" && x_at == "min") || (apply_to == "xmax" && x_at == "max") ||
							(apply_to == "ymin" && y_at == "min") || (apply_to == "ymax" && y_at == "max") ||
							(apply_to == "zmin" && z_at == "min") || (apply_to == "zmax" && z_at == "max")
						) {
							sphere(r = radius);
						} else {
							rotate = 
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
								[0, 0, 0]
							);
							rotate(a = rotate)
							cylinder(h = diameter, r = radius, center = true);
						}
					}
				}
			}
		}
	}
}

//color("Green")
//translate([0,20,13])roundedcube([69, 26, 18], true, 1, "x");

difference() {
    union() {
        translate([0,0,-1])cylinder(h = 2, d = 87);
        translate([0,0,1])cylinder(h = 2, d = 105);
        
        translate([0,0,4.5])cube([95, 9, 4], center = true);
        
        translate([0,20,8])cube([73, 26, 10], center = true);
        translate([-25,7,12])cube([10, 3, 19], center = true);
        translate([25,7,12])cube([10, 3, 19], center = true);
        translate([-25,33,12])cube([10, 3, 19], center = true);
        translate([25,33,12])cube([10, 3, 19], center = true);
        
        translate([0,-22,2])cylinder(h = 10, d = 25);
        
    }
    
    
    translate([0,-22,11])cylinder(h = 10, d = 20.75);
    translate([0,0,5])cube([91 , 5, 5], center = true);
    translate([0,20,12])roundedcube([69, 26.2, 18], true, 3, "x");
    
    translate([5,0,-3])cylinder(h = 10, d = 1.5);
    translate([-5,0,-3])cylinder(h = 10, d = 1.5);
}
    
    
    
