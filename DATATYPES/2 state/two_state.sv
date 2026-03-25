module two_state();
  bit bt;
  byte byt;
  int i;
  shortint si;
  longint li;

  initial begin
    $display("size of bit=%0d",$bits(bt));
    $display("size of byte=%0d",$size(byt));
    $display("size of int=%0d",$size(i));
    $display("size of longint=%0d",$size(li));
    $display("size of Shortint=%0d",$size(si));
    #1
    bt='1;
    byt='b11110z1x;
    $display("value of bit after initialization=%b",bt);
    $display("value of byte after initialization=%b",byt);
    i='habab;
    si='hcadez;
    li='hzface;
    $display("value of int after initialization=%b",i);
    $display("value of shortint after initialization=%b",si);
    $display("value of longint after initialization=%b",li); 
  end
  initial begin
    $display("default value of bit=%b",bt);
    $display("default value of byte=%b",byt);
    $display("default value of int=%b",i);
    $display("default value of shortint=%b",si);
    $display("default value of longint=%b",li);
  end
endmodule
