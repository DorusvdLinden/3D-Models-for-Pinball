// ******************************************** //
// *                                          * //
// *  Cover for a VUK on home-brew pinball    * //
// *                                          * //
// *  Dorus van der Linden                    * //
// *  Willem Godlieb                          * //
// *                                          * //
// *  Version 0.2                             * //
// *                                          * //
// *  To Do:                                  * //
// *    - Add holes for inserts M3            * //
// *    - Create ball path variables          * //
// *    -                                     * //
// *                                          * //
// ******************************************** //



// ******************************************** //
// *                                          * //
// *                Instructions              * //
// *                                          * //
// *  Definition of origin                    * //
// *    Centre x, left allign y , and zero z  * //
// *    Then extra translations as needed     * //
// *                                          * //
// *  All angles are counter clockwise        * //
// *    as seen from outside of axis          * //
// *                                          * //
// *  Create 3 elements:                      * //
// *  A - VUK Case Cube at z-angle 10         * //
// *  B - PVC Tube at z-angle 20, x-angle -3  * //
// *  C - Ballpath & VUK at z-angle -20       * //
// *                                          * //
// *  Final product is difference A-B-C       * //
// *                                          * //
// *        playfield is at y-angle -5        * //
// *                                          * //
// *                                          * //
// ******************************************** //


// ******************************************** //
// *                Insert test part          * //
// ******************************************** //

module M3InsertHole(Insert_D=4, Insert_H=6.7)
{
    // Centre x & y , and zero z 
    translate([0,0,Insert_H/2]) 
    cylinder(h=Insert_H, d=Insert_D,center = true);
}




// ******************************************** //
// *                Variables                 * //
// ******************************************** //


// *                Render Resolution
// *                
$fn = $preview ? 24 : 180;


// *                Margins
// *   
// Margin for objects to be merged or removed
MarginSize=0.010;
MarginTranslate=MarginSize/2;


// *                VUK Case Cube
// *                
// VUK Case Cube - Size
Case_x=70;
Case_y=76;
Case_z=120;

// VUK Case Cube - Positioning
Case_Translation        = [6,0,0];                  // Translation of VUK case
Case_Rotation           = [0,0,10];                 // Rotation of VUK case
Case_RotationReverse    = [0,0,-10];                // Rotation of VUK case


// *                PVC tube
// *
// PVC Tube - Size
PVC_ID                  = 36;                       // PVC tube inner diameter
PVC_WT                  = 3;                        // PVC tube wall thickness
PVC_OD                  = PVC_ID + 2* PVC_WT;       // PVC tube outer diameter = 42
PVC_Margin              = 1;                        // PVC OD margin
LenghtHorizontalPVC     = 240;                      // PVC tube lenghts - NOT PRINTED

// PVC Tube - Positioning 
PVC_dx                  = 21;                       // How far should the tupe be away from x=0 
PVC_dy                  = 26;                       // How far should the tupe be away from y=0 
PVC_dz                  = 64;                       // How far should the tupe be away from z=0 
PVC_Translation         = [PVC_dx,PVC_dy,PVC_dz];   // Total translation of the tube
PVC_Rotation            = [-3,0,20];                // Rotation of tube

// *                VUK & Ball Path 
// * 
// VUK
VUK_Width               = 26;                       // Width of arc of VUK
VUKr                    = 48;                       // High of arc of VUK 
VUKthickness            = 10;                       // Thickness of extruded arc
blockVUKx               = 42;                       // Size of hole for lower part of VUK
blockVUKy               = 30;                       // Size of hole for lower part of VUK
blockVUKz               = 54;                       // Size of hole for lower part of VUK
TopedgeVUKx             = 5;                        // Size of hole for top edge part of VUK
TopedgeVUKy             = 35;                       // Size of hole for top edge part of VUK
TopedgeVUKz             = 98;                       // Size of hole for top edge part of VUK
TopEdgeVuk_Translate    = [0,17,0];                 // Measured translation of VUK top edge from block
RotationOfVUK           = [0,0,-20];                // Rotation of VUK
VUKTranslation          = [0,-48,0];                // Measured translation of VUK from center

// Ball Path
// To be created from numbers in modules            // To Be created

// *                VUK Case - Final Part
// * 
// Case Entry Hole
EntryHole_x=45;                                     // x of cube and lenght of cylinder used to create entry hole
EntryHole_y=PVC_ID;                                 // y of cube and diameter of cylinder used to create entry hole
EntryHole_z=30;                                     // Height of cube and center of cylinder used to create entry hole




// ******************************************** //
// *                Modules                   * //
// ******************************************** //
//
//
// *                VUK Case Cube
// * 
// VUK Case Full Cube                               // Not merged or part that is removed so NO margin
module VUKCasingCube(Reduced_y=0)
{
    rotate(Case_Rotation)
    translate(Case_Translation)
    
    // Centre x, left allign y , and zero z 
    translate([-(Case_x/2),-(Case_y/2),0])
    cube([Case_x,Case_y-Reduced_y,Case_z]);
}
//
//
// *                PVC tube
// *
// * Modules PVC tube on exit
module HollowHorizontalTube()                       // Not merged or part that is removed so NO margin
{
    rotate(PVC_Rotation) translate(PVC_Translation) 
    difference()
    {
        FullHorizontalTube();
        InnerHorizontalTube();
    }
}


module FullHorizontalTube()                         // Not merged, removed and small margin to allow fit of PVC
{
    // Centre x, left allign y , and zero z 
    translate([0,LenghtHorizontalPVC/2,PVC_OD/2])
    rotate([-90,0,0])
    cylinder(h=LenghtHorizontalPVC,d=PVC_OD+PVC_Margin,center=true);
}


