
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
    
difference(){
    
    union(){
        
        CubePoints = [
          [  0,  0,  0 ],  //0
          [ 50,  0,  0 ],  //1
          [ 38, 40,  0 ],  //2
          [  0, 40,  0 ],  //3
          [  0,  0, 38 ],  //4
          [ 50,  0, 38 ],  //5
          [ 38, 40, 38 ],  //6
          [  0, 40, 38 ]]; //7
          
        CubeFaces = [
          [0,1,2,3],  // bottom
          [4,5,1,0],  // front
          [7,6,5,4],  // top
          [5,6,2,1],  // right
          [6,7,3,2],  // back
          [7,4,0,3]]; // left
          
        polyhedron( CubePoints, CubeFaces );
        
        translate([0,40-margin,0])cube([38,20,38]);
    }
        translate([0-margin-4,0-margin-4,4])cube([38,60,38]);
    
        // screw holes
    translate([ 10, 10,0])  cylinder(h=screw_hole_h, d=screw_hole_d, center=true);
    translate([ 10, 45,0])  cylinder(h=screw_hole_h, d=screw_hole_d, center=true);
    translate([ 25, 10,0])  cylinder(h=screw_hole_h, d=screw_hole_d, center=true);
    translate([ 25, 45,0])  cylinder(h=screw_hole_h, d=screw_hole_d, center=true);
    
        //round edge
    translate([38-5,60-5,0])difference(){translate([round_edge_r/2,round_edge_r/2,0])cube([round_edge_r,round_edge_r,100],center=true); cylinder(h=110,r=round_edge_r, center=true);}
   
}
