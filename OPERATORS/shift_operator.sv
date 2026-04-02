module shift_operator;
  logic signed [7:0]a,b;

  task automatic display();
     begin
       $display("DISPLAYING OPERANDS:");
       $display(" a=%B \n b=%B",a,b);
       $display("OPERATORS COMMON TO VERILOG AND SYSTEM VERILOG");
       $display(" a<<<b(arithmetic left shift)=%B",a<<<b);
       $display(" a>>>b(arithmetic right shift)=%B",a>>>b);
       $display(" a<<b(logical left shift)=%B",a<<b);
       $display(" a>>b(logical right shift)=%B",a>>b);
       $display("------------------------------------------------------");
     end
  endtask
    
  initial begin
    a=8'he;b=4'b1;
    $display("================= LOGICAL OPERATORS =================");
    display();
    #1 a=8'b11;b=8'b0111;  
    display();
    #1 a=8'd1;b=8'd0;  
    display();
    #1 a=8'd255;b=8'd12;
    display();
    #1 a=8'd200;b=8'd1;
    display(); 
    #1 a=8'd200;b=8'd200;
    display();
    #1 a=8'd12;b=8'd0;
    display();
    #1 $finish;
end
endmodule

/*
OUTPUT:
================= LOGICAL OPERATORS =================
DISPLAYING OPERANDS:
 a=00001110 
 b=00000001
OPERATORS COMMON TO VERILOG AND SYSTEM VERILOG
 a<<<b(arithmetic left shift)=00011100
 a>>>b(arithmetic right shift)=00000111
 a<<b(logical left shift)=00011100
 a>>b(logical right shift)=00000111
------------------------------------------------------
DISPLAYING OPERANDS:
 a=00000011 
 b=00000111
OPERATORS COMMON TO VERILOG AND SYSTEM VERILOG
 a<<<b(arithmetic left shift)=10000000
 a>>>b(arithmetic right shift)=00000000
 a<<b(logical left shift)=10000000
 a>>b(logical right shift)=00000000
------------------------------------------------------
DISPLAYING OPERANDS:
 a=00000001 
 b=00000000
OPERATORS COMMON TO VERILOG AND SYSTEM VERILOG
 a<<<b(arithmetic left shift)=00000001
 a>>>b(arithmetic right shift)=00000001
 a<<b(logical left shift)=00000001
 a>>b(logical right shift)=00000001
------------------------------------------------------
DISPLAYING OPERANDS:
 a=11111111 
 b=00001100
OPERATORS COMMON TO VERILOG AND SYSTEM VERILOG
 a<<<b(arithmetic left shift)=00000000
 a>>>b(arithmetic right shift)=11111111
 a<<b(logical left shift)=00000000
 a>>b(logical right shift)=00000000
------------------------------------------------------
DISPLAYING OPERANDS:
 a=11001000 
 b=00000001
OPERATORS COMMON TO VERILOG AND SYSTEM VERILOG
 a<<<b(arithmetic left shift)=10010000
 a>>>b(arithmetic right shift)=11100100
 a<<b(logical left shift)=10010000
 a>>b(logical right shift)=01100100
------------------------------------------------------
DISPLAYING OPERANDS:
 a=11001000 
 b=11001000
OPERATORS COMMON TO VERILOG AND SYSTEM VERILOG
 a<<<b(arithmetic left shift)=00000000
 a>>>b(arithmetic right shift)=11111111
 a<<b(logical left shift)=00000000
 a>>b(logical right shift)=00000000
------------------------------------------------------
DISPLAYING OPERANDS:
 a=00001100 
 b=00000000
OPERATORS COMMON TO VERILOG AND SYSTEM VERILOG
 a<<<b(arithmetic left shift)=00001100
 a>>>b(arithmetic right shift)=00001100
 a<<b(logical left shift)=00001100
 a>>b(logical right shift)=00001100
------------------------------------------------------
$finish called from file "testbench.sv", line 33.
$finish at simulation time                    7
           V C S   S i m u l a t i o n   R e p o r t 
*/
