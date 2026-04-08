module while_loop();
  int d, i, temp;
  logic [31:0] b;

  always @(*) begin
    temp=d; 
    i=0;
    b=0;
    $display(" decimal d=%0d",d);
    while (temp > 0) begin
      b[i]=temp%2; 
      temp=temp/2; 
      $display(" While loop Executed, when temp=%0d",temp);
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
 While loop Executed, when temp=6
 While loop Executed, when temp=3
 While loop Executed, when temp=1
 While loop Executed, when temp=0
Binary=00000000000000000000000000001100
.......................................................................
 decimal d=10
 While loop Executed, when temp=5
 While loop Executed, when temp=2
 While loop Executed, when temp=1
 While loop Executed, when temp=0
Binary=00000000000000000000000000001010
.......................................................................
 decimal d=11
 While loop Executed, when temp=5
 While loop Executed, when temp=2
 While loop Executed, when temp=1
 While loop Executed, when temp=0
Binary=00000000000000000000000000001011
.......................................................................
 decimal d=45
 While loop Executed, when temp=22
 While loop Executed, when temp=11
 While loop Executed, when temp=5
 While loop Executed, when temp=2
 While loop Executed, when temp=1
 While loop Executed, when temp=0
Binary=00000000000000000000000000101101
.......................................................................
 decimal d=32
 While loop Executed, when temp=16
 While loop Executed, when temp=8
 While loop Executed, when temp=4
 While loop Executed, when temp=2
 While loop Executed, when temp=1
 While loop Executed, when temp=0
Binary=00000000000000000000000000100000
.......................................................................
 decimal d=2147483647
 While loop Executed, when temp=1073741823
 While loop Executed, when temp=536870911
 While loop Executed, when temp=268435455
 While loop Executed, when temp=134217727
 While loop Executed, when temp=67108863
 While loop Executed, when temp=33554431
 While loop Executed, when temp=16777215
 While loop Executed, when temp=8388607
 While loop Executed, when temp=4194303
 While loop Executed, when temp=2097151
 While loop Executed, when temp=1048575
 While loop Executed, when temp=524287
 While loop Executed, when temp=262143
 While loop Executed, when temp=131071
 While loop Executed, when temp=65535
 While loop Executed, when temp=32767
 While loop Executed, when temp=16383
 While loop Executed, when temp=8191
 While loop Executed, when temp=4095
 While loop Executed, when temp=2047
 While loop Executed, when temp=1023
 While loop Executed, when temp=511
 While loop Executed, when temp=255
 While loop Executed, when temp=127
 While loop Executed, when temp=63
 While loop Executed, when temp=31
 While loop Executed, when temp=15
 While loop Executed, when temp=7
 While loop Executed, when temp=3
 While loop Executed, when temp=1
 While loop Executed, when temp=0
Binary=01111111111111111111111111111111
.......................................................................
$finish called from file "testbench.sv", line 30.
$finish at simulation time                  150
           V C S   S i m u l a t i o n   R e p o r t 
*/
