module all_to_logic();
  reg [3:0] rg;
  wire w;
  byte byt;
  bit bt;
  logic log;
  integer i1;
  int i2;
  shortint s_i;
  longint l_i;
  real rl;
  string s;
  
  assign w=1'B1;
  initial begin 
    byt='d102;
    i1='h4;
    i2='hA;
    s_i='hE;
    l_i='hF;
    rl=5.4;
    log='b0;
    rg='h4;
    s="hi";
    #2
    $display(" INITIAL VALUES:\n LOG=%B \n BYTE=%B \n WIRE=%B \n REG=%B \n INTEGER=%B \n INT=%B \n SHORTINT=%B \n LONGINT=%B \n REAL=%B \n STRING=%s ",log,byt,w,rg,i1,i2,s_i,l_i,rl,s);
    $display("=========================STATIC CASTING========================");
    
    log=logic'(byt);
    $display("BYTE TO LOGIC =%b",log);
    
    log=logic'(bt);
    $display("BIT TO LOGIC =%b",log);
    
    log=logic'(i1);
    $display("INTEGER TO LOGIC =%b",log);
    
    log=logic'(i2);
    $display("INT TO LOGIC =%b",log);
    
    log=logic'(rg);
    $display("REG TO LOGIC =%b",log);
    
    log=logic'(w);
    $display("WIRE TO LOGIC =%b",log);
    
    log=logic'(s_i);
    $display("SHORTINT TO LOGIC =%b",log);
    
    log=logic'(l_i);
    $display("LONGINT TO LOGIC =%b",log);
    
    log=logic'(rl);
    $display("REAL TO LOGIC =%b",log);
    
    log=logic'(s);
    $display("STRING TO LOGIC =%b",log);
    
    
    $display("=========================DYNAMIC CASTING========================");
    
    if($cast(log,byt))
      $display(" SUCESS:BYTE TO LOGIC=%b",log);
    else
      $display(" FAILED:BYTE TO LOGIC=%b",log);
    
    if($cast(log,bt))
      $display(" SUCESS:BIT TO LOGIC=%b",log);
    else
      $display(" FAILED:BIT TO LOGIC=%b",log);
    
    if($cast(log,i1))
    $display(" SUCESS:INTEGER TO LOGIC=%b",log);
    else
      $display(" FAILED:INTEGER TO LOGIC=%b",log);
    
    if($cast(log,i2))
    $display(" SUCESS:INT TO LOGIC=%b",log);
    else
      $display(" FAILED:INT TO LOGIC=%b",log);
    
    if($cast(log,rg))
    $display(" SUCESS:REG TO LOGIC=%b",log);
    else
      $display(" FAILED:REG TO LOGIC=%b",log);
    
    if($cast(log,w))
    $display(" SUCESS:WIRE TO LOGIC=%b",log);
    else
      $display(" FAILED:WIRE TO LOGIC=%b",log);
    
    if($cast(log,s_i))
    $display(" SUCESS:SHORTINT TO LOGIC=%b",log);
    else
      $display(" FAILED:SHORTINT TO LOGIC=%b",log);
    
    if($cast(log,l_i))
    $display(" SUCESS:LONGINT TO LOGIC=%b",log);
    else
      $display(" FAILED:LONGINT TO LOGIC=%b",log);
    
    if($cast(log,rl))
      $display(" SUCESS:REAL TO LOGIC=%b",log);
    else
      $display(" FAILED:REAL TO LOGIC=%b",log);
    
    if($cast(log,s))
    $display(" SUCESS:STRING TO LOGIC=%b",log);
    else
      $display(" FAILED:STRING TO LOGIC=%b",log);
    
  end
endmodule

/*
OUTPUT:
 INITIAL VALUES:
 LOG=0 
 BYTE=01100110 
 WIRE=1 
 REG=0100 
 INTEGER=00000000000000000000000000000100 
 INT=00000000000000000000000000001010 
 SHORTINT=0000000000001110 
 LONGINT=0000000000000000000000000000000000000000000000000000000000001111 
 REAL=00000000000000000000000000000101 
 STRING=hi 
=========================STATIC CASTING========================
BYTE TO LOGIC =0
BIT TO LOGIC =0
INTEGER TO LOGIC =0
INT TO LOGIC =0
REG TO LOGIC =0
WIRE TO LOGIC =1
SHORTINT TO LOGIC =0
LONGINT TO LOGIC =1
REAL TO LOGIC =1
STRING TO LOGIC =0
=========================DYNAMIC CASTING========================
 SUCESS:BYTE TO LOGIC=0
 SUCESS:BIT TO LOGIC=0
 SUCESS:INTEGER TO LOGIC=0
 SUCESS:INT TO LOGIC=0
 SUCESS:REG TO LOGIC=0
 SUCESS:WIRE TO LOGIC=1
 SUCESS:SHORTINT TO LOGIC=0
 SUCESS:LONGINT TO LOGIC=1
 SUCESS:REAL TO LOGIC=1
 SUCESS:STRING TO LOGIC=0
*/
