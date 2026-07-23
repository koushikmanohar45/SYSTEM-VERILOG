//design
module battery(battery_if.dut itf);
  always@(posedge itf.clk)begin
    
    if(itf.battery_level<=20)begin
      itf.low<=1;
      itf.high<=0;
      itf.med<=0;
    end
    else if(itf.battery_level>20 && itf.battery_level<=80)begin
      itf.low<=0;
      itf.high<=0;
      itf.med<=1;
    end
    else if(itf.battery_level>80 && itf.battery_level<=100)begin
      itf.low<=0;
      itf.high<=1;
      itf.med<=0;
    end
    else begin
      itf.low<=0;
      itf.high<=0;
      itf.med<=0;
    end

  end
  assign itf.charge_status=itf.charging;
  
endmodule


//testbench
interface battery_if(input logic clk);

  logic [6:0] battery_level;
  logic charging;
  logic low;
  logic high;
  logic med;
  logic charge_status;
  
  covergroup battery_cg @(posedge clk);

    cp_level:coverpoint battery_level {
                                         bins b[]={[0:100]};
                                      }
    cp_status1:coverpoint low; 
    cp_status2:coverpoint high; 
    cp_status3:coverpoint med; 

    
    cp_charge:coverpoint charging {
                                           bins charging_on={1};
                                           bins charging_off={0};
                                  }
    
    cp_charge1:coverpoint charge_status;
    
  endgroup
  
   modport dut(input clk,charging,battery_level,output low,high,med,charge_status);
    modport tb(output charging,battery_level,input clk,low,high,med,charge_status);

  //creating handle inside interface
  battery_cg cov = new();

endinterface




module tb;

  logic clk=0;
  battery_if itf(clk);
  
  battery dut(itf);

  always #5 clk=~clk;

  initial begin

    repeat(505) begin
      @(posedge clk);

      itf.battery_level=$urandom_range(0,100);
      itf.charging=$urandom_range(0,1);
      $display("battery_level=%0d,charging=%0d,low=%b,high=%b,med=%b,charge_status=%0d",itf.battery_level,itf.charging,itf.low,itf.high,itf.med,itf.charge_status);
      $display("Coverage for battery_level=%0.2f%%",itf.cov.cp_level.get_inst_coverage());
      $display("Coverage for low=%0.2f%%",itf.cov.cp_status1.get_inst_coverage());
      $display("Coverage for med=%0.2f%%",itf.cov.cp_status3.get_inst_coverage());
      $display("Coverage for high=%0.2f%%",itf.cov.cp_status2.get_inst_coverage());
      $display("Coverage for charging=%0.2f%%",itf.cov.cp_charge.get_inst_coverage());
      $display("Coverage for charge_status=%0.2f%%",itf.cov.cp_charge1.get_inst_coverage());
      $display("");
      
      
    end
    
    $stop;
    
  end

endmodule




//run.do file

run -all
# Save the database
coverage save cov.ucdb
# Just run the report once, directly to the log
coverage report -cvg -details
# Exit the simulator immediately
exit

#compiler option: -timescale 1ns/1ns -coverage
#run option: -coverage -voptargs="+acc"

