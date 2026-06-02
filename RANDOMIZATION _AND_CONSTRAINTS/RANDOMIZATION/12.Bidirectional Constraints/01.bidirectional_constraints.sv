class bidir_con;
  randc logic [7:0] a;
  randc logic [7:0] b;
  randc logic [7:0] c;
  
  constraint c1{
                 a<=c;
                 b==a;
                 c<=30;
                 b>=25;
               }
//possible values               
// +----+----+----+
// | a  | b  | c  |
// +----+----+----+
// | 25 | 25 | 25 |
// | 25 | 25 | 26 |
// | 25 | 25 | 27 |
// | 25 | 25 | 28 |
// | 25 | 25 | 29 |
// | 25 | 25 | 30 |
// | 26 | 26 | 26 |
// | 26 | 26 | 27 |
// | 26 | 26 | 28 |
// | 26 | 26 | 29 |
// | 26 | 26 | 30 |
// | 27 | 27 | 27 |
// | 27 | 27 | 28 |
// | 27 | 27 | 29 |
// | 27 | 27 | 30 |
// | 28 | 28 | 28 |
// | 28 | 28 | 29 |
// | 28 | 28 | 30 |
// | 29 | 29 | 29 |
// | 29 | 29 | 30 |
// | 30 | 30 | 30 |
// +----+----+----+
endclass

module randomization;
  
  bidir_con h;
  
  initial begin
    h=new();
    repeat(20) begin
       h.randomize();
       $display("a=%0d b=%0d c=%0d ",h.a,h.b,h.c);
    end
  end
  
endmodule

/*
output:
a=27 b=27 c=30 
a=28 b=28 c=28 
a=26 b=26 c=27 
a=29 b=29 c=29 
a=25 b=25 c=26 
a=30 b=30 c=30 
a=30 b=30 c=30 
a=27 b=27 c=29 
a=25 b=25 c=26 
a=28 b=28 c=28 
a=26 b=26 c=27 
a=29 b=29 c=29 
a=29 b=29 c=30 
a=28 b=28 c=28 
a=27 b=27 c=27 
a=25 b=25 c=29 
a=26 b=26 c=26 
a=30 b=30 c=30 
a=28 b=28 c=28 
a=29 b=29 c=30 
           V C S   S i m u l a t i o n   R e p o r t 
*/
  
