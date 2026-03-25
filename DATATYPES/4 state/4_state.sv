//example for 4-state datatypes
module four_state();
  reg [4:0] rg;
  wire wir;
  logic[8:1] log;
  tri[4:0] t;
  real rl1,rl2;
  integer i;
  initial begin
    $display("size of reg=%0d",$size(rg));
    $display("size of wire=%0d",$size(wir));
    $display("size of logic=%0d",$size(log));
    $display("size of tri=%0d",$size(t));
    $display("size of integer=%0d",$size(i));
    
    $display("default value of reg=%b",rg);
    $display("default value of wire=%b",wir);
    $display("default value of logic=%b",log);
    $display("default value of tri=%b",t);
    $display("default value of real=%0f",rl1);
    $display("default value of integer=%0d",i);
    #1
    rg=5'b11001;
    log=8'had;
    $display("value of reg after initialization=%b",rg);
    $display("value of logic after initialization=%b",log);
    rl1=12.5;
    rl2=13.34;
    $display("value of real1 after initialization=%0f",rl1);
    $display("value of real2 after initialization=%0f",rl2);
    rl1+=rl2;
    $display("real1+real2=%0f",rl1);
    
    $display("detecting 1 in logic value");
    for(i=0;i<$size(log);i++)begin
      if(log[i])
        $display("Index=%0d,detected",i);
      else
        $display("Index=%0d,not detected",i);  
      #1;
    end 
    $display("value of tri after initialization=%b",t);
    $display("value of wire after initialization=%b",wir);
  end
  assign wir=^rg;
  assign t=log[8]?rg:5'bzzzzz;
endmodule
