module random_function_with_different_seed;
  logic [31:0] a,b;
  logic d;
  logic [7:0]e,f;
  integer seed1,seed2;
  logic[8:0]out;
initial begin
  $display("-----------Random function with different seed------------");
  
  repeat(5)begin
  seed1=$urandom_range(10,50);
  seed2=$urandom_range(10,50);
  a=$urandom(seed1);
  b=$urandom(seed2);
  $display("$urandom(%0d)=%0d $urandom(%0d)=%0d ",seed1,a,seed2,b);
  #10;
  end
  
  repeat(5)begin
    d=$random();
    e=$urandom();
    f=$urandom_range(35,100);
    add();
  end
end
   task automatic add();
    begin
    out=d+e+f;
    $display("%0d+%0d+%0d=%0d",d,e,f,out);
    end
  endtask
endmodule

/*
OUTPUT:
-----------Random function with different seed------------
$urandom(27)=3455745567 $urandom(16)=4273146835 
$urandom(27)=3455745567 $urandom(21)=2777028096 
$urandom(40)=2914207056 $urandom(22)=2084007839 
$urandom(31)=245953098 $urandom(28)=3655259963 
$urandom(25)=3220994772 $urandom(30)=2777322353 
0+12+37=49
1+157+94=252
1+97+50=148
1+6+88=95
1+236+45=282
           V C S   S i m u l a t i o n   R e p o r t 
*/
