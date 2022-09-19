
// Settings
$fn = $preview ? 24 : 180;


// variables
margin              =   0.01;
bottom_thickness    =  2;
part_h              =  31.5; //30;
part_h2             =   3;

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
    


// Shapes
//          4,12
//     E   ^  D             B /| 1,9
// 14,6   / \________________/ |            ^ x
//   +---/   3,11    C    2,10 |            |
//   | F 5,13                  |       y <--|
// G |                         | A
//   |                         |
//   +-------------------------+
// 15,7            H           0,8
//


ShapePoints = [
    // Top
    [  0,  0,  0 ],  //  0
    [ 54,  0,  0 ],  //  1
    [ 38, 42,  0 ],  //  2
    [ 38,120,  0 ],  //  3
    [ 65+8,150-3,  0 ],  //  4
    [ 38,162,  0 ],  //  5
    [ 38,205,  0 ],  //  6
    [  0,205,  0 ],  //  7
    

  
    // Bottom
    [  0,  0, part_h ],  //  8
    [ 54,  0, part_h ],  //  9
    [ 38, 42, part_h ],  // 10
    [ 38,120, part_h ],  // 11
    [ 65+8,150-3, part_h ],  // 12
    [ 38,162, part_h ],  // 13
    [ 38,205, part_h ],  // 14
    [  0,205, part_h ],   // 15
 

    [ 38+10,54,0], // 16 
    [ 38+10,54,part_h], // 17
]; 
  
ShapeFaces = [
  [ 0, 1, 2,16, 3, 4, 5, 6, 7],  // Bottom
  [ 1, 0, 8, 9],  // A
  [ 2, 1, 9,10],  // B
  
  [ 16,2,10,17],
  [3,16,17,11],
  
  //[ 3, 2,10,11],  // C
  
  [ 4, 3,11,12],  // D
  [ 5, 4,12,13],  // E
  [ 6, 5,13,14],  // F
  [ 7, 6,14,15],  // G
  [ 0, 7,15, 8],  // H
  [15,14,13,12,11,17,10, 9, 8]   // Top
]; 







ShapePoints2 = [
    // Top
    [  0,  0,  0 ],  //  0
    [ 60,  0,  0 ],  //  1
    [ 38+10, 54,  0 ],  //  2
    [ 38,120,  0 ],  //  3
    [ 65+8,150-3,  0 ],  //  4
    [ 38,162,  0 ],  //  5
    [ 38,205,  0 ],  //  6
    [  0,205,  0 ],  //  7
    

  
    // Bottom
    [  0,  0, part_h2 ],  //  8
    [ 60,  0, part_h2 ],  //  9
    [ 38+10, 54, part_h2 ],  // 10
    [ 38,120, part_h2 ],  // 11
    [ 65+8,150-3, part_h2 ],  // 12
    [ 38,162, part_h2 ],  // 13
    [ 38,205, part_h2 ],  // 14
    [  0,205, part_h2 ],   // 15
 

]; 
  
ShapeFaces2 = [
  [ 0, 1, 2, 3, 4, 5, 6, 7],  // Bottom
  [ 1, 0, 8, 9],  // A
  [ 2, 1, 9,10],  // B
  

  
  [ 3, 2,10,11],  // C
  
  [ 4, 3,11,12],  // D
  [ 5, 4,12,13],  // E
  [ 6, 5,13,14],  // F
  [ 7, 6,14,15],  // G
  [ 0, 7,15, 8],  // H
  [15,14,13,12,11,10, 9, 8]   // Top
]; 


difference(){
    
 
        
    union(){          
        polyhedron( ShapePoints, ShapeFaces );
        translate([0,0,part_h-margin])polyhedron( ShapePoints2, ShapeFaces2 );
    }    
                
    //switch
    translate([0-margin,0-margin,0-margin])cube([17,45,100]);
    // mounting
    translate([0-margin,0-margin,bottom_thickness-margin])cube([28,15,100]);
    translate([0-margin,0-margin,bottom_thickness-margin])cube([17,73,100]);
    
    //ball Path
    difference(){
        union(){
            translate([5-margin,120-33-5-margin,0-margin])cube([28,145,part_h-(part_h2-3)]);
            #translate([25-margin,120-33-5-margin,0-margin])cube([28+10,33+3+20,part_h-(part_h2-3)]);
            #translate([25-margin,120-13-margin,0-margin])rotate([0,0,-10])cube([28+10,33+3,part_h-(part_h2-3)]);
            
            
            #translate([11+round_edge_r-margin+25,120+12+round_edge_r-margin+10,-margin])rotate([0,0,180])
                difference(){
                    translate([round_edge_r/2,round_edge_r/2,0])cube([round_edge_r,round_edge_r,part_h-(part_h2-3)]); 
                    translate([5,5,-margin])cylinder(h=part_h-(part_h2-3)+2*margin,r=round_edge_r);
                }
        }
        //round edge
        translate([5+round_edge_r-margin,120-33-5+round_edge_r-margin,0])rotate([0,0,180])
        difference(){
            translate([round_edge_r/2,round_edge_r/2,0])cube([round_edge_r,round_edge_r,100],center=true); 
            cylinder(h=110,r=round_edge_r, center=true);
        }
    }
        // screw holes
    translate([ 22, 7,0])  cylinder(h=screw_hole_h, d=screw_hole_d, center=true);

    translate([ 8, 60,0])  cylinder(h=screw_hole_h, d=screw_hole_d, center=true);
   

    
    
    
    translate([ 50,147,-margin]) M3InsertHole();
//    translate([ 30,55,bottom_thickness-margin-6.5]) M3InsertHole();
//    translate([ 37,10,bottom_thickness-margin-6.5]) M3InsertHole();
   
}
