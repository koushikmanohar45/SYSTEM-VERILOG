//inside modules functions are static by default
module test;

  int sum;
  function int add(int a,b);
    add=a+b;
    $display("a=%0d b=%0d",a,b);
  endfunction

  initial begin
    // Calling function with values as arguments
    repeat(10)begin
      sum=add($urandom_range(1,10),$urandom_range(1,20));
      $display("SUM=%0d\n", sum);
    end
  end

endmodule
