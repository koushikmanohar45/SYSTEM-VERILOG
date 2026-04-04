module unique_if_else();
  logic signed [7:0]a,b,c;
  logic signed [7:0]max;

  function void nothing();
     begin
       $display("DISPLAYING OPERANDS:");
       $display(" A=%0d \n B=%0d \n C=%0d",a,b,c);
    unique if(~a[7] && ~b[7] && ~c[7])begin
       unique if(a>b && a>c)begin
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
    end
       $display(" GREATEST NUMBER=%0d",max);
       $display("------------------------------------------------------");
     end
  endfunction

    initial begin
    a=-10;b=20;c=15;
    $display("================= GREATEST OF THREE =================");
    $display("NONE OF CONDITION IS TRUE");
    nothing();
    #1 a=5;b=-2;c=8; 
    $display("NONE OF CONDITION IS TRUE");
    nothing();
    #1 a=12;b=12;c=16;  
    nothing();
    #1 a=7;b=9;c=9;
    nothing();
    #1 a=25;b=35;c=25;
      $display("MORE THAN ONE CONDITION TRUE");
    nothing(); 
    #1 a=25;b=15;c=5;
    nothing(); 
    #1 $finish;
end
endmodule



/*
OUTPUT:
================= GREATEST OF THREE =================
NONE OF CONDITION IS TRUE
DISPLAYING OPERANDS:
 A=-10 
 B=20 
 C=15

Warning-[RT-NCMUIF] No condition matches in statement
testbench.sv, 9
  No condition matches in 'unique if' statement. 'else' statement is missing 
  for the last 'else if' block, inside unique_if_else.nothing, at time 0ns.

 GREATEST NUMBER=x
------------------------------------------------------
NONE OF CONDITION IS TRUE
DISPLAYING OPERANDS:
 A=5 
 B=-2 
 C=8

Warning-[RT-NCMUIF] No condition matches in statement
testbench.sv, 9
  No condition matches in 'unique if' statement. 'else' statement is missing 
  for the last 'else if' block, inside unique_if_else.nothing, at time 1ns.

 GREATEST NUMBER=x
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
MORE THAN ONE CONDITION TRUE
DISPLAYING OPERANDS:
 A=25 
 B=35 
 C=25
B is greatest

Warning-[RT-MTOCMUIF] More than one condition match in statement
testbench.sv, 10
  More than one condition matches are found in 'unique if' statement inside 
  unique_if_else.nothing, at time 4ns.
  
  Line number 14 and 22 are overlapping.

 GREATEST NUMBER=35
------------------------------------------------------
DISPLAYING OPERANDS:
 A=25 
 B=15 
 C=5
A is greatest
 GREATEST NUMBER=25
------------------------------------------------------
$finish called from file "testbench.sv", line 53.
$finish at simulation time                    6
           V C S   S i m u l a t i o n   R e p o r t 
*/
