class packet;

  rand bit [7:0] data[4];

  constraint c1 {
                   foreach(data[i])
                        data[i]<30;
                }

endclass

// Covergroup defined outside class
covergroup data(ref bit [7:0] d);

   cp:coverpoint d {
                     bins valid[]={[0:29]};
                   }

endgroup


module tb;

  packet p;

  data cg[4];

  initial begin

    p=new();

    // Create one covergroup per array element
    foreach(cg[i])
      cg[i]=new(p.data[i]);

    repeat(161) begin
      
      assert(p.randomize());
      
      foreach(cg[i])begin
        cg[i].sample();
        $display("data=%0d cg[%0d] Coverage = %0.2f%%",p.data[i],i,cg[i].get_inst_coverage());
      end
      $display("---------------------------------------------------------------------------");
    end
    
    $display(" ====================================================");
    $display("||             FINAL REPORT OF COVERAGE             ||");
    $display(" ====================================================");
    foreach(cg[i])
      $display("|| cg[%0d] Coverage = %0.2f%%                         ||",i,cg[i].get_inst_coverage());
    $display(" ====================================================");

  end

endmodule

run.do file
/*
run -all
# Save the database
coverage save cov.ucdb
# Just run the report once, directly to the log
coverage report -cvg -details
# Exit the simulator immediately
exit

#compiler option: -timescale 1ns/1ns -coverage
#run option: -coverage -voptargs="+acc"
*/

