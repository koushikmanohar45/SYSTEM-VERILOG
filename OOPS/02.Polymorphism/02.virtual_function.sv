class operation;

  int a,b;
  int result;

  function void set_values(int x, int y);
    a=x;
    b=y;
  endfunction
  
  virtual function void display();
    $display("[parent] operand a=%0d, operand b=%0d\n",a,b);
  endfunction

endclass


class arithmetic_operation extends operation;

  function void add();
    result=a+b;
  endfunction
  
  function void display();
    $display("[child] operand a=%0d, operand b=%0d",a,b);
    $display("Addition = %0d\n",result);
  endfunction

endclass


class multiplication_operation extends arithmetic_operation;

  function void multiply();
    result=a*b;
  endfunction
  
  function void display();
    $display("[grandchild] operand a=%0d, operand b=%0d",a,b);
    $display("Multiplication = %0d\n",result);
  endfunction

endclass


class signed_multiplication_operation extends multiplication_operation;

  function void signed_multiply();
    result=$signed(a)*$signed(b);
  endfunction
  
  function void display();
    $display("[great grandchild] operand a=%0d, operand b=%0d",a,b);
    $display("Signed Multiplication = %0d\n", result); 
  endfunction
  

endclass


module tb;

  signed_multiplication_operation op;
  operation o1;
  multiplication_operation m;
  arithmetic_operation a;

  initial begin

    op=new();
    o1=new();
    m=new();
    a=m;
    o1=op;
    $display("base handle points to derived class's object");

    op.set_values(10, 5);
    op.add();
    op.multiply();         
    op.signed_multiply();
   
    $display("Derived class display() executes because the base class method is declared virtual, enabling dynamic binding");
    o1.display();
    op.display();
    $display("created object for grandchild and done class assignment to child and displayed child");
    m.display();
    a.display();

  end

endmodule

/*
output:
base handle points to derived class's object
Derived class display() executes because the base class method is declared virtual, enabling dynamic binding
[great grandchild] operand a=10, operand b=5
Signed Multiplication = 50

[great grandchild] operand a=10, operand b=5
Signed Multiplication = 50

created object for grandchild and done class assignment to child and displayed child
[grandchild] operand a=0, operand b=0
Multiplication = 0

[grandchild] operand a=0, operand b=0
Multiplication = 0

           V C S   S i m u l a t i o n   R e p o r t 


*/
