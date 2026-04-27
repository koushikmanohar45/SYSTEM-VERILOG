//DESIGN
module design_v(bus_if itf);
  reg [7:0]mem[255:0];
  
  always@(posedge itf.clk)begin
    
    if(itf.rst_n)
      itf.rdata<=8'd0;
    
    else begin
      if(itf.write_en)
        mem[itf.addr]<=itf.wdata;
      else
        itf.rdata<=mem[itf.addr];
    end 
  end
endmodule

//interface declaration
interface bus_if(input logic clk);
  
  logic rst_n;
  logic [7:0] addr;  
  logic [7:0] wdata;
  logic [7:0] rdata;
  logic write_en;
  
  task write_data(input [7:0] a, input [7:0] d);
    @(posedge clk);
    write_en =1;
    addr=a;
    wdata=d;
  endtask

  task read_data(input [7:0] a);
    @(posedge clk);
    write_en=0;
    addr=a;
  endtask
  
endinterface

//TESTBENCH
module top();
  //clk generation
  logic clk=0;
  always #5 clk=~clk;
  
  //interface inialtization
  bus_if itf(clk);
  
  //dut instance
  design_v dut(itf);
  
  initial begin
  
  //reset
  itf.rst_n=1;
  itf.write_en=0;
  itf.wdata=0;
  itf.addr=8'b0001;
   #10 itf.rst_n=0;
  
  //writing
  repeat(30)begin
  #10;
    itf.write_data(itf.addr+1,$urandom);
  end
  
  //reading
  repeat(30)begin
  #10;
    itf.read_data(itf.addr-1);
  end
    
  #20;$finish;
  end
  
  initial begin
    $monitor("clk=%0t   rst_n=%b   write_en=%b  addr=%0d   wdata=%0d   rdata=%0d ",clk,itf.rst_n,itf.write_en,itf.addr,itf.wdata,itf.rdata);
  end
  
endmodule



