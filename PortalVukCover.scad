InternalDiameterPVC = 35;
WallThicknessPVC = 3;
ExternalDiameterPVC = InternalDiameterPVC + 2* WallThicknessPVC;

LenghtHorizontalPVC = 240;


//Origin = centre x, left allign y , and zero z
//Then extra translations as needed

module hollowhorizontaltube()
{
  difference()
    {
        fullhorizontaltube();
        innerhorizontaltube();
    }
}

module fullhorizontaltube()
{
    translate([0,LenghtHorizontalPVC/2,ExternalDiameterPVC/2])
    rotate([90,0,0])
    cylinder(h=LenghtHorizontalPVC,d=ExternalDiameterPVC,center=true);
}


module innerhorizontaltube()
{
    translate([0,LenghtHorizontalPVC/2,ExternalDiameterPVC/2])
    rotate([90,0,0])
    cylinder(h=LenghtHorizontalPVC+1,d=InternalDiameterPVC,center=true);
}



//
//vuk=arced 1/4 circle segment 
VUKh=26;    // width of arc
VUKr=48;  // VUKy=48;  
            // VUKz=48;
VUKthickness = 10;
blockVUKx = 42;
blockVUKy= 13;//  =ExternalDiameterPVC -33; // 35+6-33=8
blockVUKz = 54;

RotationOfVUK =[0,0,-20];
TranslationOfVUK =[0,-(InternalDiameterPVC/2+blockVUKy),0];

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

woodblockVUKz =10;


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

TopedgeVUKx =5;
TopedgeVUKy =35;
TopedgeVUKz =98;


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


//
//rotate([-2,0,20])
//    translate([InternalDiameterPVC/2,InternalDiameterPVC/2,blockVUKz+VUKr-InternalDiameterPVC])
//    hollowhorizontaltube();


module Ballpath1()
{
    cylinder(h=blockVUKz,d=InternalDiameterPVC,center=false);
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
    circle(d=InternalDiameterPVC);
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
    circle(d=InternalDiameterPVC);
}


module BallPath4()
{
        rotate(RotationOfVUK)
    translate([-InternalDiameterPVC/2,-InternalDiameterPVC/2-1,0])
    cube([InternalDiameterPVC,InternalDiameterPVC/2,blockVUKz]);
}



module BallPath5()
{
        rotate(RotationOfVUK)
    union(){
    translate([-VUKh/2,-InternalDiameterPVC/2+10,blockVUKz+15])
    cube([VUKh,InternalDiameterPVC/2,22]);      
    
        translate([-VUKh/2,-InternalDiameterPVC/2,blockVUKz])
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

    Casingx=70;
    Casingy=70;
    Casingz=120;


module VUKCasingCube()
{

    
    rotate([0,0,10])
    translate([-(Casingx/2)+6,-(Casingy/2),0])
    cube([Casingx,Casingy,Casingz]);
}


HightVerticalPVC = 100;

PullBackHorizontalPVC = InternalDiameterPVC/2-49;

module hollowhorizontaltube()
{
    translate([23,0,HightVerticalPVC-37])rotate([0,0,20]) 
    difference()
    {
        fullhorizontaltube();
        innerhorizontaltube();
        rotate([0,0,-10])
    translate([-(Casingx/2)+6,-(Casingy/2),0])
    cube([Casingx,Casingy,Casingz]);
    }
}

module fullhorizontaltube()
{
    translate([0,LenghtHorizontalPVC/2 - PullBackHorizontalPVC,ExternalDiameterPVC/2])
    rotate([90,0,0])
    translate([0,0,0])
    cylinder(h=LenghtHorizontalPVC,d=ExternalDiameterPVC,center=true);
}


module innerhorizontaltube()
{
    translate([0,LenghtHorizontalPVC/2 - PullBackHorizontalPVC,ExternalDiameterPVC/2])
    rotate([90,0,0])
    translate([0,0,0])
    cylinder(h=LenghtHorizontalPVC+1,d=InternalDiameterPVC,center=true);
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
        cylinder(h=HightVerticalPVC,d=InternalDiameterPVC,center=true);
        //hole base
       rotate([0,0,10])
        translate([20,0,11])
        cube([45,InternalDiameterPVC,41], center=true);

    //remove outer diameter exit hole
     translate([22,0,HightVerticalPVC-37])rotate([0,0,20]) 
    difference()
    {
        fullhorizontaltube();

        rotate([0,0,-10])
    translate([-(Casingx/2)+6,-(Casingy/2)+0,0])
    cube([Casingx,Casingy,Casingz]);
    }
    }

}





//VUKSpace();
VUKCasing();
//color("red")hollowhorizontaltube();
