module union_unpacked();
 
  union {
    int w;  
    byte x;
    logic [15:0] y;
    bit[7:0] z; 
  } U1; 
  always @(*)begin
    $display("___________________________________________________");  
    $display("\n w=%h",U1.w );
    $display("\n x=%h",U1.x );
    $display("\n y=%h",U1.y );
    $display("\n z=%h",U1.z );
    $display("____________________________________________________");
  end
  initial begin   
    $display("                        unpacked union                       ");
    //$display("\n size of unpacked union:%0d",$bits(U1));   
    $display("After initiallizing w with 32'hcab0de:");  
    U1.w ='hcab0de;
    #1      
    $display("After initiallizing x with 8'h45:");  
    U1.x='h45;
    #1
    $display("After initiallizing y with 16'hface:");
    U1.y='hface; 
    #1
    $display("After initiallizing z with 8'h43:");
    U1.z=8'h43;
    #1 $finish;
  end
endmodule




/* OUTPUT:
After initiallizing w with 32'hcab0de:
___________________________________________________

 w=00000000110010101011000011011110

 x=11011110

 y=1011000011011110

 z=11011110
____________________________________________________
After initiallizing x with 8'h45:
___________________________________________________

 w=00000000000000000000000001000101

 x=01000101

 y=0000000001000101

 z=01000101
____________________________________________________
After initiallizing y with 16'hface:
___________________________________________________

 w=11111111111111111111101011001110

 x=11001110

 y=1111101011001110

 z=11001110
____________________________________________________
After initiallizing z with 8'h43:
___________________________________________________

 w=00000000000000000000000001000011

 x=01000011

 y=0000000001000011

 z=01000011
____________________________________________________
*/
