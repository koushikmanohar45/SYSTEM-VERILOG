class auto;

  // STATIC LIFETIME FUNCTION
  function static int static_func();
    int count;
    count++;
    return count;
  endfunction

  // AUTOMATIC LIFETIME FUNCTION
  function automatic int automatic_func();
    int count;
    count++;
    return count;
  endfunction
endclass

module test;
  auto d1;
  initial begin
    d1=new();
    $display("STATIC FUNCTION CALLS");
    $display("%0d", d1.static_func());
    $display("%0d", d1.static_func());
    $display("%0d", d1.static_func());
    $display("");
    $display("AUTOMATIC FUNCTION CALLS");
    $display("%0d", d1.automatic_func());
    $display("%0d", d1.automatic_func());
    $display("%0d", d1.automatic_func());
  end
endmodule

/*
OUTPUT:

STATIC FUNCTION CALLS
1
2
3

AUTOMATIC FUNCTION CALLS
1
1
1
           V C S   S i m u l a t i o n   R e p o r t 

*/
