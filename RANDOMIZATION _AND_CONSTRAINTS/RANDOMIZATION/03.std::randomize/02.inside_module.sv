module std_randomize;
  bit[3:0]a;
  byte b;
  int c;
  
  initial begin
    $display("==================================================");
    $display("                   STD::RANDOMIZE                       ");
    $display("==================================================");
    repeat(3)begin
      //scope randomize
      std::randomize(a);
      $display("std::randomize(a)=%0d",a);
      std::randomize(b);
      $display("std::randomize(b)=%0d",b);
      std::randomize(c);
      $display("std::randomize(c)=%0d",b);
      randomize(a);
      $display("randomize(a)=%0d",a);
      std::randomize(c,a);
      $display("std::randomize(c,a) a=%0d b=%0d c=%0d",a,b,c);
      $display("--------------------------------------------------");
      #10;
    end
  end
endmodule

/*
OUTPUT:
==================================================
                   STD::RANDOMIZE                       
==================================================
std::randomize(a)=14
std::randomize(b)=22
std::randomize(c)=22
randomize(a)=13
std::randomize(c,a) a=5 b=22 c=-1756719925
--------------------------------------------------
std::randomize(a)=13
std::randomize(b)=-44
std::randomize(c)=-44
randomize(a)=5
std::randomize(c,a) a=14 b=-44 c=-264816468
--------------------------------------------------
std::randomize(a)=13
std::randomize(b)=38
std::randomize(c)=38
randomize(a)=15
std::randomize(c,a) a=10 b=38 c=-1666528226
--------------------------------------------------
           V C S   S i m u l a t i o n   R e p o r t 
*/
