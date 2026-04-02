module equality_operator;
  logic[3:0] a,b;

  task automatic display();
     begin
       $display("DISPLAYING OPERANDS:");
       $display(" a=%B \n b=%B",a,b);
       $display("OPERATORS COMMON TO VERILOG AND SYSTEM VERILOG");
       $display(" a===b(case equality)=%B",a===b);
       $display(" a!==b(case inequality)=%B",a!==b);
       $display(" a==b(logical equality)=%B",a==b);
       $display(" a!=b(logical inequality)=%B",a!=b);
       $display("NEW OPERATORS USED IN SYSTEM-VERILOG");
       $display(" a=?=b(equality)=%B",a==?b);
       $display(" a!?=b(inequality)=%B",a!=?b);
       $display("------------------------------------------------------");
     end
  endtask
    
  initial begin
    a=4'he;b=4'b11xx;
    $display("================= LOGICAL OPERATORS =================");
    display();
    #1 a=4'bx1zx;b=4'b1011;  
    display();
    #1 a=4'h1;b=4'h0;  
    display();
    #1 a=4'hf;b=4'b11xx;
    display();
    #1 a=4'hf;b=4'h0;
    display(); 
    #1 a=4'hc;b=4'b11x0;
    display();
    #1 a=4'h00xz;b=4'b00xz;
    display();
    #1 $finish;
end
endmodule
