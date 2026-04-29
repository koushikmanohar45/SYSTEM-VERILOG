class cons;
  rand logic [4:0]a;
  rand int b;
  rand int c;
  rand int d;
  
  constraint c1{ 
    a inside {[1:30]};
    a%3==0;
              }
  constraint c2{ b>10; b<50;}
  
  constraint c3{c!=d;}
  
  constraint c4{d%10==0;}
  
  task display();
    $display("a=%0d b=%0d c=%0d d=%0d ",a,b,c,d);
endtask
  
endclass

class override extends cons;
  rand logic  e;
  constraint c5{e dist{1:=5,0:/5};}
  constraint c2{b inside{5,2,13,15,[17:20]};}
  constraint c3{c<b;}
   task display();
    $display("a=%0d b=%0d c=%0d d=%0d e=%0d", a,b,c,d,e);
  endtask
endclass
  

module constraint_block();
  cons c;
  override o;
  initial begin
    c=new();
    o=new();
    
    $display("-------------randomize with constraint in parent class-------------");
    repeat (5)begin
      c.randomize();
      c.display();
    end
    
    $display("---------randomize with constraint in overidden child class---------");
    repeat (5)begin
      o.randomize();
      o.display();
    end
  end
endmodule

/*
OUTPUT:
-------------randomize with constraint in parent class-------------
a=21 b=47 c=398732279 d=-1017729550 
a=12 b=12 c=721723916 d=656768890 
a=24 b=39 c=-1949033479 d=-1662807910 
a=9 b=30 c=1669783138 d=-2000428660 
a=6 b=27 c=1347785270 d=409979200 
---------randomize with constraint in overidden child class---------
a=30 b=20 c=-62110548 d=-1029445350 e=1
a=3 b=19 c=-453556083 d=-1967583240 e=0
a=21 b=17 c=-818881341 d=134251560 e=1
a=30 b=5 c=-1672119785 d=-218487410 e=0
a=15 b=2 c=-963023967 d=-200706490 e=0
           V C S   S i m u l a t i o n   R e p o r t 
*/
  
