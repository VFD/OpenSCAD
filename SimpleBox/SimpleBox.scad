//============================================================
// OpenSCAD Project
//
// VincentD
//============================================================

/*
    Simple box
    Improve yourself to do what you want.
    
    All plate are symetrical.

    Text must be inside the box.
    Except for the Top Box.
    ! Take care of that
    
    If you don't want slot between sides
    ! Comment all the links that refeer them !    

*/

//------------------------------------------------------------
// Parameters
//------------------------------------------------------------
$fn = 150;  // OpenScad

// use inch if needed : 2*inch for exemple
inch = 25.4;

// Define the size of the box
width = 80;
length = 80;
height = 80;

// Thikness of the material used !!!
Thikness = 5 ;

// Size of the 1st part of the slot for mounting the box !!!
// the size of the other part depand of the length used
// Take care with the min value of
// width, length or height and Thikness!
E = 20;

// Text to help for assembly and orientation
ft = "Stencil";
//ft = "Courrier";


//------------------------------------------------------------
// For symetrical disposition to match everywhere on the box
// Slots are centred
//------------------------------------------------------------
// width calculation
x = width;
// How many ?
cx = (E <= x/2 ? floor((x/2)/E) : ( E>=x-2*Thikness ? 0 : 1 ) );
nx = cx+1;
Ex = ( cx!=0 ? (x-(cx*E))/nx : 0 );
echo(str("\n\tThe width is: ", x, "mm.",
         "\n\tThere is ", cx, " slots possible.",
         "\n\tThe size of the 1st part is: ", E, "mm.",
         "\n\tThe size of the 2nd part is: ", Ex, "mm.\n"
        ));

// length calculation
y = length;
// How many ?
cy = (E <= y/2 ? floor((y/2)/E) : ( E>=y-2*Thikness ? 0 : 1 ) );
ny = cy+1;
Ey = ( cy!=0 ? (y-(cy*E))/ny : 0 );
echo(str("\n\tThe length of the box is: ", y, "mm.",
         "\n\tThere is ", cy, " slots possible.",
         "\n\tThe size of the 1st part is: ", E, "mm.",
         "\n\tThe size of the 2nd part is: ", Ey, "mm.\n"
        ));

// height calculation
z = height;
// How many ?
cz = (E <= z/2 ? floor((z/2)/E) : ( E>=z-2*Thikness ? 0 : 1 ) );
nz = cz+1;
Ez = ( cz!=0 ? (z-(cz*E))/nz : 0 );
echo(str("\n\tThe height of the box is: ", z, "mm.",
         "\n\tThere is ", cz, " slots possible.",
         "\n\tThe size of the 1st part is: ", E, "mm.",
         "\n\tThe size of the 2nd part is: ", Ez, "mm.\n"
        ));


//------------------------------------------------------------
// Start
// Choose the view by comment and uncomment
//------------------------------------------------------------

// Need to know if it is possible or not to build the box
if ( Ex!=0 && Ey!=0 && Ez!=0 && E>Thikness)
{
    echo("\n\tBuilding the box is Possible.\n");
    //FlatView();
    MountView();
}
else echo("\n\tBuilding the box is NOT Possible.\n");


//------------------------------------------------------------
// Linear extrude and move to mount the box
// Transparency to see inside
//------------------------------------------------------------
module MountView()
{
    // center the box
    translate([-x/2,-y/2,-z/2])
    {
        // Bottom
        color("red", 0.5)
            linear_extrude(height=Thikness)
                BoxBottom();

        // Top
        color("red", 0.5)
            translate([0,0,z-Thikness])
                linear_extrude(height=Thikness)
                    BoxTop();

        // Back
        color("grey", 0.5)
            translate([0,0,z])
                rotate([0,90,0])
                    linear_extrude(height=Thikness)
                        BoxBack();

        // Front
        color("grey", 0.5)
            translate([x,0,0])
                rotate([0,-90,0])
                    linear_extrude(height=Thikness)
                        BoxFront();

        // Left
        color("yellow", 0.5)
            translate([x,0,0])
                rotate([90,0,180])
                    linear_extrude(height=Thikness)
                        BoxLeft();

        // Right
        color("yellow", 0.5)
            translate([0,y,0])
                rotate([90,0,0])
                    linear_extrude(height=Thikness)
                        BoxRight();
    }
}

//------------------------------------------------------------
// Flat View of the box
// Comment as you wish to generate DXF or SVG files
//------------------------------------------------------------
module FlatView()
{
    // Bottom
    BoxBottom();

    // Top
    translate([-z-x-2,0,0])
        BoxTop();

