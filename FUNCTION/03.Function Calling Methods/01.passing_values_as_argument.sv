class alu;

  function int operation
  (
    input int a,
    input int b,
    input string opcode
  );

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
    // Calling function with values as arguments
    result=a1.operation(20,10,"ADD");
    $display("ADD RESULT=%0d",result);

    result=a1.operation(50,15,"SUB");
    $display("SUB RESULT=%0d",result);

    result=a1.operation(5,4,"MUL");
    $display("MUL RESULT=%0d",result);

    result=a1.operation(100,5,"DIV");
    $display("DIV RESULT=%0d",result);
  end

endmodule

/*
output:
ADD RESULT=30
SUB RESULT=35
MUL RESULT=20
DIV RESULT=20
           V C S   S i m u l a t i o n   R e p o r t 
*/
