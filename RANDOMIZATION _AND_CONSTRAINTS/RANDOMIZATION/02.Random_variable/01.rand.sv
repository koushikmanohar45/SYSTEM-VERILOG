class random;
  rand bit[1:0] a;
  rand reg [1:0] b;
  rand bit[1:0] sel;
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
    $display("value of A(rand)=%0d",a);
    $display("value of B(rand)=%0d",b);
    $display("value of sel(rand)=%0d",sel);
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
OUTPUT:
==================================================
                      RANDOMIZE                    
==================================================
-----------------------ALU------------------------
value of A(rand)=1
value of B(rand)=0
value of sel(rand)=3
A/B=x
--------------------------------------------------
value of A(rand)=3
value of B(rand)=0
value of sel(rand)=2
A*B=0
--------------------------------------------------
value of A(rand)=2
value of B(rand)=2
value of sel(rand)=3
A/B=1
--------------------------------------------------
value of A(rand)=3
value of B(rand)=2
value of sel(rand)=1
A-B=1
--------------------------------------------------
value of A(rand)=0
value of B(rand)=0
value of sel(rand)=0
A+B=0
--------------------------------------------------
value of A(rand)=3
value of B(rand)=2
value of sel(rand)=0
A+B=5
--------------------------------------------------
value of A(rand)=2
value of B(rand)=0
value of sel(rand)=1
A-B=2
--------------------------------------------------
value of A(rand)=3
value of B(rand)=2
value of sel(rand)=1
A-B=1
--------------------------------------------------
value of A(rand)=0
value of B(rand)=3
value of sel(rand)=2
A*B=0
--------------------------------------------------
value of A(rand)=1
value of B(rand)=3
value of sel(rand)=0
A+B=4
--------------------------------------------------
value of A(rand)=1
value of B(rand)=3
value of sel(rand)=2
A*B=3
--------------------------------------------------
value of A(rand)=0
value of B(rand)=2
value of sel(rand)=3
A/B=0
--------------------------------------------------
value of A(rand)=3
value of B(rand)=3
value of sel(rand)=0
A+B=6
--------------------------------------------------
value of A(rand)=2
value of B(rand)=2
value of sel(rand)=1
A-B=0
--------------------------------------------------
value of A(rand)=1
value of B(rand)=0
value of sel(rand)=3
A/B=x
--------------------------------------------------
value of A(rand)=2
value of B(rand)=0
value of sel(rand)=0
A+B=2
--------------------------------------------------
value of A(rand)=2
value of B(rand)=3
value of sel(rand)=3
A/B=0
--------------------------------------------------
value of A(rand)=0
value of B(rand)=3
value of sel(rand)=3
A/B=0
--------------------------------------------------
value of A(rand)=1
value of B(rand)=2
value of sel(rand)=3
A/B=0
--------------------------------------------------
value of A(rand)=2
value of B(rand)=1
value of sel(rand)=1
A-B=1
--------------------------------------------------
           V C S   S i m u l a t i o n   R e p o r t 
*/
