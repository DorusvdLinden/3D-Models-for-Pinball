
$fn = $preview ? 24 : 180;

    margin          = 0.01;
    dikte = 2.5;

rotate([180,0,0])difference(){
    union(){
        translate([0,-10,0])cube([100,20,dikte]);
        cylinder(h=dikte,d=20);
        translate([100,0,0])cylinder(h=dikte,d=20);    
        //#rotate([0,0,22])translate([0,-10,0])cube([71,20,dikte]);
        translate([44,-8,0])rotate([0,0,50])translate([10,-10,0])cube([30,25,dikte]);
        translate([100,0,0])rotate([0,0,-38])translate([-45,-10,0])cube([45,20,dikte]);
        translate([66,27,0])cylinder(h=dikte,d=20); 
    };
        translate([0,0,-margin])cylinder(h=5,d=4.5);
        translate([100,0,-margin])cylinder(h=5,d=4.5);
    
        translate([10,6-1,-margin])cylinder(h=3,d=4);//r2=(5/2),r1=(2.5/2)
        translate([40,4-1,-margin])cylinder(h=3,d=4);    //r2=(5/2),r1=(2.5/2)
        
        translate([18,6-1,-margin])cylinder(h=3,d=4);
        translate([32,4-1,-margin])cylinder(h=3,d=4);

};
//delta=7 is 3 en 4