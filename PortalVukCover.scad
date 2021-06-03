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
// *    - Remove errors:                      * //
// *        margin betweew block and z-plane  * //
// *    - Add holes for inserts M3            * //
// *    -                                     * //
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
// *                Variables                 * //
// ******************************************** //


// *                Render Resolution
// *                
//$fn=180;

// *                Margins
// *   
// Margin for objects to be merged or removed
MarginSize=0.010;
//MarginSize=10;

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
LenghtHorizontalPVC     = 240;                      // PVC tube lenghts - NOT PRINTED

// PVC Tube - Positioning 
PVC_dx                  = 21;                       // How far should the tupe be away from x=0 
PVC_dy                  = 26;                       // How far should the tupe be away from y=0 
PVC_dz                  = 64;                       // How far should the tupe be away from z=0 
PVC_Translation         = [PVC_dx,PVC_dy,PVC_dz];   // Total translation of the tube
PVC_Rotation            = [-3,0,20];                // Rotation of tube

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


module FullHorizontalTube()                         // Not merged, removed but meant to be precise so NO margin
{
    // Centre x, left allign y , and zero z 
    translate([0,LenghtHorizontalPVC/2,PVC_OD/2])
    rotate([-90,0,0])
    cylinder(h=LenghtHorizontalPVC,d=PVC_OD,center=true);
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
// *                VUK Case - Final Part
// * 
// Entry Hole
module CaseEntryHole()                         // Part that is removed so use margin
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

        //remove VUKspace
        VUKSpace();
    }
}



// ********************  TO DO **************** //





// Dummy Variables
HightVerticalPVC = 100;                         // Dummy cilinder height/length for removal of space 

// Variables Ball Path
BallPathDiameter = 36;                          // Diameter of space for ball to travel through 



//vuk=arced 1/4 circle segment 
VUKh=26;    // width of arc
VUKr=48;  // VUKy=48;  
            // VUKz=48;
VUKthickness = 10;
blockVUKx = 42;
blockVUKy= 13;//  =PVC_OD -33; // 35+6-33=8
blockVUKz = 54;

RotationOfVUK =[0,0,-20];
TranslationOfVUK =[0,-(PVC_ID/2+blockVUKy),0];

woodblockVUKz =10;



TopedgeVUKx =5;
TopedgeVUKy =35;
TopedgeVUKz =98;







module ArcVUK()
{
    //Move match BlockVUK positive Y
    translate([0,blockVUKy-VUKthickness,0])
    //Raise z to stand on top of BlockVUK
    translate([0,0,blockVUKz])
    
    // Centered correctly
    translate([-VUKh/2,VUKr,0])
    //create Arc
    rotate([180,-90,0])
    rotate_extrude(angle=90,convexity = 10)
    translate([VUKr-VUKthickness,0,0])
    square(size = [VUKthickness, VUKh], center = false);
}



module BlockVUK()
{
    // Centered correctly
    translate([-blockVUKx/2,-17,-MarginTranslate])
    cube([blockVUKx,blockVUKy+17, blockVUKz+MarginSize]);
}


module TopedgeVUK()
{
    // Centered correctly
    translate([-TopedgeVUKx/2,0,-MarginTranslate])
    cube([TopedgeVUKx,TopedgeVUKy, TopedgeVUKz+MarginSize]);
}


module VUK()
{
    //Move entire VUK
    rotate(RotationOfVUK)
    translate(TranslationOfVUK)
    union()
    {
            
        BlockVUK();
        ArcVUK();
        TopedgeVUK();
    }
}


module fullBallPath()
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




module Ballpath1()
{
    translate([0,0,-MarginTranslate])
    cylinder(h=blockVUKz+MarginSize,d=PVC_ID,center=false);
}



module Ballpath2()
{
    rotate(RotationOfVUK)
//    translate(TranslationOfVUK)

    //Raise z to stand on top of BlockVUK
    translate([0,0,blockVUKz])
    
    // Centered correctly
    translate([0,30,0])
    rotate([90,0,-90])
    rotate_extrude(angle=90,convexity = 10)
    translate([30,0,0])
    circle(d=PVC_ID);
}



module Ballpath3()
{

    //Raise z to stand on top of BlockVUK
translate([7,20,blockVUKz+30])
   rotate([-90,90,-20]) 
        
    // Centered correctly
    translate([0,20,8])
    rotate([90,0,-90])
    rotate_extrude(angle=40,convexity = 10)
    translate([20,0,0])
    circle(d=PVC_ID);
}


module BallPath4()
{
        rotate(RotationOfVUK)
    translate([-PVC_ID/2,-PVC_ID/2-1,0-MarginTranslate])
    cube([PVC_ID,PVC_ID/2,blockVUKz+MarginSize]);
}



module BallPath5()
{
        rotate(RotationOfVUK)
    union(){
    translate([-VUKh/2,-PVC_ID/2+10,blockVUKz+15])
    cube([VUKh,PVC_ID/2,22]);      
    
        translate([-VUKh/2,-PVC_ID/2-1,blockVUKz])
    cube([VUKh,12,26]);
    }
}





module VUKSpace()
{
    union()
    {
        VUK();
        fullBallPath();

    }
}




VUKCasing();
color("green")HollowHorizontalTube();
//VUKSpace();







