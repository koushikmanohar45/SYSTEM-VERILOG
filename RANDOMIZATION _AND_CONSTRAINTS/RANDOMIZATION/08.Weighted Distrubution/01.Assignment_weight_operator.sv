/*
Generate: READ → 70% WRITE → 30%

Generate: RED → 50%  YELLOW → 20%  GREEN → 30%
*/

//wite constraint for follwing spec

// i) Generate "a": 0 → 70%  1 → 30%

//ii) Generate packet sizes (b): small (1–64) → 60%  medium (65–512) → 30%  large (513–1500) → 10%


class w_d;
  rand bit read_enable;
  rand bit [1:0] colour;
  
  constraint c1 {
    read_enable dist {0:=3,1:=7};
    colour dist{1:=5,     /* red->50% */
                2:=2,     /* yellow->20% */
                3:=3};    /* green->30% */
                }
  
endclass

class w_d1 extends w_d;
  task display();
    begin
      $display("a=%0d b=%0d",read_enable,colour);
      $display(" ");
    end
  endtask
endclass

module weighted_disribution_constraint();
  
  w_d1 d;
  initial begin
    d=new();
    for(int i=0;i<20;i++)begin
      d.randomize();
      d.display();
    end
  end
endmodule


/*
OUTPUT:

a=1 b=3
 
a=1 b=2
 
a=0 b=3
 
a=1 b=1
 
a=0 b=3
 
a=1 b=1
 
a=1 b=2
 
a=1 b=1
 
a=0 b=1
 
a=0 b=3
 
a=1 b=1
 
a=1 b=2
 
a=1 b=1
 
a=1 b=2
 
a=0 b=1
 
a=0 b=2
 
a=0 b=2
 
a=1 b=1
 
a=1 b=3
 
a=1 b=1
 
           V C S   S i m u l a t i o n   R e p o r t 
*/
