module do_while_loop();
  int d, i, temp;
  logic [31:0] b;

  always @(*) begin
    temp=d; 
    i=0;
    b=0;
    $display(" decimal d=%0d",d);
    do begin
      $display(" loop Executed, when temp=%0d",temp);
      b[i]=temp%2; 
      temp=temp/2;
      i++;
    end
    while(temp>0);

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
    #100 $finish;
  end

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
 loop Executed, when temp=0
Binary=00000000000000000000000000000000
.......................................................................
 decimal d=-10
 loop Executed, when temp=-10
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
$finish called from file "testbench.sv", line 32.
$finish at simulation time                  160
           V C S   S i m u l a t i o n   R e p o r t 
*/
endmodule