    // Back
    translate([-z-1,0,0])
        BoxBack();

    // Front
    translate([x+1,0,0])
        BoxFront();

    // Left
    translate([x,-1,0]) rotate([0,0,180])
        BoxLeft();

    // Right
    translate([0,y+1,0])
        BoxRight();
}

//------------------------------------------------------------
// Top, Bottom : use [x,y]
//------------------------------------------------------------
module BoxTop()
{
    // modify as you wish
    difference()
    {
        BoxTB();
        // Text inside for orientation
        translate([x/2,y/2,0]) rotate([0,0,90])
        text("Top", size=5, valign="center", halign="center", font=ft);
    }
}

module BoxBottom()
{
    // modify as you wish
    difference()
    {
        BoxTB();
        // Text inside for orientation
        translate([x/2,y/2,0]) rotate([0,0,90])
        text("Bottom", size=5, valign="center", halign="center", font=ft);
    }
}

// common to the 2 parts above
// use x and y variables
module BoxTB()
{
	difference()
    {
        square([x,y]);
        //  (y)
        for ( i = [Ey : Ey+E : y-E] )
        {
            // Top Bottom - Back link
            translate([0,i,0])
            square([Thikness, E]);
            
            // Top Bottom - Front Link
            translate([x-Thikness,i,0])
            square([Thikness, E]);
        }
        //  (x)
        for ( i = [Ex : Ex+E : x-E] )
        {
            // Top Bottom - Left Link
            translate([i,0,0])
            square([E, Thikness]);
            
            // Top Bottom - Right Link
            translate([i,y-Thikness,0])
            square([E, Thikness]);
        }
    }
}

//------------------------------------------------------------
// Back, Front : use [z,y]
//------------------------------------------------------------
module BoxBack()
{
    // modify as you wish
    difference()
    {
        // Correct orientation
        translate([z,0,0]) rotate([180,0,180])
        BoxBF();
        // Text inside for orientation
        translate([z/2,y/2,0]) rotate([0,0,90])
        text("Back", size=5, valign="center", halign="center", font=ft);

    }
}

module BoxFront()
{
    // modify as you wish
    difference()
    {
        BoxBF();
        // Text inside for orientation
        translate([z/2,y/2,0]) rotate([0,0,-90])
        text("Front", size=5, valign="center", halign="center", font=ft);

    }
}

// common Front and Back parts
// use z and y variables
module BoxBF()
{
	difference()
    {
        square([z,y]);
        //  (y)
        // Back Front - Bottom Link
        for ( i = [0 : Ey+E : y] )
        {
            translate([0,i,0])
            square([Thikness, Ey]);
        }
            
        // Back Front - Top Link
        for ( i = [0 : Ey+E : y] )
        {
            translate([z-Thikness,i,0])
            square([Thikness, Ey]);
        }
        // height (z)
        // Back Front - Left Link
        for ( i = [0 : Ez+E : z] )
        {
            translate([i,0,0])
            square([Ez, Thikness]);
        }
        
        // Back Front - Right Link
        for ( i = [0 : Ez+E : z] )
        {
            translate([i,y-Thikness,0])
            square([Ez, Thikness]);
        }
    }
}

//------------------------------------------------------------
// Left, Right : use [x,z]
//------------------------------------------------------------
module BoxLeft()
{
    // modify as you wish
    difference()
    {
        // Correct position of BoxLR()
        translate([x,0,0]) rotate([180,0,180])
        BoxLR();
        // Text inside for orientation
        translate([x/2,z/2,0])
        text("Left", size=5, valign="center", halign="center", font=ft);

    }
}

module BoxRight()
{
    // modify as you wish
    difference()
    {
        BoxLR();
        // Text inside for orientation
        translate([x/2,z/2,0])
        text("Right", size=5, valign="center", halign="center", font=ft);

    }
}

// common Left and Right parts
// use x and z variables
module BoxLR()
{
	difference()
    {
        square([x,z]);

        // Left Right - Back Link
        for ( i = [Ez : Ez+E : z-E] )
        {
            translate([0,i,0])
            square([Thikness, E]);
        }

        // Left Right - Front Link            
        for ( i = [Ez : Ez+E : z-E] )
        {
            translate([x-Thikness,i,0])
            square([Thikness, E]);
        }

        // Left Right - Bottom Link
        for ( i = [0 : Ex+E : x] )
        {
            translate([i,0,0])
            square([Ex, Thikness]);
        }
            
        // Left Right - Top Link
        for ( i = [0 : Ex+E : x] )
        {
            translate([i,z-Thikness,0])
            square([Ex, Thikness]);
        }
    }
}

//==EOF=======================================================