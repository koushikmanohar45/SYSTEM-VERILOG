class randomize_c;
  rand bit [1:0] x;
  rand bit [1:0] y;
  rand bit [1:0] z;
endclass

module coverage_inside_module;

  covergroup a(ref bit [1:0] x,ref bit [1:0] y);
    a1:coverpoint x;
    a2:coverpoint y;
  endgroup

  covergroup b(ref bit [1:0] x,ref bit [1:0] z);
    b1:coverpoint x;
    b2:coverpoint z;
  endgroup

  a cg1;
  b cg2;

  initial begin
    randomize_c r=new();
    
    $display("Before sample");
    cg1=new(r.x,r.y);
    cg2=new(r.x,r.z);
    $display("After sample");

    repeat(20) begin
      r.randomize();
      cg1.sample();
      cg2.sample();

      $display("x=%0d y=%0d z=%0d",r.x,r.y,r.z);

      $display("CG1 Coverage = %0.2f%%",cg1.get_inst_coverage());

      $display("CG2 Coverage = %0.2f%%",cg2.get_inst_coverage());
    end
    $stop;
  end

endmodule



//run.do

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
# coverage save -onexit cov_$Sv_Seed.ucdb
# do run.do
# Before sample
# After sample
# x=3 y=2 z=2
# CG1 Coverage = 25.00%
# CG2 Coverage = 25.00%
# x=0 y=3 z=3
# CG1 Coverage = 50.00%
# CG2 Coverage = 50.00%
# x=3 y=2 z=1
# CG1 Coverage = 50.00%
# CG2 Coverage = 62.50%
# x=1 y=0 z=1
# CG1 Coverage = 75.00%
# CG2 Coverage = 75.00%
# x=2 y=2 z=0
# CG1 Coverage = 87.50%
# CG2 Coverage = 100.00%
# x=2 y=1 z=3
# CG1 Coverage = 100.00%
# CG2 Coverage = 100.00%
# x=3 y=1 z=0
# CG1 Coverage = 100.00%
# CG2 Coverage = 100.00%
# x=3 y=1 z=3
# CG1 Coverage = 100.00%
# CG2 Coverage = 100.00%
# x=2 y=1 z=3
# CG1 Coverage = 100.00%
# CG2 Coverage = 100.00%
# x=1 y=2 z=2
# CG1 Coverage = 100.00%
# CG2 Coverage = 100.00%
# x=2 y=3 z=2
# CG1 Coverage = 100.00%
# CG2 Coverage = 100.00%
# x=1 y=2 z=2
# CG1 Coverage = 100.00%
# CG2 Coverage = 100.00%
# x=1 y=3 z=1
# CG1 Coverage = 100.00%
# CG2 Coverage = 100.00%
# x=3 y=1 z=1
# CG1 Coverage = 100.00%
# CG2 Coverage = 100.00%
# x=2 y=1 z=2
# CG1 Coverage = 100.00%
# CG2 Coverage = 100.00%
# x=3 y=2 z=0
# CG1 Coverage = 100.00%
# CG2 Coverage = 100.00%
# x=3 y=1 z=2
# CG1 Coverage = 100.00%
# CG2 Coverage = 100.00%
# x=1 y=1 z=3
# CG1 Coverage = 100.00%
# CG2 Coverage = 100.00%
# x=2 y=0 z=1
# CG1 Coverage = 100.00%
# CG2 Coverage = 100.00%
# x=0 y=3 z=1
# CG1 Coverage = 100.00%
# CG2 Coverage = 100.00%
# ** Note: $stop    : testbench.sv(41)
#    Time: 0 ns  Iteration: 0  Instance: /coverage_inside_module
# Break in Module coverage_inside_module at testbench.sv line 41
# Stopped at testbench.sv line 41
# Coverage Report by instance with details
# 
# =================================================================================
# === Instance: /coverage_inside_module
# === Design Unit: work.coverage_inside_module
# =================================================================================
# 
# Covergroup Coverage:
#     Covergroups                      2        na        na   100.00%
#         Coverpoints/Crosses          4        na        na        na
#             Covergroup Bins         16        16         0   100.00%
# ----------------------------------------------------------------------------------------------------------
# Covergroup                                             Metric       Goal       Bins    Status               
#                                                                                                          
# ----------------------------------------------------------------------------------------------------------
#  TYPE /coverage_inside_module/a                       100.00%        100          -    Covered              
#     covered/total bins:                                     8          8          -                      
#     missing/total bins:                                     0          8          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint a1                                     100.00%        100          -    Covered              
#         covered/total bins:                                 4          4          -                      
#         missing/total bins:                                 0          4          -                      
#         % Hit:                                        100.00%        100          -                      
#     Coverpoint a2                                     100.00%        100          -    Covered              
#         covered/total bins:                                 4          4          -                      
#         missing/total bins:                                 0          4          -                      
#         % Hit:                                        100.00%        100          -                      
#  Covergroup instance \/coverage_inside_module/cg1     100.00%        100          -    Covered              
#     covered/total bins:                                     8          8          -                      
#     missing/total bins:                                     0          8          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint a1                                     100.00%        100          -    Covered              
#         covered/total bins:                                 4          4          -                      
#         missing/total bins:                                 0          4          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin auto[0]                                         2          1          -    Covered              
#         bin auto[1]                                         5          1          -    Covered              
#         bin auto[2]                                         6          1          -    Covered              
#         bin auto[3]                                         7          1          -    Covered              
#     Coverpoint a2                                     100.00%        100          -    Covered              
#         covered/total bins:                                 4          4          -                      
#         missing/total bins:                                 0          4          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin auto[0]                                         2          1          -    Covered              
#         bin auto[1]                                         8          1          -    Covered              
#         bin auto[2]                                         6          1          -    Covered              
#         bin auto[3]                                         4          1          -    Covered              
#  TYPE /coverage_inside_module/b                       100.00%        100          -    Covered              
#     covered/total bins:                                     8          8          -                      
#     missing/total bins:                                     0          8          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint b1                                     100.00%        100          -    Covered              
#         covered/total bins:                                 4          4          -                      
#         missing/total bins:                                 0          4          -                      
#         % Hit:                                        100.00%        100          -                      
#     Coverpoint b2                                     100.00%        100          -    Covered              
#         covered/total bins:                                 4          4          -                      
#         missing/total bins:                                 0          4          -                      
#         % Hit:                                        100.00%        100          -                      
#  Covergroup instance \/coverage_inside_module/cg2     100.00%        100          -    Covered              
#     covered/total bins:                                     8          8          -                      
#     missing/total bins:                                     0          8          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint b1                                     100.00%        100          -    Covered              
#         covered/total bins:                                 4          4          -                      
#         missing/total bins:                                 0          4          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin auto[0]                                         2          1          -    Covered              
#         bin auto[1]                                         5          1          -    Covered              
#         bin auto[2]                                         6          1          -    Covered              
#         bin auto[3]                                         7          1          -    Covered              
#     Coverpoint b2                                     100.00%        100          -    Covered              
#         covered/total bins:                                 4          4          -                      
#         missing/total bins:                                 0          4          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin auto[0]                                         3          1          -    Covered              
#         bin auto[1]                                         6          1          -    Covered              
#         bin auto[2]                                         6          1          -    Covered              
#         bin auto[3]                                         5          1          -    Covered              
# 
# COVERGROUP COVERAGE:
# ----------------------------------------------------------------------------------------------------------
# Covergroup                                             Metric       Goal       Bins    Status               
#                                                                                                          
# ----------------------------------------------------------------------------------------------------------
#  TYPE /coverage_inside_module/a                       100.00%        100          -    Covered              
#     covered/total bins:                                     8          8          -                      
#     missing/total bins:                                     0          8          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint a1                                     100.00%        100          -    Covered              
#         covered/total bins:                                 4          4          -                      
#         missing/total bins:                                 0          4          -                      
#         % Hit:                                        100.00%        100          -                      
#     Coverpoint a2                                     100.00%        100          -    Covered              
#         covered/total bins:                                 4          4          -                      
#         missing/total bins:                                 0          4          -                      
#         % Hit:                                        100.00%        100          -                      
#  Covergroup instance \/coverage_inside_module/cg1     100.00%        100          -    Covered              
#     covered/total bins:                                     8          8          -                      
#     missing/total bins:                                     0          8          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint a1                                     100.00%        100          -    Covered              
#         covered/total bins:                                 4          4          -                      
#         missing/total bins:                                 0          4          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin auto[0]                                         2          1          -    Covered              
#         bin auto[1]                                         5          1          -    Covered              
#         bin auto[2]                                         6          1          -    Covered              
#         bin auto[3]                                         7          1          -    Covered              
#     Coverpoint a2                                     100.00%        100          -    Covered              
#         covered/total bins:                                 4          4          -                      
#         missing/total bins:                                 0          4          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin auto[0]                                         2          1          -    Covered              
#         bin auto[1]                                         8          1          -    Covered              
#         bin auto[2]                                         6          1          -    Covered              
#         bin auto[3]                                         4          1          -    Covered              
#  TYPE /coverage_inside_module/b                       100.00%        100          -    Covered              
#     covered/total bins:                                     8          8          -                      
#     missing/total bins:                                     0          8          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint b1                                     100.00%        100          -    Covered              
#         covered/total bins:                                 4          4          -                      
#         missing/total bins:                                 0          4          -                      
#         % Hit:                                        100.00%        100          -                      
#     Coverpoint b2                                     100.00%        100          -    Covered              
#         covered/total bins:                                 4          4          -                      
#         missing/total bins:                                 0          4          -                      
#         % Hit:                                        100.00%        100          -                      
#  Covergroup instance \/coverage_inside_module/cg2     100.00%        100          -    Covered              
#     covered/total bins:                                     8          8          -                      
#     missing/total bins:                                     0          8          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint b1                                     100.00%        100          -    Covered              
#         covered/total bins:                                 4          4          -                      
#         missing/total bins:                                 0          4          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin auto[0]                                         2          1          -    Covered              
#         bin auto[1]                                         5          1          -    Covered              
#         bin auto[2]                                         6          1          -    Covered              
#         bin auto[3]                                         7          1          -    Covered              
#     Coverpoint b2                                     100.00%        100          -    Covered              
#         covered/total bins:                                 4          4          -                      
#         missing/total bins:                                 0          4          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin auto[0]                                         3          1          -    Covered              
#         bin auto[1]                                         6          1          -    Covered              
#         bin auto[2]                                         6          1          -    Covered              
#         bin auto[3]                                         5          1          -    Covered              
# 
# TOTAL COVERGROUP COVERAGE: 100.00%  COVERGROUP TYPES: 2
# 
# Total Coverage By Instance (filtered view): 100.00%
# 
# 
# Saving coverage database on exit...
*/
