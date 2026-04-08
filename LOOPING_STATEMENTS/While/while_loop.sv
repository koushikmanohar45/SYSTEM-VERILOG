module while_loop();
  int d, i, temp;
  logic [31:0] b;

  always @(*) begin
    temp=d; 
    i=0;
    b=0;
    $display(" decimal d=%0d",d);
    while (temp > 0) begin
      $display(" loop Executed, when temp=%0d",temp);
      b[i]=temp%2; 
      temp=temp/2;
      i++;
    end

    $display("Binary=%b",b);
    $display(".......................................................................");
  end

  initial begin
    $display("...........................WHILE LOOP..................................");

    d=12;
    #10 d=10;
    #10 d=11;
    #10 d=0;
    #10 d=-10;
    #10 d=45;
    #10 d=32;
    #10 d=2147483647;
    #100 $finish;
  end
endmodule


/*
OUTPUT:
...........................WHILE LOOP..................................
 decimal d=12
 loop Executed, when temp=12
 loop Executed, when temp=6
 loop Executed, when temp=3
 loop Executed, when temp=1
Binary=00000000000000000000000000001100
.......................................................................
 decimal d=10
 loop Executed, when temp=10
 loop Executed, when temp=5
 loop Executed, when temp=2
 loop Executed, when temp=1
Binary=00000000000000000000000000001010
.......................................................................
 decimal d=11
 loop Executed, when temp=11
 loop Executed, when temp=5
 loop Executed, when temp=2
 loop Executed, when temp=1
Binary=00000000000000000000000000001011
.......................................................................
 decimal d=0
Binary=00000000000000000000000000000000
.......................................................................
 decimal d=-10
Binary=00000000000000000000000000000000
.......................................................................
 decimal d=45
 loop Executed, when temp=45
 loop Executed, when temp=22
 loop Executed, when temp=11
 loop Executed, when temp=5
 loop Executed, when temp=2
 loop Executed, when temp=1
Binary=00000000000000000000000000101101
.......................................................................
 decimal d=32
 loop Executed, when temp=32
 loop Executed, when temp=16
 loop Executed, when temp=8
 loop Executed, when temp=4
 loop Executed, when temp=2
 loop Executed, when temp=1
Binary=00000000000000000000000000100000
.......................................................................
 decimal d=2147483647
 loop Executed, when temp=2147483647
 loop Executed, when temp=1073741823
 loop Executed, when temp=536870911
 loop Executed, when temp=268435455
 loop Executed, when temp=134217727
 loop Executed, when temp=67108863
 loop Executed, when temp=33554431
 loop Executed, when temp=16777215
 loop Executed, when temp=8388607
 loop Executed, when temp=4194303
 loop Executed, when temp=2097151
 loop Executed, when temp=1048575
 loop Executed, when temp=524287
 loop Executed, when temp=262143
 loop Executed, when temp=131071
 loop Executed, when temp=65535
 loop Executed, when temp=32767
 loop Executed, when temp=16383
 loop Executed, when temp=8191
 loop Executed, when temp=4095
 loop Executed, when temp=2047
 loop Executed, when temp=1023
 loop Executed, when temp=511
 loop Executed, when temp=255
 loop Executed, when temp=127
 loop Executed, when temp=63
 loop Executed, when temp=31
 loop Executed, when temp=15
 loop Executed, when temp=7
 loop Executed, when temp=3
 loop Executed, when temp=1
Binary=01111111111111111111111111111111
.......................................................................
$finish called from file "testbench.sv", line 30.
$finish at simulation time                  150
           V C S   S i m u l a t i o n   R e p o r t 
*/
