class pass_by_ref;
  
  //inside class function are automatic by defult
  
  function automatic int aut_swap(const ref int a,b);
    int temp;
    $display(" A    B");
    $display("%0d   %0d",a,b);
     return a**b;
  endfunction
  
endclass


module test;
  pass_by_ref p;
  
  int a,b;
  int x;
  
  initial begin
    a=15;
    b=20;
    p=new();
    repeat(2)begin

      $display("VALUE BEFORE automatic_FUNCTION CALL:A=%0d b=%0d ",a,b);
     x=p.aut_swap(a,b);
      $display("VALUE AFTER automatic_FUNCTION CALL:A=%0d b=%0d A^B=%0d",a,b,x);
      
    end
  end
endmodule

/*
OUTPUT:

VALUE BEFORE automatic_FUNCTION CALL:A=15 b=20 
 A    B
15   20
VALUE AFTER automatic_FUNCTION CALL:A=15 b=20 A^B=-1314489151
VALUE BEFORE automatic_FUNCTION CALL:A=15 b=20 
 A    B
15   20
VALUE AFTER automatic_FUNCTION CALL:A=15 b=20 A^B=-1314489151
xmsim: *W,RNQUIE: Simulation is complete.

*/
