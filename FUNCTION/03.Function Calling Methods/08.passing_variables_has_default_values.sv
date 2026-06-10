class memory;

  bit [7:0] mem [0:15];
  
  function static int read_data_static (int addr=5);
    
    if(addr > 15 || addr < 0) begin
      $display("INVALID ADDRESS");
      return -1;
    end

    return mem[addr];

  endfunction
  
  function automatic int read_data_automatic(int addr=10);

    if(addr > 15 || addr < 0) begin
      $display("INVALID ADDRESS");
      return -1;
    end

    return mem[addr];

  endfunction

endclass



module test;

  memory m1;

  int data;

  initial begin

    m1=new();

    for(int i=0;i<15;i++)begin
      m1.mem[i]=i*i*i;
    end

    data=m1.read_data_static();
    $display("DATA=%0d", data);

    data=m1.read_data_automatic();
    $display("DATA=%0d", data);

  end

endmodule

/*
OUTPUT:
DATA=125
DATA=232
           V C S   S i m u l a t i o n   R e p o r t 
*/
