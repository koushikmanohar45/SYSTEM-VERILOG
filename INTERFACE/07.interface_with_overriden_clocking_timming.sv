                                       //DESIGN
module design_v(vote.dut itf);
 
  always@(posedge itf.clk)begin
    if(itf.rst)begin
      itf.count1<=0;
      itf.count2<=0;
    end
    else begin
      if(itf.vote_a)
        itf.count1=itf.count1+1;
      else if(itf.vote_b)
       itf.count2<=itf.count2+1;
    end
  end
  
endmodule
                                       //TESTBENCH
//INTERFACE
interface vote (input logic clk);
  logic rst;
  logic vote_a;
  logic vote_b;
  logic [7:0]count1;
  logic [7:0]count2;
  
  //clocking block for driver
  clocking drv @(negedge clk);
    default input #2 output #2;
    input count1,count2;
    output rst,vote_a;
    //overriding timming in clking block
    output #3 vote_b;
  endclocking
  
  //clocking block for monitor    
  
  clocking mon @(negedge clk);
    //WITH DEFAULT VALUES INPUT=#1; OUTPUT=#0
    input rst,count1,count2,vote_a,vote_b;
  endclocking
  
  //modports
  modport dut(input clk,rst,vote_a,vote_b,output count1,count2);
  
  modport drve(input clk,clocking drv);
    
  modport mtr(input clk,clocking mon);
   
endinterface
    
//TOP MODULE
module top();
  
  logic clk=0;
  always #5 clk=~clk;
  
  vote itf(clk);
  driver d1(itf);
  monitor d2(itf);
  design_v d3(itf);

endmodule
    
//DRIVER
module driver(vote.drve itf); 
  
  initial begin
    itf.drv.rst<=1;
    repeat (3) @(itf.drv);
    itf.drv.rst<=0;
    repeat(50) begin
       bit rand_val;
       rand_val=$urandom_range(0,1);
       itf.drv.vote_a<=rand_val;
       itf.drv.vote_b<=~rand_val;
       @(itf.drv);
      end
    @(itf.drv);$finish;
  end
  
endmodule
    
//MONITOR
module monitor(vote.mtr itf); 
  
  initial begin
    $monitor("time=%0t; vote_a=%B; vote_b=%b; count1=%0d; count2=%0d",$time,itf.mon.vote_a,itf.mon.vote_b,itf.mon.count1,itf.mon.count2);
  end
endmodule     

    
/*
OUTPUT:
time=0; vote_a=x; vote_b=x; count1=x; count2=x
time=10; vote_a=x; vote_b=x; count1=0; count2=0
time=30; vote_a=0; vote_b=1; count1=0; count2=1
time=40; vote_a=0; vote_b=1; count1=0; count2=2
time=50; vote_a=1; vote_b=0; count1=1; count2=2
time=60; vote_a=0; vote_b=1; count1=1; count2=3
time=70; vote_a=1; vote_b=0; count1=2; count2=3
time=80; vote_a=1; vote_b=0; count1=3; count2=3
time=90; vote_a=0; vote_b=1; count1=3; count2=4
time=100; vote_a=1; vote_b=0; count1=4; count2=4
time=110; vote_a=0; vote_b=1; count1=4; count2=5
time=120; vote_a=1; vote_b=0; count1=5; count2=5
time=130; vote_a=1; vote_b=0; count1=6; count2=5
time=140; vote_a=0; vote_b=1; count1=6; count2=6
time=150; vote_a=0; vote_b=1; count1=6; count2=7
time=160; vote_a=1; vote_b=0; count1=7; count2=7
time=170; vote_a=1; vote_b=0; count1=8; count2=7
time=180; vote_a=0; vote_b=1; count1=8; count2=8
time=190; vote_a=0; vote_b=1; count1=8; count2=9
time=200; vote_a=1; vote_b=0; count1=9; count2=9
time=210; vote_a=0; vote_b=1; count1=9; count2=10
time=220; vote_a=0; vote_b=1; count1=9; count2=11
time=230; vote_a=0; vote_b=1; count1=9; count2=12
time=240; vote_a=1; vote_b=0; count1=10; count2=12
time=250; vote_a=1; vote_b=0; count1=11; count2=12
time=260; vote_a=0; vote_b=1; count1=11; count2=13
time=270; vote_a=1; vote_b=0; count1=12; count2=13
time=280; vote_a=0; vote_b=1; count1=12; count2=14
time=290; vote_a=1; vote_b=0; count1=13; count2=14
time=300; vote_a=0; vote_b=1; count1=13; count2=15
time=310; vote_a=0; vote_b=1; count1=13; count2=16
time=320; vote_a=1; vote_b=0; count1=14; count2=16
time=330; vote_a=1; vote_b=0; count1=15; count2=16
time=340; vote_a=0; vote_b=1; count1=15; count2=17
time=350; vote_a=0; vote_b=1; count1=15; count2=18
time=360; vote_a=1; vote_b=0; count1=16; count2=18
time=370; vote_a=0; vote_b=1; count1=16; count2=19
time=380; vote_a=1; vote_b=0; count1=17; count2=19
time=390; vote_a=0; vote_b=1; count1=17; count2=20
time=400; vote_a=0; vote_b=1; count1=17; count2=21
time=410; vote_a=0; vote_b=1; count1=17; count2=22
time=420; vote_a=1; vote_b=0; count1=18; count2=22
time=430; vote_a=0; vote_b=1; count1=18; count2=23
time=440; vote_a=1; vote_b=0; count1=19; count2=23
time=450; vote_a=1; vote_b=0; count1=20; count2=23
time=460; vote_a=0; vote_b=1; count1=20; count2=24
time=470; vote_a=0; vote_b=1; count1=20; count2=25
time=480; vote_a=1; vote_b=0; count1=21; count2=25
time=490; vote_a=1; vote_b=0; count1=22; count2=25
time=500; vote_a=1; vote_b=0; count1=23; count2=25
time=510; vote_a=0; vote_b=1; count1=23; count2=26
time=520; vote_a=0; vote_b=1; count1=23; count2=27
$finish called from file "testbench.sv", line 61.
$finish at simulation time                  530
           V C S   S i m u l a t i o n   R e p o r t 
*/