/*

output:
# coverage save -onexit cov_$Sv_Seed.ucdb
# do run.do
# data=28 cg[0] Coverage = 3.33%
# data=5 cg[1] Coverage = 3.33%
# data=11 cg[2] Coverage = 3.33%
# data=25 cg[3] Coverage = 3.33%
# ---------------------------------------------------------------------------
# data=22 cg[0] Coverage = 6.67%
# data=14 cg[1] Coverage = 6.67%
# data=22 cg[2] Coverage = 6.67%
# data=10 cg[3] Coverage = 6.67%
# ---------------------------------------------------------------------------
# data=21 cg[0] Coverage = 10.00%
# data=5 cg[1] Coverage = 6.67%
# data=17 cg[2] Coverage = 10.00%
# data=26 cg[3] Coverage = 10.00%
# ---------------------------------------------------------------------------
# data=18 cg[0] Coverage = 13.33%
# data=7 cg[1] Coverage = 10.00%
# data=14 cg[2] Coverage = 13.33%
# data=11 cg[3] Coverage = 13.33%
# ---------------------------------------------------------------------------
# data=4 cg[0] Coverage = 16.67%
# data=23 cg[1] Coverage = 13.33%
# data=14 cg[2] Coverage = 13.33%
# data=12 cg[3] Coverage = 16.67%
# ---------------------------------------------------------------------------
# data=5 cg[0] Coverage = 20.00%
# data=3 cg[1] Coverage = 16.67%
# data=24 cg[2] Coverage = 16.67%
# data=8 cg[3] Coverage = 20.00%
# ---------------------------------------------------------------------------
# data=6 cg[0] Coverage = 23.33%
# data=11 cg[1] Coverage = 20.00%
# data=22 cg[2] Coverage = 16.67%
# data=5 cg[3] Coverage = 23.33%
# ---------------------------------------------------------------------------
# data=22 cg[0] Coverage = 23.33%
# data=24 cg[1] Coverage = 23.33%
# data=5 cg[2] Coverage = 20.00%
# data=24 cg[3] Coverage = 26.67%
# ---------------------------------------------------------------------------
# data=7 cg[0] Coverage = 26.67%
# data=10 cg[1] Coverage = 26.67%
# data=19 cg[2] Coverage = 23.33%
# data=13 cg[3] Coverage = 30.00%
# ---------------------------------------------------------------------------
# data=10 cg[0] Coverage = 30.00%
# data=0 cg[1] Coverage = 30.00%
# data=5 cg[2] Coverage = 23.33%
# data=18 cg[3] Coverage = 33.33%
# ---------------------------------------------------------------------------
# data=24 cg[0] Coverage = 33.33%
# data=29 cg[1] Coverage = 33.33%
# data=6 cg[2] Coverage = 26.67%
# data=8 cg[3] Coverage = 33.33%
# ---------------------------------------------------------------------------
# data=16 cg[0] Coverage = 36.67%
# data=17 cg[1] Coverage = 36.67%
# data=20 cg[2] Coverage = 30.00%
# data=10 cg[3] Coverage = 33.33%
# ---------------------------------------------------------------------------
# data=5 cg[0] Coverage = 36.67%
# data=11 cg[1] Coverage = 36.67%
# data=4 cg[2] Coverage = 33.33%
# data=29 cg[3] Coverage = 36.67%
# ---------------------------------------------------------------------------
# data=20 cg[0] Coverage = 40.00%
# data=28 cg[1] Coverage = 40.00%
# data=7 cg[2] Coverage = 36.67%
# data=26 cg[3] Coverage = 36.67%
# ---------------------------------------------------------------------------
# data=26 cg[0] Coverage = 43.33%
# data=24 cg[1] Coverage = 40.00%
# data=17 cg[2] Coverage = 36.67%
# data=15 cg[3] Coverage = 40.00%
# ---------------------------------------------------------------------------
# data=18 cg[0] Coverage = 43.33%
# data=24 cg[1] Coverage = 40.00%
# data=29 cg[2] Coverage = 40.00%
# data=5 cg[3] Coverage = 40.00%
# ---------------------------------------------------------------------------
# data=27 cg[0] Coverage = 46.67%
# data=9 cg[1] Coverage = 43.33%
# data=8 cg[2] Coverage = 43.33%
# data=23 cg[3] Coverage = 43.33%
# ---------------------------------------------------------------------------
# data=17 cg[0] Coverage = 50.00%
# data=28 cg[1] Coverage = 43.33%
# data=10 cg[2] Coverage = 46.67%
# data=26 cg[3] Coverage = 43.33%
# ---------------------------------------------------------------------------
# data=22 cg[0] Coverage = 50.00%
# data=5 cg[1] Coverage = 43.33%
# data=5 cg[2] Coverage = 46.67%
# data=22 cg[3] Coverage = 46.67%
# ---------------------------------------------------------------------------
# data=8 cg[0] Coverage = 53.33%
# data=28 cg[1] Coverage = 43.33%
# data=11 cg[2] Coverage = 46.67%
# data=18 cg[3] Coverage = 46.67%
# ---------------------------------------------------------------------------
# data=20 cg[0] Coverage = 53.33%
# data=26 cg[1] Coverage = 46.67%
# data=25 cg[2] Coverage = 50.00%
# data=3 cg[3] Coverage = 50.00%
# ---------------------------------------------------------------------------
# data=3 cg[0] Coverage = 56.67%
# data=4 cg[1] Coverage = 50.00%
# data=27 cg[2] Coverage = 53.33%
# data=15 cg[3] Coverage = 50.00%
# ---------------------------------------------------------------------------
# data=6 cg[0] Coverage = 56.67%
# data=19 cg[1] Coverage = 53.33%
# data=2 cg[2] Coverage = 56.67%
# data=24 cg[3] Coverage = 50.00%
# ---------------------------------------------------------------------------
# data=12 cg[0] Coverage = 60.00%
# data=13 cg[1] Coverage = 56.67%
# data=11 cg[2] Coverage = 56.67%
# data=17 cg[3] Coverage = 53.33%
# ---------------------------------------------------------------------------
# data=16 cg[0] Coverage = 60.00%
# data=6 cg[1] Coverage = 60.00%
# data=17 cg[2] Coverage = 56.67%
# data=12 cg[3] Coverage = 53.33%
# ---------------------------------------------------------------------------
# data=4 cg[0] Coverage = 60.00%
# data=12 cg[1] Coverage = 63.33%
# data=17 cg[2] Coverage = 56.67%
# data=24 cg[3] Coverage = 53.33%
# ---------------------------------------------------------------------------
# data=0 cg[0] Coverage = 63.33%
# data=1 cg[1] Coverage = 66.67%
# data=27 cg[2] Coverage = 56.67%
# data=24 cg[3] Coverage = 53.33%
# ---------------------------------------------------------------------------
# data=5 cg[0] Coverage = 63.33%
# data=6 cg[1] Coverage = 66.67%
# data=7 cg[2] Coverage = 56.67%
# data=12 cg[3] Coverage = 53.33%
# ---------------------------------------------------------------------------
# data=26 cg[0] Coverage = 63.33%
# data=26 cg[1] Coverage = 66.67%
# data=26 cg[2] Coverage = 60.00%
# data=24 cg[3] Coverage = 53.33%
# ---------------------------------------------------------------------------
# data=6 cg[0] Coverage = 63.33%
# data=4 cg[1] Coverage = 66.67%
# data=21 cg[2] Coverage = 63.33%
# data=7 cg[3] Coverage = 56.67%
# ---------------------------------------------------------------------------
# data=13 cg[0] Coverage = 66.67%
# data=27 cg[1] Coverage = 70.00%
# data=28 cg[2] Coverage = 66.67%
# data=11 cg[3] Coverage = 56.67%
# ---------------------------------------------------------------------------
# data=15 cg[0] Coverage = 70.00%
# data=18 cg[1] Coverage = 73.33%
# data=12 cg[2] Coverage = 70.00%
# data=29 cg[3] Coverage = 56.67%
# ---------------------------------------------------------------------------
# data=13 cg[0] Coverage = 70.00%
# data=2 cg[1] Coverage = 76.67%
# data=19 cg[2] Coverage = 70.00%
# data=7 cg[3] Coverage = 56.67%
# ---------------------------------------------------------------------------
# data=12 cg[0] Coverage = 70.00%
# data=20 cg[1] Coverage = 80.00%
# data=27 cg[2] Coverage = 70.00%
# data=6 cg[3] Coverage = 60.00%
# ---------------------------------------------------------------------------
# data=5 cg[0] Coverage = 70.00%
# data=11 cg[1] Coverage = 80.00%
# data=24 cg[2] Coverage = 70.00%
# data=24 cg[3] Coverage = 60.00%
# ---------------------------------------------------------------------------
# data=12 cg[0] Coverage = 70.00%
# data=12 cg[1] Coverage = 80.00%
# data=22 cg[2] Coverage = 70.00%
# data=13 cg[3] Coverage = 60.00%
# ---------------------------------------------------------------------------
# data=23 cg[0] Coverage = 73.33%
# data=12 cg[1] Coverage = 80.00%
# data=25 cg[2] Coverage = 70.00%
# data=4 cg[3] Coverage = 63.33%
# ---------------------------------------------------------------------------
# data=2 cg[0] Coverage = 76.67%
# data=8 cg[1] Coverage = 83.33%
# data=23 cg[2] Coverage = 73.33%
# data=20 cg[3] Coverage = 66.67%
# ---------------------------------------------------------------------------
# data=10 cg[0] Coverage = 76.67%
# data=22 cg[1] Coverage = 86.67%
# data=3 cg[2] Coverage = 76.67%
# data=3 cg[3] Coverage = 66.67%
# ---------------------------------------------------------------------------
# data=27 cg[0] Coverage = 76.67%
# data=4 cg[1] Coverage = 86.67%
# data=2 cg[2] Coverage = 76.67%
# data=13 cg[3] Coverage = 66.67%
# ---------------------------------------------------------------------------
# data=11 cg[0] Coverage = 80.00%
# data=9 cg[1] Coverage = 86.67%
# data=23 cg[2] Coverage = 76.67%
# data=8 cg[3] Coverage = 66.67%
# ---------------------------------------------------------------------------
# data=25 cg[0] Coverage = 83.33%
# data=29 cg[1] Coverage = 86.67%
# data=3 cg[2] Coverage = 76.67%
# data=18 cg[3] Coverage = 66.67%
# ---------------------------------------------------------------------------
# data=21 cg[0] Coverage = 83.33%
# data=20 cg[1] Coverage = 86.67%
# data=20 cg[2] Coverage = 76.67%
# data=11 cg[3] Coverage = 66.67%
# ---------------------------------------------------------------------------
# data=17 cg[0] Coverage = 83.33%
# data=23 cg[1] Coverage = 86.67%
# data=14 cg[2] Coverage = 76.67%
# data=25 cg[3] Coverage = 66.67%
# ---------------------------------------------------------------------------
# data=18 cg[0] Coverage = 83.33%
# data=4 cg[1] Coverage = 86.67%
# data=20 cg[2] Coverage = 76.67%
# data=12 cg[3] Coverage = 66.67%
# ---------------------------------------------------------------------------
# data=6 cg[0] Coverage = 83.33%
# data=23 cg[1] Coverage = 86.67%
# data=11 cg[2] Coverage = 76.67%
# data=19 cg[3] Coverage = 70.00%
# ---------------------------------------------------------------------------
# data=10 cg[0] Coverage = 83.33%
# data=24 cg[1] Coverage = 86.67%
# data=1 cg[2] Coverage = 80.00%
# data=11 cg[3] Coverage = 70.00%
# ---------------------------------------------------------------------------
# data=3 cg[0] Coverage = 83.33%
# data=4 cg[1] Coverage = 86.67%
# data=4 cg[2] Coverage = 80.00%
# data=15 cg[3] Coverage = 70.00%
# ---------------------------------------------------------------------------
# data=8 cg[0] Coverage = 83.33%
# data=7 cg[1] Coverage = 86.67%
# data=20 cg[2] Coverage = 80.00%
# data=3 cg[3] Coverage = 70.00%
# ---------------------------------------------------------------------------
# data=20 cg[0] Coverage = 83.33%
# data=15 cg[1] Coverage = 90.00%
# data=3 cg[2] Coverage = 80.00%
# data=29 cg[3] Coverage = 70.00%
# ---------------------------------------------------------------------------
# data=8 cg[0] Coverage = 83.33%
# data=8 cg[1] Coverage = 90.00%
# data=10 cg[2] Coverage = 80.00%
# data=8 cg[3] Coverage = 70.00%
# ---------------------------------------------------------------------------
# data=8 cg[0] Coverage = 83.33%
# data=10 cg[1] Coverage = 90.00%
# data=10 cg[2] Coverage = 80.00%
# data=10 cg[3] Coverage = 70.00%
# ---------------------------------------------------------------------------
# data=16 cg[0] Coverage = 83.33%
# data=26 cg[1] Coverage = 90.00%
# data=25 cg[2] Coverage = 80.00%
# data=3 cg[3] Coverage = 70.00%
# ---------------------------------------------------------------------------
# data=5 cg[0] Coverage = 83.33%
# data=19 cg[1] Coverage = 90.00%
# data=2 cg[2] Coverage = 80.00%
# data=4 cg[3] Coverage = 70.00%
# ---------------------------------------------------------------------------
# data=7 cg[0] Coverage = 83.33%
# data=14 cg[1] Coverage = 90.00%
# data=1 cg[2] Coverage = 80.00%
# data=10 cg[3] Coverage = 70.00%
# ---------------------------------------------------------------------------
# data=14 cg[0] Coverage = 86.67%
# data=0 cg[1] Coverage = 90.00%
# data=20 cg[2] Coverage = 80.00%
# data=12 cg[3] Coverage = 70.00%
# ---------------------------------------------------------------------------
# data=7 cg[0] Coverage = 86.67%
# data=27 cg[1] Coverage = 90.00%
# data=28 cg[2] Coverage = 80.00%
# data=18 cg[3] Coverage = 70.00%
# ---------------------------------------------------------------------------
# data=11 cg[0] Coverage = 86.67%
# data=25 cg[1] Coverage = 93.33%
# data=21 cg[2] Coverage = 80.00%
# data=0 cg[3] Coverage = 73.33%
# ---------------------------------------------------------------------------
# data=3 cg[0] Coverage = 86.67%
# data=1 cg[1] Coverage = 93.33%
# data=8 cg[2] Coverage = 80.00%
# data=20 cg[3] Coverage = 73.33%
# ---------------------------------------------------------------------------
# data=6 cg[0] Coverage = 86.67%
# data=13 cg[1] Coverage = 93.33%
# data=8 cg[2] Coverage = 80.00%
# data=6 cg[3] Coverage = 73.33%
# ---------------------------------------------------------------------------
# data=22 cg[0] Coverage = 86.67%
# data=16 cg[1] Coverage = 96.67%
# data=10 cg[2] Coverage = 80.00%
# data=10 cg[3] Coverage = 73.33%
# ---------------------------------------------------------------------------
# data=13 cg[0] Coverage = 86.67%
# data=25 cg[1] Coverage = 96.67%
# data=14 cg[2] Coverage = 80.00%
# data=25 cg[3] Coverage = 73.33%
# ---------------------------------------------------------------------------
# data=29 cg[0] Coverage = 90.00%
# data=20 cg[1] Coverage = 96.67%
# data=23 cg[2] Coverage = 80.00%
# data=12 cg[3] Coverage = 73.33%
# ---------------------------------------------------------------------------
# data=22 cg[0] Coverage = 90.00%
# data=22 cg[1] Coverage = 96.67%
# data=13 cg[2] Coverage = 83.33%
# data=26 cg[3] Coverage = 73.33%
# ---------------------------------------------------------------------------
# data=4 cg[0] Coverage = 90.00%
# data=6 cg[1] Coverage = 96.67%
# data=14 cg[2] Coverage = 83.33%
# data=23 cg[3] Coverage = 73.33%
# ---------------------------------------------------------------------------
# data=19 cg[0] Coverage = 93.33%
# data=6 cg[1] Coverage = 96.67%
# data=24 cg[2] Coverage = 83.33%
# data=29 cg[3] Coverage = 73.33%
# ---------------------------------------------------------------------------
# data=21 cg[0] Coverage = 93.33%
# data=19 cg[1] Coverage = 96.67%
# data=1 cg[2] Coverage = 83.33%
# data=27 cg[3] Coverage = 76.67%
# ---------------------------------------------------------------------------
# data=1 cg[0] Coverage = 96.67%
# data=3 cg[1] Coverage = 96.67%
# data=6 cg[2] Coverage = 83.33%
# data=9 cg[3] Coverage = 80.00%
# ---------------------------------------------------------------------------
# data=16 cg[0] Coverage = 96.67%
# data=12 cg[1] Coverage = 96.67%
# data=7 cg[2] Coverage = 83.33%
# data=5 cg[3] Coverage = 80.00%
# ---------------------------------------------------------------------------
# data=25 cg[0] Coverage = 96.67%
# data=2 cg[1] Coverage = 96.67%
# data=13 cg[2] Coverage = 83.33%
# data=7 cg[3] Coverage = 80.00%
# ---------------------------------------------------------------------------
# data=4 cg[0] Coverage = 96.67%
# data=18 cg[1] Coverage = 96.67%
# data=28 cg[2] Coverage = 83.33%
# data=4 cg[3] Coverage = 80.00%
# ---------------------------------------------------------------------------
# data=5 cg[0] Coverage = 96.67%
# data=26 cg[1] Coverage = 96.67%
# data=15 cg[2] Coverage = 86.67%
# data=0 cg[3] Coverage = 80.00%
# ---------------------------------------------------------------------------
# data=13 cg[0] Coverage = 96.67%
# data=7 cg[1] Coverage = 96.67%
# data=29 cg[2] Coverage = 86.67%
# data=20 cg[3] Coverage = 80.00%
# ---------------------------------------------------------------------------
# data=1 cg[0] Coverage = 96.67%
# data=0 cg[1] Coverage = 96.67%
# data=3 cg[2] Coverage = 86.67%
# data=29 cg[3] Coverage = 80.00%
# ---------------------------------------------------------------------------
# data=21 cg[0] Coverage = 96.67%
# data=10 cg[1] Coverage = 96.67%
# data=11 cg[2] Coverage = 86.67%
# data=18 cg[3] Coverage = 80.00%
# ---------------------------------------------------------------------------
# data=14 cg[0] Coverage = 96.67%
# data=22 cg[1] Coverage = 96.67%
# data=21 cg[2] Coverage = 86.67%
# data=5 cg[3] Coverage = 80.00%
# ---------------------------------------------------------------------------
# data=2 cg[0] Coverage = 96.67%
# data=0 cg[1] Coverage = 96.67%
# data=14 cg[2] Coverage = 86.67%
# data=17 cg[3] Coverage = 80.00%
# ---------------------------------------------------------------------------
# data=0 cg[0] Coverage = 96.67%
# data=16 cg[1] Coverage = 96.67%
# data=25 cg[2] Coverage = 86.67%
# data=7 cg[3] Coverage = 80.00%
# ---------------------------------------------------------------------------
# data=17 cg[0] Coverage = 96.67%
# data=27 cg[1] Coverage = 96.67%
# data=18 cg[2] Coverage = 90.00%
# data=22 cg[3] Coverage = 80.00%
# ---------------------------------------------------------------------------
# data=29 cg[0] Coverage = 96.67%
# data=11 cg[1] Coverage = 96.67%
# data=4 cg[2] Coverage = 90.00%
# data=14 cg[3] Coverage = 83.33%
# ---------------------------------------------------------------------------
# data=16 cg[0] Coverage = 96.67%
# data=2 cg[1] Coverage = 96.67%
# data=18 cg[2] Coverage = 90.00%
# data=23 cg[3] Coverage = 83.33%
# ---------------------------------------------------------------------------
# data=24 cg[0] Coverage = 96.67%
# data=13 cg[1] Coverage = 96.67%
# data=21 cg[2] Coverage = 90.00%
# data=4 cg[3] Coverage = 83.33%
# ---------------------------------------------------------------------------
# data=11 cg[0] Coverage = 96.67%
# data=12 cg[1] Coverage = 96.67%
# data=9 cg[2] Coverage = 93.33%
# data=16 cg[3] Coverage = 86.67%
# ---------------------------------------------------------------------------
# data=10 cg[0] Coverage = 96.67%
# data=27 cg[1] Coverage = 96.67%
# data=27 cg[2] Coverage = 93.33%
# data=20 cg[3] Coverage = 86.67%
# ---------------------------------------------------------------------------
# data=6 cg[0] Coverage = 96.67%
# data=18 cg[1] Coverage = 96.67%
# data=28 cg[2] Coverage = 93.33%
# data=24 cg[3] Coverage = 86.67%
# ---------------------------------------------------------------------------
# data=14 cg[0] Coverage = 96.67%
# data=3 cg[1] Coverage = 96.67%
# data=4 cg[2] Coverage = 93.33%
# data=18 cg[3] Coverage = 86.67%
# ---------------------------------------------------------------------------
# data=25 cg[0] Coverage = 96.67%
# data=10 cg[1] Coverage = 96.67%
# data=9 cg[2] Coverage = 93.33%
# data=21 cg[3] Coverage = 90.00%
# ---------------------------------------------------------------------------
# data=22 cg[0] Coverage = 96.67%
# data=21 cg[1] Coverage = 100.00%
# data=11 cg[2] Coverage = 93.33%
# data=27 cg[3] Coverage = 90.00%
# ---------------------------------------------------------------------------
# data=28 cg[0] Coverage = 96.67%
# data=21 cg[1] Coverage = 100.00%
# data=23 cg[2] Coverage = 93.33%
# data=3 cg[3] Coverage = 90.00%
# ---------------------------------------------------------------------------
# data=1 cg[0] Coverage = 96.67%
# data=19 cg[1] Coverage = 100.00%
# data=18 cg[2] Coverage = 93.33%
# data=22 cg[3] Coverage = 90.00%
# ---------------------------------------------------------------------------
# data=8 cg[0] Coverage = 96.67%
# data=0 cg[1] Coverage = 100.00%
# data=15 cg[2] Coverage = 93.33%
# data=13 cg[3] Coverage = 90.00%
# ---------------------------------------------------------------------------
# data=22 cg[0] Coverage = 96.67%
# data=22 cg[1] Coverage = 100.00%
# data=21 cg[2] Coverage = 93.33%
# data=3 cg[3] Coverage = 90.00%
# ---------------------------------------------------------------------------
# data=3 cg[0] Coverage = 96.67%
# data=5 cg[1] Coverage = 100.00%
# data=16 cg[2] Coverage = 96.67%
# data=10 cg[3] Coverage = 90.00%
# ---------------------------------------------------------------------------
# data=19 cg[0] Coverage = 96.67%
# data=28 cg[1] Coverage = 100.00%
# data=23 cg[2] Coverage = 96.67%
# data=6 cg[3] Coverage = 90.00%
# ---------------------------------------------------------------------------
# data=0 cg[0] Coverage = 96.67%
# data=7 cg[1] Coverage = 100.00%
# data=2 cg[2] Coverage = 96.67%
# data=26 cg[3] Coverage = 90.00%
# ---------------------------------------------------------------------------
# data=3 cg[0] Coverage = 96.67%
# data=9 cg[1] Coverage = 100.00%
# data=21 cg[2] Coverage = 96.67%
# data=10 cg[3] Coverage = 90.00%
# ---------------------------------------------------------------------------
# data=3 cg[0] Coverage = 96.67%
# data=6 cg[1] Coverage = 100.00%
# data=1 cg[2] Coverage = 96.67%
# data=19 cg[3] Coverage = 90.00%
# ---------------------------------------------------------------------------
# data=21 cg[0] Coverage = 96.67%
# data=24 cg[1] Coverage = 100.00%
# data=14 cg[2] Coverage = 96.67%
# data=10 cg[3] Coverage = 90.00%
# ---------------------------------------------------------------------------
# data=7 cg[0] Coverage = 96.67%
# data=17 cg[1] Coverage = 100.00%
# data=0 cg[2] Coverage = 100.00%
# data=10 cg[3] Coverage = 90.00%
# ---------------------------------------------------------------------------
# data=22 cg[0] Coverage = 96.67%
# data=2 cg[1] Coverage = 100.00%
# data=5 cg[2] Coverage = 100.00%
# data=28 cg[3] Coverage = 93.33%
# ---------------------------------------------------------------------------
# data=26 cg[0] Coverage = 96.67%
# data=10 cg[1] Coverage = 100.00%
# data=21 cg[2] Coverage = 100.00%
# data=4 cg[3] Coverage = 93.33%
# ---------------------------------------------------------------------------
# data=17 cg[0] Coverage = 96.67%
# data=17 cg[1] Coverage = 100.00%
# data=1 cg[2] Coverage = 100.00%
# data=28 cg[3] Coverage = 93.33%
# ---------------------------------------------------------------------------
# data=13 cg[0] Coverage = 96.67%
# data=22 cg[1] Coverage = 100.00%
# data=24 cg[2] Coverage = 100.00%
# data=1 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=2 cg[0] Coverage = 96.67%
# data=12 cg[1] Coverage = 100.00%
# data=13 cg[2] Coverage = 100.00%
# data=6 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=17 cg[0] Coverage = 96.67%
# data=8 cg[1] Coverage = 100.00%
# data=28 cg[2] Coverage = 100.00%
# data=22 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=29 cg[0] Coverage = 96.67%
# data=13 cg[1] Coverage = 100.00%
# data=8 cg[2] Coverage = 100.00%
# data=14 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=2 cg[0] Coverage = 96.67%
# data=5 cg[1] Coverage = 100.00%
# data=13 cg[2] Coverage = 100.00%
# data=1 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=19 cg[0] Coverage = 96.67%
# data=21 cg[1] Coverage = 100.00%
# data=29 cg[2] Coverage = 100.00%
# data=18 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=9 cg[0] Coverage = 100.00%
# data=25 cg[1] Coverage = 100.00%
# data=19 cg[2] Coverage = 100.00%
# data=6 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=19 cg[0] Coverage = 100.00%
# data=21 cg[1] Coverage = 100.00%
# data=8 cg[2] Coverage = 100.00%
# data=13 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=14 cg[0] Coverage = 100.00%
# data=8 cg[1] Coverage = 100.00%
# data=12 cg[2] Coverage = 100.00%
# data=25 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=0 cg[0] Coverage = 100.00%
# data=29 cg[1] Coverage = 100.00%
# data=13 cg[2] Coverage = 100.00%
# data=15 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=24 cg[0] Coverage = 100.00%
# data=7 cg[1] Coverage = 100.00%
# data=20 cg[2] Coverage = 100.00%
# data=6 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=9 cg[0] Coverage = 100.00%
# data=5 cg[1] Coverage = 100.00%
# data=7 cg[2] Coverage = 100.00%
# data=12 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=3 cg[0] Coverage = 100.00%
# data=8 cg[1] Coverage = 100.00%
# data=6 cg[2] Coverage = 100.00%
# data=8 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=17 cg[0] Coverage = 100.00%
# data=18 cg[1] Coverage = 100.00%
# data=15 cg[2] Coverage = 100.00%
# data=5 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=17 cg[0] Coverage = 100.00%
# data=4 cg[1] Coverage = 100.00%
# data=3 cg[2] Coverage = 100.00%
# data=12 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=11 cg[0] Coverage = 100.00%
# data=0 cg[1] Coverage = 100.00%
# data=10 cg[2] Coverage = 100.00%
# data=21 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=0 cg[0] Coverage = 100.00%
# data=3 cg[1] Coverage = 100.00%
# data=3 cg[2] Coverage = 100.00%
# data=26 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=25 cg[0] Coverage = 100.00%
# data=5 cg[1] Coverage = 100.00%
# data=10 cg[2] Coverage = 100.00%
# data=28 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=21 cg[0] Coverage = 100.00%
# data=17 cg[1] Coverage = 100.00%
# data=7 cg[2] Coverage = 100.00%
# data=1 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=8 cg[0] Coverage = 100.00%
# data=23 cg[1] Coverage = 100.00%
# data=6 cg[2] Coverage = 100.00%
# data=16 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=4 cg[0] Coverage = 100.00%
# data=20 cg[1] Coverage = 100.00%
# data=1 cg[2] Coverage = 100.00%
# data=10 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=26 cg[0] Coverage = 100.00%
# data=25 cg[1] Coverage = 100.00%
# data=6 cg[2] Coverage = 100.00%
# data=11 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=28 cg[0] Coverage = 100.00%
# data=6 cg[1] Coverage = 100.00%
# data=0 cg[2] Coverage = 100.00%
# data=11 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=21 cg[0] Coverage = 100.00%
# data=22 cg[1] Coverage = 100.00%
# data=17 cg[2] Coverage = 100.00%
# data=26 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=1 cg[0] Coverage = 100.00%
# data=23 cg[1] Coverage = 100.00%
# data=24 cg[2] Coverage = 100.00%
# data=11 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=26 cg[0] Coverage = 100.00%
# data=28 cg[1] Coverage = 100.00%
# data=19 cg[2] Coverage = 100.00%
# data=19 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=22 cg[0] Coverage = 100.00%
# data=11 cg[1] Coverage = 100.00%
# data=3 cg[2] Coverage = 100.00%
# data=26 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=29 cg[0] Coverage = 100.00%
# data=23 cg[1] Coverage = 100.00%
# data=12 cg[2] Coverage = 100.00%
# data=18 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=11 cg[0] Coverage = 100.00%
# data=20 cg[1] Coverage = 100.00%
# data=22 cg[2] Coverage = 100.00%
# data=28 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=20 cg[0] Coverage = 100.00%
# data=27 cg[1] Coverage = 100.00%
# data=24 cg[2] Coverage = 100.00%
# data=1 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=1 cg[0] Coverage = 100.00%
# data=22 cg[1] Coverage = 100.00%
# data=13 cg[2] Coverage = 100.00%
# data=12 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=13 cg[0] Coverage = 100.00%
# data=13 cg[1] Coverage = 100.00%
# data=4 cg[2] Coverage = 100.00%
# data=3 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=28 cg[0] Coverage = 100.00%
# data=26 cg[1] Coverage = 100.00%
# data=19 cg[2] Coverage = 100.00%
# data=20 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=16 cg[0] Coverage = 100.00%
# data=17 cg[1] Coverage = 100.00%
# data=17 cg[2] Coverage = 100.00%
# data=4 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=15 cg[0] Coverage = 100.00%
# data=19 cg[1] Coverage = 100.00%
# data=18 cg[2] Coverage = 100.00%
# data=11 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=21 cg[0] Coverage = 100.00%
# data=10 cg[1] Coverage = 100.00%
# data=3 cg[2] Coverage = 100.00%
# data=8 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=8 cg[0] Coverage = 100.00%
# data=24 cg[1] Coverage = 100.00%
# data=4 cg[2] Coverage = 100.00%
# data=14 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=7 cg[0] Coverage = 100.00%
# data=19 cg[1] Coverage = 100.00%
# data=18 cg[2] Coverage = 100.00%
# data=18 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=2 cg[0] Coverage = 100.00%
# data=20 cg[1] Coverage = 100.00%
# data=19 cg[2] Coverage = 100.00%
# data=11 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=24 cg[0] Coverage = 100.00%
# data=14 cg[1] Coverage = 100.00%
# data=17 cg[2] Coverage = 100.00%
# data=24 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=5 cg[0] Coverage = 100.00%
# data=29 cg[1] Coverage = 100.00%
# data=19 cg[2] Coverage = 100.00%
# data=14 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=26 cg[0] Coverage = 100.00%
# data=12 cg[1] Coverage = 100.00%
# data=19 cg[2] Coverage = 100.00%
# data=14 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=18 cg[0] Coverage = 100.00%
# data=0 cg[1] Coverage = 100.00%
# data=0 cg[2] Coverage = 100.00%
# data=12 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=5 cg[0] Coverage = 100.00%
# data=3 cg[1] Coverage = 100.00%
# data=5 cg[2] Coverage = 100.00%
# data=17 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=13 cg[0] Coverage = 100.00%
# data=2 cg[1] Coverage = 100.00%
# data=3 cg[2] Coverage = 100.00%
# data=13 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=14 cg[0] Coverage = 100.00%
# data=14 cg[1] Coverage = 100.00%
# data=14 cg[2] Coverage = 100.00%
# data=8 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=4 cg[0] Coverage = 100.00%
# data=17 cg[1] Coverage = 100.00%
# data=6 cg[2] Coverage = 100.00%
# data=9 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=5 cg[0] Coverage = 100.00%
# data=23 cg[1] Coverage = 100.00%
# data=23 cg[2] Coverage = 100.00%
# data=26 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=21 cg[0] Coverage = 100.00%
# data=9 cg[1] Coverage = 100.00%
# data=16 cg[2] Coverage = 100.00%
# data=17 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=23 cg[0] Coverage = 100.00%
# data=9 cg[1] Coverage = 100.00%
# data=27 cg[2] Coverage = 100.00%
# data=1 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=19 cg[0] Coverage = 100.00%
# data=19 cg[1] Coverage = 100.00%
# data=7 cg[2] Coverage = 100.00%
# data=11 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=27 cg[0] Coverage = 100.00%
# data=26 cg[1] Coverage = 100.00%
# data=4 cg[2] Coverage = 100.00%
# data=0 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=14 cg[0] Coverage = 100.00%
# data=11 cg[1] Coverage = 100.00%
# data=21 cg[2] Coverage = 100.00%
# data=14 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=26 cg[0] Coverage = 100.00%
# data=18 cg[1] Coverage = 100.00%
# data=26 cg[2] Coverage = 100.00%
# data=14 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=20 cg[0] Coverage = 100.00%
# data=27 cg[1] Coverage = 100.00%
# data=0 cg[2] Coverage = 100.00%
# data=3 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=27 cg[0] Coverage = 100.00%
# data=3 cg[1] Coverage = 100.00%
# data=12 cg[2] Coverage = 100.00%
# data=14 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=24 cg[0] Coverage = 100.00%
# data=10 cg[1] Coverage = 100.00%
# data=25 cg[2] Coverage = 100.00%
# data=4 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=20 cg[0] Coverage = 100.00%
# data=28 cg[1] Coverage = 100.00%
# data=0 cg[2] Coverage = 100.00%
# data=25 cg[3] Coverage = 96.67%
# ---------------------------------------------------------------------------
# data=11 cg[0] Coverage = 100.00%
# data=11 cg[1] Coverage = 100.00%
# data=12 cg[2] Coverage = 100.00%
# data=2 cg[3] Coverage = 100.00%
# ---------------------------------------------------------------------------
#  ====================================================
# ||             FINAL REPORT OF COVERAGE             ||
#  ====================================================
# || cg[0] Coverage = 100.00%                         ||
# || cg[1] Coverage = 100.00%                         ||
# || cg[2] Coverage = 100.00%                         ||
# || cg[3] Coverage = 100.00%                         ||
#  ====================================================
# Coverage Report by instance with details
# 
# =================================================================================
# === Instance: /design_sv_unit
# === Design Unit: work.design_sv_unit
# =================================================================================
# 
# Covergroup Coverage:
#     Covergroups                      1        na        na   100.00%
#         Coverpoints/Crosses          1        na        na        na
#             Covergroup Bins        120       120         0   100.00%
# ----------------------------------------------------------------------------------------------------------
# Covergroup                                             Metric       Goal       Bins    Status               
#                                                                                                          
# ----------------------------------------------------------------------------------------------------------
#  TYPE /design_sv_unit/data                            100.00%        100          -    Covered              
#     covered/total bins:                                   120        120          -                      
#     missing/total bins:                                     0        120          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint cp                                     100.00%        100          -    Covered              
#         covered/total bins:                               120        120          -                      
#         missing/total bins:                                 0        120          -                      
#         % Hit:                                        100.00%        100          -                      
#  Covergroup instance \/tb/cg#1                        100.00%        100          -    Covered              
#     covered/total bins:                                    30         30          -                      
#     missing/total bins:                                     0         30          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint cp                                     100.00%        100          -    Covered              
#         covered/total bins:                                30         30          -                      
#         missing/total bins:                                 0         30          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin valid[0]                                        5          1          -    Covered              
#         bin valid[1]                                        5          1          -    Covered              
#         bin valid[2]                                        5          1          -    Covered              
#         bin valid[3]                                        7          1          -    Covered              
#         bin valid[4]                                        6          1          -    Covered              
#         bin valid[5]                                        9          1          -    Covered              
#         bin valid[6]                                        6          1          -    Covered              
#         bin valid[7]                                        5          1          -    Covered              
#         bin valid[8]                                        7          1          -    Covered              
#         bin valid[9]                                        2          1          -    Covered              
#         bin valid[10]                                       4          1          -    Covered              
#         bin valid[11]                                       6          1          -    Covered              
#         bin valid[12]                                       3          1          -    Covered              
#         bin valid[13]                                       7          1          -    Covered              
#         bin valid[14]                                       6          1          -    Covered              
#         bin valid[15]                                       2          1          -    Covered              
#         bin valid[16]                                       6          1          -    Covered              
#         bin valid[17]                                       7          1          -    Covered              
#         bin valid[18]                                       4          1          -    Covered              
#         bin valid[19]                                       5          1          -    Covered              
#         bin valid[20]                                       6          1          -    Covered              
#         bin valid[21]                                       9          1          -    Covered              
#         bin valid[22]                                       9          1          -    Covered              
#         bin valid[23]                                       2          1          -    Covered              
#         bin valid[24]                                       5          1          -    Covered              
#         bin valid[25]                                       4          1          -    Covered              
#         bin valid[26]                                       7          1          -    Covered              
#         bin valid[27]                                       4          1          -    Covered              
#         bin valid[28]                                       4          1          -    Covered              
#         bin valid[29]                                       4          1          -    Covered              
#  Covergroup instance \/tb/cg#2                        100.00%        100          -    Covered              
#     covered/total bins:                                    30         30          -                      
#     missing/total bins:                                     0         30          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint cp                                     100.00%        100          -    Covered              
#         covered/total bins:                                30         30          -                      
#         missing/total bins:                                 0         30          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin valid[0]                                        7          1          -    Covered              
#         bin valid[1]                                        2          1          -    Covered              
#         bin valid[2]                                        5          1          -    Covered              
#         bin valid[3]                                        6          1          -    Covered              
#         bin valid[4]                                        6          1          -    Covered              
#         bin valid[5]                                        7          1          -    Covered              
#         bin valid[6]                                        6          1          -    Covered              
#         bin valid[7]                                        5          1          -    Covered              
#         bin valid[8]                                        5          1          -    Covered              
#         bin valid[9]                                        5          1          -    Covered              
#         bin valid[10]                                       7          1          -    Covered              
#         bin valid[11]                                       7          1          -    Covered              
#         bin valid[12]                                       7          1          -    Covered              
#         bin valid[13]                                       5          1          -    Covered              
#         bin valid[14]                                       4          1          -    Covered              
#         bin valid[15]                                       1          1          -    Covered              
#         bin valid[16]                                       2          1          -    Covered              
#         bin valid[17]                                       6          1          -    Covered              
#         bin valid[18]                                       5          1          -    Covered              
#         bin valid[19]                                       7          1          -    Covered              
#         bin valid[20]                                       6          1          -    Covered              
#         bin valid[21]                                       4          1          -    Covered              
#         bin valid[22]                                       7          1          -    Covered              
#         bin valid[23]                                       7          1          -    Covered              
#         bin valid[24]                                       6          1          -    Covered              
#         bin valid[25]                                       4          1          -    Covered              
#         bin valid[26]                                       6          1          -    Covered              
#         bin valid[27]                                       6          1          -    Covered              
#         bin valid[28]                                       6          1          -    Covered              
#         bin valid[29]                                       4          1          -    Covered              
#  Covergroup instance \/tb/cg#3                        100.00%        100          -    Covered              
#     covered/total bins:                                    30         30          -                      
#     missing/total bins:                                     0         30          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint cp                                     100.00%        100          -    Covered              
#         covered/total bins:                                30         30          -                      
#         missing/total bins:                                 0         30          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin valid[0]                                        5          1          -    Covered              
#         bin valid[1]                                        6          1          -    Covered              
#         bin valid[2]                                        4          1          -    Covered              
#         bin valid[3]                                        9          1          -    Covered              
#         bin valid[4]                                        7          1          -    Covered              
#         bin valid[5]                                        5          1          -    Covered              
#         bin valid[6]                                        6          1          -    Covered              
#         bin valid[7]                                        6          1          -    Covered              
#         bin valid[8]                                        5          1          -    Covered              
#         bin valid[9]                                        2          1          -    Covered              
#         bin valid[10]                                       6          1          -    Covered              
#         bin valid[11]                                       6          1          -    Covered              
#         bin valid[12]                                       5          1          -    Covered              
#         bin valid[13]                                       6          1          -    Covered              
#         bin valid[14]                                       8          1          -    Covered              
#         bin valid[15]                                       3          1          -    Covered              
#         bin valid[16]                                       2          1          -    Covered              
#         bin valid[17]                                       7          1          -    Covered              
#         bin valid[18]                                       5          1          -    Covered              
#         bin valid[19]                                       8          1          -    Covered              
#         bin valid[20]                                       6          1          -    Covered              
#         bin valid[21]                                       8          1          -    Covered              
#         bin valid[22]                                       4          1          -    Covered              
#         bin valid[23]                                       6          1          -    Covered              
#         bin valid[24]                                       6          1          -    Covered              
#         bin valid[25]                                       5          1          -    Covered              
#         bin valid[26]                                       2          1          -    Covered              
#         bin valid[27]                                       5          1          -    Covered              
#         bin valid[28]                                       5          1          -    Covered              
#         bin valid[29]                                       3          1          -    Covered              
#  Covergroup instance \/tb/cg#4                        100.00%        100          -    Covered              
#     covered/total bins:                                    30         30          -                      
#     missing/total bins:                                     0         30          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint cp                                     100.00%        100          -    Covered              
#         covered/total bins:                                30         30          -                      
#         missing/total bins:                                 0         30          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin valid[0]                                        3          1          -    Covered              
#         bin valid[1]                                        5          1          -    Covered              
#         bin valid[2]                                        1          1          -    Covered              
#         bin valid[3]                                        8          1          -    Covered              
#         bin valid[4]                                        7          1          -    Covered              
#         bin valid[5]                                        5          1          -    Covered              
#         bin valid[6]                                        6          1          -    Covered              
#         bin valid[7]                                        4          1          -    Covered              
#         bin valid[8]                                        7          1          -    Covered              
#         bin valid[9]                                        2          1          -    Covered              
#         bin valid[10]                                      10          1          -    Covered              
#         bin valid[11]                                      10          1          -    Covered              
#         bin valid[12]                                      10          1          -    Covered              
#         bin valid[13]                                       6          1          -    Covered              
#         bin valid[14]                                       8          1          -    Covered              
#         bin valid[15]                                       4          1          -    Covered              
#         bin valid[16]                                       2          1          -    Covered              
#         bin valid[17]                                       4          1          -    Covered              
#         bin valid[18]                                       9          1          -    Covered              
#         bin valid[19]                                       3          1          -    Covered              
#         bin valid[20]                                       5          1          -    Covered              
#         bin valid[21]                                       2          1          -    Covered              
#         bin valid[22]                                       4          1          -    Covered              
#         bin valid[23]                                       3          1          -    Covered              
#         bin valid[24]                                       8          1          -    Covered              
#         bin valid[25]                                       5          1          -    Covered              
#         bin valid[26]                                       9          1          -    Covered              
#         bin valid[27]                                       2          1          -    Covered              
#         bin valid[28]                                       4          1          -    Covered              
#         bin valid[29]                                       5          1          -    Covered              
# 
# TOTAL COVERGROUP COVERAGE: 100.00%  COVERGROUP TYPES: 1
# 
# Total Coverage By Instance (filtered view): 100.00%
  
  */
