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
        display("task_a1 inside fork-join_none");
        #1;
        $display("time=%0t waiting for event",$time);
        @(e);
        a=1;b=2;c=3;d=4;
        display("task_a1 inside fork-join_none");
        #2;
        b<=9;
        c<=b;
        display("task_a1 inside fork-join_none");
        $display("time=%0t task_a1 inside fork-join_none ------------------------------------------->finished",$time);
      end:task_a1
      
      fork:task_a2
          begin:task_a21
            a<=7;
            b<=8;
            display("task_a21 inside fork(fork-join)-join_none");
            #5;
            display("task_a21 inside fork(fork-join)-join_none");
            ->e;
            $display("time=%0t event is triggerd",$time);
            #2;
            b=40;
            d<=b;
            display("task_a21 inside fork(fork-join)-join_none");
            $display("time=%0t task_a21 inside fork(fork-join)-join_none ------------------------------->finished",$time);
            
          end:task_a21
      
          begin:task_a22
            c<=20;
            d<=30;
            display("task_a22 inside fork(fork-join)-join_none");
            #7;
            a=30;
            c<=120;
            display("task_a22 inside fork(fork-join)-join_none");
        
             #2;
             ->e;
             $display("time=%0t event is triggerd",$time);
             b=a;
             c<=d;
            display("task_a22 inside fork(fork-join)-join_none");
            $display("time=%0t task_a22 inside fork(fork-join)-join_none ------------------------------->finished",$time);
           end:task_a22
        
        join:task_a2
      
    join_none
      
    $display("time=%0t executing join_none statements",$time);
    begin:task_b
      #1;
      a<=10; b<=20;c<=30;d<=40;
      display("task_b outside fork-join_none");
      #1;
      $display("time=%0t join_none------------------------------------------------------------------->finished",$time);
    end:task_b  
    
  end
endmodule

/*
output:
time=0 executing join_none statements
time=0 [task_a1 inside fork-join_none]  a=5 b=7 c=0 d=0
time=0 [task_a21 inside fork(fork-join)-join_none]  a=5 b=7 c=0 d=0
time=0 [task_a22 inside fork(fork-join)-join_none]  a=5 b=7 c=0 d=0
time=1 [task_b outside fork-join_none]  a=7 b=8 c=20 d=30
time=1 waiting for event
time=2 join_none------------------------------------------------------------------->finished
time=5 [task_a21 inside fork(fork-join)-join_none]  a=10 b=20 c=30 d=40
time=5 event is triggerd
time=5 [task_a1 inside fork-join_none]  a=1 b=2 c=3 d=4
time=7 [task_a22 inside fork(fork-join)-join_none]  a=30 b=2 c=3 d=4
time=7 [task_a21 inside fork(fork-join)-join_none]  a=30 b=40 c=3 d=4
time=7 task_a21 inside fork(fork-join)-join_none ------------------------------->finished
time=7 [task_a1 inside fork-join_none]  a=30 b=40 c=3 d=4
time=7 task_a1 inside fork-join_none ------------------------------------------->finished
time=9 event is triggerd
time=9 [task_a22 inside fork(fork-join)-join_none]  a=30 b=30 c=40 d=4
time=9 task_a22 inside fork(fork-join)-join_none ------------------------------->finished
           V C S   S i m u l a t i o n   R e p o r t
*/
