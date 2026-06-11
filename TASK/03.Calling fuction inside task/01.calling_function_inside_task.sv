class task_func;
  rand int a;
  constraint c1{a inside{[10:30]};}
  
  function int square(int a);
    $display("a=%0d",a);
    return a*a;
  endfunction
  
  task process();
    int value;
    #5;
    value=square(a);
    $display("[time=%0t] value=%0d",$time,value);
    $display("-----------------------------------------------");
  endtask
endclass

module test;

  task_func t;
  
  initial begin
    t=new();
    repeat(5)begin
      t.randomize();
      t.process();
    end
  end

endmodule

/*
OUTPUT:

a=14
[time=5] value=196
-----------------------------------------------
a=15
[time=10] value=225
-----------------------------------------------
a=22
[time=15] value=484
-----------------------------------------------
a=26
[time=20] value=676
-----------------------------------------------
a=14
[time=25] value=196
-----------------------------------------------
           V C S   S i m u l a t i o n   R e p o r t 
           
*/
