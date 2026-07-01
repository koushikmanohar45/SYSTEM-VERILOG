class disable_task;
    task static packet_process1(int a);
    
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
  
  task task_disable();
    
    begin : task_a
        $display("[time=%0t],task_a initiated",$time);
        #30;
        $display("[time=%0t],task_a finished",$time);
    end :task_a

    begin : task_b
        $display("[time=%0t],task_b initiated",$time);
        #30;
        $display("[time=%0t],task_b finished",$time);
    end :task_b
    
  endtask
  
endclass


module test;
  disable_task d;

  initial begin
   fork
     d=new();
     d.packet_process1(1);
     d.packet_process2(4);
     d.task_disable();
     #10
     disable d.task_disable.task_a;
     $display("[time=%0t],disable task_a",$time);
   join
  end

endmodule

/*
OUTPUT:
[0] a=1 b=100 count=0 (before delay)
[0] a=4 b=400 count=0 (before delay)
[time=0],task_a initiated
[time=0],disable task_a
[10] a=1 b=100 count=0 (after delay)
[10] a=4 b=400 count=0 (after delay)
[time=10],task_b initiated
[time=40],task_b finished
           V C S   S i m u l a t i o n   R e p o r t 
Time: 40 ns
CPU Time:      0.610 seconds;       Data structure size:   0.0Mb
Wed Jul  1 02:58:45 2026
Done
*/
