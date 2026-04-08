module forever_loop();
  bit[3:0]a;
  initial begin
    $display("Starting forever loop..................");

    forever begin
      $display("This runs forever at time = %0t", $time);
      $display("a=%0d",a);
      if(a==15)
        $finish;
      else
        a=$urandom;
    end
  end

endmodule


/*
OUTPUT:
Starting forever loop..................
This runs forever at time = 0
a=0
This runs forever at time = 0
a=6
This runs forever at time = 0
a=12
This runs forever at time = 0
a=13
This runs forever at time = 0
a=2
This runs forever at time = 0
a=11
This runs forever at time = 0
a=15
$finish called from file "testbench.sv", line 10.
$finish at simulation time                    0
           V C S   S i m u l a t i o n   R e p o r t
*/
