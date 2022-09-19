// Settings
$fn = $preview ? 24 : 180;


// variables
margin              =   0.01;
bottom_thickness    =  3;
part_h              =  4; //30;
part_h2              =  33 - part_h; 

E_dx                =  33;
E_dy                =  40+40+33; //partD1+partd2+gap

Angle               =  37;

screw_hole_h        =  20;
screw_hole_d        =   2.5;

wall_thickness      =   4;
round_edge_r        =  25;
    wall = 5;
    



ShapePoints1 = [
    // Top
    [-10,  0,  0 ],
    [  0,  0,  0 ],  
    [ 33, 35,  0 ],  
    [-10, 35,  0 ],  

  
    // Bottom
    [-10,  0,  part_h ],
    [  0,  0,  part_h ],  
    [ 33, 35,  part_h ],  
    [-10, 35,  part_h ], 


 ]; 
  
ShapeFaces1 = [
  [ 0, 1, 2, 3],  // Bottom
  
  [ 1, 0, 4, 5],  
  [ 2, 1, 5, 6],  
  [ 3, 2, 6, 7],  
  [ 0, 3, 7, 4],  
  
  [ 7, 6, 5, 4]   // Top
]; 



ShapePoints2 = [
    // Top
    [ 0-wall,  0,  0 ],  //  0
    [  0,  0,  0 ],  //  1
    [ 33, 35,  0 ],  //  2
    [ 33-wall, 35,  0 ],  //  3
  
    // Bottom
    [ 0-wall,  0,  part_h2 ],  //  4
    [  0,  0,  part_h2 ],  //  5
    [ 33, 35,  part_h2 ],  //  6
    [ 33-wall, 35,  part_h2 ],  //  7
    
 ]; 
  
ShapeFaces2 = [
  [ 0, 1, 2, 3],  // Bottom
  
  [ 1, 0, 4, 5],  
  [ 2, 1, 5, 6],  
  [ 3, 2, 6, 7],  
  [ 0, 3, 7, 4],  
  
  [ 7, 6, 5, 4]   // Top
]; 
    
difference(){
    
 
        
    union(){          
        polyhedron( ShapePoints1, ShapeFaces1 );
        translate([0,0,part_h-margin])polyhedron( ShapePoints2, ShapeFaces2 );
    }
    
           // screw holes
    translate([ -4, 12,0])  cylinder(h=screw_hole_h, d=screw_hole_d, center=true);
    translate([ 10, 27,0])  cylinder(h=screw_hole_h, d=screw_hole_d, center=true);


    
}