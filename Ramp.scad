// *                Render Resolution
// *                
$fn = $preview ? 24 : 180;



module M3InsertHole(Insert_D=4, Insert_H=6.7)
{
    // Centre x & y , and zero z 
    translate([0,0,Insert_H/2]) 
    cylinder(h=Insert_H, d=Insert_D,center = true);
}


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


//translate([0,-200,0])
   
difference(){
    union(){
        bar(h2=30);
        translate([0,0,30-0.001]) wedge();
    }
    translate([5,-0.001,0])  bar(w=70,h1=55,h2=90,l=220);
    translate([70,220,0]) rotate([90,0,11]) cylinder(h=230,r=30);
    translate([ 10,50,-0.01]) M3InsertHole();
    translate([ 30,180,-0.01]) M3InsertHole();
    translate([ 60,50,-0.01]) M3InsertHole();

};


