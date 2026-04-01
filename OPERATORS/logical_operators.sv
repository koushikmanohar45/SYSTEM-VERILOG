module logical_operator;
  reg  [3:0] a,b;

  task automatic display();
     begin
       $display("DISPLAYING OPERANDS:");
       $display(" a=%B \n b=%B",a,b);
       $display("OPERATORS COMMON TO VERILOG AND SYSTEM VERILOG");
       $display(" a&&b=%B",a&&b);
       $display(" a||b=%B",a||b);
       $display(" !a=%B",!a);
       $display("NEW OPERATORS USED IN SYSTEM-VERILOG");
       $display(" a->b(!a||b)=%B",a->b);
       $display(" a<->b((!a||b)&&(a||!b))=%B",a<->b);
       $display("------------------------------------------------------");
     end
  endtask
    
  initial begin
    a=4'he;b=4'hd; 
    $display("================= LOGICAL OPERATORS =================");
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
================= LOGICAL OPERATORS =================
DISPLAYING OPERANDS:
 a=1110 
 b=1101
OPERATORS COMMON TO VERILOG AND SYSTEM VERILOG
 a&&b=1
 a||b=1
 !a=0
NEW OPERATORS USED IN SYSTEM-VERILOG
 a->b(!a||b)=1
 a<->b((!a||b)&&(a||!b))=1
------------------------------------------------------
DISPLAYING OPERANDS:
 a=0000 
 b=1010
OPERATORS COMMON TO VERILOG AND SYSTEM VERILOG
 a&&b=0
 a||b=1
 !a=1
NEW OPERATORS USED IN SYSTEM-VERILOG
 a->b(!a||b)=1
 a<->b((!a||b)&&(a||!b))=0
------------------------------------------------------
DISPLAYING OPERANDS:
 a=0001 
 b=0000
OPERATORS COMMON TO VERILOG AND SYSTEM VERILOG
 a&&b=0
 a||b=1
 !a=0
NEW OPERATORS USED IN SYSTEM-VERILOG
 a->b(!a||b)=0
 a<->b((!a||b)&&(a||!b))=0
------------------------------------------------------
DISPLAYING OPERANDS:
 a=1111 
 b=0010
OPERATORS COMMON TO VERILOG AND SYSTEM VERILOG
 a&&b=1
 a||b=1
 !a=0
NEW OPERATORS USED IN SYSTEM-VERILOG
 a->b(!a||b)=1
 a<->b((!a||b)&&(a||!b))=1
------------------------------------------------------
DISPLAYING OPERANDS:
 a=1111 
 b=0000
OPERATORS COMMON TO VERILOG AND SYSTEM VERILOG
 a&&b=0
 a||b=1
 !a=0
NEW OPERATORS USED IN SYSTEM-VERILOG
 a->b(!a||b)=0
 a<->b((!a||b)&&(a||!b))=0
------------------------------------------------------
$finish called from file "testbench.sv", line 34.
$finish at simulation time                    5
           V C S   S i m u l a t i o n   R e p o r t 
*/
