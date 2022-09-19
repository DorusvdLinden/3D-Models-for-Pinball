
// Settings
$fn = $preview ? 24 : 180;
// variables
margin              =   0.01;

// variables


    screw_hole_h        =  20;
    screw_hole_d        =   2.5;


module M3InsertHole(Insert_D=4, Insert_H=6.7)
{
    // Centre x & y , and zero z 
    translate([0,0,Insert_H/2]) 
    cylinder(h=Insert_H, d=Insert_D,center = true);
}


difference(){
    cube([72,200,3]);
    
    translate([ 53  ,  28.8, -margin]) M3InsertHole(Insert_D=3.5);
    translate([ 22.5, 138.2, -margin]) M3InsertHole(Insert_D=3.5);   
    translate([ 60  , 190  , -margin]) M3InsertHole(Insert_D=3.5);  
    
    translate([ 6,  20, 0])  cylinder(h=screw_hole_h, d=screw_hole_d, center=true);
    translate([ 6,  80, 0])  cylinder(h=screw_hole_h, d=screw_hole_d, center=true);
    translate([ 6, 140, 0])  cylinder(h=screw_hole_h, d=screw_hole_d, center=true);
}
