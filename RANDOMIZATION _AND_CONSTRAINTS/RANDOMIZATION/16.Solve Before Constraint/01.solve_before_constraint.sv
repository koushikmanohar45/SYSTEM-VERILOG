class solve_before;
  rand bit [5:0]a,b;
  rand bit [1:0] e,f;
  rand bit [5:0] c,d;
  
  constraint c2{
                 solve a before b;
                 solve b before c;
                 solve c before d;
                 a<25;
                 b==a;
                 b>20;
                 c<a;
                 d<c;
               }
  
  constraint c1{
                 solve e before f;
    (e==2)->(f<1);
               }
  
endclass

class without_solve_before;
  rand bit [5:0]a,b;
  rand bit [1:0] e,f;
  rand bit [5:0] c,d;
  constraint c1{
    (e==2)->(f<1);
               }
  constraint c2{
                 a<25;
                 b==a;
                 b>20;
                 c<a;
                 d<c;
               }
endclass

module randomization;
  without_solve_before w;
  solve_before s;
  
  initial begin
    w=new();
    s=new();
    $display("without solve before constraint..............");
    $display("  constraint 1(20<a==b<25;a>c>d;)     constraint 2 {(e==2)->(f<2)}");
    repeat(20)begin
      w.randomize;
      $display("   A=%d   B=%d   C=%d   D=%d                E=%d    f=%d",w.a,w.b,w.c,w.d,w.e,w.f);
    end
    
    $display("");
    $display("using solve before constraint..............");
    $display("  constraint 1(20<a==b<25;a>c>d;)    constraint 2 {(e==2)->(f<2)}");
    repeat(20)begin
      s.randomize;
      $display("   A=%d   B=%d   C=%d   D=%d                E=%d    f=%d",s.a,s.b,s.c,s.d,s.e,s.f);
    end
  end
endmodule

/*
output:
without solve before constraint..............
  constraint 1(20<a==b<25;a>c>d;)     constraint 2 {(e==2)->(f<2)}
   A=21   B=21   C=11   D= 1                E=3    f=1
   A=24   B=24   C= 7   D= 3                E=1    f=1
   A=22   B=22   C=10   D= 6                E=3    f=0
   A=21   B=21   C=16   D= 1                E=1    f=0
   A=23   B=23   C=16   D= 6                E=0    f=1
   A=22   B=22   C=20   D= 4                E=1    f=1
   A=23   B=23   C=13   D= 8                E=0    f=2
   A=24   B=24   C=23   D=21                E=0    f=3
   A=23   B=23   C=21   D=11                E=1    f=0
   A=22   B=22   C=14   D= 4                E=3    f=1
   A=22   B=22   C=11   D= 2                E=3    f=3
   A=24   B=24   C= 9   D= 6                E=0    f=1
   A=23   B=23   C=17   D= 0                E=0    f=3
   A=24   B=24   C=23   D=15                E=3    f=1
   A=24   B=24   C=18   D= 9                E=1    f=2
   A=22   B=22   C=20   D= 7                E=1    f=0
   A=21   B=21   C=13   D=12                E=1    f=2
   A=21   B=21   C=17   D= 1                E=1    f=0
   A=22   B=22   C=21   D=13                E=2    f=0
   A=23   B=23   C=21   D=15                E=1    f=0

using solve before constraint..............
  constraint 1(20<a==b<25;a>c>d;)    constraint 2 {(e==2)->(f<2)}
   A=23   B=23   C=19   D=10                E=3    f=0
   A=21   B=21   C= 4   D= 1                E=1    f=0
   A=24   B=24   C= 9   D= 2                E=0    f=0
   A=23   B=23   C=18   D= 7                E=3    f=3
   A=23   B=23   C=15   D= 3                E=3    f=3
   A=21   B=21   C=12   D= 7                E=0    f=1
   A=24   B=24   C= 9   D= 8                E=0    f=2
   A=21   B=21   C=19   D=16                E=3    f=3
   A=23   B=23   C=22   D=21                E=2    f=0
   A=24   B=24   C=13   D= 6                E=2    f=0
   A=24   B=24   C= 7   D= 5                E=1    f=2
   A=24   B=24   C= 5   D= 3                E=1    f=2
   A=22   B=22   C= 9   D= 7                E=1    f=0
   A=24   B=24   C=22   D= 8                E=1    f=2
   A=23   B=23   C=11   D= 8                E=3    f=1
   A=22   B=22   C=19   D=11                E=1    f=0
   A=22   B=22   C=11   D= 6                E=2    f=0
   A=23   B=23   C=11   D= 1                E=3    f=1
   A=22   B=22   C= 4   D= 0                E=3    f=2
   A=22   B=22   C=13   D=10                E=0    f=1
           V C S   S i m u l a t i o n   R e p o r t 
*/
