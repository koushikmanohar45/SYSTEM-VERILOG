module if_else();
  logic signed [7:0]a,b,c;
  logic signed [7:0]max;

  function nothing();
     begin
       $display("DISPLAYING OPERANDS:");
       $display(" A=%0d \n B=%0d \n C=%0d",a,b,c);
       if(a>b && a>c)begin
         $display("A is greatest");
         max=a;
       end
       else if(b>a && b>c)begin
         $display("B is greatest");
         max=b;
       end
      else if(a==b)begin
       $display("A and B  are equal");
         max=a;
       end
      else if(a==c)begin
         $display("A and c are equal");
         max=a;
       end
       else begin
         $display("c is greatest");
         max=c;
       end
       $display(" GREATEST NUMBER=%0d",max);
       $display("------------------------------------------------------");
     end
  endfunction

    initial begin
    a=-10;b=20;c=15;
    $display("================= GREATEST OF THREE =================");
    nothing();
    #1 a=5;b=-2;c=8;  
    nothing();
    #1 a=12;b=12;c=16;  
    nothing();
    #1 a=7;b=9;c=9;
    nothing();
    #1 a=-25;b=35;c=-25;
    nothing(); 
      #1 a=25;b=15;c=5;
    nothing(); 
    #1 $finish;
end
endmodule
/*
OUTPUT:
================= GREATEST OF THREE =================
DISPLAYING OPERANDS:
 A=-10 
 B=20 
 C=15
B is greatest
 GREATEST NUMBER=20
------------------------------------------------------
DISPLAYING OPERANDS:
 A=5 
 B=-2 
 C=8
c is greatest
 GREATEST NUMBER=8
------------------------------------------------------
DISPLAYING OPERANDS:
 A=12 
 B=12 
 C=16
A and B  are equal
 GREATEST NUMBER=12
------------------------------------------------------
DISPLAYING OPERANDS:
 A=7 
 B=9 
 C=9
c is greatest
 GREATEST NUMBER=9
------------------------------------------------------
DISPLAYING OPERANDS:
 A=-25 
 B=35 
 C=-25
B is greatest
 GREATEST NUMBER=35
------------------------------------------------------
DISPLAYING OPERANDS:
 A=25 
 B=15 
 C=5
A is greatest
 GREATEST NUMBER=25
------------------------------------------------------
$finish called from file "testbench.sv", line 48.
$finish at simulation time                    6
           V C S   S i m u l a t i o n   R e p o r t 
*/
