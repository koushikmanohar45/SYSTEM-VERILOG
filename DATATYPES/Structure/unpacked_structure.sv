module packed_structure;

  typedef struct 
  {
    string Name;
    logic [3:0] Header;
    bit [3:0] ID;
    byte data;
  } packet_s;

  packet_s my_packet1;
  packet_s my_packet2;
  
  always@(*)begin
    $display("++++++++++++++++++++++++++++++++++++++++++++++");
    $display("STRUCTURE1:%p",my_packet1);
    $display("Name:%s",my_packet1.Name);
    $display("Header:%b",my_packet1.Header);
    $display("ID:%b",my_packet1.ID);  
    $display("Data:%b",my_packet1.data);
    
  end
  always@(*)begin
    $display("++++++++++++++++++++++++++++++++++++++++++++++");
    $display("STRUCTURE2:%p",my_packet2);
    $display("Name:%s",my_packet2.Name);
    $display("Header:%b",my_packet2.Header);
    $display("ID:%b",my_packet2.ID);  
    $display("Data:%b",my_packet2.data);
  end

  initial begin
    $display("                Packed Struct            ");
    #10;
    my_packet2='{"Rangarajan",4'hd,4'he,8'hfx};
    #10
    my_packet1=my_packet2;
    #10
    my_packet1.Header=4'h2;
    my_packet2.ID=4'h7;
    my_packet2.Name="Mek_leo";
    #10 $finish;
  end
endmodule



/*output:
xcelium> source /xcelium25.03/tools/xcelium/files/xmsimrc
xcelium> run
                Packed Struct            
++++++++++++++++++++++++++++++++++++++++++++++
STRUCTURE2:'{Name:"Rangarajan", Header:'hd, ID:'he, data:'hf0}
Name:Rangarajan
Header:1101
ID:1110
Data:11110000
++++++++++++++++++++++++++++++++++++++++++++++
STRUCTURE1:'{Name:"Rangarajan", Header:'hd, ID:'he, data:'hf0}
Name:Rangarajan
Header:1101
ID:1110
Data:11110000
++++++++++++++++++++++++++++++++++++++++++++++
STRUCTURE1:'{Name:"Rangarajan", Header:'h2, ID:'he, data:'hf0}
Name:Rangarajan
Header:0010
ID:1110
Data:11110000
++++++++++++++++++++++++++++++++++++++++++++++
STRUCTURE2:'{Name:"Mek_leo", Header:'hd, ID:'h7, data:'hf0}
Name:Mek_leo
Header:1101
ID:0111
Data:11110000
Simulation complete via $finish(1) at time 40 NS + 0
./testbench.sv:42     #10 $finish;*/
