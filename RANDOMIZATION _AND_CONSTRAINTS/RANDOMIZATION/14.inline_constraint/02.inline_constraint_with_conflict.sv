class inline_constraints;
  
  randc bit clk;
  rand bit rst;
  rand bit load;
  rand bit [7:0]d;
  bit [7:0]q;
  
  constraint r{rst dist {0:=20,1:=1};}
  constraint r1{load dist {0:=20,1:=1};}
  constraint r2{d<100;}
  
  task shift();

  if(clk)begin
    if (rst)
      q=0;
    else begin
      if(load)
        q=d;
      else
        q={q[6:0],1'b0};
    end
  end
  else
    q<=q;
  endtask
  
endclass

module randomization();
  
  inline_constraints i;
  
  initial begin
    i=new();
    $display("===========LOAD/SHIFT====================");
    repeat(20)begin
      i.randomize();
      i.shift();
      $display("clk=%b rst=%b load=%b d=%b q=%b",i.clk,i.rst,i.load,i.d,i.q);
    end
    //applied constraints temporarily during a specific randomization call.
    $display("INLINE CONSTRAINT(temporarly load data 10)");
    i.randomize with {d>100;load==1;rst==0;clk==1;};
    i.shift();
    $display("clk=%b rst=%b load=%b d=%b q=%b",i.clk,i.rst,i.load,i.d,i.q);
  end
endmodule
  
  
/*
output:
===========LOAD/SHIFT=========================
clk=1 rst=0 load=0 d=00000110 q=00000000
clk=0 rst=0 load=0 d=01100000 q=00000000
clk=0 rst=0 load=0 d=00011110 q=00000000
clk=1 rst=1 load=0 d=00011001 q=00000000
clk=1 rst=0 load=0 d=01000110 q=00000000
clk=0 rst=0 load=0 d=01011101 q=00000000
clk=0 rst=0 load=0 d=00010110 q=00000000
clk=1 rst=0 load=0 d=00010000 q=00000000
clk=0 rst=0 load=0 d=00010000 q=00000000
clk=1 rst=0 load=1 d=01000011 q=01000011
clk=0 rst=0 load=0 d=00011111 q=01000011
clk=1 rst=0 load=0 d=01100010 q=10000110
clk=1 rst=0 load=0 d=01010100 q=00001100
clk=0 rst=0 load=0 d=00110111 q=00001100
clk=0 rst=0 load=0 d=01100000 q=00001100
clk=1 rst=0 load=0 d=00111111 q=00011000
clk=0 rst=0 load=0 d=01000100 q=00011000
clk=1 rst=0 load=0 d=00111001 q=00110000
clk=0 rst=0 load=0 d=00100110 q=00110000
clk=1 rst=0 load=0 d=00011100 q=01100000
INLINE CONSTRAINT(temporarly load data 10)

=======================================================

Solver failed when solving following set of constraints 


rand bit[7:0] d; // rand_mode = ON 

constraint r2    // (from this) (constraint_mode = ON) (testbench.sv:11)
{
   (d < 8'h64);
}
constraint WITH_CONSTRAINT    // (from this) (constraint_mode = ON) (testbench.sv:45)
{
   (d > 8'h64);
}

=======================================================


Note-[CNST-SATE] Standalone test extracted
  A standalone test-case for this failure has automatically been extracted 
  from randomize serial 21 partition 3.
  To reproduce the error using the extracted testcase, please use the 
  following command:
  cd /home/runner/./simv.cst/testcases;
  vcs -sverilog extracted_r_21_p_3_inconsistent_constraints.sv -R
  To reproduce the error using the original design and verbose logging, re-run
  simulation using:
  simv +ntb_solver_debug=trace +ntb_solver_debug_filter=21
  To reproduce the error using the original design and debug the error with 
  Verdi/DVE:
  1. re-compile the original design with -debug_access+all, if not already 
  done so
  	% vcs -debug_access+all <other options>
  2. re-run the simulation interactively with -gui/-verdi
  	% simv -gui/-verdi <other options>
  3. enter the following commands to begin interactive constraint 
  inconsistency debug within Verdi/DVE
  	I. set the breakpoint:	verdi/dve> stop -solver -serial 21
  	II. run the simulation till it stops:	verdi/dve> run
  	III. step in the constraint solver:	verdi/dve> step -solver


Error-[CNST-CIF] Constraints inconsistency failure
testbench.sv, 45
  Constraints are inconsistent and cannot be solved.
  Please check the inconsistent constraints being printed above and rewrite 
  them.

clk=1 rst=0 load=0 d=00011100 q=11000000
           V C S   S i m u l a t i o n   R e p o r t 
  */
