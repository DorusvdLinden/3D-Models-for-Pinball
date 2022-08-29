
$fn = $preview ? 24 : 180;


    // variables
    margin              =   0.01;
    bottom_thickness    =  38;
    Part_Angle          = -24;
    C_Part_x1           =  45;
    C_Part_y1           =  40;

    C_Part_x2           =  27;
    C_Part_y2           =  40;

    Angle               =  37;

    screw_hole_h        =  20;
    screw_hole_d        =   2.5;
    
    wall_thickness      =   4;
    round_edge_r        =   5;
 

module M3InsertHole(Insert_D=4, Insert_H=6.7)
{
    // Centre x & y , and zero z 
    translate([0,0,Insert_H/2]) 
    cylinder(h=Insert_H, d=Insert_D,center = true);
}
 
difference(){
    
    union(){
        
        CubePoints = [
          [  0,  0,  0 ],  //0
          [ 10,  0,  0 ],  //1
          [ 25, 40,  0 ],  //2
          [  0, 55,  0 ],  //3
          [  0,  0, 38 ],  //4
          [ 10,  0, 38 ],  //5
          [ 25, 40, 38 ],  //6
          [  0, 55, 38 ]]; //7
          
        CubeFaces = [
          [0,1,2,3],  // bottom
          [4,5,1,0],  // front
          [7,6,5,4],  // top
          [5,6,2,1],  // right
          [6,7,3,2],  // back
          [7,4,0,3]]; // left
          
        polyhedron( CubePoints, CubeFaces );
        
        translate([0,55-5,0])cube([5,40,38]);
    }
    
    translate([ 6,10,-0.01]) M3InsertHole();
    translate([ 10,40,-0.01]) M3InsertHole();

   
}
