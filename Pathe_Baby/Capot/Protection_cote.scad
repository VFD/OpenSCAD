//============================================================
// Project Pathe Baby
//
// Vincent DUBOIS
//============================================================

/*
	I've 2 Pathe Baby (9.5mm projector)
	This piece miss one, but the 2 Baby are not compatible.

	So, I build the cache missing.
	May be different form one Pathe Baby to another
	Must be adapt for other pathe Baby.
	Pathe Baby are black, print it black if you can.
	Else, paint it black.

	English is not my natural tongue, sorry for the "fautes".
*/

//------------------------------------------------------------
// Parameters in millimeter - Recommended values see comment
//------------------------------------------------------------
$fn = 100 ;		// OpenScad Resolution
Epsilon = 0.15 ;	// by definition Printer resolution

Thikness = 2 ;	// Thikness of Pathe Baby plate

// Approximatively, 
Plate_Height = 20;

// Axe position
// From the left corner of the mecanic bloc
// [0,0,0] is the corner position so it's now easy to build
Axe1_position = [12,40,0];
Axe2_position = [57,32,0];

// Diameter of each wheel
Wheel1_Diameter = 32;
Wheel2_Diameter = 30;
Wheel1_Radius = Wheel1_Diameter/2;
Wheel2_Radius = Wheel2_Diameter/2;

// Hole for the axe for fixing the cache
// Apparently the same for each Pathe Baby
Hole_Diameter = 6;
Hole_Radius = Hole_Diameter/2;

// This corner of the Baby is rounded
// I decide to eliminate material for simplicity
Chanfrain = 10;

//------------------------------------------------------------
View_Protection();


//------------------------------------------------------------
// Create Base
//------------------------------------------------------------
/*
	I use the HULL to build it from a cube and a cylinder
	The piece is exactly what I expected
*/
module Plate_Base()
{
	hull()
	{
		translate([0,Wheel1_Diameter/2,0])
			cube([1,Wheel1_Radius*3,Plate_Height]);
		translate(Axe2_position)
			cylinder
			(
				r=Wheel2_Radius+3*Thikness,
				h=Plate_Height,
				center=false
			);
	}
}

//------------------------------------------------------------
// Plate Empty
//------------------------------------------------------------
/*
	Same as above but for emptying the bloc
	Thikness is used
*/
module Plate_Empty()
{
translate([0,0,-Thikness])
hull()
{
	translate([-Thikness,Wheel1_Diameter/2+Thikness,0])
		cube([1,Wheel1_Radius*3-2*Thikness,Plate_Height]);
	translate(Axe2_position)
		cylinder
		(
			r=Wheel2_Radius+2*Thikness,
			h=Plate_Height,
			center=false
		);
}
}

//------------------------------------------------------------
// Module Plate Cache
//------------------------------------------------------------
/*
	All assembled
*/
module Plate_Cache()
{
	difference()
	{
		Plate_Base();
		Plate_Empty();
		translate(Axe1_position)
			cylinder
			(
				r=Hole_Radius,
				h=Plate_Height+Epsilon,
				center=false
			);
		translate([0,2*Wheel1_Diameter,0])
			rotate([90,90,0])
				cylinder
				(
					r=Chanfrain,
					h=4*Wheel1_Diameter,
					center=true
				);
		// option, there is it one my other Pathe Baby
		translate(Axe2_position)
			rotate([90,90,0])
				cylinder
				(
					r=Chanfrain,
					h=4*Wheel1_Diameter,
					center=true
				);
	}

}

//------------------------------------------------------------
// View Whell
//------------------------------------------------------------
/*
	If needed, to see the wheels, so I know if the plate fit or not
*/
module View_Wheel()
{
	translate(Axe1_position)
	#cylinder
	(
		r=Wheel1_Radius,
		h=Plate_Height,
		center=false
	);
	translate(Axe2_position)
	#cylinder
	(
		r=Wheel2_Radius,
		h=Plate_Height,
		center=false
	);
}

//------------------------------------------------------------
// View
//------------------------------------------------------------
/*
	The rotation is here befor export to STL.
	So when you import it on the printer the piece is in good
	position to be printed.
*/
module View_Protection()
{
//	rotate([180,0,0])
	{
		//View_Wheel();
		//color("black")
		Plate_Cache();
	}
}

//==EOF=======================================================