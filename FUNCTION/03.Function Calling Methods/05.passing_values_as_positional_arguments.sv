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
    result=a1.operation(.a(20),.b(10),.opcode("ADD"));
    $display("ADD RESULT=%0d",result);

    result=a1.operation(.a(50),.b(15),.opcode("SUB"));
    $display("SUB RESULT=%0d",result);

    result=a1.operation(.a(5),.b(4),.opcode("MUL"));
    $display("MUL RESULT=%0d",result);

    result=a1.operation(.a(100),.b(5),.opcode("DIV"));
    $display("DIV RESULT=%0d",result);
  end

endmodule
