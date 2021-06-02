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
//$fn=180;
Overlap=0.01;


// *                VUK Case Cube
// *                
// VUK Case Cube - Size
Case_x=70;
Case_y=70;
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
PVC_dx                  = 10;                       // How far should the tupe be away from x=0 
PVC_dy                  = 31;                       // How far should the tupe be away from y=0 
PVC_dz                  = 63;                       // How far should the tupe be away from z=0 
PVC_Translation         = [PVC_dx,PVC_dy,PVC_dz];   // Total translation of the tube
PVC_Rotation            = [-3,0,20];                // Rotation of tube



// ******************************************** //
// *                Modules                   * //
// ******************************************** //


// *                VUK Case Cube
// * 
// VUK Case Full Cube
module VUKCasingCube()
{
    rotate(Case_Rotation)
    translate(Case_Translation)
    
    // Centre x, left allign y , and zero z 
    translate([-(Case_x/2),-(Case_y/2),0])
    cube([Case_x,Case_y,Case_z]);
}
//

// *                PVC tube
// *
// * Modules PVC tube on exit
module hollowhorizontaltube()
{

    difference()
    {
        translate(PVC_Translation) rotate(PVC_Rotation)fullhorizontaltube();
        translate(PVC_Translation) rotate(PVC_Rotation)innerhorizontaltube();
        VUKCasingCube();
    }
}


module fullhorizontaltube()
{
    // Centre x, left allign y , and zero z 
    translate([0,LenghtHorizontalPVC/2,PVC_OD/2])
    rotate([-90,0,0])
    translate([0,0,0])
    cylinder(h=LenghtHorizontalPVC,d=PVC_OD,center=true);
}


module innerhorizontaltube()
{
    // Centre x, left allign y , and zero z 
    translate([0,LenghtHorizontalPVC/2 ,PVC_OD/2])
    rotate([-90,0,0])
    translate([0,0,0])
    cylinder(h=LenghtHorizontalPVC+1,d=PVC_ID,center=true);
}
//






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


module ArcVUK2()
{
    VUKh2 = VUKh+2;
    //Move match BlockVUK positive Y
    translate([0,blockVUKy-VUKthickness,0])
    //Raise z to stand on top of BlockVUK
    translate([0,0,blockVUKz])
    
    // Centered correctly
    translate([-VUKh2/2,VUKr,0])
    //create Arc
    rotate([180,-90,0])
    rotate_extrude(angle=90,convexity = 10)
    translate([VUKr-VUKthickness,0,0])
    square(size = [VUKthickness, VUKh2], center = false);
}

module BlockVUK()
{
    // Centered correctly
    translate([-blockVUKx/2,0,0])
    cube([blockVUKx,blockVUKy, blockVUKz]);
}




module woodblockVUK()
{
    // Centered correctly
    translate([-blockVUKx/2,-15,blockVUKz-woodblockVUKz])
    cube([blockVUKx,15, woodblockVUKz]);
}

module UnderwoodblockVUK()
{
    // Centered correctly
    translate([-blockVUKx/2,-16,0])
    cube([blockVUKx,17, blockVUKz]);
}




module TopedgeVUK()
{
    // Centered correctly
    translate([-TopedgeVUKx/2,0,0])
    cube([TopedgeVUKx,TopedgeVUKy, TopedgeVUKz]);
}


module VUK()
{
    //Move entire VUK
    rotate(RotationOfVUK)
    translate(TranslationOfVUK)
    union()
    {
            
        ArcVUK();
        BlockVUK();
        woodblockVUK();
        TopedgeVUK();
    }
}


module VUK2()
{
    //Move entire VUK
    rotate(RotationOfVUK)
    translate(TranslationOfVUK)
    union()
    {
            
        ArcVUK2();
        BlockVUK();
        woodblockVUK();
    }
}





module Ballpath1()
{
    cylinder(h=blockVUKz,d=PVC_ID,center=false);
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
translate([8,20,blockVUKz+30])
   rotate([-90,90,-20]) 
        
    // Centered correctly
    translate([0,30,0])
    rotate([90,0,-90])
    rotate_extrude(angle=40,convexity = 10)
    translate([30,0,0])
    circle(d=PVC_ID);
}


module BallPath4()
{
        rotate(RotationOfVUK)
    translate([-PVC_ID/2,-PVC_ID/2-1,0])
    cube([PVC_ID,PVC_ID/2,blockVUKz]);
}



module BallPath5()
{
        rotate(RotationOfVUK)
    union(){
    translate([-VUKh/2,-PVC_ID/2+10,blockVUKz+15])
    cube([VUKh,PVC_ID/2,22]);      
    
        translate([-VUKh/2,-PVC_ID/2,blockVUKz])
    cube([VUKh,10,26]);
    }
}

module fullBallPath()
{
    difference()
    { 
        union()
        {
            Ballpath1();
            Ballpath2();
            Ballpath3();
            BallPath4();
            BallPath5();
        }
        
      //  VUK2();
    }
    
}

module VUKspaceUnderneath()
{
    rotate(RotationOfVUK)
    translate(TranslationOfVUK)
    UnderwoodblockVUK();  

}

module VUKSpace()
{
    union()
    {
        VUK();
        fullBallPath();
        VUKspaceUnderneath();
    }
}











module VUKCasing()
{
    difference()
    {
        VUKCasingCube();
        //remove VUKspace
        VUKSpace();
        
        //remove entry archway
        //hole arc
        rotate([0,0,10])
        translate([HightVerticalPVC/2,0,30])
        rotate([0,90,0])
        cylinder(h=HightVerticalPVC,d=PVC_ID,center=true);
        //hole base
       rotate([0,0,10])
        translate([20,0,11])
        cube([45,PVC_ID,41], center=true);

    //remove outer diameter exit hole
     translate([22,0,HightVerticalPVC-37])rotate([0,0,20]) 
    difference()
    {
        fullhorizontaltube();

        rotate([0,0,-10])
    translate([-(Case_x/2)+6,-(Case_y/2)+0,0])
    cube([Case_x,Case_y,Case_z]);
    }
    }

}





//VUKSpace();
//VUKCasingCube();
//
VUKCasing();
//color("green")hollowhorizontaltube();
//
//fullBallPath();



//minkowski()
//    {
//    union()
//        {
//        cube(10);
//        translate([0,0,12])cube(10);
//        }
//    sphere(5);
//    }


//hull(){
//    cube(10, center=true);
//    translate([6,7,8]) 
//    sphere(4);
//}