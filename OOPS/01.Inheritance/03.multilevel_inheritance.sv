class transaction;

  rand bit [7:0] data;

  function void generate_data();
    data = $urandom_range(0,255);
    $display("Generated Data = %b", data);
  endfunction

endclass

class uart_transaction extends transaction;

  bit start_bit;
  bit stop_bit;

  function void frame_uart();
    start_bit=0;
    stop_bit=1;
    $display("UART Frame Created");
  endfunction

endclass


class uart_tx_transaction extends uart_transaction;

  bit [9:0] tx_frame;

  function void transmit();
    tx_frame = {stop_bit, data, start_bit};
    $display("TX Frame = %b", tx_frame);
  endfunction

endclass


class uart_tx_parity_transaction extends uart_tx_transaction;

  bit parity;

  function void calculate_parity();
    parity = ^data;
    $display("Parity = %0b", parity);
  endfunction

endclass


module tb;

  uart_tx_parity_transaction uart;

  initial begin

    uart=new();
    uart.generate_data();  
    uart.frame_uart();  
    uart.transmit(); 
    uart.calculate_parity();

  end

endmodule

/*
output:
Generated Data = 00111100
UART Frame Created
TX Frame = 1001111000
Parity = 0
           V C S   S i m u l a t i o n   R e p o r t 
*/
