$fn = $preview ? 24 : 180;

// variables
margin          = 0.01;


cyl_d=10;

cube_y = 10;
base_y=20;
base_h=2.5;
cube_x=10;
base_d=cube_x+0;
distanceTube_floor = 10;

difference(){
    union(){

        translate([-20/2,5,])cube([cube_x+10,cube_y,10]);
        translate([-base_d/2,0,0])cube([base_d,base_y,base_h]);
        
        translate([0,0,0])cylinder(h=base_h, d=cyl_d );
        translate([0,base_y,0])cylinder(h=base_h, d=cyl_d );
                //r2=(5/2),r1=(2.5/2)
 
    }
 
    
    translate([0,0,-margin]) cylinder(h=4,r2=(5/2),r1=(2.5/2));
    translate([0,base_y,-margin])cylinder(h=4,r2=(5/2),r1=(2.5/2));
    
    //minus donut ring to hold tywrap
   translate([-5,0,1])difference(){
      translate([-2.25,base_y/2,distanceTube_floor+20])rotate([0,90,0])cylinder(h=4.5,d=56);
          translate([-2.5,base_y/2,distanceTube_floor+20])rotate([0,90,0])cylinder(h=5,d=50);
   };
      translate([5,0,1])difference(){
      translate([-2.25,base_y/2,distanceTube_floor+20])rotate([0,90,0])cylinder(h=4.5,d=56);
          translate([-2.5,base_y/2,distanceTube_floor+20])rotate([0,90,0])cylinder(h=5,d=50);
   };
};