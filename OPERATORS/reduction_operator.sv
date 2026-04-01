module reduction_operator;
  bit  [3:0] a;

  task automatic display();
     begin
       $display("DISPLAYING OPERANDS:");
       $display(" a=%B ",a);
       $display("&a=%b",&a);
       $display("|a=%b",|a); 
       $display("^a=%b",^a); 
       $display("~&a=%b",~&a); 
       $display("~|a=%b",~|a);
       $display("^a=%b",~^a); 
       $display("------------------------------------------------------");
     end
  endtask
    
  initial begin
    a=4'he; 
    $display("================= REDUCTION OPERATORS =================");
    display();
    #1 a=4'h8; 
    display();
    #1 a=4'h1;  
    display();
    #1 a=4'ha;
    display();
    #1 a=4'hf;
    display();
    #1 $finish;
end

endmodule

/*
OUTPUT:
================= REDUCTION OPERATORS =================
DISPLAYING OPERANDS:
 a=1110 
&a=0
|a=1
^a=1
~&a=1
~|a=0
^a=0
------------------------------------------------------
DISPLAYING OPERANDS:
 a=1000 
&a=0
|a=1
^a=1
~&a=1
~|a=0
^a=0
------------------------------------------------------
DISPLAYING OPERANDS:
 a=0001 
&a=0
|a=1
^a=1
~&a=1
~|a=0
^a=0
------------------------------------------------------
DISPLAYING OPERANDS:
 a=1010 
&a=0
|a=1
^a=0
~&a=1
~|a=0
^a=1
------------------------------------------------------
DISPLAYING OPERANDS:
 a=1111 
&a=1
|a=1
^a=0
~&a=0
~|a=0
^a=1
------------------------------------------------------
$finish called from file "testbench.sv", line 31.
$finish at simulation time                    5
           V C S   S i m u l a t i o n   R e p o r t 
*/
