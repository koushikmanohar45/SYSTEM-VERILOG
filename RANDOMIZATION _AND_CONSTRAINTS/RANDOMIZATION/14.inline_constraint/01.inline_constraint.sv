class inline_constraints;
  
  randc bit clk;
  rand bit rst;
  rand bit load;
  rand bit [3:0]d;
  bit [3:0]q;
  
  constraint r{rst dist {0:=20,1:=1};}
  constraint r1{load dist {0:=20,1:=1};}
  
  task shift();

  if(clk)begin
    if (rst)
      q=0;
    else begin
      if(load)
        q=d;
      else
        q={q[2:0],1'b0};
    end
  end
  else
    q<=q;
  endtask
  
endclass

module randomization();
  
  inline_constraints i;
  
  initial begin
    i=new();
    $display("===========LOAD/SHIFT===========");
    repeat(20)begin
      i.randomize();
      i.shift();
      $display("clk=%b rst=%b load=%b d=%b q=%b",i.clk,i.rst,i.load,i.d,i.q);
    end
    //applied constraints temporarily during a specific randomization call.
    $display("INLINE CONSTRAINT(temporarly load data 10)");
    i.randomize with {d==10;load==1;rst==0;clk==1;};
    i.shift();
    $display("clk=%b rst=%b load=%b d=%b q=%b",i.clk,i.rst,i.load,i.d,i.q);
  end
endmodule
  
  
  /*
output:
===========LOAD/SHIFT===========
clk=1 rst=0 load=0 d=1100 q=0000
clk=0 rst=0 load=0 d=0000 q=0000
clk=0 rst=0 load=0 d=0110 q=0000
clk=1 rst=1 load=0 d=0010 q=0000
clk=1 rst=0 load=0 d=1100 q=0000
clk=0 rst=0 load=0 d=0110 q=0000
clk=0 rst=0 load=0 d=1100 q=0000
clk=1 rst=0 load=0 d=1110 q=0000
clk=0 rst=0 load=0 d=0011 q=0000
clk=1 rst=0 load=1 d=0111 q=0111
clk=0 rst=0 load=0 d=1011 q=0111
clk=1 rst=0 load=0 d=0010 q=1110
clk=1 rst=0 load=0 d=0011 q=1100
clk=0 rst=0 load=0 d=1110 q=1100
clk=0 rst=0 load=0 d=0100 q=1100
clk=1 rst=0 load=0 d=0000 q=1000
clk=0 rst=0 load=0 d=0011 q=1000
clk=1 rst=0 load=0 d=1011 q=0000
clk=0 rst=0 load=0 d=0010 q=0000
clk=1 rst=0 load=0 d=0101 q=0000
INLINE CONSTRAINT(temporarly load data 10)
clk=1 rst=0 load=1 d=1010 q=1010
           V C S   S i m u l a t i o n   R e p o r t 
*/
