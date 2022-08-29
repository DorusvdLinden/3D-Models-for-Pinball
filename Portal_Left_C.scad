
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
    
    wall_thickness      =   10;
    round_edge_r        =   10;
    
    
    
    module M3InsertHole(Insert_D=4, Insert_H=6.7)
{
    // Centre x & y , and zero z 
    translate([0,0,Insert_H/2]) 
    cylinder(h=Insert_H, d=Insert_D,center = true);
}
    
difference(){
    cube([C_Part_x1+C_Part_x2 ,C_Part_y1,bottom_thickness]);
            
       
    translate([45+27,0,-margin])rotate([0,0,-90+37])translate([-100,0,0])cube([300,300,100]);
    

    
    // screw holes
    translate([ 17, 22,0])  cylinder(h=screw_hole_h, d=screw_hole_d, center=true);
    translate([ 30, 22,0])  cylinder(h=screw_hole_h, d=screw_hole_d, center=true);
    translate([ 17, 10,0])  cylinder(h=screw_hole_h, d=screw_hole_d, center=true);
    translate([ 40, 10,0])  cylinder(h=screw_hole_h, d=screw_hole_d, center=true);
    
    //round edge
    translate([C_Part_x1-round_edge_r+2.2,C_Part_y1-round_edge_r+0.9,0])rotate([0,0,37/2])
    difference(){translate([round_edge_r/2,round_edge_r/2,0])cube([round_edge_r,round_edge_r,100],center=true); cylinder(h=110,r=round_edge_r, center=true);}
    
    // back end
    translate([wall_thickness-margin,-margin,+4])cube([C_Part_x1-2*wall_thickness,C_Part_y1-wall_thickness,bottom_thickness]);
    translate([wall_thickness-margin+0,-margin+12,+4])rotate([0,0,-90+37])cube([C_Part_x1-2*wall_thickness+20,C_Part_y1-wall_thickness,bottom_thickness]);

    translate([  5,10,bottom_thickness-margin-6.5]) M3InsertHole();    
    translate([  5,35,bottom_thickness-margin-6.5]) M3InsertHole();
    translate([ 30,35,bottom_thickness-margin-6.5]) M3InsertHole();
    translate([ 57,10,bottom_thickness-margin-6.5]) M3InsertHole();


    
}
