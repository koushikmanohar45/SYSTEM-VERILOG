class randomize_c;
  randc bit [2:0] x;
  randc bit [2:0] y;
  randc bit [2:0] z;
  
   covergroup a;
    a1:coverpoint x;
    a2:coverpoint y;
  endgroup

  covergroup b;
    b1:coverpoint x{bins ba={0,2};}
    b2:coverpoint z{bins bb[]={[0:1]};}
  endgroup
  
  function new();
    a=new();
    b=new();
  endfunction
endclass

module coverage_inside_class;


  initial begin
    randomize_c r=new();
      $display("+-----------------------+-----------------------+");
      $display("|     cg1 coverage      |      cg2 coverage     |");
      $display("| x=0,...,7 | y=0,...,7 |    x=0(or)2 | z=0,1   |");
      $display("+-----------------------+-----------------------+");

    repeat(8) begin
      r.randomize();
      r.a.sample();
      r.b.sample();
     
      $display("|     x=%d y=%d           |   x=%d  z=%d            |",r.x,r.y,r.x,r.z);
      $display("| coverage=%0.2f%%       |  coverage=%0.2f%%      |",r.a.get_inst_coverage(),r.b.get_inst_coverage());
      $display("+-----------------------------------------------+");

    end
    $stop;
  end

endmodule




//run.do file
run -all
# Save the database
coverage save cov.ucdb
# Just run the report once, directly to the log
coverage report -cvg -details
# Exit the simulator immediately
exit

#compiler option: -timescale 1ns/1ns -coverage
#run option: -coverage -voptargs="+acc"




/*
OUTPUT:
coverage save -onexit cov_$Sv_Seed.ucdb
# do run.do
# +-----------------------+-----------------------+
# |     cg1 coverage      |      cg2 coverage     |
# | x=0,...,7 | y=0,...,7 |    x=0(or)2 | z=0,1   |
# +-----------------------+-----------------------+
# |     x=2 y=2           |   x=2  z=3            |
# | coverage=12.50%       |  coverage=50.00%      |
# +-----------------------------------------------+
# |     x=0 y=4           |   x=0  z=5            |
# | coverage=25.00%       |  coverage=50.00%      |
# +-----------------------------------------------+
# |     x=3 y=6           |   x=3  z=1            |
# | coverage=37.50%       |  coverage=75.00%      |
# +-----------------------------------------------+
# |     x=1 y=7           |   x=1  z=0            |
# | coverage=50.00%       |  coverage=100.00%      |
# +-----------------------------------------------+
# |     x=5 y=0           |   x=5  z=4            |
# | coverage=62.50%       |  coverage=100.00%      |
# +-----------------------------------------------+
# |     x=4 y=1           |   x=4  z=2            |
# | coverage=75.00%       |  coverage=100.00%      |
# +-----------------------------------------------+
# |     x=7 y=5           |   x=7  z=6            |
# | coverage=87.50%       |  coverage=100.00%      |
# +-----------------------------------------------+
# |     x=6 y=3           |   x=6  z=7            |
# | coverage=100.00%       |  coverage=100.00%      |
# +-----------------------------------------------+
# ** Note: $stop    : testbench.sv(42)
#    Time: 0 ns  Iteration: 0  Instance: /coverage_inside_class
# Break in Module coverage_inside_class at testbench.sv line 42
# Stopped at testbench.sv line 42
# Coverage Report by instance with details
# 
# =================================================================================
# === Instance: /design_sv_unit
# === Design Unit: work.design_sv_unit
# =================================================================================
# 
# Covergroup Coverage:
#     Covergroups                      2        na        na   100.00%
#         Coverpoints/Crosses          4        na        na        na
#             Covergroup Bins         19        19         0   100.00%
# ----------------------------------------------------------------------------------------------------------
# Covergroup                                             Metric       Goal       Bins    Status               
#                                                                                                          
# ----------------------------------------------------------------------------------------------------------
#  TYPE /design_sv_unit/randomize_c/a                   100.00%        100          -    Covered              
#     covered/total bins:                                    16         16          -                      
#     missing/total bins:                                     0         16          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint a1                                     100.00%        100          -    Covered              
#         covered/total bins:                                 8          8          -                      
#         missing/total bins:                                 0          8          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin auto[0]                                         1          1          -    Covered              
#         bin auto[1]                                         1          1          -    Covered              
#         bin auto[2]                                         1          1          -    Covered              
#         bin auto[3]                                         1          1          -    Covered              
#         bin auto[4]                                         1          1          -    Covered              
#         bin auto[5]                                         1          1          -    Covered              
#         bin auto[6]                                         1          1          -    Covered              
#         bin auto[7]                                         1          1          -    Covered              
#     Coverpoint a2                                     100.00%        100          -    Covered              
#         covered/total bins:                                 8          8          -                      
#         missing/total bins:                                 0          8          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin auto[0]                                         1          1          -    Covered              
#         bin auto[1]                                         1          1          -    Covered              
#         bin auto[2]                                         1          1          -    Covered              
#         bin auto[3]                                         1          1          -    Covered              
#         bin auto[4]                                         1          1          -    Covered              
#         bin auto[5]                                         1          1          -    Covered              
#         bin auto[6]                                         1          1          -    Covered              
#         bin auto[7]                                         1          1          -    Covered              
#  TYPE /design_sv_unit/randomize_c/b                   100.00%        100          -    Covered              
#     covered/total bins:                                     3          3          -                      
#     missing/total bins:                                     0          3          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint b1                                     100.00%        100          -    Covered              
#         covered/total bins:                                 1          1          -                      
#         missing/total bins:                                 0          1          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin ba                                              2          1          -    Covered              
#     Coverpoint b2                                     100.00%        100          -    Covered              
#         covered/total bins:                                 2          2          -                      
#         missing/total bins:                                 0          2          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin bb[0]                                           1          1          -    Covered              
#         bin bb[1]                                           1          1          -    Covered              
# 
# TOTAL COVERGROUP COVERAGE: 100.00%  COVERGROUP TYPES: 2
# 
# Total Coverage By Instance (filtered view): 100.00%
*/
    
    
    
    
    
    
    
  


