

$fn = $preview ? 24 : 180;
difference(){
    cube(10, center=true);
    translate([0,0,-5.5]) cylinder(h=11,d=4);
}
