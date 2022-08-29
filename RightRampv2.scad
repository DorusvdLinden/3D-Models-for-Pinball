

// $fa = 1;
// $fs = 0.4;



$fn = $preview ? 24 : 180;

    // variables
    margin          = 0.01;

    floor_z         =   3;  

    object_x        = 100;    
    object_y        = 100;
    object_z        =  30 + floor_z;
     
    wing_x          =  10;    
    wing_y          =       object_y;
    wing_z          =   3;  // height where wing begins from bottom of floor
    wing_t          =   4;  // wing thickness
    wing_extra_x    =   2;

    screw_hole_h    =  80;
    screw_hole_r    =   3.1;


    object_dx       =       -wing_x/2;  
    object_dz       =       object_z/2 - floor_z;    

                    //      -y zijde uitlijnen naar 0 ~ verplaatsen over -x deel object ~ -extra marge
    wing_dx         =       (wing_x + wing_extra_x)/2 - (object_x/2 + wing_x) - margin;  
                    
                    //      -z uilijnen naar 0  ~ omhoog verplaatsen zoals nogig  ~ - extra marge
    wing_dz         =       -(wing_z+floor_z)/2 + wing_z - margin ;


    screw_hole_dx   =      (object_x+wing_x-wing_extra_x)/2; 
    screw_hole_dy   = -30;
   
    path_radius     = 46;
    path_diameter   = 33;
    path_extraangle = 50;
    path_angle      = 180 + path_extraangle;
    path_rotate     = 180 - path_extraangle;
   
   
    ramp_angle      = -18;


    exit_x          =  29;
    exit_y          = 100;
    exit_z          =  50;
    exit_dx         =  13;
    exit_dy         =   7;
    exit_angle      = 0;
    
//    rail gaten gemeten vanaf eind wing (= object/2+wing)
//    onder  1,7-2,2 en 3,9-4,4 op bodem niveau (cm)
//    midden 1,3-1,7 en 4,2-5,2 op 1-1,5 cm hoog
//    boven  0,9-1,4 en 4,5 - 5,5 op 2,1-2,6 hoog

    rail_dy         =  40;
    rail_d          =   5;
    rail_d2         =   8; 
    
    rail_base_x     = -object_x/2 + wing_extra_x - 2 ; // vanaf waar wing onder begint, gezien vanaf midden cylinder
    rail_or_x       = rail_base_x + rail_d/2  + 16; // tot 22 vanaf wing (rail_d)
    rail_ol_x       = rail_base_x + rail_d/2  + 37; // tot 44 vanaf wing (rail_d)
    rail_mr_x       = rail_base_x + rail_d/2  + 11; // tot 17 vanaf wing (rail_d)
    rail_ml_x       = rail_base_x + rail_d2/2 + 43; // tot 52 vanaf wing (rail_d2)
    rail_br_x       = rail_base_x + rail_d/2  + 08.5; // tot 14 vanaf wing (rail_d)
    rail_bl_x       = rail_base_x + rail_d2/2 + 45; // tot 53 vanaf wing (rail_d2)
   
    rail_y          = -20;
    rail_h          =  10;

    rail_o_z        =   0;
    rail_ml_z       =  14.5;
    rail_mr_z       =  15.5;
    rail_bl_z       =  26.5;
    rail_br_z       =  27.5;

    
// Modules used in ramp

    module wedge(w1=80,dw=15,l=210,h=55){
        polyhedron(
            points=[[0,0,0], [w1,0,0], [w1-dw,l,0], [dw,l,0], [dw,l,h], [w1-dw,l,h]],
            faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
        );
    }
   
    module bar(w=80,dw=15,l=210,h1=0,h2=50){
        polyhedron(
            points=[[0,0,0], [w,0,0], [w-dw,l,h1], [dw,l,h1], [0,0,h2 ], [w,0,h2], [w-dw,l,h2], [dw,l,h2] ],
            faces=[
                [0,1,2,3],  // bottom
                [4,5,1,0],  // front
                [7,6,5,4],  // top
                [5,6,2,1],  // right
                [6,7,3,2],  // back
                [7,4,0,3]] // left
        );
    }



//
    
difference(){
   
    // base cube
    translate([object_dx,0,object_dz])cube([object_x + wing_x,object_y,object_z], center=true);

//////////////////////////
// test remove chunk
    translate([-100,-85,7])cube([200,100,100]);
//////////////////////    
    
    echo(rail_base_x);
    echo(rail_or_x);

    // Rail holes
    translate([rail_or_x,rail_dy-rail_h/2+margin,rail_o_z-rail_d/2+margin])cube([rail_d, rail_h, rail_d], center=true); 
    translate([rail_ol_x,rail_dy-rail_h/2+margin,rail_o_z-rail_d/2+margin])cube([rail_d, rail_h, rail_d], center=true); 
    #translate([rail_mr_x,rail_dy-rail_h/2+margin,rail_mr_z-rail_d/2+margin])cube([rail_d, rail_h, rail_d], center=true); 
    #translate([rail_ml_x,rail_dy-rail_h/2+margin,rail_ml_z-rail_d/2+margin])cube([rail_d2, rail_h, rail_d], center=true);   
    #translate([rail_br_x,rail_dy-rail_h/2+margin,rail_br_z-rail_d/2+margin])cube([rail_d, rail_h, rail_d], center=true); 
    #translate([rail_bl_x,rail_dy-rail_h/2+margin,rail_bl_z-rail_d/2+margin])cube([rail_d2, rail_h, rail_d], center=true); 
    
    
    // create wing with holes
    translate([wing_dx,-margin,wing_dz])cube([wing_x+wing_extra_x,wing_y,wing_z+floor_z], center=true);
    translate([wing_dx,-margin,object_z/2 + wing_z + wing_t])cube([wing_x+wing_extra_x,wing_y,object_z], center=true);    
    translate([-screw_hole_dx,0,0])    cylinder(screw_hole_h, screw_hole_r,screw_hole_r, center=true);
    translate([-screw_hole_dx,screw_hole_dy,0])  cylinder(screw_hole_h, screw_hole_r,screw_hole_r, center=true);

    // ball path
    union(){
        // ring
        rotate([0,0,path_rotate])rotate_extrude(angle=path_angle){
            translate([path_radius - path_diameter, 0])square(path_diameter);
        };
        
        // entrance wedge
        translate([0,0,-margin])difference(){
            // Slope wedge as in ramp
            rotate([0,0,ramp_angle])translate([-11,200,90])rotate([0,180,180])bar(w=70,h1=55,h2=90,l=220);
            // minus corner
            translate([30,-40,-400])cube([20,20,1000]);
        };
        
        // exit wedge
        rotate([0,0,exit_angle])translate([-object_x/2 +(exit_x/2) + wing_extra_x + exit_dx, exit_y/2+exit_dy ,exit_z/2])cube([exit_x,exit_y,exit_z], center = true);              
    };  
    
    // connect to ramp 
    rotate([0,0,ramp_angle])translate([64,210,-10.001])rotate([0,0,180])bar(h2=60);  
    
    // Connect to rail
    translate([0,100+rail_dy,0])cube([200,200,200],center = true);  
};

       


