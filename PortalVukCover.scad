// ******************************************** //
// *                                          * //
// *  Cover for a VUK on home-brew pinball    * //
// *                                          * //
// *  Dorus van der Linden                    * //
// *  Willem Godlieb                          * //
// *                                          * //
// *  Version 0.9                             * //
// *                                          * //
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
// *                Insert Module             * //
// ******************************************** //

module M3InsertHole(Insert_D=4, Insert_H=6.7)
{
    // Centre x & y , and zero z 
    translate([0,0,Insert_H/2]) 
    cylinder(h=Insert_H, d=Insert_D,center = true);
}

module M3InsertTestBlock()
{
    difference()
    {
        translate([0,0,10]) cube([30,30,20], center = true);
        translate([ 8, 8,-0.01]) M3InsertHole();
        translate([-8, 8,-0.01]) M3InsertHole();
        translate([ 8,-8,-0.01]) M3InsertHole();
        translate([-8,-8,-0.01]) M3InsertHole();
    }
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
VUK_Width               = 26 +2;                       // Width of arc of VUK
VUKr                    = 48;                       // High of arc of VUK 
VUKthickness            = 10 +2;                       // Thickness of extruded arc
blockVUKx               = 42 +2;                       // Size of hole for lower part of VUK
blockVUKy               = 30 +2;                       // Size of hole for lower part of VUK
blockVUKz               = 54 +2 ;                   // Size of hole for lower part of VUK
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
    translate([0,0,blockVUKz-2])
    
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
    translate([7,20,blockVUKz-2+30])                  // Manual fitting
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

module CaseEntryHole2 ()
{
    //hole arc
    rotate(Case_Rotation)
    translate([EntryHole_x/2,0,12])
    rotate([0,90,0])
    cylinder(h=EntryHole_x,r1=17, r2=34,center=true);  
}


module CaseExitHole()                               // Not merged, removed but meant to be precise so NO margin
{
    // remove outer diameter PVC exit hole
    rotate(PVC_Rotation)        
    translate(PVC_Translation)
    FullHorizontalTube();
}

module LEDHole()
{
    union()
    {
        rotate(Case_Rotation)
        translate([15,-28,84])
        sphere(d=4);
        
        rotate(Case_Rotation)
        translate([30,-28,44])
        rotate([0,90,0])
        cylinder(h=30, d=4, center=true);
        
        rotate(Case_Rotation)
        translate([15,-28,34])
        cylinder(h=100, d=4, center=true);

        rotate(Case_Rotation)
        translate([30,-28,84])
        rotate([0,90,0])
        cylinder(h=30, d=4, center=true);


    }
}



    module bar(w=80,dw=15,l=210,h1=0,h2=50){
        polyhedron(
            points=[[0,0,0], [w,0,0], [w-dw,l,h1], [dw,l,h1], [0,0,h2 ], [w,0,h2], [w-dw,l,h2], [dw,l,h2] ],
            faces=[
                [0,1,2,3],  // bottom
                [4,5,1,0],  // front
                [7,6,5,4],  // top
                [5,6,2,1],  // right
                [6,7,3,2],  // back
                [7,4,0,3]] // left
        );
    }

module WindowHole()
{
    union()
    {
        rotate(Case_Rotation)
        translate([32,-34,70])  // y = 76/2  = 38 -2 edge = 36
        cube([10,31,40]); // width = y =76/2 - 2*2 = 38-4 = 34
        //translate([10,0.5,-5])rotate([0,0,90])bar(w=34,dw=0,h1=5,h2=48,l=10);
        
//Centers
        rotate(Case_Rotation)
        translate([40,0,60])  // x= (70/2, case depth/2) +6 (case translation) - 1 depth)  z = half extra 10 height
        cube([2,1,Case_z+10]);

        rotate(Case_Rotation)
        rotate([0,0,90])
        translate([37,-6,-70])  // x= (76/2, case depth/2)  - 1 depth)  z = half extra 10 height  y = -6 for translation
        cube([2,1,Case_z+10]);

        rotate(Case_Rotation)
        rotate([0,0,-90])
        translate([37,+6,-5])  // x= (76/2, case depth/2)  - 1 depth)  z = half extra 10 height  y = + 6 for translation
        cube([2,1,Case_z+10]);
        
        rotate(Case_Rotation)
        rotate([0,0,180])
        translate([28,0,-5])  // x= (70/2, case depth/2) -6 (case translation) - 1 depth)  z = half extra 10 height
        cube([2,1,Case_z+10]);
        
 
//edges

