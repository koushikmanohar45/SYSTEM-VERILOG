class pass_by_ref;
  
  //inside class function are automatic by defult
  
  function automatic int aut_swap(ref int a,b);
    int temp;
    $display(" A    B");
    $display("%0d   %0d",a,b);
    temp=a;
    a=b;
    b=temp;
    $display("%0d   %0d",a,b);
  endfunction
  
endclass


module test;
  pass_by_ref p;
  
  int a,b;
  
  initial begin
    a=15;
    b=20;
    p=new();
    repeat(2)begin

    $display("VALUE BEFORE automatic_FUNCTION CALL:A=%0d b=%0d",a,b);
    p.aut_swap(a,b);
    $display("VALUE AFTER automatic_FUNCTION CALL:A=%0d b=%0d",a,b);
      
    end
  end
endmodule

/*
OUTPUT:

VALUE BEFORE automatic_FUNCTION CALL:A=15 b=20
 A    B
15   20
20   15
VALUE AFTER automatic_FUNCTION CALL:A=20 b=15
VALUE BEFORE automatic_FUNCTION CALL:A=20 b=15
 A    B
20   15
15   20
VALUE AFTER automatic_FUNCTION CALL:A=15 b=20
xmsim: *W,RNQUIE: Simulation is complete.

*/
