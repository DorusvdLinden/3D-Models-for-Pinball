// Settings
$fn = $preview ? 24 : 180;


// variables
margin              =   0.01;
bottom_thickness    =  3;
part_h              =  33; //30;
part_h2              =  38 - part_h; 

E_dx                =  33;
E_dy                =  40+40+33; //partD1+partd2+gap

Angle               =  37;

screw_hole_h        =  20;
screw_hole_d        =   2.5;

wall_thickness      =   4;
round_edge_r        =  25;
    
    
// Modules    
module M3InsertHole(Insert_D=4, Insert_H=6.7)
{
    // Centre x & y , and zero z 
    translate([0,0,Insert_H/2]) 
    cylinder(h=Insert_H, d=Insert_D,center = true);
}
//


ShapePoints1 = [
    // Top
    [  0,  0,  0 ],  //  0
    [ 40, 30,  0 ],  //  1
    [ 40, 78,  0 ],  //  2
    [ 25, 80,  0 ],  //  3
    [ 40,164,   0],  //  4
    [ 0, 145,  0 ],  //  5
  
    // Bottom
    [  0,  0,  part_h ],  //  6
    [ 40, 30,  part_h ],  //  7
    [ 40, 78,  part_h ],  //  8
    [ 25, 80,  part_h ],  //  9
    [ 40,164,  part_h ],  //  10
    [ 0, 145,  part_h ],  //  11

 ]; 
  
ShapeFaces1 = [
  [ 0, 1, 2, 3, 4, 5],  // Bottom
  
  [ 1, 0, 6, 7],  // A
  [ 2, 1, 7, 8],  // B
  [ 3, 2, 8, 9],  // C
  [ 4, 3, 9,10],  // D
  [ 5, 4,10,11],
  [ 0, 5,11, 6],  // E
  
  [11,10,9,8,7,6]   // Top
]; 



ShapePoints2 = [
    // Top
    [  0,  0,  0 ],  //  0
    [ 40, 30,  0 ],  //  1
    [ 40, 78,  0 ],  //  2
    [ 54,170,  0 ],  //  3
    [ 0, 145,  0 ],  //  4
  
    // Bottom
    [  0,  0, part_h2 ],  //  8
    [ 40,  30, part_h2 ],  //  9
    [ 40, 78, part_h2 ],  // 10
    [ 54,170, part_h2 ],  // 11
    [ 0,145, part_h2 ],  // 12

 ]; 
  
ShapeFaces2 = [
  [ 0, 1, 2, 3, 4],  // Bottom
  
  [ 1, 0, 5, 6],  // A
  [ 2, 1, 6, 7],  // B
  [ 3, 2, 7, 8],  // C
  [ 4, 3,8,9],  // D
  [ 0, 4,9,5],  // E
  
  [9,8,7,6,5]   // Top
];
    
difference(){
    
 
        
    union(){          
        polyhedron( ShapePoints1, ShapeFaces1 );
        translate([0,0,part_h-margin])polyhedron( ShapePoints2, ShapeFaces2 );
    }
    
    translate([ 15,30,bottom_thickness-margin-6.5]) M3InsertHole();    
    translate([ 15,80,bottom_thickness-margin-6.5]) M3InsertHole();
    translate([ 15,130,bottom_thickness-margin-6.5]) M3InsertHole();
   


    
}
