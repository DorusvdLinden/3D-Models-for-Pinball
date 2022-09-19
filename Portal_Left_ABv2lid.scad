
$fn = $preview ? 24 : 180;


    // variables
    margin              =   0.01;
    Part_h    =  2;
    Part_Angle          = -24;
    A_Part_x            = 80;
    A_Part_y1           =  40-2;
    A_Part_y2           =  24-2;
    ABOverlap_x         =  31;    
    B_Part_x            = 115+ ABOverlap_x;
    B_Part_y            =  63;
    B_Part_dx           =  60;

    
    Ball_Path_x         =  A_Part_x-58; // 58 from rail to gap
    Ball_Path_y         =  35-2;
    
    screw_hole_h        =  20;
    screw_hole_d        =   2.5;
    
    wall_thickness      =   10;
    bottom_t            =   4;
    round_edge_r        =   5;

fullx = B_Part_dx-ABOverlap_x+B_Part_x;

//fullx= A_Part_x;
module M3InsertHole(Insert_D=4, Insert_H=6.7)
{
    // Centre x & y , and zero z 
    translate([0,0,Insert_H/2]) 
    cylinder(h=Insert_H, d=Insert_D,center = true);
}

    
difference(){
    //remove left part
    intersection(){
        union(){
            cube([fullx,A_Part_y1,Part_h]);
            translate([B_Part_dx-ABOverlap_x,-B_Part_y,0])cube([B_Part_x,B_Part_y,Part_h]);
        }
    translate([0,A_Part_y1-A_Part_y2,0])rotate([0,0,Part_Angle])translate([-500,0,0])cube([1000,600,Part_h]);    translate([0,A_Part_y1-A_Part_y2,0])rotate([0,0,Part_Angle-1])translate([-500,0,0])cube([1000,60,Part_h]);
    }
   
    
//cylinder(h=20, d=3.5, center=true)
    
    translate([ 10,33,Part_h-margin-6.5]) cylinder(h=20, d=3.5, center=true);
    translate([ 70,-5,Part_h-margin-6.5]) cylinder(h=20, d=3.5, center=true);
    translate([110,-5,Part_h-margin-6.5]) cylinder(h=20, d=3.5, center=true);
    translate([160,-5,Part_h-margin-6.5]) cylinder(h=20, d=3.5, center=true);
    translate([170,-45,Part_h-margin-6.5]) cylinder(h=20, d=3.5, center=true);
    
}
