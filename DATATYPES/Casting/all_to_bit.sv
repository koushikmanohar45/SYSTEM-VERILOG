module all_to_bit();
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
    byt='d102;
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
    
    bt=bit'(byt);
    $display("BYTE TO BIT =%b",bt);
    
    bt=bit'(log);
    $display("LOGIC TO BIT =%b",bt);
    
    bt=bit'(i1);
    $display("INTEGER TO BIT =%b",bt);
    
    bt=bit'(i2);
    $display("INT TO BIT =%b",bt);
    
    bt=bit'(rg);
    $display("REG TO BIT =%b",bt);
    
    bt=bit'(w);
    $display("WIRE TO BIT =%b",bt);
    
    bt=bit'(s_i);
    $display("SHORTINT TO BIT =%b",bt);
    
    bt=bit'(l_i);
    $display("LONGINT TO BIT =%b",bt);
    
    bt=bit'(rl);
    $display("REAL TO BIT =%b",bt);
    
    bt=bit'(s);
    $display("STRING TO BIT =%b",bt);
    
    
    $display("=========================DYNAMIC CASTING========================");
    
    if($cast(bt,byt))
      $display(" SUCESS:BYTE TO BIT=%b",bt);
    else
      $display(" FAILED:BYTE TO BIT=%b",bt);
    
    if($cast(bt,log))
    $display(" SUCESS:LOGIC TO BIT=%b",bt);
    else
      $display(" FAILED:LOGIC TO BIT=%b",bt);
    
    if($cast(bt,i1))
    $display(" SUCESS:INTEGER TO BIT=%b",bt);
    else
      $display(" FAILED:INTEGER TO BIT=%b",bt);
    
    if($cast(bt,i2))
    $display(" SUCESS:INT TO BIT=%b",bt);
    else
      $display(" FAILED:INT TO BIT=%b",bt);
    
    if($cast(bt,rg))
    $display(" SUCESS:REG TO BIT=%b",bt);
    else
      $display(" FAILED:REG TO BIT=%b",bt);
    
    if($cast(bt,w))
    $display(" SUCESS:WIRE TO BIT=%b",bt);
    else
      $display(" FAILED:WIRE TO BIT=%b",bt);
    
    if($cast(bt,s_i))
    $display(" SUCESS:SHORTINT TO BIT=%b",bt);
    else
      $display(" FAILED:SHORTINT TO BIT=%b",bt);
    
    if($cast(bt,l_i))
    $display(" SUCESS:LONGINT TO BIT=%b",bt);
    else
      $display(" FAILED:LONGINT TO BIT=%b",bt);
    
    if($cast(bt,rl))
      $display(" SUCESS:REAL TO BIT=%b",bt);
    else
      $display(" FAILED:REAL TO BIT=%b",bt);
    
    if($cast(bt,s))
    $display(" SUCESS:STRING TO BIT=%b",bt);
    else
      $display(" FAILED:STRING TO BIT=%b",bt);
    
  end
endmodule


/*
OUTPUT:
INITIAL VALUES:
 BIT=0 
 BYTE=01100110 
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
BYTE TO BIT =0
LOGIC TO BIT =1
INTEGER TO BIT =0
INT TO BIT =0
REG TO BIT =0
WIRE TO BIT =1
SHORTINT TO BIT =0
LONGINT TO BIT =1
REAL TO BIT =1
STRING TO BIT =0
=========================DYNAMIC CASTING========================
 SUCESS:BYTE TO BIT=0
 SUCESS:LOGIC TO BIT=1
 SUCESS:INTEGER TO BIT=0
 SUCESS:INT TO BIT=0
 SUCESS:REG TO BIT=0
 SUCESS:WIRE TO BIT=1
 SUCESS:SHORTINT TO BIT=0
 SUCESS:LONGINT TO BIT=1
 SUCESS:REAL TO BIT=1
 SUCESS:STRING TO BIT=0
 */

    
