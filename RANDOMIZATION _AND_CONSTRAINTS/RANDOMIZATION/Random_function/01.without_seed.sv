module random_function_without_seed;
  logic [31:0] a,b,c;
  logic d;
  logic [7:0]e,f;
  logic[8:0]out;
initial begin
  $display("--------------------Random function without seed---------------------");
  
  repeat(5)begin
    a=$urandom();
    b=$random();
    c=$urandom_range(10,50);
    $display("$urandom()=%0d $random()=%0d $urandom_range(10,50)=%0d",a,b,c);
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
--------------------Random function without seed---------------------
$urandom()=98710838 $random()=303379748 $urandom_range(10,50)=16
$urandom()=3196053373 $random()=3230228097 $urandom_range(10,50)=23
$urandom()=41501707 $random()=2223298057 $urandom_range(10,50)=38
$urandom()=4082149696 $random()=2985317987 $urandom_range(10,50)=31
$urandom()=1837005222 $random()=112818957 $urandom_range(10,50)=25
1+181+67=249
1+78+94=173
0+125+83=208
1+150+88=239
1+196+85=282
           V C S   S i m u l a t i o n   R e p o r t 
*/
