//============================================================
// Pathé Baby
//	Axe de roue d'embobinage
// Vincent DUBOIS
//============================================================

//------------------------------------------------------------
// Parameters in millimeter - Recommended values see comment
//------------------------------------------------------------
$fn = 100 ;		//
Thikness = 4 ;		// 2 <=> 5
Epsilon = 0.1 ;	// par definition Printer resolution

// Longueur de l'axe
Axe_Height = 19;

// longueur de la vis interne


// Trou pour la vis
Axe_Internal_Hole_Diameter = 2;
Axe_Internal_Hole_Radius = Axe_Internal_Hole_Diameter/2;

// Diamètre externe de l'axe
Axe_External_Diameter = 6;
Axe_External_Radius = Axe_External_Diameter/2;

// Têt de l'axe
Axe_Head_Height = 4;
Axe_Head_Diameter = 12;
Axe_Head_Radius = Axe_Head_Diameter/2;

// Trou de tête pour la vis cf. longueur de la vis...
Axe_Head_Hole_Diameter = 4;
Axe_Head_Hole_Radius = Axe_Head_Hole_Diameter/2;

//------------------------------------------------------------
// Axe de roue
//------------------------------------------------------------
module Axe_Wheel()
{

	difference()
	{
		union()
		{
			cylinder
			(
				r=Axe_External_Radius,
				h=Axe_Height,
				center=true
			);
			translate([0,0,(Axe_Height-Axe_Head_Height)/2])
				cylinder
				(
					r=Axe_Head_Radius,
					h=Axe_Head_Height,
					center=true
				);
		}

		// passage de la vis
		cylinder
		(
			r=Axe_Internal_Hole_Radius+Epsilon,
			h=Axe_Height+Epsilon,
			center=true
		);

		// pour la tête de vis
		translate([0,0,(Axe_Height-Axe_Head_Height)/2])
			cylinder
			(
				r=Axe_Head_Hole_Radius,
				h=Axe_Head_Height+Epsilon,
				center=true
			);
	}
}

//------------------------------------------------------------
// View
//------------------------------------------------------------

Axe_Wheel();


//==EOF=======================================================