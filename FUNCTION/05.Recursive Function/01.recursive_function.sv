class auto_f;

  //inside class function is default by automatic
  function static int sum_static(int s);
    if(s==0)
      return 0;
    else
      return s+sum_static(s-1);
  endfunction

  // AUTOMATIC FUNCTION
  function automatic int sum_auto(int s);
    if(s==0)
      return 0;
    else 
      return s+sum_auto(s-1);
  endfunction

endclass


module test;
  //inside module function is default by static
  
  auto_f d1;

  initial begin
    d1=new();
    $display("STATIC FUNCTION CALLS");
    $display("%0d", d1.sum_static(10));
    $display("%0d", d1.sum_static(20));
    $display("%0d", d1.sum_static(5));
    $display("");
    $display("AUTOMATIC FUNCTION CALLS");
    $display("%0d", d1.sum_auto(4));
    $display("%0d", d1.sum_auto(3));
    $display("%0d", d1.sum_auto(2));
  end

endmodule

/*
OUTPUT:
# KERNEL: STATIC FUNCTION CALLS
# KERNEL: 0
# KERNEL: 0
# KERNEL: 0
# KERNEL: 
# KERNEL: AUTOMATIC FUNCTION CALLS
# KERNEL: 10
# KERNEL: 6
# KERNEL: 3
# KERNEL: Simulation has finished. There are no more test vectors to simulate.
# VSIM: Simulation has finished.
Done
*/
