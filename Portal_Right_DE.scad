
// Settings
$fn = $preview ? 24 : 180;


// variables
margin              =   0.01;
bottom_thickness    =  3;
part_h              =  3; //38;

E_dx                =  33;
E_dy                =  40+40+33; //partD1+partd2+gap

Angle               =  37;

screw_hole_h        =  20;
screw_hole_d        =   2.5;

wall_thickness      =   4;
round_edge_r        =   5;
    
    
// Modules    
module M3InsertHole(Insert_D=4, Insert_H=6.7)
{
    // Centre x & y , and zero z 
    translate([0,0,Insert_H/2]) 
    cylinder(h=Insert_H, d=Insert_D,center = true);
}
    


// Shapes
//
//    15,5 ----- 4,13         /| 1,10
// 16,7   /     \____________/ |
//   +---/       3,12     2,11 |
//   |   6,14                  |
//   |                         |
//   |                         |
//   +-------------------------+
// 17,8                        0,9
//


ShapePoints = [
    // Top
    [  0,  0,  0 ],  //  0
    [  0,  0,  0 ],  //  1
    [ 28, 40,  0 ],  //  2
    [ 28, 55,  0 ],  //  3
    [  0, 55,  0 ],  //  4
    [  0,  0,  0 ],  //  5
    [ 10,  0,  0 ],  //  6
    [ 28, 40,  0 ],  //  7
    [ 28, 55,  0 ],  //  8
    
    // Bottom
    [  0,  0,  0 ],  //  9
    [  0,  0,  0 ],  // 10
    [ 28, 40,  0 ],  // 11
    [ 28, 55,  0 ],  // 12
    [  0, 55,  0 ],  // 13
    [  0,  0,  0 ],  // 14
    [ 10,  0,  0 ],  // 15
    [ 28, 40,  0 ],  // 16
    [ 28, 55,  0 ],  // 17




]; 
  
ShapeFaces = [
  [0,1,2,3,4],  // bottom
  [6,5,1,0],  // front
  [1,2,7,6],  // s
  [2,3,8,7],  // right
  [3,4,9,8],  // back
  [4,0,5,9],
  [9,8,7,6,5]
]; 

difference(){
    
    union(){
        
        CubePoints1 = [
          [  0,  0,  0 ],  //0
          [ 54,  0,  0 ],  //1
          [ 38, 40,  0 ],  //2
          [  0, 40,  0 ],  //3
          [  0,  0, part_h ],  //4
          [ 54,  0, part_h ],  //5
          [ 38, 40, part_h ],  //6
          [  0, 40, part_h ]]; //7
          
        CubeFaces1 = [
          [0,1,2,3],  // bottom
          [4,5,1,0],  // front
          [7,6,5,4],  // top
          [5,6,2,1],  // right
          [6,7,3,2],  // back
          [7,4,0,3]]; // left
          
        polyhedron( CubePoints1, CubeFaces1 );
        
        
        CubePoints2 = [
          [  0,  0,  0 ],  //0
          [ 38,  0,  0 ],  //1
          [ 38, 40,  0 ],  //2
          [  0, 40,  0 ],  //3
          [  0,  0, part_h ],  //4
          [ 38,  0, part_h ],  //5
          [ 38, 40, part_h ],  //6
          [  0, 40, part_h ]]; //7
          
        CubeFaces2 = [
          [0,1,2,3],  // bottom
          [4,5,1,0],  // front
          [7,6,5,4],  // top
          [5,6,2,1],  // right
          [6,7,3,2],  // back
          [7,4,0,3]]; // left
          
        translate([0,40-margin,0])polyhedron( CubePoints2, CubeFaces2 );
                
        
        
        
        translate([0,40+40-margin,0])cube([38,40,part_h]);
        
         
        CubePoints3 = [
          [  0,  0,  0 ],  //0
          [ 10+E_dx,  0,  0 ],  //1
          [ 28+E_dx, 40,  0 ],  //2
                    [28,55,0], //3
          [  0, 55,  0 ],  //4
          
          [  0,  0, part_h ],  //5
          [ 10+E_dx,  0, part_h ],  //6
          [ 28+E_dx, 40, part_h ],  //7
                     [28,55,part_h], //8 
                     [  0, 55, part_h ],//9
          

                
          ]; 
          
        CubeFaces3 = [
          [0,1,2,3,4],  // bottom
          [6,5,1,0],  // front
          [1,2,7,6],  // s
          [2,3,8,7],  // right
          [3,4,9,8],  // back
          [4,0,5,9],
          [9,8,7,6,5]]; // left
          
        translate([0,E_dy-margin,0])polyhedron( CubePoints3, CubeFaces3 );
        
        translate([0,E_dy+55-5,0])cube([5+E_dx,40,part_h]);
        
    }
    translate([0-margin-10,0-margin-10,4])cube([38,60,38]);
    
        // screw holes
//    translate([ 10, 10,0])  cylinder(h=screw_hole_h, d=screw_hole_d, center=true);
//    translate([ 10, 45,0])  cylinder(h=screw_hole_h, d=screw_hole_d, center=true);
//    translate([ 25, 10,0])  cylinder(h=screw_hole_h, d=screw_hole_d, center=true);
//    translate([ 25, 45,0])  cylinder(h=screw_hole_h, d=screw_hole_d, center=true);
    
        //round edge
//    translate([38-5+margin,60-5+20+margin,0])difference(){translate([round_edge_r/2,round_edge_r/2,0])cube([round_edge_r,round_edge_r,100],center=true); cylinder(h=110,r=round_edge_r, center=true);}
    
    
    
//    translate([ 10,55,bottom_thickness-margin-6.5]) M3InsertHole();
//    translate([ 30,55,bottom_thickness-margin-6.5]) M3InsertHole();
//    translate([ 37,10,bottom_thickness-margin-6.5]) M3InsertHole();
   
}
