class transaction;

  rand bit [7:0] data;

  function void gen_data();
    data = $urandom_range(0,255);
    $display("Generated Data = %b", data);
  endfunction
  
  function void display();
    $display("DATA GENERATED");
  endfunction

endclass


class uart_trans extends transaction;

  bit start_bit;
  bit stop_bit;

  function void frame_uart();
    start_bit=0;
    stop_bit=1;
    $display("UART Frame Created");
  endfunction
  
  function void display();
    $display("START BIT AND STOP BIT GENERATED ");
  endfunction

endclass


class uart_tx_parity_trans extends uart_trans;
  
  bit parity;

  function void cal_parity();
    parity=^data;
    $display("Parity = %0b",parity);
  endfunction
  
  function void display();
    super.display;
    $display("PARITY GENERATED");
  endfunction

endclass


class  uart_tx_trans extends uart_tx_parity_trans;

    bit [9:0] tx_frame;

  function void transmit();
    tx_frame = {stop_bit, data, start_bit};
    $display("TX Frame = %b", tx_frame);
  endfunction
  
  function void display();
     $display("FRAME CREATED");
  endfunction

endclass


module tb;

  uart_tx_trans uart;
  uart_tx_parity_trans u1;
  transaction  t1;
  
  initial begin

    uart=new();
    u1=new();
    t1=new();
    
    uart.gen_data();  
    uart.frame_uart();  
    uart.transmit(); 
    uart.cal_parity();
    $display("");
    
    //displaying over-ridden methods by creating objects
    
    t1.display();
    $display("");
    u1.display();
    $display("");
    uart.display();

  end

endmodule

/*
output:
Generated Data = 11100010
UART Frame Created
TX Frame = 1111000100
Parity = 0

DATA GENERATED

START BIT AND STOP BIT GENERATED 
PARITY GENERATED

FRAME CREATED
           V C S   S i m u l a t i o n   R e p o r t 
*/
