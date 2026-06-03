class Header;
  rand bit [3:0] version;
  rand bit [1:0] ptype;
  rand bit [7:0] length;
  constraint c_ver { version inside {4, 6}; }
  constraint c_len { length  inside {[20:60]}; }
endclass

class Payload;
  rand byte data [];
  constraint c_size { data.size() inside {[0:64]}; }
endclass

class Packet;
  rand Header  hdr;
  rand Payload body;
  rand bit [15:0] src_port;

  constraint c_port {
    src_port > 1023;
  }

  constraint c_cross {
    (hdr.ptype==2'b10) -> body.data.size() > 10;
  }

  function new();
    hdr = new();  
    body = new();
  endfunction
endclass

module test;
  initial begin
    Packet p = new();
    if (p.randomize()) begin
      $display("version=%0d, ptype=%0d, length=%0d, src_port=%0d",p.hdr.version, p.hdr.ptype, p.hdr.length, p.src_port);
      $display("data size=%0d, data=%p", p.body.data.size(), p.body.data);
    end 
    else begin
      $display("Randomization failed!");
    end
    end
endmodule
/*
output:
version=4, ptype=1, length=37, src_port=25297

data size=55, data='{-93, -113, 17, -118, -60, 115, 66, 73, -2, -16, -86, -93, 30, -120, -45, -33, -111, 120, -6, 47, 100, -63, -11, -83, -111, 11, 119, 102, -78, 49, 42, 107, 81, 74, 12, 2, 31, 85, -57, -122, -35, 21, -68, -114, 18, 48, -49, -67, -112, 124, -49, -65, 103, 55, -67} 
           V C S   S i m u l a t i o n   R e p o r t 
*/
