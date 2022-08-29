

$fn = $preview ? 24 : 180;

    margin          = 0.01;

    poot_d          = 8;
    gat_h           = 42;
    object_h        = gat_h+poot_d;
    gat_x           = 29;
    object_x        = gat_x+ 2* poot_d;

    gat_afstand     = object_x - (2 * poot_d / 2);  //= 47-9=38

difference(){
    translate([-poot_d/2,-poot_d/2,0])cube([object_x,poot_d,object_h]);
    translate([0,0,-margin])cylinder(h=15,d=1.5);
    translate([gat_afstand,0,-margin])cylinder(h=15,d=1.5);   
    translate([poot_d/2,-poot_d/2-margin,-margin])cube([gat_x,poot_d+1,gat_h]);
};