class shapes;
  real area;
  string shape;

  function void display(); 
    $display("Area of %s=%f ",shape,area);
  endfunction
  
endclass

class circle extends shapes;
  
  function real area_c(real radius);
    shape="Circle";
    area=((3.14)*radius);
  endfunction
  
endclass

module tb;
  circle c;
  
  initial begin
    c=new();
    c.area_c(2.5);
    c.display();
  end
endmodule

/*
output:
Area of Circle=7.850000 
           V C S   S i m u l a t i o n   R e p o r t 
*/
