class shapes;
  real area;
  string shape;

  function void display(); 
    $display("area of %s=%f \n",shape,area);
  endfunction
  
endclass

class circle extends shapes;
  
  function void area_c(real radius);
    $display("radius=%f",radius);
    shape="Circle";
    area=((3.14)*radius);
  endfunction
  
endclass

class square extends shapes;
  
  function void area_c(real a);
    $display("side=%f",a);
    shape="Square";
    area=a*a*a;
  endfunction
  
endclass

class rectangle extends shapes;
  
  function void area_c(real l,real w);
    $display("length=%f width=%f",l,w);
    shape="rectangle";
    area=l*w;
  endfunction
  
endclass

class triangle extends shapes;
  
  function void area_c(real b,real h);
    $display("base=%f height=%f",b,h);
    shape="rectangle";
    area=(b*h)/2;
  endfunction
  
endclass



module tb;
  circle c;
  rectangle r;
  square s;
  triangle t;
  
  initial begin
    $display("==========================shapes==========================");
    c=new();
    $display("========");
    $display("CIRCLE:");
    $display("========");
    c.area_c(2.5);
    c.display();
    
    r=new();
    $display("==========");
    $display("RECTANGLE:");
    $display("==========");
    r.area_c(2,3.1);
    r.display();
    
    s=new();
    $display("========");
    $display("SQUARE:");
    $display("========");
    s.area_c(5);
    s.display();
    
    t=new();
    $display("==========");
    $display("TRIANGLE:");
    $display("==========");
    t.area_c(4,3.3);
    t.display();
  end
endmodule

/*
output:
==========================shapes==========================
========
CIRCLE:
========
radius=2.500000
area of Circle=7.850000 

==========
RECTANGLE:
==========
length=2.000000 width=3.100000
area of rectangle=6.200000 

========
SQUARE:
========
side=5.000000
area of Square=125.000000 

==========
TRIANGLE:
==========
base=4.000000 height=3.300000
area of rectangle=6.600000 

           V C S   S i m u l a t i o n   R e p o r t 
*/
