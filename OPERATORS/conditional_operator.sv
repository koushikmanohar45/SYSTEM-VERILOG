module conditional_operator;
  logic signed [7:0]a,b;

  task automatic display();
     begin
       $display("DISPLAYING OPERANDS:");
       $display(" a=%0d \n b=%0d",a,b);
       $display(" (a>b)?a:b=%0d",(a>b)?a:b);
       $display(" (a<b)?a:b=%0d",(a<b)?a:b);
       $display(" (a==b)?a:b=%0d",(a==b)?a:b);
       $display(" (a!=b)?a:b=%0d",(a!=b)?a:b);
       $display("------------------------------------------------------");
     end
  endtask
    
  initial begin
    a=8'he;b=8'hd;
    $display("=================CONDITIONAL OPERATORS=================");
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
=================CONDITIONAL OPERATORS=================
DISPLAYING OPERANDS:
 a=14 
 b=13
 (a>b)?a:b=14
 (a<b)?a:b=13
 (a==b)?a:b=13
 (a!=b)?a:b=14
------------------------------------------------------
DISPLAYING OPERANDS:
 a=3 
 b=7
 (a>b)?a:b=7
 (a<b)?a:b=3
 (a==b)?a:b=7
 (a!=b)?a:b=3
------------------------------------------------------
DISPLAYING OPERANDS:
 a=1 
 b=0
 (a>b)?a:b=1
 (a<b)?a:b=0
 (a==b)?a:b=0
 (a!=b)?a:b=1
------------------------------------------------------
DISPLAYING OPERANDS:
 a=-1 
 b=12
 (a>b)?a:b=12
 (a<b)?a:b=-1
 (a==b)?a:b=12
 (a!=b)?a:b=-1
------------------------------------------------------
DISPLAYING OPERANDS:
 a=-56 
 b=1
 (a>b)?a:b=1
 (a<b)?a:b=-56
 (a==b)?a:b=1
 (a!=b)?a:b=-56
------------------------------------------------------
DISPLAYING OPERANDS:
 a=-56 
 b=-56
 (a>b)?a:b=-56
 (a<b)?a:b=-56
 (a==b)?a:b=-56
 (a!=b)?a:b=-56
------------------------------------------------------
DISPLAYING OPERANDS:
 a=12 
 b=0
 (a>b)?a:b=12
 (a<b)?a:b=0
 (a==b)?a:b=0
 (a!=b)?a:b=12
------------------------------------------------------
$finish called from file "testbench.sv", line 33.
$finish at simulation time                    7
           V C S   S i m u l a t i o n   R e p o r t 
*/
