
// Settings
$fn = $preview ? 24 : 180;
// variables
margin              =   0.01;

// variables
exit_h      =  20;
ballpath_h  =  32+1.5;
ballpath_w1 =  30;
roof_h      =   2;

    screw_hole_h        =  20;
    screw_hole_d        =   2.5;

//
part_w      =  60;
part_l      = 120;
ramp_l_extra=  40; // 4 cm in part, 4 cm extra


    path_radius     = 100-33;//146;
    path_diameter   = 33;
    path_angle      = 90 ;
    path_rotate     = 180 ; 
   
witdthMax   =62;

ShapePoints = [
    // Top
    [  0,  -10,  0 ],     //  0
    [ 20,  -10,  0 ],     
    [ witdthMax, 120, 0 ],     
    [ 30+margin, 120, 0 ],     
    [ 30,  80, 0 ], 
    [ 30, 160, 0 ],     
    [  0, 160, 0 ],     
    [  0,  80, 0 ],     //  7
    

  
    // Bottom
    [  0,  -10,  exit_h ],     //  8
    [ 20,  -10,  exit_h ],     
    [ witdthMax, 120, exit_h ],     
    [ 30+margin, 120, exit_h ],     
    [ 30,  80, exit_h ], 
    [ 30, 160, 0 ],     
    [  0, 160, 0 ],     
    [  0,  80, exit_h ],     //  15

 

]; 
  
ShapeFaces = [
  [ 0, 1, 2, 3, 4, 5, 6,7],  // Bottom
  
  [ 1, 0, 8, 9],  
  [ 2, 1, 9,10],  
  [ 3, 2,10,11],  
  [ 4, 3,11,12],  
  [ 5, 4,12,13],  
  [ 6, 5,13,14],  
  [ 7, 6,14,15],  
  [ 0, 7,15, 8], 

  [15,14,13,12, 11,10, 9, 8]   // Top
]; 



ShapePoints2 = [
    // Top
    [  0,  -10,  0 ],     //  0
    [ 20,  -10,  0 ],     
    [ witdthMax, 120, 0 ],     
    [ 30+margin, 120, 0 ],     
    [ 30,  80, 0 ], 
    [  0,  80, 0 ],     //  5
    

  
    // Bottom
    [  0,  -10,  ballpath_h ],     //  6
    [ 20,  -10,  ballpath_h ],     
    [ witdthMax, 120, ballpath_h ],     
    [ 30+margin, 120, ballpath_h ],     
    [ 30,  80, ballpath_h ], 
    [  0,  80, ballpath_h ],     //  11

 

]; 
  
ShapeFaces2 = [
  [ 0, 1, 2, 3, 4, 5],  // Bottom
  
  [ 1, 0, 6, 7],  
  [ 2, 1, 7, 8],  
  [ 3, 2, 8, 9],  
  [ 4, 3, 9,10],  
  [ 5, 4,10,11],  
  [ 0, 5,11, 6],  


  [11,10, 9, 8, 7, 6]   // Top
];


ShapePoints3 = [
    // Top
    [  0,  -10,  0 ],     //  0
    [ 20,  -10,  0 ],     
    [ witdthMax, 120, 0 ],     
    [  0, 120, 0 ],     //  3
    

  
    // Bottom
    [  0,  -10,  roof_h ],     //  4
    [ 20,  -10,  roof_h ],     
    [ witdthMax, 120, roof_h ],     
    [  0, 120, roof_h ],     //  7

 

]; 
  
ShapeFaces3 = [
  [ 0, 1, 2, 3],  // Bottom
  
  [ 1, 0, 4, 5],  
  [ 2, 1, 5, 6],  
  [ 3, 2, 6, 7],  
  [ 0, 3, 7, 4],  
 


  [7, 6, 5, 4]   // Top
];

arc1=150; // was 150
gap1y=  -11; // was 0
arc2=130; // was 130
gap2y= 6; // was 6
gap2x=6; //was 6
gap3y=-11;
gap3x=1;


module M3InsertHole(Insert_D=4, Insert_H=6.7)
{
    // Centre x & y , and zero z 
    translate([0,0,Insert_H/2]) 
    cylinder(h=Insert_H, d=Insert_D,center = true);
}


difference(){
    union() {
        polyhedron( ShapePoints, ShapeFaces );
        // screwtab
        translate([witdthMax-10-5,120-2,0])cube([10,12,3]);
        translate([10-5,-10-10,0])cube([10,12,3]);
        

        
        difference(){
            // shape
            translate([0,0,exit_h-margin])polyhedron( ShapePoints2, ShapeFaces2 );
            //ball path
            translate([-margin,69+margin-11,exit_h-margin])cube([ballpath_w1,40+2*margin,ballpath_h+margin]);
            translate([100+gap3x,70+gap3y,exit_h-margin])rotate([0,0,path_rotate])rotate_extrude(angle=path_angle){translate([100 - path_diameter, 0])square([path_diameter+margin,path_diameter+0.5+margin]);};
        }
        // lid
  //      translate([0,0,exit_h-margin+ballpath_h-margin])polyhedron( ShapePoints3, ShapeFaces3 );
    }
    // screw holes
    
    translate([ witdthMax-10,120+5,0])  cylinder(h=screw_hole_h, d=screw_hole_d, center=true);
    translate([ 10,-15,0])  cylinder(h=screw_hole_h, d=screw_hole_d, center=true);
    // Metal rail
    translate([arc1+margin,120-60+margin-gap1y,0-margin])rotate([0,0,180])rotate_extrude(angle=90){translate([arc1 - 0, 0])square([3,31]);};
    
    // Curve
    translate([arc2+40+gap2x+margin,17-gap2y,0-margin])rotate([0,0,110])rotate_extrude(angle=90){translate([arc2 - 0, 0])square([30,exit_h+ballpath_h+margin]);};
    
    
        translate([ 10,90,-margin]) M3InsertHole();
        translate([ 10,50,-margin]) M3InsertHole();    
        translate([ 6,-3,-margin]) M3InsertHole();    
 
        translate([ 40,110,exit_h+ballpath_h+margin-6.7]) M3InsertHole();
        translate([ 10,0,exit_h+ballpath_h+margin-6.7]) M3InsertHole();   
    // remove chunk
      // Metal rail
    translate([arc1+margin,120-60+margin-gap1y,0-margin])rotate([0,0,180])rotate_extrude(angle=90){translate([arc1 - 0, 0])square([300,310]);};
                translate([100+gap3x,70+gap3y,exit_h-margin])rotate([0,0,path_rotate])rotate_extrude(angle=path_angle){translate([100 - path_diameter, 0])square([path_diameter+margin+10,path_diameter+0.5+margin]);};
}
