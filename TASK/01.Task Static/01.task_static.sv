class alu;
  
  rand bit[7:0] a,b;
  bit out;
  task static operation
  (
    input int a,
    input int b,
    input string opcode,
    output int test,
    output int out
    
  );
    
    test=test+1;
    $display("==========================");
    $display("test.no=%0d",test);
    $display("==========================");
    $display("a=%0d b=%0d",a,b);
    

    case(opcode)

      "ADD":out=a+b;
      "SUB":out=a-b;
      "MUL":out=a*b;
      "DIV":begin
                if(b==0) begin
                  $display("DIVIDE BY ZERO ERROR");
                end
                else
                  out=a/b;
              end
      default:begin
                  $display("INVALID OPCODE");
                end
    endcase
  endtask
endclass



module test;

  alu a1;

  int result;
  int test;

  initial begin
    
    a1=new();
    a1.randomize();
    a1.operation(a1.a,a1.b,"ADD",test,a1.out);
    // Calling function with arguments from an expression
    $display("ADD RESULT=%0d",a1.out);
    
    a1.operation(a1.a,a1.b,"SUB",test,a1.out);   
    $display("SUB RESULT=%0d",a1.out);
    
    a1.operation(a1.a,a1.b,"MUL",test,a1.out);
    $display("MUL RESULT=%0d",a1.out);
    
    a1.operation(a1.a,a1.b,"DIV",test,a1.out);
    $display("DIV RESULT=%0d",a1.out );
    
  end

endmodule

/*
OUTPUT:
==========================
test.no=1
==========================
a=185 b=108
ADD RESULT=1
==========================
test.no=2
==========================
a=185 b=108
SUB RESULT=1
==========================
test.no=3
==========================
a=185 b=108
MUL RESULT=0
==========================
test.no=4
==========================
a=185 b=108
DIV RESULT=1
           V C S   S i m u l a t i o n   R e p o r t 
*/
