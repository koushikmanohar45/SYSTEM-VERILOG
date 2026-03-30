module union_type();
  union packed { 
    byte x;
    logic [7:0] y;
    bit[7:0] z; 
  } U1; 
  always @(*)begin
    $display("___________________________________________________");  
    $display("x=%h",U1.x );
    $display("y=%h",U1.y );
    $display("z=%h",U1.z );
    $display("____________________________________________________");
  end
  initial begin   
    $display("                        unpacked union                       ");
    $display("\n size of unpacked union:%0d",$bits(U1));   
    $display("After initiallizing x with 8'h45:");  
    U1.x='h45;
    #1
    $display("After initiallizing y with 8'hx:");
    U1.y='hx; 
    #1
    $display("After initiallizing z with 8'h43:");
    U1.z='h43;
    #1 $finish;
  end
endmodule

/*OUTPUT:
                         unpacked union       
size of unpacked union:8
After initiallizing x with 8'h45:
___________________________________________________
x=45
y=45
z=45
____________________________________________________
After initiallizing y with 8'hx:
___________________________________________________
x=00
y=xx
z=00
____________________________________________________
After initiallizing z with 8'h43:
___________________________________________________
x=43
y=43
z=43
____________________________________________________

*/
