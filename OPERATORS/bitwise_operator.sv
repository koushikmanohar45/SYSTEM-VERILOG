module bitwise_operator;
  reg  [3:0] a,b;

  task automatic display();
     begin
       $display("DISPLAYING OPERANDS:");
       $display(" a=%B \n b=%B",a,b);
       $display("a&b=%b",a&b);
       $display("~(a&b)=%b",~(a&b));
       $display("a|b=%b",a|b);
       $display("~(a|b)=%b",~(a|b));
       $display("a^b=%b",a^b);
       $display("~(a^b)=%b",~(a^b));
       $display("~a=%b",~a);
       $display("------------------------------------------------------");
     end
  endtask
    
  initial begin
    a=4'he;b=4'hd; 
    $display("================= BITWISE OPERATORS =================");
    display();
    #1 a=4'h0;b=4'ha;  
    display();
    #1 a=4'h1;b=4'h0;  
    display();
    #1 a=4'hf;b=4'h2;
    display();
    #1 a=4'hf;b=4'h0;
    display();
    #1 $finish;
end
endmodule

/*
OUTPUT:
================= BITWISE OPERATORS =================
DISPLAYING OPERANDS:
 a=1110 
 b=1101
a&b=1100
~(a&b)=0011
a|b=1111
~(a|b)=0000
a^b=0011
~(a^b)=1100
~a=0001
------------------------------------------------------
DISPLAYING OPERANDS:
 a=0000 
 b=1010
a&b=0000
~(a&b)=1111
a|b=1010
~(a|b)=0101
a^b=1010
~(a^b)=0101
~a=1111
------------------------------------------------------
DISPLAYING OPERANDS:
 a=0001 
 b=0000
a&b=0000
~(a&b)=1111
a|b=0001
~(a|b)=1110
a^b=0001
~(a^b)=1110
~a=1110
------------------------------------------------------
DISPLAYING OPERANDS:
 a=1111 
 b=0010
a&b=0010
~(a&b)=1101
a|b=1111
~(a|b)=0000
a^b=1101
~(a^b)=0010
~a=0000
------------------------------------------------------
DISPLAYING OPERANDS:
 a=1111 
 b=0000
a&b=0000
~(a&b)=1111
a|b=1111
~(a|b)=0000
a^b=1111
~(a^b)=0000
~a=0000
------------------------------------------------------
$finish called from file "testbench.sv", line 32.
$finish at simulation time                    5
           V C S   S i m u l a t i o n   R e p o r t 
*/
