module fork_join;
  int a;
  int b;
  int c;
  int d;
  event e;
  function void display(string s);
    $display("[%s] time=%0t a=%0d b=%0d c=%0d d=%0d",s,$time,a,b,c,d);
  endfunction
  
  initial begin
    fork:task_a
      
      begin:task_a1
        a=5;
        b=7;
        display("task_a1");
        #1;
        $display("waiting for event");
        @(e);
        a=1;b=2;c=3;d=4;
        display("task_a1");
        #2;
        b<=9;
        c<=b;
        display("task_a1");
      end:task_a1
      
      begin:task_a2
        a<=7;
        b<=8;
        display("task_a2");
        #5;
        display("task_a2");
        ->e;
        $display("event is triggerd");
        #2;
        b=a;
        d<=b;
        display("task_a2");
      end:task_a2
      
      begin:task_a3
        c<=20;
        d<=30;
        display("task_a3");
        #7;
        a=30;
        b=40;
        display("task_a3");
        
        #2;
        ->e;
        $display("event is triggerd");
        b=a;
        c<=d;
        display("task_a3");
      end:task_a3
    join
  end
endmodule


/*
output:
[task_a1] time=0 a=5 b=7 c=0 d=0
[task_a2] time=0 a=5 b=7 c=0 d=0
[task_a3] time=0 a=5 b=7 c=0 d=0
waiting for event
[task_a2] time=5 a=7 b=8 c=20 d=30
event is triggerd
[task_a1] time=5 a=1 b=2 c=3 d=4
[task_a3] time=7 a=30 b=40 c=3 d=4
[task_a2] time=7 a=30 b=30 c=3 d=4
[task_a1] time=7 a=30 b=30 c=3 d=4
event is triggerd
[task_a3] time=9 a=30 b=30 c=30 d=30
           V C S   S i m u l a t i o n   R e p o r t

*/
