class and_gate;
  logic c;
  logic d;
  logic y;
  
  function new();
    c=0;
    d=1;
    y=c&d;
    $display("[PARENT CLASS] c=%b,  d=%b, and_gate=%b",c,d,y);
  endfunction
  
endclass

class or_gate extends and_gate;
  logic a;
  logic b;
  logic y;
  
  function new();
    a=0;
    b=1;
    y=a|b;
    $display("[CHILD CLASS] a=%b,  b=%b, or_gate=%b",a,b,y);
  endfunction
  
endclass

class xor_gate extends or_gate;
  logic e;
  logic f;
  logic y;
  
  function new();
    e=0;
    f=1;
    y=e^f;
    $display("[GRANDCHILD CLASS] e=%b,  f=%b, or_gate=%b",e,f,y);
    
  endfunction
  
endclass

module test;
  xor_gate x;
  
  initial begin
    x=new();
    #1 $finish;
  end
  
endmodule



