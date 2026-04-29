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
  
  extern constraint c3;
  
  extern constraint c4;
  
  task display();
      $display("a=%0d b=%0d c=%0d d=%0d",a,b,c,d);
  endtask
  
endclass

//declaring constraint outside class
constraint cons:: c3 {c<0;}

constraint cons:: c4 { d inside {[1:100]};
                       d%10==0;
                     }


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
a=9 b=47 c=-2007861365 d=40
a=6 b=12 c=-68830052 d=70
a=12 b=39 c=-1496389642 d=30
a=6 b=30 c=-1599005221 d=10
a=3 b=27 c=-642024307 d=70
           V C S   S i m u l a t i o n   R e p o r t 
*/
  
