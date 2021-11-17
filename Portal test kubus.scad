
margin=0.001;

module maakhoeken(d)
    for (rot =[[0,0,0],[0,90,0],[0,0,90]])    
        rotate(rot)
        for (y=[-d,d])
            for (z=[-d,d])
                if ((y!=0) || (z!=0))
                    translate([0,y,z])children();
    
        
module maakstrepen(d)
    for (rot =[[0,0,0],[0,90,0],[0,0,90]])    
        rotate(rot)
        for (T=[[0,-d,0],[0,d,0],[0,0,-d],[0,0,d]])  
            translate(T)children();                        
            
difference()
    {
    cube([10,10,10],center=true);
    maakhoeken(4.5)cube([20,1+margin,1+margin],center=true);
    maakstrepen(4.5)cube([20,1+margin,1+margin],center=true);
    }
            


translate([0,15,0])
difference()
    {
    cube([10,10,10],center=true);
    maakhoeken(d=5)rotate([0,90,0])cylinder(h=20,d=2+margin,center=true,$fn=45);
    maakstrepen(d=4.5)rotate([0,90,0])cylinder(h=20,d=1+margin,center=true,$fn=45);
    maakstrepen(d=5)cube([20,1+margin,1+margin],center=true);
    }
            
    
            