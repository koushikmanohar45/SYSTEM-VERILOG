module packed_structure();

  typedef struct packed 
  {
    logic [3:0] Header;
    bit [3:0] ID;
    byte data;
  } packet_s;

  packet_s my_packet1;
  packet_s my_packet2;
  
  always@(*)begin
    $display("++++++++++++++++++++++++++++++++++++++++++++++");
    $display("STRUCTURE1:%p",my_packet1);
    $display("Packed:%h",my_packet1); //This is illegal in unpacked
    $display("Header:%b",my_packet1.Header);
    $display("ID:%b",my_packet1.ID);  
    $display("Data:%b",my_packet1.data);
  end
  always@(*)begin
    $display("++++++++++++++++++++++++++++++++++++++++++++++");
    $display("STRUCTURE2:%p",my_packet2);
    $display("Packed:%h",my_packet2); //This is illegeal in unpacked
    $display("Header:%b",my_packet2.Header);
    $display("ID:%b",my_packet2.ID);  
    $display("Data:%b",my_packet2.data);
  end

  initial begin
    $display("                Packed Struct            ");
    my_packet1=16'hA5F2; //This is illegal in unpacked
    #10;
    my_packet2='{4'hd,4'he,8'hfx};
    #10
    my_packet1=my_packet2;
    #10
    my_packet1.Header=4'h2;
    my_packet2.ID=4'h7;
    #10 $finish;
  end
endmodule



/*output:
                Packed Struct            
++++++++++++++++++++++++++++++++++++++++++++++
STRUCTURE1:'{Header:'ha, ID:'h5, data:'hf2}
Packed:a5f2
Header:1010
ID:0101
Data:11110010
++++++++++++++++++++++++++++++++++++++++++++++
STRUCTURE2:'{Header:'hd, ID:'he, data:'hf0}
Packed:def0
Header:1101
ID:1110
Data:11110000
++++++++++++++++++++++++++++++++++++++++++++++
STRUCTURE1:'{Header:'hd, ID:'he, data:'hf0}
Packed:def0
Header:1101
ID:1110
Data:11110000
++++++++++++++++++++++++++++++++++++++++++++++
STRUCTURE1:'{Header:'h2, ID:'he, data:'hf0}
Packed:2ef0
Header:0010
ID:1110
Data:11110000
++++++++++++++++++++++++++++++++++++++++++++++
STRUCTURE2:'{Header:'hd, ID:'h7, data:'hf0}
Packed:d7f0
Header:1101
ID:0111
Data:11110000 */
