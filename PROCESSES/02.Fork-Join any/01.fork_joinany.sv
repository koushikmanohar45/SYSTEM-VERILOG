module fork_join;
  int a;
  int b;
  int c;
  int d;
  event e;
  
  function void display(string s);
    $display("time=%0t [%s]  a=%0d b=%0d c=%0d d=%0d",$time,s,a,b,c,d);
  endfunction
  
  initial begin
    fork:task_a
      
      begin:task_a1
        a=5;
        b=7;
        display("task_a1 inside fork-join_any");
        #1;
        $display("time=%0t waiting for event",$time);
        @(e);
        a=1;b=2;c=3;d=4;
        display("task_a1 inside fork-join_any");
        #2;
        b<=9;
        c<=b;
        display("task_a1 inside fork-join_any");
        $display("time=%0t task_a1 inside fork-join_any ------------------------------------------->finished",$time);
      end:task_a1
      
      fork:task_a2
          begin:task_a21
            a<=7;
            b<=8;
            display("task_a21 inside fork(fork-join)-join_any");
            #5;
            display("task_a21 inside fork(fork-join)-join_any");
            ->e;
            $display("time=%0t event is triggerd",$time);
            #2;
            b=40;
            d<=b;
            display("task_a21 inside fork(fork-join)-join_any");
            $display("time=%0t task_a21 inside fork(fork-join)-join_any ------------------------------->finished",$time);
            
          end:task_a21
      
          begin:task_a22
            c<=20;
            d<=30;
            display("task_a22 inside fork(fork-join)-join_any");
            #7;
            a=30;
            c<=120;
            display("task_a22 inside fork(fork-join)-join_any");
        
             #2;
             ->e;
             $display("time=%0t event is triggerd",$time);
             b=a;
             c<=d;
            display("task_a22 inside fork(fork-join)-join_any");
            $display("time=%0t task_a22 inside fork(fork-join)-join_any ------------------------------->finished",$time);
           end:task_a22
        
        join:task_a2
    join_any
      
    $display("time=%0t executing join_any statements",$time);
    begin:task_b
      #1;
      a=10; b=20;c=30;d=40;
      display("task_b outside fork-join_any");
      #1;
      $display("time=%0t join_any------------------------------------------------------------------->finished",$time);
    end:task_b  
    
  end
endmodule

/*
output:
time=0 [task_a1 inside fork-join_any]  a=5 b=7 c=0 d=0
time=0 [task_a21 inside fork(fork-join)-join_any]  a=5 b=7 c=0 d=0
time=0 [task_a22 inside fork(fork-join)-join_any]  a=5 b=7 c=0 d=0
time=1 waiting for event
time=5 [task_a21 inside fork(fork-join)-join_any]  a=7 b=8 c=20 d=30
time=5 event is triggerd
time=5 [task_a1 inside fork-join_any]  a=1 b=2 c=3 d=4
time=7 [task_a22 inside fork(fork-join)-join_any]  a=30 b=2 c=3 d=4
time=7 [task_a21 inside fork(fork-join)-join_any]  a=30 b=40 c=3 d=4
time=7 task_a21 inside fork(fork-join)-join_any ------------------------------->finished
time=7 [task_a1 inside fork-join_any]  a=30 b=40 c=3 d=4
time=7 task_a1 inside fork-join_any ------------------------------------------->finished
time=7 executing join_any statements
time=8 [task_b outside fork-join_any]  a=10 b=20 c=30 d=40
time=9 event is triggerd
time=9 [task_a22 inside fork(fork-join)-join_any]  a=10 b=10 c=30 d=40
time=9 task_a22 inside fork(fork-join)-join_any ------------------------------->finished
time=9 join_any------------------------------------------------------------------->finished
           V C S   S i m u l a t i o n   R e p o r t
*/
