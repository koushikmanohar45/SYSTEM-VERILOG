//wite constraint for follwing spec

// i) Generate "a": 0 → 70%  1 → 30%

//ii) Generate packet sizes (b): small (1–64) → 60%  medium (65–512) → 30%  large (513–1500) → 10%


class w_d;
  rand bit a;
  rand int b;
  
  constraint c1 {
    a dist {0:/4,1:/1};
    b dist{[1:64]:/6,[65:512]:/3,[513:1500]:/1};
                }
  
endclass

class w_d1 extends w_d;
  task display();
    begin
      $display("a=%0d b=%0d",a,b);
      $display(" ");
    end
  endtask
endclass

module weighted_disribution_constraint();
  
  w_d1 d;
  initial begin
    d=new();
    for(int i=0;i<10;i++)begin
      d.randomize();
      d.display();
    end
  end
endmodule


/*
OUTPUT

a=0 b=294
 
a=1 b=12
 
a=0 b=385
 
a=0 b=275
 
a=0 b=21
 
a=0 b=424
 
a=0 b=17
 
a=1 b=243
 
a=0 b=44
 
a=0 b=585
*/