module InnerHorizontalTube()                        // Part that is removed so use margin
{
    // Centre x, left allign y , and zero z 
    translate([0, LenghtHorizontalPVC/2 , PVC_OD/2])
    rotate([-90,0,0])
    cylinder(h=(LenghtHorizontalPVC + MarginSize), d=PVC_ID, center=true);
}
//
//
// *                VUK & Ball Path
// * 
// Cube part of VUK
module BlockVUK()                                   // Part that is removed so use margin
{
    // Centered correctly
    translate([-blockVUKx/2,0,-MarginTranslate])
    cube([blockVUKx,blockVUKy, blockVUKz+MarginSize]);
}

// Arc part of VUK
module ArcVUK()                                     // Overlap is in lower parts of VUK so NO margin
{
    // Centered correctly
    translate([-VUK_Width/2,VUKr,0])
    //create Arc
    rotate([180,-90,0])
    rotate_extrude(angle=90,convexity = 10)
    translate([VUKr-VUKthickness,0,0])
    square(size = [VUKthickness, VUK_Width], center = false);
}

//TopEdge part of VUK
module TopedgeVUK()                                 // Part that is removed so use margin
{
    // Centered correctly
    translate([-TopedgeVUKx/2,0,-MarginTranslate])
    cube([TopedgeVUKx,TopedgeVUKy, TopedgeVUKz+MarginSize]);
}


// Combined VUK
module VUK()                                        // Merged part with margins in it so NO extra margin
{
    //Move entire VUK
    rotate(RotationOfVUK)
    translate(VUKTranslation)                            // measured
    
    union()
    {
        BlockVUK();
        
        translate([0,blockVUKy-VUKthickness,blockVUKz])     // Move match BlockVUK (block y - arc thickness) and to stand on top of BlockVUK 
        ArcVUK();
        
        translate(TopEdgeVuk_Translate) 
        TopedgeVUK();             
    }
}

//
// Ball Path Modules
module Ballpath1()                                  // Part that is removed so use margin
{
    translate([0,0,-MarginTranslate])
    cylinder(h=blockVUKz+MarginSize,d=PVC_ID,center=false);
}



module Ballpath2()                                  // Overlap is in lower parts of VUK so NO margin
{
    rotate(RotationOfVUK)

    //Raise z to stand on top of Ballpath1
    translate([0,0,blockVUKz])
    
    // Centered correctly
    translate([0,30,0])
    rotate([90,0,-90])
    rotate_extrude(angle=90,convexity = 10)
    translate([30,0,0])
    circle(d=PVC_ID);
}



module Ballpath3()                                  // Overlap in measurements so NO extra margin
{

    //Raise z to fit with overlap to Ballpath2
    translate([7,20,blockVUKz+30])                  // Manual fitting
    rotate([-90,90,-20]) 
        
    // Centered correctly
    translate([0,20,8])
    rotate([90,0,-90])
    rotate_extrude(angle=40,convexity = 10)
    translate([20,0,0])
    circle(d=PVC_ID);
}


module BallPath4()                                  // Part that is removed so use margin
{
    rotate(RotationOfVUK)
    translate([-PVC_ID/2,-PVC_ID/2-1,0-MarginTranslate])
    cube([PVC_ID,PVC_ID/2,blockVUKz+MarginSize]);
}



module BallPath5()                                  // Overlap in measurements so NO extra margin
{
    rotate(RotationOfVUK)
    union()
    {
        translate([-VUK_Width/2,-8,blockVUKz+15])   // Manual fitting
        cube([VUK_Width,18,22]);                    // Manual fitting    
    
        translate([-VUK_Width/2,-19,blockVUKz])     // Manual fitting
        cube([VUK_Width,12,26]);                    // Manual fitting
    }
}








module CombinedBallPath()                           // Merged part with margins in it so NO extra margin
{
    union()
    {
        Ballpath1();
        Ballpath2();
        Ballpath3();
        BallPath4();
        BallPath5();
    }
}


//
// Conbined VUK and Ball Path
module VUKandBallPath()                             // Merged part with margins in it so NO extra margin
{
    union()
    {
        VUK();
        CombinedBallPath();
    }
}


//
//
// *                VUK Case - Final Part
// * 
// Entry Hole
module CaseEntryHole()                              // Part that is removed so use margin
{
    //hole arc
    rotate(Case_Rotation)
    translate([EntryHole_x/2,0,EntryHole_z])
    rotate([0,90,0])
    cylinder(h=EntryHole_x,d=EntryHole_y,center=true);
    //hole base
    rotate(Case_Rotation)
    translate([EntryHole_x/2 ,0,EntryHole_z/2- MarginTranslate])
    cube([EntryHole_x,EntryHole_y,EntryHole_z+MarginSize], center=true);
}

module CaseExitHole()                               // Not merged, removed but meant to be precise so NO margin
{
    // remove outer diameter PVC exit hole
    rotate(PVC_Rotation)        
    translate(PVC_Translation)
    FullHorizontalTube();
}

// VUK Case Final Part                              // Final Part so NO margin
module VUKCasing()
{
    difference()
    {
        VUKCasingCube();
        
        // remove entry archway
        CaseEntryHole();
        
        // remove exit hole and PVC tube connection
        CaseExitHole();

        // ********************  TO DO **************** /

        //remove VUKandBallPath
        VUKandBallPath();
    }
}



//
//
// *                Render
// Render Final part
//VUKCasing();

// Optional Renders
//color("green")HollowHorizontalTube();
M3InsertHole();