        rotate(Case_Rotation)
        translate([40,37,-5])  // x= (70/2, case depth/2) +6 (case translation) - 1 depth)  z = half extra 10 height, y=76/2 -1 = 37
        cube([2,2,Case_z+10]);
        
        
        rotate(Case_Rotation)
        translate([40,-39,-5])  // x= (70/2, case depth/2) +6 (case translation) - 1 depth)  z = half extra 10 height, y=-76/2 -1 = -39
        cube([2,2,Case_z+10]); 


        rotate(Case_Rotation)
        rotate([0,0,-180])
        translate([28,37,-5])  // x= (70/2, case depth/2) -6 (case translation) - 1 depth)  z = half extra 10 height, y=76/2 -1 = 37
        cube([2,2,Case_z+10]);
        
        rotate(Case_Rotation)
        rotate([0,0,-180])
        translate([28,-39,-5])  // x= (70/2, case depth/2) -6 (case translation) - 1 depth)  z = half extra 10 height, y=-76/2 -1 = -39
        cube([2,2,Case_z+10]); 



//horizontal
    //front
        rotate(Case_Rotation)
        rotate([90,0,0])
        translate([41,60,-55])  // x= (70/2, case depth/2) +6 (case translation) - 1 depth)  z = half extra 10 height
        scale([2,1,1])cylinder(h=Case_z+10,d=1,$fn=45);
        
    
        
    // right (exit)
        rotate(Case_Rotation)
        rotate([90,0,90])
        translate([38,60,-55])  // x= (70/2, case depth/2) +6 (case translation) - 1 depth)  z = half extra 10 height
        scale([2,1,1])cylinder(h=Case_z+10,d=1,$fn=45);
        

    //Left
        rotate(Case_Rotation)
        rotate([90,0,-90])
        translate([38,60,-55])  // x= (70/2, case depth/2) +6 (case translation) - 1 depth)  z = half extra 10 height
        scale([2,1,1])cylinder(h=Case_z+10,d=1,$fn=45);
        

    //back
        rotate(Case_Rotation)
        rotate([90,0,180])
        translate([29,60,-55])  // x= (70/2, case depth/2) +6 (case translation) - 1 depth)  z = half extra 10 height
        scale([2,1,1])cylinder(h=Case_z+10,d=1,$fn=45);
        
//bottom edge
        rotate(Case_Rotation)
        rotate([90,0,0])
        translate([40,-1,-55])  // x= (70/2, case depth/2) +6 (case translation) - 1 depth)  z = half extra 10 height
        cube([2,2,Case_z+10]);     

        rotate(Case_Rotation)
        rotate([90,0,90])
        translate([37,-1,-55])  // x= (70/2, case depth/2) +6 (case translation) - 1 depth)  z = half extra 10 height
        cube([2,2,Case_z+10]);   

        rotate(Case_Rotation)
        rotate([90,0,-90])
        translate([37,-1,-55])  // x= (70/2, case depth/2) +6 (case translation) - 1 depth)  z = half extra 10 height
        cube([2,2,Case_z+10]);   


        rotate(Case_Rotation)
        rotate([90,0,180])
        translate([28,-1,-55])  // x= (70/2, case depth/2) +6 (case translation) - 1 depth)  z = half extra 10 height
        cube([2,2,Case_z+10]);   



    }
        

}



// VUK Case Final Part                              // Final Part so NO margin
module VUKCasing()
{
    difference()
    {
        VUKCasingCube();
        
        // remove entry archway
        CaseEntryHole2();
        
        // remove exit hole and PVC tube connection
        CaseExitHole();

        // remove VUKandBallPath
        VUKandBallPath();
        
        // remove LED holes
        LEDHole();
        
        // remove textures
        WindowHole();
        
        // remove InsertHoles
        rotate(Case_Rotation)
        translate(Case_Translation)
        union()
        {
            translate([16,32,-MarginTranslate])M3InsertHole();
            translate([-26,28,-MarginTranslate])M3InsertHole();
            translate([16,-32,-MarginTranslate])M3InsertHole();
        }
    }
}


module test_print() // small intersection with the full object, containing overhang, lines and led hole. (Willem)
    {
    intersection()
        {
        VUKCasing();
        translate([35,-40,58])rotate(Case_Rotation)cube([20,50,30]);
        }
    }

test_print();


//
//
// *                Render
// Render Final part
//VUKCasing();

// Optional Renders
//HollowHorizontalTube();
//color("green")
//M3InsertTestBlock();
//VUK();
//CaseEntr2Hole2 ();
//LEDHole();
//WindowHole();