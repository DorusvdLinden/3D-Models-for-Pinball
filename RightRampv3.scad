

// $fa = 1;
// $fs = 0.4;



$fn = $preview ? 24 : 180;




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



difference(){
    translate([-5,0,13])cube([110,100,34], center=true);

    translate([-60.01,-60,-5.01])cube([12,100,7], center=false);

    translate([-60.01,-60,8])cube([12,100,60], center=false);
    
   translate([-54,0,-5.01]) cylinder(60, 3.2,3.2);

   translate([-54,-30,-5.01]) cylinder(60, 3.2,3.2);
union(){
    path_radius = 46;
    path_diameter = 33;
    translate ([0,0,0])rotate([0,0,160])rotate_extrude(angle=200){
        translate([path_radius - path_diameter, 0])square(path_diameter);
    };
    translate([0,0,-0.01])difference(){
        rotate([0,0,-18])translate([-11,200,90])rotate([0,180,180])bar(w=70,h1=55,h2=90,l=213);
        translate([35,-29,-400])cube([10,10,1000]);
    };
    
            
 translate([-50+(33/2)+7,50-0.01-8,25])cube([33,100,50], center = true);   
 
        };  
        rotate([0,0,-18])translate([64,210,-10.001])rotate([0,0,180])bar(h2=60);  
      translate([0,120,0])cube([200,200,200],center = true);  
};

       


