class memory;

  bit [7:0] mem [0:15];
  bit[7:0] data_out;
  
 function static int read_data_static (int addr);
    
   fork 
    if(addr>15 || addr<0) begin
      $display("INVALID ADDRESS");
      read_data_static=-1;
     // return -1 Illege inside fork join
      $display("TASK CALLED");
    end
     
    else begin
      $display("VALID ADDRESS");
      read_data_static=1;
     // return 1 Illege inside fork join
      $display("TASK CALLED");
      display(addr);
    end
     
   join_none
      
  endfunction
  
  function automatic int read_data_automatic(int addr);

   fork 
    if(addr>15 || addr<0) begin
      $display("INVALID ADDRESS");
      read_data_automatic=-1;
      //  return -1; Illege inside fork join
      $display("TASK CALLED");
    end
     
    else begin
      $display("VALID ADDRESS");
      read_data_automatic=1;
      //return 1 illegal inside inside fork join
      $display("TASK CALLED");
      display(addr);
    end
     
   join_none

  endfunction
  
  task display(int addr);
     #1;
     data_out=mem[addr];
  endtask
    

endclass



module test;

  memory m1;

  int data;

  initial begin

    m1=new();

    for(int i=0;i<15;i++)begin
      m1.mem[i]=i*i*i;
    end
    
    $monitor("[time=%0t] DATA=%0d",$time, m1.data_out);
    data=m1.read_data_static(5);
    #1;
    data=m1.read_data_automatic(10);

  end

endmodule
/*
OUTPUT:
VALID ADDRESS
TASK CALLED
[time=0] DATA=0
VALID ADDRESS
TASK CALLED
[time=1] DATA=125
[time=2] DATA=232
*/
