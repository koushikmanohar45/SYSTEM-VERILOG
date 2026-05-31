virtual class protocol;
  
  bit[10:0] data_frame;
  

  virtual function void transfer();
    $display("data_frame=%b",data_frame);
  endfunction

endclass

class uart extends protocol;
  bit [7:0] data;
  bit start_bit;
  bit stop_bit;
  bit parity;
  
  function new(bit[7:0]d);
    start_bit=0;
    stop_bit=0;
    data=d;
    parity=^data;
  endfunction
  
  function void transfer();
    data_frame={stop_bit,parity,data,start_bit};
    $display("====");
    $display("UART");
    $display("====");
    $display("data_frame=%b",data_frame);
  endfunction
  
endclass

class spi extends protocol;
  bit miso;
  bit scl;
  bit cpol;
  bit cpha;
  bit[10:0]data;
  
  function new(bit[10:0]d);
    cpol=0;
    cpha=0;
    data=d;
    scl=1;
  endfunction
      
  function void transfer();
    $display("===");
    $display("SPI");
    $display("===");
    for(int i=0;i<=10;i++)begin
      miso=data[i];
      if(scl)begin
         data_frame={miso,data_frame[10:1]};
        $display("data_frame in leading edge of scl=%b",data_frame);
      end
    end     
  endfunction 
    
 endclass
    
module tb;
  
  protocol p;
  uart u;
  spi s;
  
  initial begin
    
    //p=new() (illegal to create object for virtual class)
    
    u=new(25);
    u.transfer();
    
    s=new(30);
    s.transfer();
    
    p=u;
    p.transfer();
    
    p=s;
    s.transfer();
    
  end
endmodule

/*

output:

====
UART
====
data_frame=01000110010
===
SPI
===
data_frame in leading edge of scl=00000000000
data_frame in leading edge of scl=10000000000
data_frame in leading edge of scl=11000000000
data_frame in leading edge of scl=11100000000
data_frame in leading edge of scl=11110000000
data_frame in leading edge of scl=01111000000
data_frame in leading edge of scl=00111100000
data_frame in leading edge of scl=00011110000
data_frame in leading edge of scl=00001111000
data_frame in leading edge of scl=00000111100
data_frame in leading edge of scl=00000011110
====
UART
====
data_frame=01000110010
===
SPI
===
data_frame in leading edge of scl=00000001111
data_frame in leading edge of scl=10000000111
data_frame in leading edge of scl=11000000011
data_frame in leading edge of scl=11100000001
data_frame in leading edge of scl=11110000000
data_frame in leading edge of scl=01111000000
data_frame in leading edge of scl=00111100000
data_frame in leading edge of scl=00011110000
data_frame in leading edge of scl=00001111000
data_frame in leading edge of scl=00000111100
data_frame in leading edge of scl=00000011110
           V C S   S i m u l a t i o n   R e p o r t 
*/
        
    
    
  
