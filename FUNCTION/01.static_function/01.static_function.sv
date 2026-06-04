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

/*
output:
a=9 b=1
SUM=10

a=4 b=11
SUM=15

a=8 b=12
SUM=20

a=7 b=4
SUM=11

a=3 b=8
SUM=11

a=2 b=11
SUM=13

a=9 b=6
SUM=15

a=8 b=11
SUM=19

a=5 b=10
SUM=15

a=3 b=7
SUM=10

           V C S   S i m u l a t i o n   R e p o r t 
*/
