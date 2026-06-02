class soft_cons;
  rand bit [7:0] addr;
  rand bit [7:0] data;

  constraint c1 {
    soft addr inside {[10:20]};
    soft data == 50;
  }

endclass

class without_soft_cons;
  rand bit [7:0] addr;
  rand bit [7:0] data;

  constraint c1 {
    addr inside {[10:20]};
    data == 50;
  }

endclass


module test;

  soft_cons p;
  without_soft_cons p1;

  initial begin

    p=new();
    p1=new();

    $display(" -------------------------------------");
    $display("             Randomization            ");
    $display(" -------------------------------------");
    assert(p.randomize() with {
                          addr>100;
                          data==200;
    });

    $display("With soft constraints (conflicting data and address)");
    $display("ADDR=%0d  DATA=%0d", p.addr, p.data);
    
    
    assert(p1.randomize() with {
                          soft addr>100;
                          soft data==200;
    });
    $display("\nWithout soft constraints (conflicting data and address with soft keyword)");
    $display("ADDR=%0d  DATA=%0d", p1.addr, p1.data);

    assert(p1.randomize() with {
                            addr>100;
                            data==200;
    });
    $display("\nWithout soft constraints (conflicting data and address)");
    $display("ADDR=%0d  DATA=%0d", p1.addr, p1.data);

  end

endmodule

/*
output:
-------------------------------------
             Randomization            
 -------------------------------------
With soft constraints (conflicting data and address)
ADDR=185  DATA=200

Without soft constraints (conflicting data and address with soft keyword)
ADDR=14  DATA=50

                                              //error
xmsim: *W,RNDOCS: These constraints and variables contribute to the set of conflicting constraints (view the extended help for this message using 'xmhelp xmsim RNDOCS' for guidelines on how debug the issue):

In ./testbench.sv
line 17:  addr inside { [ 32'ha : 32'h14 ] }
line 54:  ( addr > 8'h64 )


Variable  Type         Status        Current Value          Source                    
--------------------------------------------------------------------------------------
addr      (bit [7:0])  RANDOM        <unassigned>           ./testbench.sv ; line 13


    assert(p1.randomize() with {
                      |
xmsim: *W,SVRNDF (./testbench.sv,53|22): The randomize method call failed. The unique id of the failed randomize call is 2.
Observed simulation time : 0 FS + 0.
xmsim: *E,ASRTST (./testbench.sv,53): (time 0 FS) Assertion test.__assert_3 has failed 

Without soft constraints (conflicting data and address)
ADDR=14  DATA=50
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/
