$fn = $preview ? 24 : 180;
difference(){
    cube([20,20,10], center = true);
        #translate([-5,-5,0])  cylinder(h=20, d=2.5, center=true);
    translate([-5,-3.5,4.5])text("2.5",size =3);
        #translate([-5,5,0])  cylinder(h=20, d=2, center=true);
    translate([-5,6,4.5])text("2",size =3);
        #translate([5,-5,0])  cylinder(h=20, d=1.5, center=true);    
    translate([4,-4,4.5])text("1.5",size =3);
        #translate([5,5,0])  cylinder(h=20, d=1, center=true);  
        translate([4,6,4.5])text("1",size =3);
};