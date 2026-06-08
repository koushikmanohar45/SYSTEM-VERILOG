class alu;
  
  rand bit a,b;
  function int operation
  (
    input int a,
    input int b,
    input string opcode
  );
    $display("a=%0d b=%0d",a,b);

    case(opcode)

      "ADD":return a+b;
      "SUB":return a-b;
      "MUL":return a*b;
      "DIV":begin
                if(b==0) begin
                  $display("DIVIDE BY ZERO ERROR");
                  return 0;
                end
                else
                  return a/b;
              end
      default:begin
                  $display("INVALID OPCODE");
                  return -1;
                end
    endcase
  endfunction
endclass


module test;

  alu a1;

  int result;

  initial begin
    
    a1=new();
    a1.randomize();
    // Calling function with values from an expression
    $display("ADD RESULT=%0d",a1.operation(5,7,"ADD"));

    $display("SUB RESULT=%0d",a1.operation(8,10,"SUB"));

    $display("MUL RESULT=%0d",a1.operation(12,12,"MUL"));

    $display("DIV RESULT=%0d",a1.operation(3,10,"DIV"));
    
  end

endmodule

/*
output:
a=5 b=7
ADD RESULT=12
a=8 b=10
SUB RESULT=-2
a=12 b=12
MUL RESULT=144
a=3 b=10
DIV RESULT=0
           V C S   S i m u l a t i o n   R e p o r t 
*/
