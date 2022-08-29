$fn = $preview ? 24 : 180;

// variables
margin          = 0.01;


cyl_d=12;

cube_y = 30;
base_y=40;
base_h=2.5;
cube_x=12;
base_d=cube_x+0;
distanceTube_floor = 58;

difference(){
    union(){

        translate([-cube_x/2,5,base_h-margin])cube([cube_x,cube_y,71]);
        translate([-base_d/2,0,0])cube([base_d,base_y,base_h]);
        
        translate([0,0,0])cylinder(h=base_h, d=cyl_d );
        translate([0,base_y,0])cylinder(h=base_h, d=cyl_d );
    }
 
    translate([-7,base_y/2+4,distanceTube_floor+20])rotate([0,90,0])cylinder(h=14,d=40);
    
    translate([0,0,-margin]) cylinder(h=4,d=4.6);
    translate([0,base_y,-margin])cylinder(h=4,d=4.6);
    
    //minus donut ring to hold tywrap
   difference(){
      translate([-2.25,base_y/2+4,distanceTube_floor+20])rotate([0,90,0])cylinder(h=4.5,d=56);
          translate([-2.5,base_y/2+4,distanceTube_floor+20])rotate([0,90,0])cylinder(h=5,d=50);
   };
};