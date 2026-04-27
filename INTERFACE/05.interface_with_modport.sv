//DESIGN
module door_lock(door.dut itf);
  
  typedef enum logic [2:0] {IDLE,WAIT_PASSWORD,CHECK_PASSWORD,OPEN_DOOR,ALARM}state_t;
  state_t state,nxt_state;
  reg [1:0]count;
  
  always@(posedge itf.clk)begin
    if(itf.rst)
      state<=IDLE;
    else
      state<=nxt_state;
   end
  
  always@(*)begin
    case(state)
      IDLE:nxt_state=WAIT_PASSWORD;
      
      WAIT_PASSWORD:nxt_state=(itf.enter)?CHECK_PASSWORD:WAIT_PASSWORD;
      
      CHECK_PASSWORD:begin
        if(itf.password==1234)
          nxt_state=OPEN_DOOR;
        else if(count<2)
           nxt_state=WAIT_PASSWORD;
        else
          nxt_state=ALARM;
      end
      
      OPEN_DOOR:nxt_state=OPEN_DOOR;
      
      ALARM:nxt_state=ALARM;
      
      default:nxt_state=IDLE;
    endcase
   end
  
  always @(posedge itf.clk)begin
    if(itf.rst)
      count<=0;
    else begin
      if( itf.password!=8'h26 && count < 3)
        count<=count+1;
      else
        count<=count;
    end
  end
      
    assign itf.pass_ok=(state==OPEN_DOOR);
    assign itf.door_open=(state==OPEN_DOOR);
    assign itf.alarm=(state==ALARM);

endmodule

//TESHBENCH

interface door(input logic clk);

  logic rst;
  logic[15:0]password;
  logic enter;
  logic pass_ok;
  logic door_open;
  logic alarm;
  
  modport dut(input clk,input rst,input password,input enter,output pass_ok,output door_open,output alarm);
  modport tb(input clk,output rst,output password,output enter,input pass_ok,input door_open,input alarm);
  
endinterface


module top;

  logic clk = 0;
  always #5 clk = ~clk;

  door itf(clk);

  door_lock dut(itf);
  driver tb(itf);
  
  initial begin
        $dumpfile("v.vcd");
    $dumpvars(0,top);
  end

endmodule


module driver(door.tb itf);

  task send_pass(input [15:0] p);
    begin
      @(posedge itf.clk);
      itf.password =p;
      itf.enter=1;

      @(posedge itf.clk);
      itf.enter=0;
    end
  endtask


  initial begin

    // Reset
    itf.rst=1;
    itf.password=0;
    itf.enter= 0;

    repeat(2) @(posedge itf.clk);
    itf.rst=0;
    send_pass(9012);
    #10
    itf.rst=1;
    #10
    itf.rst=0;
    send_pass(1234);
    #30
    itf.rst=1;
    #10
    itf.rst=0;
    send_pass(5555);
    #5;
    send_pass(2344);
    #5
    send_pass(1456);
    #5
    send_pass(5455);
    #5;
    send_pass(1235);

    $finish;
  end
  
  initial begin
    $monitor("clk=%0t;rst=%b;password=%0d;enter=%b;pass_ok=%b;door_open=%b;ALARM=%b",itf.clk,itf.rst,itf.password,itf.enter,itf.pass_ok,itf.door_open,itf.alarm); 
  end

endmodule

/*
OUTPUT:
clk=0; rst=1;password=0;enter=0;pass_ok=x;door_open=x;ALARM=x
clk=1; rst=1;password=0;enter=0;pass_ok=0;door_open=0;ALARM=0
clk=0; rst=1;password=0;enter=0;pass_ok=0;door_open=0;ALARM=0
clk=1; rst=0;password=0;enter=0;pass_ok=0;door_open=0;ALARM=0
clk=0; rst=0;password=0;enter=0;pass_ok=0;door_open=0;ALARM=0
clk=1; rst=0;password=9012;enter=1;pass_ok=0;door_open=0;ALARM=0
clk=0; rst=0;password=9012;enter=1;pass_ok=0;door_open=0;ALARM=0
clk=1; rst=0;password=9012;enter=0;pass_ok=0;door_open=0;ALARM=0
clk=0; rst=0;password=9012;enter=0;pass_ok=0;door_open=0;ALARM=0
clk=1; rst=1;password=9012;enter=0;pass_ok=0;door_open=0;ALARM=0
clk=0; rst=1;password=9012;enter=0;pass_ok=0;door_open=0;ALARM=0
clk=1; rst=0;password=1234;enter=1;pass_ok=0;door_open=0;ALARM=0
clk=0; rst=0;password=1234;enter=1;pass_ok=0;door_open=0;ALARM=0
clk=1; rst=0;password=1234;enter=0;pass_ok=0;door_open=0;ALARM=0
clk=0; rst=0;password=1234;enter=0;pass_ok=0;door_open=0;ALARM=0
clk=1; rst=0;password=1234;enter=0;pass_ok=1;door_open=1;ALARM=0
clk=0; rst=0;password=1234;enter=0;pass_ok=1;door_open=1;ALARM=0
clk=1; rst=0;password=1234;enter=0;pass_ok=1;door_open=1;ALARM=0
clk=0; rst=0;password=1234;enter=0;pass_ok=1;door_open=1;ALARM=0
clk=1; rst=1;password=1234;enter=0;pass_ok=0;door_open=0;ALARM=0
clk=0; rst=1;password=1234;enter=0;pass_ok=0;door_open=0;ALARM=0
clk=1; rst=0;password=5555;enter=1;pass_ok=0;door_open=0;ALARM=0
clk=0; rst=0;password=5555;enter=1;pass_ok=0;door_open=0;ALARM=0
clk=1; rst=0;password=5555;enter=0;pass_ok=0;door_open=0;ALARM=0
clk=0; rst=0;password=5555;enter=0;pass_ok=0;door_open=0;ALARM=0
clk=1; rst=0;password=2344;enter=1;pass_ok=0;door_open=0;ALARM=1
clk=0; rst=0;password=2344;enter=1;pass_ok=0;door_open=0;ALARM=1
clk=1; rst=0;password=2344;enter=0;pass_ok=0;door_open=0;ALARM=1
clk=0; rst=0;password=2344;enter=0;pass_ok=0;door_open=0;ALARM=1
clk=1; rst=0;password=1456;enter=1;pass_ok=0;door_open=0;ALARM=1
clk=0; rst=0;password=1456;enter=1;pass_ok=0;door_open=0;ALARM=1
clk=1; rst=0;password=1456;enter=0;pass_ok=0;door_open=0;ALARM=1
clk=0; rst=0;password=1456;enter=0;pass_ok=0;door_open=0;ALARM=1
clk=1; rst=0;password=5455;enter=1;pass_ok=0;door_open=0;ALARM=1
clk=0; rst=0;password=5455;enter=1;pass_ok=0;door_open=0;ALARM=1
clk=1; rst=0;password=5455;enter=0;pass_ok=0;door_open=0;ALARM=1
clk=0; rst=0;password=5455;enter=0;pass_ok=0;door_open=0;ALARM=1
clk=1; rst=0;password=1235;enter=1;pass_ok=0;door_open=0;ALARM=1
clk=0; rst=0;password=1235;enter=1;pass_ok=0;door_open=0;ALARM=1
clk=1; rst=0;password=1235;enter=0;pass_ok=0;door_open=0;ALARM=1
clk=0; rst=0;password=1235;enter=0;pass_ok=0;door_open=0;ALARM=1
clk=1; rst=0;password=1235;enter=0;pass_ok=0;door_open=0;ALARM=1
clk=0; rst=0;password=1235;enter=0;pass_ok=0;door_open=0;ALARM=1
clk=1; rst=0;password=1235;enter=0;pass_ok=0;door_open=0;ALARM=1
clk=0; rst=0;password=1235;enter=0;pass_ok=0;door_open=0;ALARM=1
$finish called from file "testbench.sv", line 80.
$finish at simulation time                  225
           V C S   S i m u l a t i o n   R e p o r t 
*/



