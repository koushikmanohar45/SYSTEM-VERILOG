                                            //DESIGN
module design_v(fan.dut vif); 
  always @(posedge vif.clk)begin 
    if(vif.autometic)begin 
      if (vif.temp<20) begin 
        vif.fan_off=1; 
      end 
      else if (vif.temp<50) begin 
        vif.fan_low=1; 
      end 
      else if (vif.temp<80) begin 
        vif.fan_medium=1; 
      end 
      else begin 
        vif.fan_high=1; 
      end 
    end 
    else if(vif.manual)begin 
      vif.fan_off=$urandom; 
      if(vif.fan_off)begin 
        vif.fan_low=0; 
        vif.fan_high=0; 
        vif.fan_medium=0; 
      end 
      else begin 
        vif.fan_low=$urandom; 
        if(vif.fan_low)begin 
          vif.fan_high=0; 
          vif.fan_medium=0; 
        end 
        else begin 
          vif.fan_high=$urandom; 
          if(vif.fan_high) 
            vif.fan_medium=0; 
          else vif.fan_medium=1; 
        end 
      end 
    end 
  end 
endmodule
                                           //TESTBENCH

//INTERFACE
interface fan(input logic clk);
  logic manual;
  logic autometic;
  logic [6:0]temp;
  logic fan_off;
  logic fan_low;
  logic fan_high;
  logic fan_medium;
  
  //CLOCKING BLOCK
  clocking drv @(posedge clk);
    default input #2 output #1;
    
    output manual;
    output autometic;
    output temp;

    input fan_off;
    input fan_low;
    input fan_medium;
    input fan_high; 
  endclocking

  //MODPORTS
  modport drive(clocking drv);
    
  modport dut(input clk,manual,autometic,temp,output fan_off,fan_low,fan_high,fan_medium);
  
  modport mtr(input manual,autometic,temp,fan_off,fan_low,fan_high,fan_medium);
  
endinterface

//DRIVER CLASS
  
class driver;
  
  //VIRTUAL INTERFCE DECLARATION (MODPORT DRIVE)
  virtual fan.drive vif;
  
  //CONSTRUCTOR
  function new(virtual fan.drive vif);
    this.vif=vif;
  endfunction

  
  task run();
    reg rand_val;
    repeat (20) begin
      @(vif.drv);
      rand_val=$urandom_range(0,1);
      if (rand_val)
        drive_auto();
      else
        drive_manu();
    end
  endtask

  //AUTOMATIC DRIVER
  task drive_auto();
     vif.drv.manual<=0;
     vif.drv.autometic<=1;
     vif.drv.temp<=$urandom_range(0,100);
  endtask

  //MANUAL DRIVER
  task drive_manu();
    vif.drv.manual<=1;
    vif.drv.autometic<=0;
    vif.drv.temp<=$urandom_range(0,100);
  endtask
  
endclass

//monitor class    
class monitor;
  //VIRTUAL INTERFACE DECLARATION(MODPORT MTR)
  virtual fan.mtr vif;
  //CONSTRUCTOR
  function new(virtual fan.mtr vif);
    this.vif=vif;
  endfunction
  task display(); 
    repeat(20)begin
      #10;
      $display("manual=%B,autometic=%B,temp=%0d,fan_off=%B,fan_low=%B,fan_high=%B,fan_medium=%B",vif.manual,vif.autometic,vif.temp,vif.fan_off,vif.fan_low,vif.fan_high,vif.fan_medium);
    end
  endtask
endclass

    
//TEST 
module test(fan vif);  
  //CREATE HANDLE
  driver dri;
  monitor m;
  initial begin 
    m=new(vif);
    dri=new(vif); 
    fork
      dri.run();//ACCESSING TASK IN  A CLASS USING HANDLE  
      m.display();
    join
    #200; $finish;
  end
  
endmodule 

// TOP-TB
module tb_top();
  
  logic clk=0;
  always#5 clk=~clk;
     
  fan vif(clk);//CONNECTING INTERFACE WITH TOP
  test t1(vif); //CONNECTING TESTMODULE WITH TOP  
  design_v d1(vif);//CONNECTING DESIGN WITH TOP
endmodule

    /*
    OUTPUT:
    manual=0,autometic=1,temp=74,fan_off=x,fan_low=x,fan_high=x,fan_medium=x
    manual=0,autometic=1,temp=71,fan_off=x,fan_low=x,fan_high=x,fan_medium=1
    manual=1,autometic=0,temp=68,fan_off=x,fan_low=x,fan_high=x,fan_medium=1
    manual=0,autometic=1,temp=66,fan_off=0,fan_low=0,fan_high=1,fan_medium=0
    manual=1,autometic=0,temp=26,fan_off=0,fan_low=0,fan_high=1,fan_medium=1
    manual=1,autometic=0,temp=38,fan_off=0,fan_low=1,fan_high=0,fan_medium=0
    manual=0,autometic=1,temp=22,fan_off=1,fan_low=0,fan_high=0,fan_medium=0
    manual=0,autometic=1,temp=40,fan_off=1,fan_low=1,fan_high=0,fan_medium=0
    manual=0,autometic=1,temp=72,fan_off=1,fan_low=1,fan_high=0,fan_medium=0
    manual=1,autometic=0,temp=25,fan_off=1,fan_low=1,fan_high=0,fan_medium=1
    manual=0,autometic=1,temp=23,fan_off=0,fan_low=1,fan_high=0,fan_medium=0
    manual=1,autometic=0,temp=57,fan_off=0,fan_low=1,fan_high=0,fan_medium=0
    manual=1,autometic=0,temp=7,fan_off=0,fan_low=1,fan_high=0,fan_medium=0
    manual=0,autometic=1,temp=43,fan_off=1,fan_low=0,fan_high=0,fan_medium=0
    manual=1,autometic=0,temp=22,fan_off=1,fan_low=1,fan_high=0,fan_medium=0
    manual=1,autometic=0,temp=87,fan_off=0,fan_low=0,fan_high=1,fan_medium=0
    manual=0,autometic=1,temp=33,fan_off=1,fan_low=0,fan_high=0,fan_medium=0
    manual=1,autometic=0,temp=25,fan_off=1,fan_low=1,fan_high=0,fan_medium=0
    manual=1,autometic=0,temp=53,fan_off=0,fan_low=0,fan_high=1,fan_medium=0
    manual=0,autometic=1,temp=67,fan_off=0,fan_low=0,fan_high=0,fan_medium=1
    $finish called from file "testbench.sv", line 93.
    $finish at simulation time    400
               V C S   S i m u l a t i o n   R e p o r t 
    */
  
  
