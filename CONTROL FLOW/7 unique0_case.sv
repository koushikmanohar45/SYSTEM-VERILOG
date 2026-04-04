module unique0_case();
  logic signed [7:0]a,b,c;
  logic signed [7:0]max;

  function void nothing();
     begin
       $display("DISPLAYING OPERANDS:");
       $display(" A=%0d \n B=%0d \n C=%0d",a,b,c);
    unique0 casex ({a>=b && a>=c , b>=a && b>=c})
       2'b10:begin
         $display("A is greatest");
         max=a;
       end
       2'b01:begin
         $display("B is greatest");
         max=b;
       end
       2'b11:begin
         $display("A B C are equal or two are equal and greatest");
         max=a;
       end
        2'b1x:begin
          $display("either A is greatest or A B C are equal or two are equal and greatest");
         max=a;
        end   
     endcase
       $display(" GREATEST NUMBER=%0d",max);
       $display("------------------------------------------------------");
     end
  endfunction

    initial begin
    b=20;c=25;
    $display("================= GREATEST OF THREE =================");
      $display("MORE THAN ONE CONDITION IS TRUE");
    nothing();
    #1 a=5;b=-2;c=8; 
    $display("NONE OF CONDITION IS TRUE");
    nothing();
    #1 a=12;b=22;c=16;  
    nothing();
    #1 a=7;b=9;c=9;
    nothing();
    #1 a=25;b=35;c=25;
    nothing(); 
    #1 a=25;b=15;c=5;
    $display("MORE THAN ONE CONDITION TRUE");
    nothing(); 
    #1 $finish;
end
endmodule
/*
OUTPUT:
================= GREATEST OF THREE =================
MORE THAN ONE CONDITION IS TRUE
DISPLAYING OPERANDS:
 A=x 
 B=20 
 C=25
A is greatest

Warning-[RT-MTOCMU0CS] More than one condition matches in statement
testbench.sv, 9
  Unique0 case statement inside CASE.nothing matches more than one condition 
  at time 0ns.
  
  Line numbers 10 and 22 match.

 GREATEST NUMBER=x
------------------------------------------------------
NONE OF CONDITION IS TRUE
DISPLAYING OPERANDS:
 A=5 
 B=-2 
 C=8
 GREATEST NUMBER=x
------------------------------------------------------
DISPLAYING OPERANDS:
 A=12 
 B=22 
 C=16
B is greatest
 GREATEST NUMBER=22
------------------------------------------------------
DISPLAYING OPERANDS:
 A=7 
 B=9 
 C=9
B is greatest
 GREATEST NUMBER=9
------------------------------------------------------
DISPLAYING OPERANDS:
 A=25 
 B=35 
 C=25
B is greatest
 GREATEST NUMBER=35
------------------------------------------------------
MORE THAN ONE CONDITION TRUE
DISPLAYING OPERANDS:
 A=25 
 B=15 
 C=5
A is greatest

Warning-[RT-MTOCMU0CS] More than one condition matches in statement
testbench.sv, 9
  Unique0 case statement inside CASE.nothing matches more than one condition 
  at time 5ns.
  
  Line numbers 10 and 22 match.

 GREATEST NUMBER=25
------------------------------------------------------
$finish called from file "testbench.sv", line 49.
$finish at simulation time                    6
           V C S   S i m u l a t i o n   R e p o r t 
*/
