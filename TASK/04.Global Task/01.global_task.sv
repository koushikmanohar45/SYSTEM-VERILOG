//-------------------------------------
// Global Task ($unit scope)
// Static by default
//-------------------------------------

task packet_process1(int a);

  int b;
  int count;
  b=a*100;

  $display("[%0t] a=%0d b=%0d count=%0d (before delay)",$time,a,b,count);
  #10;
  $display("[%0t] a=%0d b=%0d count=%0d (after delay)",$time,a,b,count);
  count++;
  
endtask

task automatic packet_process2(int a);

  int b;
  int count;
  b=a*100;

  $display("[%0t] a=%0d b=%0d count=%0d (before delay)",$time,a,b,count);
  #10;
  $display("[%0t] a=%0d b=%0d count=%0d (after delay)",$time,a,b,count);
  count++;
  
endtask


module test1;

  initial begin
    $display(" CALLING GLOBAL TASK STAIC WITH FORK-JOIN...........");
    fork
      packet_process1(1);
      packet_process1(2);
      packet_process1(3);
    join
    $display(".......................................................");

  end

endmodule

module test2;

  initial begin
    #11;
    $display(" CALLING GLOBAL TASK AUTOMATIC WITH FORK-JOIN...........");
    fork
      packet_process2(4);
      packet_process2(6);
      packet_process2(5);
    join_any
    #1;
    $display("CALLING GLOBAL TASK STATIC WITHOUT FORK-JOIN...........");  
      packet_process1(4);
      packet_process1(6);
      packet_process1(5);
    $display(".......................................................");

  end

endmodule

/*
OUTPUT:
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jun 11 09:35 2026
 CALLING GLOBAL TASK STAIC WITH FORK-JOIN...........
[0] a=1 b=100 count=0 (before delay)
[0] a=2 b=200 count=0 (before delay)
[0] a=3 b=300 count=0 (before delay)
[10] a=3 b=300 count=0 (after delay)
[10] a=3 b=300 count=1 (after delay)
[10] a=3 b=300 count=2 (after delay)
.......................................................
 CALLING GLOBAL TASK AUTOMATIC WITH FORK-JOIN...........
[11] a=4 b=400 count=0 (before delay)
[11] a=6 b=600 count=0 (before delay)
[11] a=5 b=500 count=0 (before delay)
[21] a=4 b=400 count=0 (after delay)
[21] a=6 b=600 count=0 (after delay)
[21] a=5 b=500 count=0 (after delay)
CALLING GLOBAL TASK STATIC WITHOUT FORK-JOIN...........
[22] a=4 b=400 count=3 (before delay)
[32] a=4 b=400 count=3 (after delay)
[32] a=6 b=600 count=4 (before delay)
[42] a=6 b=600 count=4 (after delay)
[42] a=5 b=500 count=5 (before delay)
[52] a=5 b=500 count=5 (after delay)
.......................................................
           V C S   S i m u l a t i o n   R e p o r t 
*/