/*
OUTPUT:
clk=0   rst_n=1   write_en=0  addr=1   wdata=0   rdata=x 
clk=1   rst_n=1   write_en=0  addr=1   wdata=0   rdata=0 
clk=0   rst_n=0   write_en=0  addr=1   wdata=0   rdata=0 
clk=1   rst_n=0   write_en=0  addr=1   wdata=0   rdata=x 
clk=0   rst_n=0   write_en=0  addr=1   wdata=0   rdata=x 
clk=1   rst_n=0   write_en=1  addr=2   wdata=19   rdata=x 
clk=0   rst_n=0   write_en=1  addr=2   wdata=19   rdata=x 
clk=1   rst_n=0   write_en=1  addr=3   wdata=112   rdata=x 
clk=0   rst_n=0   write_en=1  addr=3   wdata=112   rdata=x 
clk=1   rst_n=0   write_en=1  addr=4   wdata=253   rdata=x 
clk=0   rst_n=0   write_en=1  addr=4   wdata=253   rdata=x 
clk=1   rst_n=0   write_en=1  addr=5   wdata=226   rdata=x 
clk=0   rst_n=0   write_en=1  addr=5   wdata=226   rdata=x 
clk=1   rst_n=0   write_en=1  addr=6   wdata=151   rdata=x 
clk=0   rst_n=0   write_en=1  addr=6   wdata=151   rdata=x 
clk=1   rst_n=0   write_en=1  addr=7   wdata=241   rdata=x 
clk=0   rst_n=0   write_en=1  addr=7   wdata=241   rdata=x 
clk=1   rst_n=0   write_en=1  addr=8   wdata=197   rdata=x 
clk=0   rst_n=0   write_en=1  addr=8   wdata=197   rdata=x 
clk=1   rst_n=0   write_en=1  addr=9   wdata=236   rdata=x 
clk=0   rst_n=0   write_en=1  addr=9   wdata=236   rdata=x 
clk=1   rst_n=0   write_en=1  addr=10   wdata=72   rdata=x 
clk=0   rst_n=0   write_en=1  addr=10   wdata=72   rdata=x 
clk=1   rst_n=0   write_en=1  addr=11   wdata=12   rdata=x 
clk=0   rst_n=0   write_en=1  addr=11   wdata=12   rdata=x 
clk=1   rst_n=0   write_en=1  addr=12   wdata=44   rdata=x 
clk=0   rst_n=0   write_en=1  addr=12   wdata=44   rdata=x 
clk=1   rst_n=0   write_en=1  addr=13   wdata=107   rdata=x 
clk=0   rst_n=0   write_en=1  addr=13   wdata=107   rdata=x 
clk=1   rst_n=0   write_en=1  addr=14   wdata=27   rdata=x 
clk=0   rst_n=0   write_en=1  addr=14   wdata=27   rdata=x 
clk=1   rst_n=0   write_en=1  addr=15   wdata=69   rdata=x 
clk=0   rst_n=0   write_en=1  addr=15   wdata=69   rdata=x 
clk=1   rst_n=0   write_en=1  addr=16   wdata=244   rdata=x 
clk=0   rst_n=0   write_en=1  addr=16   wdata=244   rdata=x 
clk=1   rst_n=0   write_en=1  addr=17   wdata=108   rdata=x 
clk=0   rst_n=0   write_en=1  addr=17   wdata=108   rdata=x 
clk=1   rst_n=0   write_en=1  addr=18   wdata=103   rdata=x 
clk=0   rst_n=0   write_en=1  addr=18   wdata=103   rdata=x 
clk=1   rst_n=0   write_en=1  addr=19   wdata=140   rdata=x 
clk=0   rst_n=0   write_en=1  addr=19   wdata=140   rdata=x 
clk=1   rst_n=0   write_en=1  addr=20   wdata=74   rdata=x 
clk=0   rst_n=0   write_en=1  addr=20   wdata=74   rdata=x 
clk=1   rst_n=0   write_en=1  addr=21   wdata=166   rdata=x 
clk=0   rst_n=0   write_en=1  addr=21   wdata=166   rdata=x 
clk=1   rst_n=0   write_en=1  addr=22   wdata=163   rdata=x 
clk=0   rst_n=0   write_en=1  addr=22   wdata=163   rdata=x 
clk=1   rst_n=0   write_en=1  addr=23   wdata=157   rdata=x 
clk=0   rst_n=0   write_en=1  addr=23   wdata=157   rdata=x 
clk=1   rst_n=0   write_en=1  addr=24   wdata=124   rdata=x 
clk=0   rst_n=0   write_en=1  addr=24   wdata=124   rdata=x 
clk=1   rst_n=0   write_en=1  addr=25   wdata=184   rdata=x 
clk=0   rst_n=0   write_en=1  addr=25   wdata=184   rdata=x 
clk=1   rst_n=0   write_en=1  addr=26   wdata=235   rdata=x 
clk=0   rst_n=0   write_en=1  addr=26   wdata=235   rdata=x 
clk=1   rst_n=0   write_en=1  addr=27   wdata=91   rdata=x 
clk=0   rst_n=0   write_en=1  addr=27   wdata=91   rdata=x 
clk=1   rst_n=0   write_en=1  addr=28   wdata=243   rdata=x 
clk=0   rst_n=0   write_en=1  addr=28   wdata=243   rdata=x 
clk=1   rst_n=0   write_en=1  addr=29   wdata=77   rdata=x 
clk=0   rst_n=0   write_en=1  addr=29   wdata=77   rdata=x 
clk=1   rst_n=0   write_en=1  addr=30   wdata=92   rdata=x 
clk=0   rst_n=0   write_en=1  addr=30   wdata=92   rdata=x 
clk=1   rst_n=0   write_en=1  addr=31   wdata=246   rdata=x 
clk=0   rst_n=0   write_en=1  addr=31   wdata=246   rdata=x 
clk=1   rst_n=0   write_en=0  addr=30   wdata=246   rdata=92 
clk=0   rst_n=0   write_en=0  addr=30   wdata=246   rdata=92 
clk=1   rst_n=0   write_en=0  addr=29   wdata=246   rdata=77 
clk=0   rst_n=0   write_en=0  addr=29   wdata=246   rdata=77 
clk=1   rst_n=0   write_en=0  addr=28   wdata=246   rdata=243 
clk=0   rst_n=0   write_en=0  addr=28   wdata=246   rdata=243 
clk=1   rst_n=0   write_en=0  addr=27   wdata=246   rdata=91 
clk=0   rst_n=0   write_en=0  addr=27   wdata=246   rdata=91 
clk=1   rst_n=0   write_en=0  addr=26   wdata=246   rdata=235 
clk=0   rst_n=0   write_en=0  addr=26   wdata=246   rdata=235 
clk=1   rst_n=0   write_en=0  addr=25   wdata=246   rdata=184 
clk=0   rst_n=0   write_en=0  addr=25   wdata=246   rdata=184 
clk=1   rst_n=0   write_en=0  addr=24   wdata=246   rdata=124 
clk=0   rst_n=0   write_en=0  addr=24   wdata=246   rdata=124 
clk=1   rst_n=0   write_en=0  addr=23   wdata=246   rdata=157 
clk=0   rst_n=0   write_en=0  addr=23   wdata=246   rdata=157 
clk=1   rst_n=0   write_en=0  addr=22   wdata=246   rdata=163 
clk=0   rst_n=0   write_en=0  addr=22   wdata=246   rdata=163 
clk=1   rst_n=0   write_en=0  addr=21   wdata=246   rdata=166 
clk=0   rst_n=0   write_en=0  addr=21   wdata=246   rdata=166 
clk=1   rst_n=0   write_en=0  addr=20   wdata=246   rdata=74 
clk=0   rst_n=0   write_en=0  addr=20   wdata=246   rdata=74 
clk=1   rst_n=0   write_en=0  addr=19   wdata=246   rdata=140 
clk=0   rst_n=0   write_en=0  addr=19   wdata=246   rdata=140 
clk=1   rst_n=0   write_en=0  addr=18   wdata=246   rdata=103 
clk=0   rst_n=0   write_en=0  addr=18   wdata=246   rdata=103 
clk=1   rst_n=0   write_en=0  addr=17   wdata=246   rdata=108 
clk=0   rst_n=0   write_en=0  addr=17   wdata=246   rdata=108 
clk=1   rst_n=0   write_en=0  addr=16   wdata=246   rdata=244 
clk=0   rst_n=0   write_en=0  addr=16   wdata=246   rdata=244 
clk=1   rst_n=0   write_en=0  addr=15   wdata=246   rdata=69 
clk=0   rst_n=0   write_en=0  addr=15   wdata=246   rdata=69 
clk=1   rst_n=0   write_en=0  addr=14   wdata=246   rdata=27 
clk=0   rst_n=0   write_en=0  addr=14   wdata=246   rdata=27 
clk=1   rst_n=0   write_en=0  addr=13   wdata=246   rdata=107 
clk=0   rst_n=0   write_en=0  addr=13   wdata=246   rdata=107 
clk=1   rst_n=0   write_en=0  addr=12   wdata=246   rdata=44 
clk=0   rst_n=0   write_en=0  addr=12   wdata=246   rdata=44 
clk=1   rst_n=0   write_en=0  addr=11   wdata=246   rdata=12 
clk=0   rst_n=0   write_en=0  addr=11   wdata=246   rdata=12 
clk=1   rst_n=0   write_en=0  addr=10   wdata=246   rdata=72 
clk=0   rst_n=0   write_en=0  addr=10   wdata=246   rdata=72 
clk=1   rst_n=0   write_en=0  addr=9   wdata=246   rdata=236 
clk=0   rst_n=0   write_en=0  addr=9   wdata=246   rdata=236 
clk=1   rst_n=0   write_en=0  addr=8   wdata=246   rdata=197 
clk=0   rst_n=0   write_en=0  addr=8   wdata=246   rdata=197 
clk=1   rst_n=0   write_en=0  addr=7   wdata=246   rdata=241 
clk=0   rst_n=0   write_en=0  addr=7   wdata=246   rdata=241 
clk=1   rst_n=0   write_en=0  addr=6   wdata=246   rdata=151 
clk=0   rst_n=0   write_en=0  addr=6   wdata=246   rdata=151 
clk=1   rst_n=0   write_en=0  addr=5   wdata=246   rdata=226 
clk=0   rst_n=0   write_en=0  addr=5   wdata=246   rdata=226 
clk=1   rst_n=0   write_en=0  addr=4   wdata=246   rdata=253 
clk=0   rst_n=0   write_en=0  addr=4   wdata=246   rdata=253 
clk=1   rst_n=0   write_en=0  addr=3   wdata=246   rdata=112 
clk=0   rst_n=0   write_en=0  addr=3   wdata=246   rdata=112 
clk=1   rst_n=0   write_en=0  addr=2   wdata=246   rdata=19 
clk=0   rst_n=0   write_en=0  addr=2   wdata=246   rdata=19 
clk=1   rst_n=0   write_en=0  addr=1   wdata=246   rdata=x 
clk=0   rst_n=0   write_en=0  addr=1   wdata=246   rdata=x 
clk=1   rst_n=0   write_en=0  addr=1   wdata=246   rdata=x 
clk=0   rst_n=0   write_en=0  addr=1   wdata=246   rdata=x 
$finish called from file "testbench.sv", line 33.
$finish at simulation time                  635
           V C S   S i m u l a t i o n   R e p o r t 
*/
