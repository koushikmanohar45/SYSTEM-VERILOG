module concatenation_operator;
  logic [7:0]a,b;
  logic [15:0]c;

  task automatic display();
     begin
       $display("DISPLAYING OPERANDS:");
       $display(" a=%B \n b=%B",a,b);
       $display("CONCATENATION OPERATORS");
       c={a,b};
       $display(" {a,b}=%B",c);
       $display(" {b,a}=%B",{b,a});
       $display(" {a[3:0],b[7:4]}=%B",{a[3:0],b[7:4]});
       $display("------------------------------------------------------");
     end
  endtask
    
  initial begin
    a=8'he;b=8'hd;
    $display("================= CONCATENATION OPERATORS =================");
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
================= CONCATENATION OPERATORS =================
DISPLAYING OPERANDS:
 a=00001110 
 b=00001101
CONCATENATION OPERATORS
 {a,b}=0000111000001101
 {b,a}=0000110100001110
 {a[3:0],b[7:4]}=11100000
------------------------------------------------------
DISPLAYING OPERANDS:
 a=00000011 
 b=00000111
CONCATENATION OPERATORS
 {a,b}=0000001100000111
 {b,a}=0000011100000011
 {a[3:0],b[7:4]}=00110000
------------------------------------------------------
DISPLAYING OPERANDS:
 a=00000001 
 b=00000000
CONCATENATION OPERATORS
 {a,b}=0000000100000000
 {b,a}=0000000000000001
 {a[3:0],b[7:4]}=00010000
------------------------------------------------------
DISPLAYING OPERANDS:
 a=11111111 
 b=00001100
CONCATENATION OPERATORS
 {a,b}=1111111100001100
 {b,a}=0000110011111111
 {a[3:0],b[7:4]}=11110000
------------------------------------------------------
DISPLAYING OPERANDS:
 a=11001000 
 b=00000001
CONCATENATION OPERATORS
 {a,b}=1100100000000001
 {b,a}=0000000111001000
 {a[3:0],b[7:4]}=10000000
------------------------------------------------------
DISPLAYING OPERANDS:
 a=11001000 
 b=11001000
CONCATENATION OPERATORS
 {a,b}=1100100011001000
 {b,a}=1100100011001000
 {a[3:0],b[7:4]}=10001100
------------------------------------------------------
DISPLAYING OPERANDS:
 a=00001100 
 b=00000000
CONCATENATION OPERATORS
 {a,b}=0000110000000000
 {b,a}=0000000000001100
 {a[3:0],b[7:4]}=11000000
------------------------------------------------------
$finish called from file "testbench.sv", line 34.
$finish at simulation time                    7
           V C S   S i m u l a t i o n   R e p o r t
*/
