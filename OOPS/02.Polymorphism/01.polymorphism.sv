class operation;

  int a,b;
  int result;

  function void set_values(int x, int y);
    a=x;
    b=y;
  endfunction
  
  function void display();
    $display("[parent] operand a=%0d, operand b=%0d",a,b);
  endfunction

endclass


class arithmetic_operation extends operation;

  function void add();
    result=a+b;
  endfunction
  
  function void display();
    $display("[child] operand a=%0d, operand b=%0d",a,b);
    $display("Addition = %0d",result);
  endfunction

endclass


class multiplication_operation extends arithmetic_operation;

  function void multiply();
    result=a*b;
  endfunction
  
  function void display();
    $display("[grandchild] operand a=%0d, operand b=%0d",a,b);
    $display("Multiplication = %0d",result);
  endfunction

endclass


class signed_multiplication_operation extends multiplication_operation;

  function void signed_multiply();
    result=$signed(a)*$signed(b);
  endfunction
  
  function void display();
    $display("[great grandchild] operand a=%0d, operand b=%0d",a,b);
    $display("Signed Multiplication = %0d", result); 
  endfunction
  

endclass


module tb;

  signed_multiplication_operation op;
  operation o1;
  arithmetic_operation a;

  initial begin

    op = new();
    o1=new();
    a=op;
    o1=op;
    $display(" base handle points to derived class's object");

    op.set_values(10, 5);
    op.add();
    op.multiply();         
    op.signed_multiply();
   
    $display("Base method executes because display() is not declared virtual (static binding )");
    o1.display();
    op.display();
    $display("created object for parengt and done class assignment to child and displayed child");
    a.display();

  end

endmodule

/*
output:
base handle points to derived class's object
Base method executes because display() is not declared virtual (static binding )
[parent] operand a=10, operand b=5
[great grandchild] operand a=10, operand b=5
Signed Multiplication = 50
created object for parengt and done class assignment to child and displayed child
[child] operand a=10, operand b=5
Addition = 50
           V C S   S i m u l a t i o n   R e p o r t 
*/
