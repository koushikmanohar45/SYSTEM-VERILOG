module set_membership_operator;
  logic [7:0]a,b;

  task automatic display();
     begin
       $display("DISPLAYING OPERANDS:");
       $display(" a=%B \n b=%B",a,b);
       $display("OPERATORS COMMON TO VERILOG AND SYSTEM VERILOG");
       $display(" a inside {1,2,3,4} =%B",a inside {1,2,3,4});
       $display(" b inside {[0:5]} =%B",b inside {[0:5]});
       $display(" a inside {8'h0,8'hF} =%B",a inside {8'h0,8'hF});
       $display(" b inside {[8'd10:8'd20]} =%B",b inside {[8'd10:8'd20]});
       $display("------------------------------------------------------");
     end
  endtask
    
  initial begin
    a=8'he;b=8'hd;
    $display("================= SET MEMBERSHIP OPERATORS =================");
    display();
    #1 a=8'b11;b=8'b0111;  
    display();
    #1 a=8'd1;b=8'd0;  
    display();
    #1 a=8'd255;b=8'd12;
    display();
    #1 a=8'd200;b=8'd1;
    display(); 
    #1 a=8'd200;b=8'd200;
    display();
    #1 a=8'd12;b=8'd0;
    display();
    #1 $finish;
end
endmodule


/*
OUTPUT:
================= SET MEMBERSHIP OPERATORS =================
NEW OPERATORS USED IN SYSTEM VERILOG
DISPLAYING OPERANDS:
 a=14 
 b=13
 a inside {1,2,3,4} =0
 b inside {[0:5]} =0
 a inside {8'h0,8'hF} =0
 b inside {[8'd10:8'd20]} =1
------------------------------------------------------
DISPLAYING OPERANDS:
 a=3 
 b=7
 a inside {1,2,3,4} =1
 b inside {[0:5]} =0
 a inside {8'h0,8'hF} =0
 b inside {[8'd10:8'd20]} =0
------------------------------------------------------
DISPLAYING OPERANDS:
 a=1 
 b=0
 a inside {1,2,3,4} =1
 b inside {[0:5]} =1
 a inside {8'h0,8'hF} =0
 b inside {[8'd10:8'd20]} =0
------------------------------------------------------
DISPLAYING OPERANDS:
 a=255 
 b=12
 a inside {1,2,3,4} =0
 b inside {[0:5]} =0
 a inside {8'h0,8'hF} =0
 b inside {[8'd10:8'd20]} =1
------------------------------------------------------
DISPLAYING OPERANDS:
 a=200 
 b=1
 a inside {1,2,3,4} =0
 b inside {[0:5]} =1
 a inside {8'h0,8'hF} =0
 b inside {[8'd10:8'd20]} =0
------------------------------------------------------
DISPLAYING OPERANDS:
 a=200 
 b=200
 a inside {1,2,3,4} =0
 b inside {[0:5]} =0
 a inside {8'h0,8'hF} =0
 b inside {[8'd10:8'd20]} =0
------------------------------------------------------
DISPLAYING OPERANDS:
 a=12 
 b=0
 a inside {1,2,3,4} =0
 b inside {[0:5]} =1
 a inside {8'h0,8'hF} =0
 b inside {[8'd10:8'd20]} =0
------------------------------------------------------
$finish called from file "testbench.sv", line 33.
$finish at simulation time                    7
           V C S   S i m u l a t i o n   R e p o r t 
*/
