class cons;
  rand logic [3:0]a;
  rand int b;
  rand int c;
  rand int d;
  
  //Generate multiples of 3 between 1 and 30
  constraint c1{ 
                 a inside {[1:30]};
                 a%3==0;
               }
  constraint c2{ b>10; b<50;}
  
  constraint c3{c!=d;}
  
  constraint c4{a<b;b<c;c<d;}
  
  constraint c5{d%10==0;}
  
  //task outside class
  extern task display();
  
endclass

task cons::display();
  $display("a=%0d b=%0d c=%0d d=%0d",a,b,c,d);
endtask

module constraint_block();
  cons c;
  initial begin
    c=new();
    repeat (5)begin
    c.randomize();
      c.display();
    end
  end
endmodule
  

/*
OUTPUT:
a=15 b=40 c=613177540 d=1763097920
a=9 b=48 c=778963705 d=929741380
a=15 b=18 c=13038946 d=1230094040
a=9 b=22 c=574092710 d=655961190
a=3 b=13 c=135674203 d=538539450
           V C S   S i m u l a t i o n   R e p o r t 
*/
