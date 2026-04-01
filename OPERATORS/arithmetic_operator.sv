module arithmetic_operator;
  reg  [3:0] a,b;
  int result;

  initial begin
    a=4'he;  
    b=4'hd;  
 
    $display(" DISPLAYING OPERANDS:");
    $display(" a=%0d \n b=%0d",a,b);

    
    $display(" =================ARITHMETIC OPERATORS=================");
    $display("OPERATORS COMMON TO VERILOG AND SYSTEM VERILOG");
    $display("a+b=%0d",a+b);
    $display("a-b=%0d",a-b);
    $display("a*b=%0d",a*b);
    $display("a/b=%0d",a/b);
    $display("a modulus b=%0d",a%b);
    result=a**b;
    $display("a Pow b=%0d",result);
    
    $display("NEW METHODS TO BE USED IN SYSTEM VERILOG:");
    a+=b;
    $display("(a+=b)=%0d",a);
    #1 a=4'he;b=4'hd;
    a-=b;
    $display("(a-=b)=%0d",a-b);
    #1 a=4'he;b=4'hd;
    a*=b;
    $display("(a*=b)=%0d",a*b);
    #1 a=4'he;b=4'hd;
    a/=b;
    $display("(a/=b)=%0d",a/b);
    #1 a=4'he;b=4'hd;
    a%=b;
    $display("(a modulus=b)=%0d",a%b);
    #1 $finish;
end
endmodule

/*
OUTPUT:
DISPLAYING OPERANDS:
 a=14 
 b=13
 =================ARITHMETIC OPERATORS=================
OPERATORS COMMON TO VERILOG AND SYSTEM VERILOG
a+b=11
a-b=1
a*b=6
a/b=1
a modulus b=1
a Pow b=521986048
NEW METHODS TO BE USED IN SYSTEM VERILOG:
(a+=b)=11
(a-=b)=4
(a*=b)=14
(a/=b)=0
(a modulus=b)=1
           V C S   S i m u l a t i o n   R e p o r t
*/
