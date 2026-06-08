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
    // Calling function with variables as arguments
    result=a1.operation(a1.a,a1.b,"ADD");
    $display("ADD RESULT=%0d",result);

    result=a1.operation(a1.a,a1.b,"SUB");
    $display("SUB RESULT=%0d",result);

    result=a1.operation(a1.a,a1.b,"MUL");
    $display("MUL RESULT=%0d",result);

    result=a1.operation(a1.a,a1.b,"DIV");
    $display("DIV RESULT=%0d",result);
    
  end

endmodule

/*
output:

a=1 b=0
ADD RESULT=1
a=1 b=0
SUB RESULT=1
a=1 b=0
MUL RESULT=0
a=1 b=0
DIVIDE BY ZERO ERROR
DIV RESULT=0
           V C S   S i m u l a t i o n   R e p o r t 
*/
