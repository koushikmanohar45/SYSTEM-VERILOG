module all_to_byte();
  reg [3:0] rg;
  wire w;
  bit bt;
  byte byt;
  logic [4:0]log;
  integer i1;
  int i2;
  shortint s_i;
  longint l_i;
  real rl;
  string s;
  
  assign w=1'B1;
  initial begin 
    bt='B0;
    byt='d12;
    i1='h4;
    i2='hA;
    s_i='hE;
    l_i='hF;
    rl=5.4;
    log='h3;
    rg='h4;
    s="hi";
    #2
    $display(" INITIAL VALUES:\n BIT=%B \n BYTE=%B \n LOG=%B \n WIRE=%B \n REG=%B \n INTEGER=%B \n INT=%B \n SHORTINT=%B \n LONGINT=%B \n REAL=%B \n STRING=%s ",bt,byt,log,w,rg,i1,i2,s_i,l_i,rl,s);
    $display("=========================STATIC CASTING========================");
    
    byt=byte'(bt);
    $display("BIT TO BYTE =%b",byt);
    
    byt=byte'(log);
    $display("LOGIC TO BYTE =%b",byt);
    
    byt=byte'(i1);
    $display("INTEGER TO BYTE =%b",byt);
    
    byt=byte'(i2);
    $display("INT TO BYTE =%b",byt);
    
    byt=byte'(rg);
    $display("REG TO BYTE =%b",byt);
    
    byt=byte'(w);
    $display("WIRE TO BYTE =%b",byt);
    
    byt=byte'(s_i);
    $display("SHORTINT TO BYTE =%b",byt);
    
    byt=byte'(l_i);
    $display("LONGINT TO BYTE =%b",byt);
    
    byt=byte'(rl);
    $display("REAL TO BYTE =%b",byt);
    
    byt=byte'(s);
    $display("STRING TO BYTE =%b",byt);
    
    
    $display("=========================DYNAMIC CASTING========================");
    
    if($cast(byt,bt))
      $display(" SUCESS:BYTE TO BYTE=%b",byt);
    else
      $display(" FAILED:BYTE TO BYTE=%b",byt);
    
    if($cast(byt,log))
      $display(" SUCESS:LOGIC TO BYTE=%b",byt);
    else
      $display(" FAILED:LOGIC TO BYTE=%b",byt);
    
    if($cast(byt,i1))
      $display(" SUCESS:INTEGER TO BYTE=%b",byt);
    else
      $display(" FAILED:INTEGER TO BYTE=%b",byt);
    
    if($cast(byt,i2))
      $display(" SUCESS:INT TO BYTE=%b",byt);
    else
      $display(" FAILED:INT TO BYTE=%b",byt);
    
    if($cast(byt,rg))
      $display(" SUCESS:REG TO BYTE=%b",byt);
    else
      $display(" FAILED:REG TO BYTE=%b",byt);
    
    if($cast(byt,w))
      $display(" SUCESS:WIRE TO BYTE=%b",byt);
    else
      $display(" FAILED:WIRE TO BYTE=%b",byt);
    
    if($cast(byt,s_i))
      $display(" SUCESS:SHORTINT TO BYTE=%b",byt);
    else
      $display(" FAILED:SHORTINT TO BYTE=%b",byt);
    
    if($cast(byt,l_i))
      $display(" SUCESS:LONGINT TO BYTE=%b",byt);
    else
      $display(" FAILED:LONGINT TO BYTE=%b",byt);
    
    if($cast(byt,rl))
      $display(" SUCESS:REAL TO BYTE=%b",byt);
    else
      $display(" FAILED:REAL TO BYTE=%b",byt);
    
    if($cast(byt,s))
      $display(" SUCESS:STRING TO BYTE=%b",byt);
    else
      $display(" FAILED:STRING TO BYTE=%b",byt);
    
  end
endmodule


/*
OUTPUT:
 INITIAL VALUES:
 BIT=0 
 BYTE=00001100 
 LOG=00011 
 WIRE=1 
 REG=0100 
 INTEGER=00000000000000000000000000000100 
 INT=00000000000000000000000000001010 
 SHORTINT=0000000000001110 
 LONGINT=0000000000000000000000000000000000000000000000000000000000001111 
 REAL=00000000000000000000000000000101 
 STRING=hi 
=========================STATIC CASTING========================
BIT TO BYTE =00000000
LOGIC TO BYTE =00000011
INTEGER TO BYTE =00000100
INT TO BYTE =00001010
REG TO BYTE =00000100
WIRE TO BYTE =00000001
SHORTINT TO BYTE =00001110
LONGINT TO BYTE =00001111
REAL TO BYTE =00000101
STRING TO BYTE =01101001
=========================DYNAMIC CASTING========================
 SUCESS:BYTE TO BYTE=00000000
 SUCESS:LOGIC TO BYTE=00000011
 SUCESS:INTEGER TO BYTE=00000100
 SUCESS:INT TO BYTE=00001010
 SUCESS:REG TO BYTE=00000100
 SUCESS:WIRE TO BYTE=00000001
 SUCESS:SHORTINT TO BYTE=00001110
 SUCESS:LONGINT TO BYTE=00001111
 SUCESS:REAL TO BYTE=00000101
 SUCESS:STRING TO BYTE=01101001
 */
