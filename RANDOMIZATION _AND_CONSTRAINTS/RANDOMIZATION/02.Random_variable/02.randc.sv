class random;
  randc bit[1:0] a;
  randc reg [1:0] b;
  randc bit[1:0] sel;
  logic [3:0] out;
  
  task alu_operation();
    begin
    case(sel)
      2'b00:out=a+b;
      2'b01:out=a-b;
      2'b10:out=a*b;
      2'b11:out=a/b;
      default:out=16'd0;
    endcase
    end
  endtask
endclass

class print extends random;
  task display();
    begin
      $display("value of A(randc)=%0d",a);
      $display("value of B(randc)=%0d",b);
      $display("value of sel(randc)=%0d",sel);
      if(sel==2'b00)
        $display("A+B=%0d",out);
      else if(sel==2'b01)
        $display("A-B=%0d",out);
      else if(sel==2'b10)
        $display("A*B=%0d",out);
      else 
        $display("A/B=%0d",out);
    end
  endtask
endclass


module randomize();
  print r;
 
  initial begin
     r=new();
    $display("==================================================");
    $display("                      RANDOMIZE                    ");
    $display("==================================================");
    $display("-----------------------ALU------------------------");
     repeat(20) begin
       r.randomize;
       r.alu_operation();
       r.display();
       $display("--------------------------------------------------");
       #10;
     end
  end
  
endmodule
  



/*
==================================================
                      RANDOMIZE                    
==================================================
-----------------------ALU------------------------
value of A(randc)=3
value of B(randc)=2
value of sel(randc)=2
A*B=6
--------------------------------------------------
value of A(randc)=1
value of B(randc)=0
value of sel(randc)=0
A+B=1
--------------------------------------------------
value of A(randc)=0
value of B(randc)=1
value of sel(randc)=1
A-B=15
--------------------------------------------------
value of A(randc)=2
value of B(randc)=3
value of sel(randc)=3
A/B=0
--------------------------------------------------
value of A(randc)=2
value of B(randc)=2
value of sel(randc)=3
A/B=1
--------------------------------------------------
value of A(randc)=0
value of B(randc)=3
value of sel(randc)=0
A+B=3
--------------------------------------------------
value of A(randc)=1
value of B(randc)=0
value of sel(randc)=2
A*B=0
--------------------------------------------------
value of A(randc)=3
value of B(randc)=1
value of sel(randc)=1
A-B=2
--------------------------------------------------
value of A(randc)=1
value of B(randc)=1
value of sel(randc)=1
A-B=0
--------------------------------------------------
value of A(randc)=0
value of B(randc)=3
value of sel(randc)=0
A+B=3
--------------------------------------------------
value of A(randc)=2
value of B(randc)=0
value of sel(randc)=3
A/B=x
--------------------------------------------------
value of A(randc)=3
value of B(randc)=2
value of sel(randc)=2
A*B=6
--------------------------------------------------
value of A(randc)=3
value of B(randc)=3
value of sel(randc)=2
A*B=9
--------------------------------------------------
value of A(randc)=2
value of B(randc)=2
value of sel(randc)=3
A/B=1
--------------------------------------------------
value of A(randc)=0
value of B(randc)=0
value of sel(randc)=1
A-B=0
--------------------------------------------------
value of A(randc)=1
value of B(randc)=1
value of sel(randc)=0
A+B=2
--------------------------------------------------
value of A(randc)=0
value of B(randc)=3
value of sel(randc)=3
A/B=0
--------------------------------------------------
value of A(randc)=2
value of B(randc)=0
value of sel(randc)=0
A+B=2
--------------------------------------------------
value of A(randc)=1
value of B(randc)=1
value of sel(randc)=2
A*B=1
--------------------------------------------------
value of A(randc)=3
value of B(randc)=2
value of sel(randc)=1
A-B=1
--------------------------------------------------
           V C S   S i m u l a t i o n   R e p o r t 
*/
