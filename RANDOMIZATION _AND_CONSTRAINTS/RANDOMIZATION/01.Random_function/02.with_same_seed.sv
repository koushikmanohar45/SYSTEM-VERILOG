module random_function_with_same_seed;
  logic [31:0] a,b;
  logic d;
  logic [7:0]e,f;
  integer seed1,seed2;
  logic[8:0]out;
initial begin
  seed1=15;
  seed2=25;
  $display("-----------Random function with same seed value------------");
  
  repeat(5)begin
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
-----------Random function with same seed value------------
$urandom(15)=2462402994 $urandom(25)=3220994772 
$urandom(15)=2462402994 $urandom(25)=3220994772 
$urandom(15)=2462402994 $urandom(25)=3220994772 
$urandom(15)=2462402994 $urandom(25)=3220994772 
$urandom(15)=2462402994 $urandom(25)=3220994772 
0+116+97=213
1+167+93=261
1+88+90=179
1+73+65=139
1+49+49=99
           V C S   S i m u l a t i o n   R e p o r t 
*/