# coverage save -onexit cov_$Sv_Seed.ucdb
# do run.do
# battery_level=29,charging=0,low=x,high=x,med=x,charge_status=x
# Coverage for battery_level=0.00%
# Coverage for low=0.00%
# Coverage for med=0.00%
# Coverage for high=0.00%
# Coverage for charging=0.00%
# Coverage for charge_status=0.00%
# 
# battery_level=29,charging=0,low=0,high=0,med=0,charge_status=0
# Coverage for battery_level=0.99%
# Coverage for low=50.00%
# Coverage for med=50.00%
# Coverage for high=50.00%
# Coverage for charging=50.00%
# Coverage for charge_status=50.00%
# 
# battery_level=92,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=0.99%
# Coverage for low=50.00%
# Coverage for med=100.00%
# Coverage for high=50.00%
# Coverage for charging=50.00%
# Coverage for charge_status=50.00%
# 
# battery_level=21,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=1.98%
# Coverage for low=50.00%
# Coverage for med=100.00%
# Coverage for high=50.00%
# Coverage for charging=50.00%
# Coverage for charge_status=50.00%
# 
# battery_level=20,charging=1,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=2.97%
# Coverage for low=50.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=39,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=3.96%
# Coverage for low=50.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=63,charging=0,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=4.95%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=33,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=5.94%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=58,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=6.93%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=46,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=7.92%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=64,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=8.91%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=71,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=9.90%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=81,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=10.89%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=7,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=11.88%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=1,charging=0,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=12.87%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=24,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=13.86%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=6,charging=0,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=14.85%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=55,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=15.84%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=74,charging=0,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=16.83%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=84,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=17.82%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=27,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=18.81%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=69,charging=1,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=19.80%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=70,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=20.79%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=49,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=21.78%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=44,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=22.77%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=29,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=23.76%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=50,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=23.76%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=14,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=24.75%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=90,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=25.74%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=48,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=26.73%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=57,charging=1,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=27.72%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=52,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=28.71%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=81,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=29.70%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=7,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=29.70%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=26,charging=1,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=29.70%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=49,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=30.69%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=0,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=30.69%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=23,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=31.68%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=97,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=32.67%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=28,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=33.66%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=94,charging=1,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=34.65%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=64,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=35.64%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=51,charging=1,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=35.64%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=15,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=36.63%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=56,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=37.62%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=89,charging=0,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=38.61%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=59,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=39.60%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=16,charging=0,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=40.59%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=85,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=41.58%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=15,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=42.57%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=85,charging=1,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=42.57%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=96,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=42.57%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=31,charging=1,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=43.56%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=22,charging=1,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=44.55%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=89,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=45.54%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=5,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=45.54%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=82,charging=0,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=46.53%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=53,charging=0,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=47.52%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=76,charging=0,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=48.51%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=15,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=49.50%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=78,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=49.50%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=55,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=50.50%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=55,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=50.50%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=97,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=50.50%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=24,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=50.50%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=30,charging=0,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=50.50%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=84,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=51.49%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=19,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=51.49%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=38,charging=0,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=52.48%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=1,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=53.47%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=30,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=53.47%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=7,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=53.47%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=72,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=53.47%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=33,charging=0,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=54.46%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=84,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=54.46%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=99,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=54.46%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=11,charging=1,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=55.45%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=1,charging=0,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=56.44%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=86,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=56.44%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=4,charging=0,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=57.43%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=15,charging=1,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=58.42%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=67,charging=0,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=58.42%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=62,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=59.41%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=100,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=60.40%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=29,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=61.39%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=20,charging=0,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=61.39%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=26,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=61.39%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=35,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=61.39%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=13,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=62.38%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=27,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=63.37%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=15,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=63.37%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=15,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=63.37%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=95,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=63.37%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=60,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=64.36%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=88,charging=0,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=65.35%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=4,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=66.34%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=86,charging=0,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=66.34%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=4,charging=0,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=66.34%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=19,charging=1,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=66.34%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=98,charging=0,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=66.34%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=17,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=67.33%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=48,charging=1,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=68.32%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=39,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=68.32%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=49,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=68.32%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=81,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=68.32%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=28,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=68.32%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=64,charging=0,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=68.32%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=93,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=68.32%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=56,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=69.31%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=71,charging=1,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=69.31%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=69,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=69.31%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=93,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=69.31%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=31,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=69.31%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=32,charging=0,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=69.31%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=88,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=70.30%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=0,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=70.30%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=40,charging=1,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=70.30%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=13,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=71.29%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=76,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=71.29%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=52,charging=0,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=71.29%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=77,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=71.29%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=21,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=72.28%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=95,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=72.28%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=28,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=72.28%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=57,charging=1,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=72.28%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=24,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=72.28%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=25,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=72.28%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=18,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=73.27%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=81,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=74.26%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=90,charging=0,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=74.26%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=5,charging=0,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=74.26%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=63,charging=1,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=74.26%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=52,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=74.26%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=51,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=74.26%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=98,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=74.26%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=2,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=74.26%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=22,charging=0,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=75.25%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=14,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=75.25%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=96,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=75.25%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=89,charging=0,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=75.25%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=38,charging=0,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=75.25%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=18,charging=0,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=75.25%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=45,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=75.25%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=37,charging=0,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=76.24%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=30,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=77.23%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=64,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=77.23%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=97,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=77.23%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=75,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=77.23%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=100,charging=1,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=78.22%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=100,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=78.22%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=58,charging=0,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=78.22%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=95,charging=0,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=78.22%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=7,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=78.22%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=16,charging=1,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=78.22%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=32,charging=0,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=78.22%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=16,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=78.22%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=60,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=78.22%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=16,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=78.22%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=52,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=78.22%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=13,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=78.22%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=91,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=78.22%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=24,charging=0,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=79.21%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=28,charging=1,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=79.21%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=75,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=79.21%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=81,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=79.21%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=59,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=79.21%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=45,charging=0,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=79.21%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=70,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=79.21%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=66,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=79.21%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=5,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=80.20%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=93,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=80.20%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=36,charging=0,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=80.20%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=69,charging=1,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=81.19%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=74,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=81.19%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=52,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=81.19%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=3,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=81.19%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=43,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=82.18%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=79,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=83.17%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=59,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=84.16%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=84,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=84.16%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=61,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=84.16%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=17,charging=0,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=85.15%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=88,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=85.15%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=7,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=85.15%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=1,charging=1,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=85.15%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=52,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=85.15%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=50,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=85.15%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=48,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=85.15%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=95,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=85.15%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=0,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=85.15%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=89,charging=1,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=85.15%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=87,charging=0,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=85.15%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=11,charging=0,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=86.14%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=58,charging=0,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=86.14%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=48,charging=0,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=86.14%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=91,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=86.14%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=48,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=86.14%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=3,charging=0,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=86.14%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=40,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=86.14%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=40,charging=0,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=86.14%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=21,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=86.14%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=65,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=86.14%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=64,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=87.13%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=47,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=87.13%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=76,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=88.12%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=54,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=88.12%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=19,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=89.11%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=52,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=89.11%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=15,charging=0,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=89.11%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=25,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=89.11%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=93,charging=0,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=89.11%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=89,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=89.11%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=44,charging=1,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=89.11%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=92,charging=0,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=89.11%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=0,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=89.11%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=87,charging=1,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=89.11%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=44,charging=0,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=89.11%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=9,charging=1,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=89.11%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=100,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=90.10%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=75,charging=0,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=90.10%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=66,charging=0,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=90.10%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=71,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=90.10%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=13,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=90.10%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=35,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=90.10%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=3,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=90.10%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=56,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=90.10%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=39,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=90.10%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=72,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=90.10%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=93,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=90.10%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=49,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=90.10%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=29,charging=1,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=90.10%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=100,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=90.10%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=74,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=90.10%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=1,charging=0,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=90.10%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=69,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=90.10%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=25,charging=0,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=90.10%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=16,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=90.10%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=11,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=90.10%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=56,charging=0,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=90.10%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=70,charging=0,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=90.10%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=26,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=90.10%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=54,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=90.10%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=70,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=90.10%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=98,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=90.10%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=80,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=90.10%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=100,charging=1,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=91.09%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=39,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=91.09%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=63,charging=1,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=91.09%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=21,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=91.09%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=50,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=91.09%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=40,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=91.09%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=2,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=91.09%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=94,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=91.09%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=30,charging=0,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=91.09%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=16,charging=1,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=91.09%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=100,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=91.09%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=13,charging=0,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=91.09%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=53,charging=1,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=91.09%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=74,charging=0,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=91.09%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=37,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=91.09%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=0,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=91.09%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=79,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=91.09%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=12,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=91.09%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=69,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=92.08%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=32,charging=0,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=92.08%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=86,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=92.08%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=38,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=92.08%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=36,charging=1,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=92.08%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=86,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=92.08%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=5,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=92.08%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=73,charging=1,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=92.08%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=26,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=93.07%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=69,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=93.07%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=69,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=93.07%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=79,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=93.07%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=71,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=93.07%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=4,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=93.07%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=90,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=93.07%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=57,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=93.07%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=42,charging=1,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=93.07%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=30,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=94.06%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=42,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=94.06%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=26,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=94.06%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=8,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=94.06%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=100,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=95.05%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=87,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=95.05%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=84,charging=0,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=95.05%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=1,charging=0,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=95.05%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=13,charging=1,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=95.05%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=49,charging=0,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=95.05%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=54,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=95.05%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=15,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=95.05%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=11,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=95.05%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=8,charging=0,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=95.05%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=23,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=95.05%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=88,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=95.05%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=15,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=95.05%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=56,charging=0,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=95.05%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=66,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=95.05%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=78,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=95.05%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=80,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=95.05%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=19,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=95.05%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=29,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=95.05%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=40,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=95.05%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=27,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=95.05%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=3,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=95.05%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=68,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=95.05%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=33,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=96.04%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=13,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=96.04%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=64,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=96.04%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=59,charging=0,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=96.04%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=54,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=96.04%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=50,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=96.04%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=67,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=96.04%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=23,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=96.04%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=39,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=96.04%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=53,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=96.04%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=63,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=96.04%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=43,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=96.04%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=16,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=96.04%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=54,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=96.04%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=10,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=96.04%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=69,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=97.03%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=12,charging=0,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=97.03%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=94,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=97.03%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=18,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=97.03%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=63,charging=0,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=97.03%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=18,charging=0,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=97.03%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=37,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=97.03%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=19,charging=0,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=97.03%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=15,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=97.03%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=54,charging=0,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=97.03%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=46,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=97.03%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=10,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=97.03%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=26,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=97.03%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=54,charging=0,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=97.03%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=61,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=97.03%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=25,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=97.03%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=11,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=97.03%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=92,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=97.03%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=13,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=97.03%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=98,charging=1,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=97.03%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=34,charging=0,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=97.03%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=26,charging=1,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=98.02%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=64,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=98.02%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=20,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=98.02%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=90,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=98.02%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=28,charging=0,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=98.02%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=57,charging=1,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=98.02%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=47,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=98.02%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=34,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=98.02%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=50,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=98.02%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=98,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=98.02%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=21,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=98.02%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=2,charging=0,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=98.02%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=8,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=98.02%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=55,charging=0,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=98.02%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=17,charging=0,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=98.02%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=84,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=98.02%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=7,charging=0,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=98.02%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=86,charging=1,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=98.02%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=2,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=98.02%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=41,charging=1,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=98.02%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=90,charging=0,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=29,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=56,charging=1,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=38,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=51,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=54,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=84,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=33,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=4,charging=0,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=18,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=23,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=50,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=49,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=1,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=50,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=32,charging=0,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=1,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=58,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=37,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=18,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=58,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=5,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=35,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=84,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=87,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=20,charging=0,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=40,charging=0,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=25,charging=0,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=22,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=63,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=92,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=51,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=71,charging=0,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=95,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=58,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=16,charging=0,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=75,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=26,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=4,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=99,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=1,charging=0,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=64,charging=0,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=97,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=30,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=68,charging=1,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=67,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=34,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=78,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=13,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=37,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=53,charging=0,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=52,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=52,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=35,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=87,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=59,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=55,charging=1,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=56,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=2,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=52,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=65,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=15,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=14,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=82,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=13,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=96,charging=0,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=22,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=65,charging=1,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=19,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=65,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=50,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=26,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=66,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=80,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=20,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=20,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=63,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=74,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=85,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=40,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=57,charging=0,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=77,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=97,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=73,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=27,charging=0,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=60,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=13,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=25,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=15,charging=0,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=29,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=34,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=68,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=74,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=67,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=27,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=7,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=80,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=85,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=30,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=30,charging=1,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=6,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=31,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=33,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=32,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=61,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=67,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=63,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=16,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=17,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=14,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=45,charging=0,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=60,charging=0,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=31,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=13,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=91,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=35,charging=0,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=72,charging=1,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=21,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=99,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=44,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=31,charging=1,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=9,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=90,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=100,charging=1,low=1,high=0,med=0,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=66,charging=0,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=78,charging=0,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=75,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=65,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=40,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=37,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=29,charging=1,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=8,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=34,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=12,charging=0,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=60,charging=0,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=35,charging=1,low=1,high=0,med=0,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=99,charging=0,low=0,high=0,med=1,charge_status=1
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=83,charging=1,low=0,high=0,med=1,charge_status=0
# Coverage for battery_level=99.01%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=92,charging=1,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=100.00%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=94,charging=0,low=0,high=1,med=0,charge_status=1
# Coverage for battery_level=100.00%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=35,charging=0,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=100.00%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# battery_level=19,charging=1,low=0,high=1,med=0,charge_status=0
# Coverage for battery_level=100.00%
# Coverage for low=100.00%
# Coverage for med=100.00%
# Coverage for high=100.00%
# Coverage for charging=100.00%
# Coverage for charge_status=100.00%
# 
# ** Note: $stop    : testbench.sv(68)
#    Time: 5045 ns  Iteration: 1  Instance: /tb
# Break in Module tb at testbench.sv line 68
# Stopped at testbench.sv line 68
# Coverage Report by instance with details
# 
# =================================================================================
# === Instance: /tb/itf
# === Design Unit: work.battery_if
# =================================================================================
# 
# Covergroup Coverage:
#     Covergroups                      1        na        na   100.00%
#         Coverpoints/Crosses          6        na        na        na
#             Covergroup Bins        111       111         0   100.00%
# ----------------------------------------------------------------------------------------------------------
# Covergroup                                             Metric       Goal       Bins    Status               
#                                                                                                          
# ----------------------------------------------------------------------------------------------------------
#  TYPE /tb/itf/battery_cg                              100.00%        100          -    Covered              
#     covered/total bins:                                   111        111          -                      
#     missing/total bins:                                     0        111          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint cp_level                               100.00%        100          -    Covered              
#         covered/total bins:                               101        101          -                      
#         missing/total bins:                                 0        101          -                      
#         % Hit:                                        100.00%        100          -                      
#     Coverpoint cp_status1                             100.00%        100          -    Covered              
#         covered/total bins:                                 2          2          -                      
#         missing/total bins:                                 0          2          -                      
#         % Hit:                                        100.00%        100          -                      
#     Coverpoint cp_status2                             100.00%        100          -    Covered              
#         covered/total bins:                                 2          2          -                      
#         missing/total bins:                                 0          2          -                      
#         % Hit:                                        100.00%        100          -                      
#     Coverpoint cp_status3                             100.00%        100          -    Covered              
#         covered/total bins:                                 2          2          -                      
#         missing/total bins:                                 0          2          -                      
#         % Hit:                                        100.00%        100          -                      
#     Coverpoint cp_charge                              100.00%        100          -    Covered              
#         covered/total bins:                                 2          2          -                      
#         missing/total bins:                                 0          2          -                      
#         % Hit:                                        100.00%        100          -                      
#     Coverpoint cp_charge1                             100.00%        100          -    Covered              
#         covered/total bins:                                 2          2          -                      
#         missing/total bins:                                 0          2          -                      
#         % Hit:                                        100.00%        100          -                      
#  Covergroup instance \/tb/itf/cov                     100.00%        100          -    Covered              
#     covered/total bins:                                   111        111          -                      
#     missing/total bins:                                     0        111          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint cp_level                               100.00%        100          -    Covered              
#         covered/total bins:                               101        101          -                      
#         missing/total bins:                                 0        101          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin b[0]                                            5          1          -    Covered              
#         bin b[1]                                            9          1          -    Covered              
#         bin b[2]                                            5          1          -    Covered              
#         bin b[3]                                            4          1          -    Covered              
#         bin b[4]                                            6          1          -    Covered              
#         bin b[5]                                            5          1          -    Covered              
#         bin b[6]                                            2          1          -    Covered              
#         bin b[7]                                            7          1          -    Covered              
#         bin b[8]                                            4          1          -    Covered              
#         bin b[9]                                            2          1          -    Covered              
#         bin b[10]                                           2          1          -    Covered              
#         bin b[11]                                           5          1          -    Covered              
#         bin b[12]                                           3          1          -    Covered              
#         bin b[13]                                          12          1          -    Covered              
#         bin b[14]                                           4          1          -    Covered              
#         bin b[15]                                          12          1          -    Covered              
#         bin b[16]                                           9          1          -    Covered              
#         bin b[17]                                           4          1          -    Covered              
#         bin b[18]                                           6          1          -    Covered              
#         bin b[19]                                           6          1          -    Covered              
#         bin b[20]                                           6          1          -    Covered              
#         bin b[21]                                           6          1          -    Covered              
#         bin b[22]                                           4          1          -    Covered              
#         bin b[23]                                           4          1          -    Covered              
#         bin b[24]                                           4          1          -    Covered              
#         bin b[25]                                           6          1          -    Covered              
#         bin b[26]                                           9          1          -    Covered              
#         bin b[27]                                           5          1          -    Covered              
#         bin b[28]                                           5          1          -    Covered              
#         bin b[29]                                           9          1          -    Covered              
#         bin b[30]                                           8          1          -    Covered              
#         bin b[31]                                           5          1          -    Covered              
#         bin b[32]                                           5          1          -    Covered              
#         bin b[33]                                           5          1          -    Covered              
#         bin b[34]                                           5          1          -    Covered              
#         bin b[35]                                           7          1          -    Covered              
#         bin b[36]                                           2          1          -    Covered              
#         bin b[37]                                           6          1          -    Covered              
#         bin b[38]                                           4          1          -    Covered              
#         bin b[39]                                           5          1          -    Covered              
#         bin b[40]                                           8          1          -    Covered              
#         bin b[41]                                           1          1          -    Covered              
#         bin b[42]                                           2          1          -    Covered              
#         bin b[43]                                           2          1          -    Covered              
#         bin b[44]                                           4          1          -    Covered              
#         bin b[45]                                           3          1          -    Covered              
#         bin b[46]                                           2          1          -    Covered              
#         bin b[47]                                           2          1          -    Covered              
#         bin b[48]                                           5          1          -    Covered              
#         bin b[49]                                           6          1          -    Covered              
#         bin b[50]                                           8          1          -    Covered              
#         bin b[51]                                           4          1          -    Covered              
#         bin b[52]                                          10          1          -    Covered              
#         bin b[53]                                           4          1          -    Covered              
#         bin b[54]                                           8          1          -    Covered              
#         bin b[55]                                           5          1          -    Covered              
#         bin b[56]                                           7          1          -    Covered              
#         bin b[57]                                           5          1          -    Covered              
#         bin b[58]                                           6          1          -    Covered              
#         bin b[59]                                           5          1          -    Covered              
#         bin b[60]                                           5          1          -    Covered              
#         bin b[61]                                           3          1          -    Covered              
#         bin b[62]                                           1          1          -    Covered              
#         bin b[63]                                           8          1          -    Covered              
#         bin b[64]                                           8          1          -    Covered              
#         bin b[65]                                           5          1          -    Covered              
#         bin b[66]                                           5          1          -    Covered              
#         bin b[67]                                           5          1          -    Covered              
#         bin b[68]                                           3          1          -    Covered              
#         bin b[69]                                           8          1          -    Covered              
#         bin b[70]                                           4          1          -    Covered              
#         bin b[71]                                           5          1          -    Covered              
#         bin b[72]                                           3          1          -    Covered              
#         bin b[73]                                           2          1          -    Covered              
#         bin b[74]                                           6          1          -    Covered              
#         bin b[75]                                           5          1          -    Covered              
#         bin b[76]                                           3          1          -    Covered              
#         bin b[77]                                           2          1          -    Covered              
#         bin b[78]                                           4          1          -    Covered              
#         bin b[79]                                           3          1          -    Covered              
#         bin b[80]                                           4          1          -    Covered              
#         bin b[81]                                           5          1          -    Covered              
#         bin b[82]                                           2          1          -    Covered              
#         bin b[83]                                           1          1          -    Covered              
#         bin b[84]                                           8          1          -    Covered              
#         bin b[85]                                           4          1          -    Covered              
#         bin b[86]                                           5          1          -    Covered              
#         bin b[87]                                           5          1          -    Covered              
#         bin b[88]                                           4          1          -    Covered              
#         bin b[89]                                           5          1          -    Covered              
#         bin b[90]                                           6          1          -    Covered              
#         bin b[91]                                           3          1          -    Covered              
#         bin b[92]                                           5          1          -    Covered              
#         bin b[93]                                           5          1          -    Covered              
#         bin b[94]                                           4          1          -    Covered              
#         bin b[95]                                           5          1          -    Covered              
#         bin b[96]                                           3          1          -    Covered              
#         bin b[97]                                           5          1          -    Covered              
#         bin b[98]                                           5          1          -    Covered              
#         bin b[99]                                           4          1          -    Covered              
#         bin b[100]                                          9          1          -    Covered              
#     Coverpoint cp_status1                             100.00%        100          -    Covered              
#         covered/total bins:                                 2          2          -                      
#         missing/total bins:                                 0          2          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin auto[0]                                       386          1          -    Covered              
#         bin auto[1]                                       118          1          -    Covered              
#     Coverpoint cp_status2                             100.00%        100          -    Covered              
#         covered/total bins:                                 2          2          -                      
#         missing/total bins:                                 0          2          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin auto[0]                                       411          1          -    Covered              
#         bin auto[1]                                        93          1          -    Covered              
#     Coverpoint cp_status3                             100.00%        100          -    Covered              
#         covered/total bins:                                 2          2          -                      
#         missing/total bins:                                 0          2          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin auto[0]                                       212          1          -    Covered              
#         bin auto[1]                                       292          1          -    Covered              
#     Coverpoint cp_charge                              100.00%        100          -    Covered              
#         covered/total bins:                                 2          2          -                      
#         missing/total bins:                                 0          2          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin charging_on                                   259          1          -    Covered              
#         bin charging_off                                  245          1          -    Covered              
#     Coverpoint cp_charge1                             100.00%        100          -    Covered              
#         covered/total bins:                                 2          2          -                      
#         missing/total bins:                                 0          2          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin auto[0]                                       245          1          -    Covered              
#         bin auto[1]                                       259          1          -    Covered              
#  
# TOTAL COVERGROUP COVERAGE: 100.00%  COVERGROUP TYPES: 1
# 
# Total Coverage By Instance (filtered view): 100.00%
