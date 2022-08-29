

$fn = $preview ? 24 : 180;
cyl_d=12;
cube_d=15;
margin          = 0.01;

difference(){
    union(){
        translate([-5,(33-20)/2,12.5-margin])cube([10,27,6]);
        translate([-5,(33-20)/2,2.5-margin])cube([10,20,11]);
        translate([-cube_d/2,0,0])cube([cube_d,33,2.5]);
        translate([0,0,0])cylinder(h=2.5, d=cyl_d );
        translate([0,33,0])cylinder(h=2.5, d=cyl_d );
    }
 
    translate([0,0,-margin]) cylinder(h=4,d=4.6);
    translate([-2,27,-margin])cube([4,15,4]);
    #translate([0,0,12.5])rotate([-90,0,0])cylinder(h=40,d=4);

}