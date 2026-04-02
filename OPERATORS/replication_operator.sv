module replication_operator;
  logic [7:0]a,b;
  logic [31:0]c;

  task automatic display();
     begin
       $display("DISPLAYING OPERANDS:");
       $display(" a=%B \n b=%B",a,b);
       $display("REPLICATION OPERATORS");
       c={4{a}};
       $display(" {4{a}}=%B",c);
       $display(" {2{b}}=%B",{2{b}});
       $display(" {2{a[3:0]}}=%B",{2{a[3:0]}});
       $display("------------------------------------------------------");
     end
  endtask
    
  initial begin
    a=8'he;b=8'hd;
    $display("================= REPLICATION OPERATORS =================");
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
================= REPLICATION OPERATORS =================
DISPLAYING OPERANDS:
 a=00001110 
 b=00001101
REPLICATION OPERATORS
 {4{a}}=00001110000011100000111000001110
 {2{b}}=0000110100001101
 {2{a[3:0]}}=11101110
------------------------------------------------------
DISPLAYING OPERANDS:
 a=00000011 
 b=00000111
REPLICATION OPERATORS
 {4{a}}=00000011000000110000001100000011
 {2{b}}=0000011100000111
 {2{a[3:0]}}=00110011
------------------------------------------------------
DISPLAYING OPERANDS:
 a=00000001 
 b=00000000
REPLICATION OPERATORS
 {4{a}}=00000001000000010000000100000001
 {2{b}}=0000000000000000
 {2{a[3:0]}}=00010001
------------------------------------------------------
DISPLAYING OPERANDS:
 a=11111111 
 b=00001100
REPLICATION OPERATORS
 {4{a}}=11111111111111111111111111111111
 {2{b}}=0000110000001100
 {2{a[3:0]}}=11111111
------------------------------------------------------
DISPLAYING OPERANDS:
 a=11001000 
 b=00000001
REPLICATION OPERATORS
 {4{a}}=11001000110010001100100011001000
 {2{b}}=0000000100000001
 {2{a[3:0]}}=10001000
------------------------------------------------------
DISPLAYING OPERANDS:
 a=11001000 
 b=11001000
REPLICATION OPERATORS
 {4{a}}=11001000110010001100100011001000
 {2{b}}=1100100011001000
 {2{a[3:0]}}=10001000
------------------------------------------------------
DISPLAYING OPERANDS:
 a=00001100 
 b=00000000
REPLICATION OPERATORS
 {4{a}}=00001100000011000000110000001100
 {2{b}}=0000000000000000
 {2{a[3:0]}}=11001100
------------------------------------------------------
$finish called from file "testbench.sv", line 34.
$finish at simulation time                    7
           V C S   S i m u l a t i o n   R e p o r t 
*/
