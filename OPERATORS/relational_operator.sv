module relational_operator;
  reg  [3:0] a,b;

  task automatic display();
     begin
       $display(" DISPLAYING OPERANDS:");
       $display(" a=%0d \n b=%0d",a,b);
       $display("a>b=%0d",a>b);
       $display("a<b=%0d",a<b);
       $display("a>=b=%0d",a>=b);
       $display("a<=b=%0d",a<=b);
       $display("a==b=%0d",a==b);
       $display("a!=b=%0d",a!=b);
       $display("------------------------------------------------------");
     end
  endtask
    
  initial begin
    a=4'he;b=4'hd; 
    $display("=================RELATIONAL OPERATORS=================");  
    display();
    #1 a=4'ha;b=4'ha;  
    display();
    #1 a=4'h1;b=4'h4;  
    display();
    #1 $finish;
end

endmodule


/*
OUTPUT:
=================RELATIONAL OPERATORS=================
 DISPLAYING OPERANDS:
 a=14 
 b=13
a>b=1
a<b=0
a>=b=1
a<=b=0
a==b=0
a!=b=1
------------------------------------------------------
 DISPLAYING OPERANDS:
 a=10 
 b=10
a>b=0
a<b=0
a>=b=1
a<=b=1
a==b=1
a!=b=0
------------------------------------------------------
 DISPLAYING OPERANDS:
 a=1 
 b=4
a>b=0
a<b=1
a>=b=0
a<=b=1
a==b=0
a!=b=1
------------------------------------------------------
$finish called from file "testbench.sv", line 27.
$finish at simulation time                    3
           V C S   S i m u l a t i o n   R e p o r t 
*/
