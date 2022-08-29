

// $fa = 1;
// $fs = 0.4;



$fn = $preview ? 24 : 180;

    // variables
    margin          = 0.01;

    floor_z         =   4;  

    object_x        = 100;    
    object_y        = 100;
    object_z        =  30 + floor_z + 3 +0;
     
    wing_x          =  10;    
    wing_y          =       object_y;
    wing_z          =   3;  // height where wing begins from bottom of floor
    wing_t          =   3;  // wing thickness
    wing_extra_x    =   2;

    screw_hole_h    =  20;
    screw_hole_d    =   3;


    object_dx       =    0;//   -wing_x/2;  
    object_dz       =       object_z/2 - floor_z;    

                    //      -y zijde uitlijnen naar 0 ~ verplaatsen over -x deel object ~ -extra marge
    wing_dx         =       (wing_x + wing_extra_x)/2 - (object_x/2 + wing_x) - margin;  
                    
                    //      -z uilijnen naar 0  ~ omhoog verplaatsen zoals nogig  ~ - extra marge
    wing_dz         =       -(wing_z+floor_z)/2 + wing_z - margin ;


    screw_hole_dx   =      (object_x+wing_x-wing_extra_x)/2 +1; 
    screw_hole_dy   = -30;
    screw_hole_dy2   = 30;
   
    path_radius     = 46;
    path_diameter   = 33;
    path_extraangle = 59;
    path_angle      = 180 + path_extraangle;
    path_rotate     = 180 - path_extraangle;
   
   
    ramp_angle      = -18;


    exit_x          =  29;
    exit_y          = 100;
    exit_z          =  33;
    exit_dx         =  13;
    exit_dy         =  11;
    exit_angle      =   0;
    
//    rail gaten gemeten vanaf eind wing (= object/2+wing)
//    onder  1,7-2,2 en 3,9-4,4 op bodem niveau (cm)
//    midden 1,3-1,7 en 4,2-5,2 op 1-1,5 cm hoog
//    boven  0,9-1,4 en 4,5 - 5,5 op 2,1-2,6 hoog

    rail_dy         =  40;
    rail_d          =   5;
    rail_d2         =   8; 
    
    rail_base_x     = -object_x/2 + wing_extra_x - 2 ; // vanaf waar wing onder begint, gezien vanaf midden cylinder
    rail_or_x       = rail_base_x + rail_d/2  + 15.2; // tot 22 vanaf wing (rail_d)
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
    translate([object_dx,0,0])cube([object_x,object_y,3], center=true);


    
    
    // create wing with holes
 
    translate([wing_dx,-margin,0])cube([wing_x+wing_extra_x,wing_y,object_z], center=true);    


 
    
    // connect to ramp 
    rotate([0,0,ramp_angle])translate([64,210,-10.001])rotate([0,0,180])bar(h2=60);  
    
    // Connect to rail
    translate([0,110,0])cube([200,200,200],center = true);  
    
    // roof screw holes
        translate([40,-40,0])  cylinder(h=20, d=3.5, center=true);
        translate([-40,-40,0])  cylinder(h=20, d=3.5, center=true);
        translate([-5,-5,0])  cylinder(h=20, d=3.5, center=true);   

    
    };

       


