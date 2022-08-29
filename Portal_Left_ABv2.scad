
$fn = $preview ? 24 : 180;


    // variables
    margin              =   0.01;
    bottom_thickness    =  38;
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
    
    wall_thickness      =   4;
    round_edge_r        =   5;
    
difference(){
    //remove left part
    intersection(){
        union(){
            cube([A_Part_x,A_Part_y1,bottom_thickness]);
            translate([B_Part_dx-ABOverlap_x,-B_Part_y,0])cube([B_Part_x,B_Part_y,bottom_thickness]);
        }
        translate([0,A_Part_y1-A_Part_y2,0])rotate([0,0,Part_Angle])translate([-500,0,0])cube([1000,1000,bottom_thickness]);
    }
    translate([A_Part_x-Ball_Path_x+margin,0,-margin])cube([Ball_Path_x,Ball_Path_y,bottom_thickness+10*margin]);
    
    // screw holes
    translate([ 15, 25,0])  cylinder(h=screw_hole_h, d=screw_hole_d, center=true);
    translate([ 35, 20,0])  cylinder(h=screw_hole_h, d=screw_hole_d, center=true);
    translate([100,-15,0])  cylinder(h=screw_hole_h, d=screw_hole_d, center=true);
    translate([155,-30,0])  cylinder(h=screw_hole_h, d=screw_hole_d, center=true);
    
    //round edge
    translate([B_Part_dx-ABOverlap_x+B_Part_x-5+margin,-5+margin,0])difference(){translate([round_edge_r/2,round_edge_r/2,0])cube([round_edge_r,round_edge_r,100],center=true); cylinder(h=110,r=round_edge_r, center=true);}
    
    translate([wall_thickness,0,+wall_thickness])cube([A_Part_x-Ball_Path_x-(2*wall_thickness),A_Part_y1-wall_thickness,bottom_thickness]);
    translate([-wall_thickness,-wall_thickness,+wall_thickness])translate([B_Part_dx-ABOverlap_x,-B_Part_y,0])cube([B_Part_x,B_Part_y,bottom_thickness]);
    
}
