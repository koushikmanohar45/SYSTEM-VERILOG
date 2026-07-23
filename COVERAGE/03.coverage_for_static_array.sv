class randomize_c;
  randc bit [7:0] data1[4];
  randc bit [7:0] data2[20];
  
  constraint c1{
                     foreach(data1[i])
                         data1[i]<30;
               }
  
  constraint c2{
                     foreach(data2[i])
                         data2[i] inside{0,[2:5],20,[25:31]};
               }

  
//    covergroup error;
//     a1:coverpoint data1;//error-A coverpoint expects a scalar/integral expression, not an unpacked array.
//    endgroup
  
  covergroup a;   
    a1:coverpoint data1[0]{
                            bins a11[]={[0:29]};
                          }
    a2:coverpoint data1[1]{
                            bins a21[]={[0:29]};
                          }
    a3:coverpoint data1[2]{
                            bins a31[]={[0:29]};
                          }
    a4:coverpoint data1[3]{
                            bins a41[]={[0:29]};
                          }
  endgroup


  
  
  function new();
//    error=new();
    a=new();
  endfunction
  
endclass


  covergroup b(ref bit[7:0]d);
    b1:coverpoint d{
                      bins ba[]={0,[2:5],20,[25:31]};
                    }
  endgroup


module coverage_inside_class;


  initial begin
    randomize_c r=new();
    
    b cg[20];

    foreach(cg[i])
      cg[i] = new(r.data2[i]);
    
    $display("+----------------------------------+-----------------------------------+");
    $display("|          cg1 coverage            |            cg2 coverage           |");
    $display("|         data1[4]=0,..,29         |    data[45]=0,2,3,4,5,20,25..,31  |");
    $display("+----------------------------------+-----------------------------------+");

    repeat(30) begin
      r.randomize();
//    r.error.sample();
      r.a.sample();
      $display("|     data1[0]=%d data[1]=%d    |                                  |",r.data1[0],r.data1[1]);
      $display("|     data1[2]=%d data[3]=%d    |                                  |",r.data1[2],r.data1[3]);
      $display("|       coverage=%0.2f%%          |                                 |",r.a.get_inst_coverage());
      
      foreach(cg[i])begin
          cg[i].sample();
        $display("|                                 |   data[%0d]=%d                   |",i,r.data2[i]);
        $display("|                                 |         coverage=%0.2f%%         |",cg[i].get_inst_coverage());
      end

      
      $display("+--------------------------------+-----------------------------------+");

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
output:
 +----------------------------------+-----------------------------------+
# |          cg1 coverage            |            cg2 coverage           |
# |         data1[4]=0,..,29         |    data[45]=0,2,3,4,5,20,25..,31  |
# +----------------------------------+-----------------------------------+
# |     data1[0]= 14 data[1]= 11    |                                  |
# |     data1[2]= 24 data[3]= 19    |                                  |
# |       coverage=3.33%          |                                 |
# |                                 |   data[0]= 25                   |
# |                                 |         coverage=7.69%         |
# |                                 |   data[1]=  5                   |
# |                                 |         coverage=7.69%         |
# |                                 |   data[2]= 25                   |
# |                                 |         coverage=7.69%         |
# |                                 |   data[3]=  2                   |
# |                                 |         coverage=7.69%         |
# |                                 |   data[4]= 31                   |
# |                                 |         coverage=7.69%         |
# |                                 |   data[5]= 29                   |
# |                                 |         coverage=7.69%         |
# |                                 |   data[6]=  0                   |
# |                                 |         coverage=7.69%         |
# |                                 |   data[7]=  4                   |
# |                                 |         coverage=7.69%         |
# |                                 |   data[8]= 30                   |
# |                                 |         coverage=7.69%         |
# |                                 |   data[9]= 26                   |
# |                                 |         coverage=7.69%         |
# |                                 |   data[10]=  0                   |
# |                                 |         coverage=7.69%         |
# |                                 |   data[11]= 20                   |
# |                                 |         coverage=7.69%         |
# |                                 |   data[12]= 31                   |
# |                                 |         coverage=7.69%         |
# |                                 |   data[13]= 27                   |
# |                                 |         coverage=7.69%         |
# |                                 |   data[14]= 30                   |
# |                                 |         coverage=7.69%         |
# |                                 |   data[15]= 30                   |
# |                                 |         coverage=7.69%         |
# |                                 |   data[16]= 28                   |
# |                                 |         coverage=7.69%         |
# |                                 |   data[17]= 27                   |
# |                                 |         coverage=7.69%         |
# |                                 |   data[18]=  5                   |
# |                                 |         coverage=7.69%         |
# |                                 |   data[19]=  2                   |
# |                                 |         coverage=7.69%         |
# +--------------------------------+-----------------------------------+
# |     data1[0]= 10 data[1]= 20    |                                  |
# |     data1[2]= 25 data[3]=  6    |                                  |
# |       coverage=6.67%          |                                 |
# |                                 |   data[0]= 29                   |
# |                                 |         coverage=15.38%         |
# |                                 |   data[1]= 31                   |
# |                                 |         coverage=15.38%         |
# |                                 |   data[2]= 31                   |
# |                                 |         coverage=15.38%         |
# |                                 |   data[3]= 28                   |
# |                                 |         coverage=15.38%         |
# |                                 |   data[4]= 29                   |
# |                                 |         coverage=15.38%         |
# |                                 |   data[5]=  3                   |
# |                                 |         coverage=15.38%         |
# |                                 |   data[6]= 20                   |
# |                                 |         coverage=15.38%         |
# |                                 |   data[7]=  2                   |
# |                                 |         coverage=15.38%         |
# |                                 |   data[8]=  3                   |
# |                                 |         coverage=15.38%         |
# |                                 |   data[9]= 31                   |
# |                                 |         coverage=15.38%         |
# |                                 |   data[10]= 25                   |
# |                                 |         coverage=15.38%         |
# |                                 |   data[11]=  5                   |
# |                                 |         coverage=15.38%         |
# |                                 |   data[12]= 27                   |
# |                                 |         coverage=15.38%         |
# |                                 |   data[13]= 25                   |
# |                                 |         coverage=15.38%         |
# |                                 |   data[14]=  3                   |
# |                                 |         coverage=15.38%         |
# |                                 |   data[15]= 28                   |
# |                                 |         coverage=15.38%         |
# |                                 |   data[16]= 25                   |
# |                                 |         coverage=15.38%         |
# |                                 |   data[17]=  2                   |
# |                                 |         coverage=15.38%         |
# |                                 |   data[18]= 28                   |
# |                                 |         coverage=15.38%         |
# |                                 |   data[19]= 20                   |
# |                                 |         coverage=15.38%         |
# +--------------------------------+-----------------------------------+
# |     data1[0]=  7 data[1]=  1    |                                  |
# |     data1[2]= 22 data[3]=  2    |                                  |
# |       coverage=10.00%          |                                 |
# |                                 |   data[0]=  3                   |
# |                                 |         coverage=23.08%         |
# |                                 |   data[1]= 27                   |
# |                                 |         coverage=23.08%         |
# |                                 |   data[2]= 30                   |
# |                                 |         coverage=23.08%         |
# |                                 |   data[3]= 30                   |
# |                                 |         coverage=23.08%         |
# |                                 |   data[4]= 28                   |
# |                                 |         coverage=23.08%         |
# |                                 |   data[5]= 27                   |
# |                                 |         coverage=23.08%         |
# |                                 |   data[6]= 29                   |
# |                                 |         coverage=23.08%         |
# |                                 |   data[7]= 26                   |
# |                                 |         coverage=23.08%         |
# |                                 |   data[8]= 29                   |
# |                                 |         coverage=23.08%         |
# |                                 |   data[9]=  5                   |
# |                                 |         coverage=23.08%         |
# |                                 |   data[10]=  5                   |
# |                                 |         coverage=23.08%         |
# |                                 |   data[11]=  2                   |
# |                                 |         coverage=23.08%         |
# |                                 |   data[12]=  3                   |
# |                                 |         coverage=23.08%         |
# |                                 |   data[13]= 20                   |
# |                                 |         coverage=23.08%         |
# |                                 |   data[14]=  5                   |
# |                                 |         coverage=23.08%         |
# |                                 |   data[15]=  2                   |
# |                                 |         coverage=23.08%         |
# |                                 |   data[16]= 27                   |
# |                                 |         coverage=23.08%         |
# |                                 |   data[17]= 31                   |
# |                                 |         coverage=23.08%         |
# |                                 |   data[18]=  0                   |
# |                                 |         coverage=23.08%         |
# |                                 |   data[19]=  0                   |
# |                                 |         coverage=23.08%         |
# +--------------------------------+-----------------------------------+
# |     data1[0]= 18 data[1]= 16    |                                  |
# |     data1[2]=  2 data[3]= 18    |                                  |
# |       coverage=13.33%          |                                 |
# |                                 |   data[0]= 30                   |
# |                                 |         coverage=30.77%         |
# |                                 |   data[1]= 30                   |
# |                                 |         coverage=30.77%         |
# |                                 |   data[2]= 26                   |
# |                                 |         coverage=30.77%         |
# |                                 |   data[3]= 26                   |
# |                                 |         coverage=30.77%         |
# |                                 |   data[4]=  4                   |
# |                                 |         coverage=30.77%         |
# |                                 |   data[5]= 30                   |
# |                                 |         coverage=30.77%         |
# |                                 |   data[6]=  4                   |
# |                                 |         coverage=30.77%         |
# |                                 |   data[7]= 25                   |
# |                                 |         coverage=30.77%         |
# |                                 |   data[8]=  2                   |
# |                                 |         coverage=30.77%         |
# |                                 |   data[9]=  3                   |
# |                                 |         coverage=30.77%         |
# |                                 |   data[10]= 26                   |
# |                                 |         coverage=30.77%         |
# |                                 |   data[11]= 31                   |
# |                                 |         coverage=30.77%         |
# |                                 |   data[12]= 26                   |
# |                                 |         coverage=30.77%         |
# |                                 |   data[13]= 26                   |
# |                                 |         coverage=30.77%         |
# |                                 |   data[14]= 27                   |
# |                                 |         coverage=30.77%         |
# |                                 |   data[15]=  5                   |
# |                                 |         coverage=30.77%         |
# |                                 |   data[16]= 31                   |
# |                                 |         coverage=30.77%         |
# |                                 |   data[17]= 25                   |
# |                                 |         coverage=30.77%         |
# |                                 |   data[18]= 26                   |
# |                                 |         coverage=30.77%         |
# |                                 |   data[19]=  5                   |
# |                                 |         coverage=30.77%         |
# +--------------------------------+-----------------------------------+
# |     data1[0]=  9 data[1]=  5    |                                  |
# |     data1[2]= 18 data[3]= 12    |                                  |
# |       coverage=16.67%          |                                 |
# |                                 |   data[0]= 31                   |
# |                                 |         coverage=38.46%         |
# |                                 |   data[1]= 29                   |
# |                                 |         coverage=38.46%         |
# |                                 |   data[2]= 27                   |
# |                                 |         coverage=38.46%         |
# |                                 |   data[3]= 31                   |
# |                                 |         coverage=38.46%         |
# |                                 |   data[4]=  3                   |
# |                                 |         coverage=38.46%         |
# |                                 |   data[5]= 25                   |
# |                                 |         coverage=38.46%         |
# |                                 |   data[6]=  5                   |
# |                                 |         coverage=38.46%         |
# |                                 |   data[7]=  5                   |
# |                                 |         coverage=38.46%         |
# |                                 |   data[8]= 28                   |
# |                                 |         coverage=38.46%         |
# |                                 |   data[9]= 25                   |
# |                                 |         coverage=38.46%         |
# |                                 |   data[10]= 20                   |
# |                                 |         coverage=38.46%         |
# |                                 |   data[11]=  4                   |
# |                                 |         coverage=38.46%         |
# |                                 |   data[12]=  0                   |
# |                                 |         coverage=38.46%         |
# |                                 |   data[13]= 30                   |
# |                                 |         coverage=38.46%         |
# |                                 |   data[14]= 25                   |
# |                                 |         coverage=38.46%         |
# |                                 |   data[15]= 20                   |
# |                                 |         coverage=38.46%         |
# |                                 |   data[16]=  0                   |
# |                                 |         coverage=38.46%         |
# |                                 |   data[17]=  3                   |
# |                                 |         coverage=38.46%         |
# |                                 |   data[18]= 31                   |
# |                                 |         coverage=38.46%         |
# |                                 |   data[19]= 28                   |
# |                                 |         coverage=38.46%         |
# +--------------------------------+-----------------------------------+
# |     data1[0]= 19 data[1]= 27    |                                  |
# |     data1[2]= 10 data[3]= 10    |                                  |
# |       coverage=20.00%          |                                 |
# |                                 |   data[0]=  5                   |
# |                                 |         coverage=46.15%         |
# |                                 |   data[1]=  4                   |
# |                                 |         coverage=46.15%         |
# |                                 |   data[2]=  2                   |
# |                                 |         coverage=46.15%         |
# |                                 |   data[3]= 29                   |
# |                                 |         coverage=46.15%         |
# |                                 |   data[4]=  5                   |
# |                                 |         coverage=46.15%         |
# |                                 |   data[5]=  0                   |
# |                                 |         coverage=46.15%         |
# |                                 |   data[6]= 25                   |
# |                                 |         coverage=46.15%         |
# |                                 |   data[7]=  3                   |
# |                                 |         coverage=46.15%         |
# |                                 |   data[8]= 27                   |
# |                                 |         coverage=46.15%         |
# |                                 |   data[9]=  2                   |
# |                                 |         coverage=46.15%         |
# |                                 |   data[10]=  4                   |
# |                                 |         coverage=46.15%         |
# |                                 |   data[11]= 25                   |
# |                                 |         coverage=46.15%         |
# |                                 |   data[12]= 28                   |
# |                                 |         coverage=46.15%         |
# |                                 |   data[13]=  4                   |
# |                                 |         coverage=46.15%         |
# |                                 |   data[14]= 26                   |
# |                                 |         coverage=46.15%         |
# |                                 |   data[15]=  3                   |
# |                                 |         coverage=46.15%         |
# |                                 |   data[16]=  3                   |
# |                                 |         coverage=46.15%         |
# |                                 |   data[17]= 29                   |
# |                                 |         coverage=46.15%         |
# |                                 |   data[18]= 25                   |
# |                                 |         coverage=46.15%         |
# |                                 |   data[19]=  4                   |
# |                                 |         coverage=46.15%         |
# +--------------------------------+-----------------------------------+
# |     data1[0]= 29 data[1]=  9    |                                  |
# |     data1[2]=  0 data[3]= 29    |                                  |
# |       coverage=23.33%          |                                 |
# |                                 |   data[0]=  2                   |
# |                                 |         coverage=53.85%         |
# |                                 |   data[1]= 20                   |
# |                                 |         coverage=53.85%         |
# |                                 |   data[2]= 20                   |
# |                                 |         coverage=53.85%         |
# |                                 |   data[3]=  4                   |
# |                                 |         coverage=53.85%         |
# |                                 |   data[4]= 20                   |
# |                                 |         coverage=53.85%         |
# |                                 |   data[5]= 20                   |
# |                                 |         coverage=53.85%         |
# |                                 |   data[6]= 26                   |
# |                                 |         coverage=53.85%         |
# |                                 |   data[7]= 31                   |
# |                                 |         coverage=53.85%         |
# |                                 |   data[8]=  5                   |
# |                                 |         coverage=53.85%         |
# |                                 |   data[9]= 30                   |
# |                                 |         coverage=53.85%         |
# |                                 |   data[10]= 29                   |
# |                                 |         coverage=53.85%         |
# |                                 |   data[11]=  3                   |
# |                                 |         coverage=53.85%         |
# |                                 |   data[12]= 20                   |
# |                                 |         coverage=53.85%         |
# |                                 |   data[13]=  2                   |
# |                                 |         coverage=53.85%         |
# |                                 |   data[14]=  4                   |
# |                                 |         coverage=53.85%         |
# |                                 |   data[15]= 31                   |
# |                                 |         coverage=53.85%         |
# |                                 |   data[16]=  5                   |
# |                                 |         coverage=53.85%         |
# |                                 |   data[17]=  4                   |
# |                                 |         coverage=53.85%         |
# |                                 |   data[18]= 27                   |
# |                                 |         coverage=53.85%         |
# |                                 |   data[19]= 27                   |
# |                                 |         coverage=53.85%         |
# +--------------------------------+-----------------------------------+
# |     data1[0]= 20 data[1]= 17    |                                  |
# |     data1[2]= 14 data[3]= 13    |                                  |
# |       coverage=26.67%          |                                 |
# |                                 |   data[0]= 20                   |
# |                                 |         coverage=61.54%         |
# |                                 |   data[1]= 25                   |
# |                                 |         coverage=61.54%         |
# |                                 |   data[2]= 28                   |
# |                                 |         coverage=61.54%         |
# |                                 |   data[3]=  3                   |
# |                                 |         coverage=61.54%         |
# |                                 |   data[4]= 25                   |
# |                                 |         coverage=61.54%         |
# |                                 |   data[5]=  4                   |
# |                                 |         coverage=61.54%         |
# |                                 |   data[6]=  3                   |
# |                                 |         coverage=61.54%         |
# |                                 |   data[7]= 28                   |
# |                                 |         coverage=61.54%         |
# |                                 |   data[8]= 20                   |
# |                                 |         coverage=61.54%         |
# |                                 |   data[9]=  0                   |
# |                                 |         coverage=61.54%         |
# |                                 |   data[10]=  3                   |
# |                                 |         coverage=61.54%         |
# |                                 |   data[11]= 26                   |
# |                                 |         coverage=61.54%         |
# |                                 |   data[12]= 25                   |
# |                                 |         coverage=61.54%         |
# |                                 |   data[13]= 31                   |
# |                                 |         coverage=61.54%         |
# |                                 |   data[14]= 31                   |
# |                                 |         coverage=61.54%         |
# |                                 |   data[15]= 27                   |
# |                                 |         coverage=61.54%         |
# |                                 |   data[16]=  4                   |
# |                                 |         coverage=61.54%         |
# |                                 |   data[17]= 20                   |
# |                                 |         coverage=61.54%         |
# |                                 |   data[18]=  2                   |
# |                                 |         coverage=61.54%         |
# |                                 |   data[19]=  3                   |
# |                                 |         coverage=61.54%         |
# +--------------------------------+-----------------------------------+
# |     data1[0]=  3 data[1]= 12    |                                  |
# |     data1[2]= 27 data[3]= 27    |                                  |
# |       coverage=30.00%          |                                 |
# |                                 |   data[0]=  4                   |
# |                                 |         coverage=69.23%         |
# |                                 |   data[1]= 28                   |
# |                                 |         coverage=69.23%         |
# |                                 |   data[2]=  5                   |
# |                                 |         coverage=69.23%         |
# |                                 |   data[3]= 20                   |
# |                                 |         coverage=69.23%         |
# |                                 |   data[4]= 26                   |
# |                                 |         coverage=69.23%         |
# |                                 |   data[5]= 31                   |
# |                                 |         coverage=69.23%         |
# |                                 |   data[6]= 30                   |
# |                                 |         coverage=69.23%         |
# |                                 |   data[7]= 20                   |
# |                                 |         coverage=69.23%         |
# |                                 |   data[8]=  0                   |
# |                                 |         coverage=69.23%         |
# |                                 |   data[9]= 29                   |
# |                                 |         coverage=69.23%         |
# |                                 |   data[10]= 31                   |
# |                                 |         coverage=69.23%         |
# |                                 |   data[11]= 28                   |
# |                                 |         coverage=69.23%         |
# |                                 |   data[12]=  2                   |
# |                                 |         coverage=69.23%         |
# |                                 |   data[13]=  3                   |
# |                                 |         coverage=69.23%         |
# |                                 |   data[14]= 20                   |
# |                                 |         coverage=69.23%         |
# |                                 |   data[15]= 26                   |
# |                                 |         coverage=69.23%         |
# |                                 |   data[16]= 20                   |
# |                                 |         coverage=69.23%         |
# |                                 |   data[17]= 28                   |
# |                                 |         coverage=69.23%         |
# |                                 |   data[18]=  4                   |
# |                                 |         coverage=69.23%         |
# |                                 |   data[19]= 31                   |
# |                                 |         coverage=69.23%         |
# +--------------------------------+-----------------------------------+
# |     data1[0]=  8 data[1]= 19    |                                  |
# |     data1[2]= 17 data[3]=  0    |                                  |
# |       coverage=33.33%          |                                 |
# |                                 |   data[0]= 26                   |
# |                                 |         coverage=76.92%         |
# |                                 |   data[1]=  0                   |
# |                                 |         coverage=76.92%         |
# |                                 |   data[2]=  0                   |
# |                                 |         coverage=76.92%         |
# |                                 |   data[3]=  0                   |
# |                                 |         coverage=76.92%         |
# |                                 |   data[4]=  0                   |
# |                                 |         coverage=76.92%         |
# |                                 |   data[5]=  2                   |
# |                                 |         coverage=76.92%         |
# |                                 |   data[6]=  2                   |
# |                                 |         coverage=76.92%         |
# |                                 |   data[7]=  0                   |
# |                                 |         coverage=76.92%         |
# |                                 |   data[8]= 25                   |
# |                                 |         coverage=76.92%         |
# |                                 |   data[9]=  4                   |
# |                                 |         coverage=76.92%         |
# |                                 |   data[10]=  2                   |
# |                                 |         coverage=76.92%         |
# |                                 |   data[11]=  0                   |
# |                                 |         coverage=76.92%         |
# |                                 |   data[12]= 29                   |
# |                                 |         coverage=76.92%         |
# |                                 |   data[13]= 29                   |
# |                                 |         coverage=76.92%         |
# |                                 |   data[14]=  2                   |
# |                                 |         coverage=76.92%         |
# |                                 |   data[15]= 25                   |
# |                                 |         coverage=76.92%         |
# |                                 |   data[16]= 30                   |
# |                                 |         coverage=76.92%         |
# |                                 |   data[17]= 26                   |
# |                                 |         coverage=76.92%         |
# |                                 |   data[18]= 29                   |
# |                                 |         coverage=76.92%         |
# |                                 |   data[19]= 26                   |
# |                                 |         coverage=76.92%         |
# +--------------------------------+-----------------------------------+
# |     data1[0]=  0 data[1]= 13    |                                  |
# |     data1[2]=  6 data[3]=  9    |                                  |
# |       coverage=36.67%          |                                 |
# |                                 |   data[0]= 27                   |
# |                                 |         coverage=84.62%         |
# |                                 |   data[1]= 26                   |
# |                                 |         coverage=84.62%         |
# |                                 |   data[2]= 29                   |
# |                                 |         coverage=84.62%         |
# |                                 |   data[3]= 25                   |
# |                                 |         coverage=84.62%         |
# |                                 |   data[4]= 30                   |
# |                                 |         coverage=84.62%         |
# |                                 |   data[5]=  5                   |
# |                                 |         coverage=84.62%         |
# |                                 |   data[6]= 31                   |
# |                                 |         coverage=84.62%         |
# |                                 |   data[7]= 29                   |
# |                                 |         coverage=84.62%         |
# |                                 |   data[8]= 26                   |
# |                                 |         coverage=84.62%         |
# |                                 |   data[9]= 28                   |
# |                                 |         coverage=84.62%         |
# |                                 |   data[10]= 30                   |
# |                                 |         coverage=84.62%         |
# |                                 |   data[11]= 30                   |
# |                                 |         coverage=84.62%         |
# |                                 |   data[12]=  4                   |
# |                                 |         coverage=84.62%         |
# |                                 |   data[13]=  0                   |
# |                                 |         coverage=84.62%         |
# |                                 |   data[14]=  0                   |
# |                                 |         coverage=84.62%         |
# |                                 |   data[15]=  4                   |
# |                                 |         coverage=84.62%         |
# |                                 |   data[16]=  2                   |
# |                                 |         coverage=84.62%         |
# |                                 |   data[17]=  0                   |
# |                                 |         coverage=84.62%         |
# |                                 |   data[18]=  3                   |
# |                                 |         coverage=84.62%         |
# |                                 |   data[19]= 29                   |
# |                                 |         coverage=84.62%         |
# +--------------------------------+-----------------------------------+
# |     data1[0]=  5 data[1]=  0    |                                  |
# |     data1[2]=  4 data[3]=  7    |                                  |
# |       coverage=40.00%          |                                 |
# |                                 |   data[0]=  0                   |
# |                                 |         coverage=92.31%         |
# |                                 |   data[1]=  2                   |
# |                                 |         coverage=92.31%         |
# |                                 |   data[2]=  3                   |
# |                                 |         coverage=92.31%         |
# |                                 |   data[3]=  5                   |
# |                                 |         coverage=92.31%         |
# |                                 |   data[4]= 27                   |
# |                                 |         coverage=92.31%         |
# |                                 |   data[5]= 28                   |
# |                                 |         coverage=92.31%         |
# |                                 |   data[6]= 27                   |
# |                                 |         coverage=92.31%         |
# |                                 |   data[7]= 27                   |
# |                                 |         coverage=92.31%         |
# |                                 |   data[8]= 31                   |
# |                                 |         coverage=92.31%         |
# |                                 |   data[9]= 27                   |
# |                                 |         coverage=92.31%         |
# |                                 |   data[10]= 28                   |
# |                                 |         coverage=92.31%         |
# |                                 |   data[11]= 29                   |
# |                                 |         coverage=92.31%         |
# |                                 |   data[12]= 30                   |
# |                                 |         coverage=92.31%         |
# |                                 |   data[13]=  5                   |
# |                                 |         coverage=92.31%         |
# |                                 |   data[14]= 28                   |
# |                                 |         coverage=92.31%         |
# |                                 |   data[15]=  0                   |
# |                                 |         coverage=92.31%         |
# |                                 |   data[16]= 26                   |
# |                                 |         coverage=92.31%         |
# |                                 |   data[17]=  5                   |
# |                                 |         coverage=92.31%         |
# |                                 |   data[18]= 30                   |
# |                                 |         coverage=92.31%         |
# |                                 |   data[19]= 25                   |
# |                                 |         coverage=92.31%         |
# +--------------------------------+-----------------------------------+
# |     data1[0]=  1 data[1]= 15    |                                  |
# |     data1[2]= 19 data[3]= 20    |                                  |
# |       coverage=43.33%          |                                 |
# |                                 |   data[0]= 28                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[1]=  3                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[2]=  4                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[3]= 27                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[4]=  2                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[5]= 26                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[6]= 28                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[7]= 30                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[8]=  4                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[9]= 20                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[10]= 27                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[11]= 27                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[12]=  5                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[13]= 28                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[14]= 29                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[15]= 29                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[16]= 29                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[17]= 30                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[18]= 20                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[19]= 30                   |
# |                                 |         coverage=100.00%         |
# +--------------------------------+-----------------------------------+
# |     data1[0]= 27 data[1]=  7    |                                  |
# |     data1[2]=  9 data[3]= 11    |                                  |
# |       coverage=46.67%          |                                 |
# |                                 |   data[0]= 26                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[1]= 31                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[2]=  4                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[3]=  3                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[4]= 31                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[5]=  5                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[6]= 30                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[7]=  3                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[8]= 27                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[9]= 25                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[10]= 20                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[11]=  4                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[12]=  0                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[13]= 26                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[14]=  5                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[15]= 20                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[16]= 30                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[17]=  0                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[18]= 27                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[19]=  0                   |
# |                                 |         coverage=100.00%         |
# +--------------------------------+-----------------------------------+
# |     data1[0]=  2 data[1]=  2    |                                  |
# |     data1[2]= 26 data[3]= 24    |                                  |
# |       coverage=50.00%          |                                 |
# |                                 |   data[0]= 29                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[1]= 28                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[2]= 29                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[3]= 31                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[4]=  3                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[5]= 26                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[6]= 27                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[7]=  5                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[8]= 29                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[9]= 30                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[10]=  2                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[11]= 28                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[12]= 25                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[13]=  5                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[14]= 30                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[15]=  4                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[16]= 29                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[17]= 20                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[18]= 29                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[19]= 20                   |
# |                                 |         coverage=100.00%         |
# +--------------------------------+-----------------------------------+
# |     data1[0]= 11 data[1]=  8    |                                  |
# |     data1[2]=  5 data[3]= 26    |                                  |
# |       coverage=53.33%          |                                 |
# |                                 |   data[0]=  0                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[1]=  3                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[2]= 28                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[3]= 30                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[4]=  2                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[5]= 30                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[6]= 26                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[7]=  4                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[8]= 28                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[9]=  5                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[10]= 25                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[11]= 30                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[12]= 20                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[13]=  0                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[14]= 20                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[15]=  2                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[16]=  0                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[17]=  2                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[18]=  3                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[19]=  3                   |
# |                                 |         coverage=100.00%         |
# +--------------------------------+-----------------------------------+
# |     data1[0]= 12 data[1]= 25    |                                  |
# |     data1[2]= 20 data[3]= 17    |                                  |
# |       coverage=56.67%          |                                 |
# |                                 |   data[0]=  5                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[1]= 26                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[2]= 30                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[3]= 27                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[4]=  4                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[5]= 25                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[6]=  2                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[7]= 28                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[8]= 26                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[9]= 20                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[10]=  4                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[11]=  3                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[12]=  3                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[13]= 31                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[14]= 27                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[15]=  3                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[16]=  4                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[17]= 30                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[18]=  5                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[19]=  2                   |
# |                                 |         coverage=100.00%         |
# +--------------------------------+-----------------------------------+
# |     data1[0]= 22 data[1]= 26    |                                  |
# |     data1[2]=  3 data[3]= 22    |                                  |
# |       coverage=60.00%          |                                 |
# |                                 |   data[0]= 30                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[1]=  5                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[2]=  3                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[3]= 29                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[4]= 30                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[5]=  4                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[6]=  5                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[7]= 20                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[8]=  4                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[9]=  4                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[10]=  0                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[11]= 27                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[12]=  4                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[13]=  2                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[14]=  3                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[15]= 28                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[16]= 20                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[17]=  3                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[18]= 25                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[19]= 30                   |
# |                                 |         coverage=100.00%         |
# +--------------------------------+-----------------------------------+
# |     data1[0]= 17 data[1]= 14    |                                  |
# |     data1[2]= 12 data[3]= 16    |                                  |
# |       coverage=63.33%          |                                 |
# |                                 |   data[0]= 31                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[1]= 25                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[2]=  0                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[3]= 28                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[4]= 29                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[5]= 28                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[6]= 28                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[7]= 25                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[8]= 31                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[9]= 28                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[10]=  5                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[11]= 31                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[12]= 26                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[13]= 30                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[14]=  2                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[15]= 29                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[16]=  2                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[17]= 25                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[18]=  4                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[19]=  4                   |
# |                                 |         coverage=100.00%         |
# +--------------------------------+-----------------------------------+
# |     data1[0]= 28 data[1]=  6    |                                  |
# |     data1[2]= 29 data[3]=  4    |                                  |
# |       coverage=66.67%          |                                 |
# |                                 |   data[0]= 27                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[1]= 27                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[2]= 27                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[3]=  2                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[4]= 20                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[5]= 27                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[6]=  3                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[7]= 30                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[8]=  3                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[9]= 31                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[10]= 28                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[11]= 26                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[12]=  2                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[13]= 20                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[14]=  4                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[15]= 25                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[16]= 27                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[17]=  5                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[18]= 30                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[19]= 28                   |
# |                                 |         coverage=100.00%         |
# +--------------------------------+-----------------------------------+
# |     data1[0]= 21 data[1]= 10    |                                  |
# |     data1[2]= 23 data[3]= 25    |                                  |
# |       coverage=70.00%          |                                 |
# |                                 |   data[0]= 20                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[1]= 30                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[2]= 20                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[3]=  0                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[4]= 26                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[5]= 20                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[6]=  0                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[7]=  0                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[8]= 30                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[9]=  3                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[10]= 26                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[11]=  0                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[12]= 29                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[13]=  3                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[14]= 28                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[15]=  5                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[16]= 31                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[17]= 29                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[18]=  0                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[19]= 27                   |
# |                                 |         coverage=100.00%         |
# +--------------------------------+-----------------------------------+
# |     data1[0]= 26 data[1]= 23    |                                  |
# |     data1[2]= 13 data[3]= 21    |                                  |
# |       coverage=73.33%          |                                 |
# |                                 |   data[0]=  2                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[1]=  0                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[2]=  2                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[3]= 26                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[4]= 27                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[5]= 29                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[6]= 31                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[7]= 26                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[8]=  2                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[9]= 29                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[10]= 30                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[11]=  2                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[12]= 30                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[13]= 28                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[14]= 31                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[15]=  0                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[16]= 25                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[17]=  4                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[18]= 26                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[19]= 26                   |
# |                                 |         coverage=100.00%         |
# +--------------------------------+-----------------------------------+
# |     data1[0]=  6 data[1]= 28    |                                  |
# |     data1[2]= 28 data[3]= 23    |                                  |
# |       coverage=76.67%          |                                 |
# |                                 |   data[0]= 25                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[1]=  2                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[2]=  5                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[3]=  5                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[4]= 28                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[5]= 31                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[6]= 20                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[7]=  2                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[8]=  0                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[9]=  2                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[10]= 27                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[11]= 20                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[12]= 27                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[13]= 25                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[14]= 29                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[15]= 31                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[16]= 28                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[17]= 27                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[18]= 31                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[19]=  5                   |
# |                                 |         coverage=100.00%         |
# +--------------------------------+-----------------------------------+
# |     data1[0]= 24 data[1]=  3    |                                  |
# |     data1[2]= 16 data[3]= 15    |                                  |
# |       coverage=80.00%          |                                 |
# |                                 |   data[0]=  4                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[1]= 20                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[2]= 31                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[3]= 25                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[4]=  0                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[5]=  2                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[6]=  4                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[7]= 29                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[8]=  5                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[9]= 27                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[10]=  3                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[11]=  5                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[12]= 31                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[13]= 29                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[14]= 25                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[15]= 26                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[16]= 26                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[17]= 26                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[18]= 20                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[19]= 25                   |
# |                                 |         coverage=100.00%         |
# +--------------------------------+-----------------------------------+
# |     data1[0]= 13 data[1]= 24    |                                  |
# |     data1[2]= 15 data[3]= 28    |                                  |
# |       coverage=83.33%          |                                 |
# |                                 |   data[0]=  3                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[1]= 29                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[2]= 26                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[3]= 20                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[4]= 25                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[5]=  3                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[6]= 25                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[7]= 31                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[8]= 25                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[9]=  0                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[10]= 31                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[11]= 29                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[12]= 28                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[13]=  4                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[14]=  0                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[15]= 30                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[16]=  3                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[17]= 28                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[18]= 28                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[19]= 29                   |
# |                                 |         coverage=100.00%         |
# +--------------------------------+-----------------------------------+
# |     data1[0]= 23 data[1]= 18    |                                  |
# |     data1[2]= 21 data[3]=  3    |                                  |
# |       coverage=86.67%          |                                 |
# |                                 |   data[0]= 28                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[1]=  4                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[2]= 25                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[3]=  4                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[4]=  5                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[5]=  0                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[6]= 29                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[7]= 27                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[8]= 20                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[9]= 26                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[10]= 29                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[11]= 25                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[12]=  5                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[13]= 27                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[14]= 26                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[15]= 27                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[16]=  5                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[17]= 31                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[18]=  2                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[19]= 31                   |
# |                                 |         coverage=100.00%         |
# +--------------------------------+-----------------------------------+
# |     data1[0]= 25 data[1]= 22    |                                  |
# |     data1[2]= 11 data[3]=  5    |                                  |
# |       coverage=90.00%          |                                 |
# |                                 |   data[0]=  4                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[1]= 28                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[2]= 25                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[3]= 26                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[4]=  5                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[5]= 29                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[6]= 25                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[7]= 25                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[8]=  5                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[9]= 29                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[10]=  5                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[11]= 30                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[12]=  2                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[13]= 27                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[14]= 25                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[15]= 20                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[16]= 20                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[17]=  5                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[18]=  0                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[19]=  0                   |
# |                                 |         coverage=100.00%         |
# +--------------------------------+-----------------------------------+
# |     data1[0]=  4 data[1]= 29    |                                  |
# |     data1[2]=  1 data[3]=  8    |                                  |
# |       coverage=93.33%          |                                 |
# |                                 |   data[0]= 29                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[1]=  5                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[2]= 28                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[3]=  2                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[4]= 30                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[5]= 31                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[6]= 27                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[7]= 29                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[8]=  3                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[9]=  0                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[10]=  3                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[11]= 25                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[12]= 27                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[13]= 31                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[14]= 30                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[15]= 27                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[16]= 25                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[17]= 29                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[18]= 27                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[19]= 25                   |
# |                                 |         coverage=100.00%         |
# +--------------------------------+-----------------------------------+
# |     data1[0]= 15 data[1]= 21    |                                  |
# |     data1[2]=  8 data[3]=  1    |                                  |
# |       coverage=96.67%          |                                 |
# |                                 |   data[0]= 26                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[1]=  2                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[2]= 20                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[3]=  3                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[4]=  0                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[5]=  4                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[6]= 31                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[7]=  2                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[8]=  2                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[9]= 30                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[10]= 26                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[11]= 28                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[12]=  0                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[13]=  0                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[14]=  0                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[15]=  4                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[16]=  3                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[17]=  4                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[18]= 25                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[19]=  2                   |
# |                                 |         coverage=100.00%         |
# +--------------------------------+-----------------------------------+
# |     data1[0]= 16 data[1]=  4    |                                  |
# |     data1[2]=  7 data[3]= 14    |                                  |
# |       coverage=100.00%          |                                 |
# |                                 |   data[0]=  3                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[1]=  3                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[2]= 27                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[3]=  4                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[4]=  3                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[5]= 26                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[6]=  2                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[7]=  5                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[8]=  4                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[9]= 25                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[10]= 20                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[11]= 31                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[12]= 29                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[13]= 25                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[14]= 31                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[15]=  3                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[16]=  4                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[17]= 28                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[18]=  5                   |
# |                                 |         coverage=100.00%         |
# |                                 |   data[19]=  3                   |
# |                                 |         coverage=100.00%         |
# +--------------------------------+-----------------------------------+
# ** Note: $stop    : testbench.sv(87)
#    Time: 0 ns  Iteration: 0  Instance: /coverage_inside_class
# Break in Module coverage_inside_class at testbench.sv line 87
# Stopped at testbench.sv line 87
# Coverage Report by instance with details
# 
# =================================================================================
# === Instance: /design_sv_unit
# === Design Unit: work.design_sv_unit
# =================================================================================
#
# COVERGROUP COVERAGE:
# ----------------------------------------------------------------------------------------------------------
# Covergroup                                             Metric       Goal       Bins    Status               
#                                                                                                          
# ----------------------------------------------------------------------------------------------------------
#  TYPE /design_sv_unit/b                               100.00%        100          -    Covered              
#     covered/total bins:                                   260        260          -                      
#     missing/total bins:                                     0        260          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint b1                                     100.00%        100          -    Covered              
#         covered/total bins:                               260        260          -                      
#         missing/total bins:                                 0        260          -                      
#         % Hit:                                        100.00%        100          -                      
#  Covergroup instance \/coverage_inside_class/#ublk#68526291#56/cg#1  
#                                                       100.00%        100          -    Covered              
#     covered/total bins:                                    13         13          -                      
#     missing/total bins:                                     0         13          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint b1                                     100.00%        100          -    Covered              
#         covered/total bins:                                13         13          -                      
#         missing/total bins:                                 0         13          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin ba[0]                                           2          1          -    Covered              
#         bin ba[2]                                           2          1          -    Covered              
#         bin ba[3]                                           3          1          -    Covered              
#         bin ba[4]                                           3          1          -    Covered              
#         bin ba[5]                                           2          1          -    Covered              
#         bin ba[20]                                          2          1          -    Covered              
#         bin ba[25]                                          2          1          -    Covered              
#         bin ba[26]                                          3          1          -    Covered              
#         bin ba[27]                                          2          1          -    Covered              
#         bin ba[28]                                          2          1          -    Covered              
#         bin ba[29]                                          3          1          -    Covered              
#         bin ba[30]                                          2          1          -    Covered              
#         bin ba[31]                                          2          1          -    Covered              
#  Covergroup instance \/coverage_inside_class/#ublk#68526291#56/cg#2  
#                                                       100.00%        100          -    Covered              
#     covered/total bins:                                    13         13          -                      
#     missing/total bins:                                     0         13          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint b1                                     100.00%        100          -    Covered              
#         covered/total bins:                                13         13          -                      
#         missing/total bins:                                 0         13          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin ba[0]                                           2          1          -    Covered              
#         bin ba[2]                                           3          1          -    Covered              
#         bin ba[3]                                           3          1          -    Covered              
#         bin ba[4]                                           2          1          -    Covered              
#         bin ba[5]                                           3          1          -    Covered              
#         bin ba[20]                                          2          1          -    Covered              
#         bin ba[25]                                          2          1          -    Covered              
#         bin ba[26]                                          2          1          -    Covered              
#         bin ba[27]                                          2          1          -    Covered              
#         bin ba[28]                                          3          1          -    Covered              
#         bin ba[29]                                          2          1          -    Covered              
#         bin ba[30]                                          2          1          -    Covered              
#         bin ba[31]                                          2          1          -    Covered              
#  Covergroup instance \/coverage_inside_class/#ublk#68526291#56/cg#3  
#                                                       100.00%        100          -    Covered              
#     covered/total bins:                                    13         13          -                      
#     missing/total bins:                                     0         13          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint b1                                     100.00%        100          -    Covered              
#         covered/total bins:                                13         13          -                      
#         missing/total bins:                                 0         13          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin ba[0]                                           2          1          -    Covered              
#         bin ba[2]                                           2          1          -    Covered              
#         bin ba[3]                                           2          1          -    Covered              
#         bin ba[4]                                           2          1          -    Covered              
#         bin ba[5]                                           2          1          -    Covered              
#         bin ba[20]                                          3          1          -    Covered              
#         bin ba[25]                                          3          1          -    Covered              
#         bin ba[26]                                          2          1          -    Covered              
#         bin ba[27]                                          3          1          -    Covered              
#         bin ba[28]                                          3          1          -    Covered              
#         bin ba[29]                                          2          1          -    Covered              
#         bin ba[30]                                          2          1          -    Covered              
#         bin ba[31]                                          2          1          -    Covered              
#  Covergroup instance \/coverage_inside_class/#ublk#68526291#56/cg#4  
#                                                       100.00%        100          -    Covered              
#     covered/total bins:                                    13         13          -                      
#     missing/total bins:                                     0         13          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint b1                                     100.00%        100          -    Covered              
#         covered/total bins:                                13         13          -                      
#         missing/total bins:                                 0         13          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin ba[0]                                           2          1          -    Covered              
#         bin ba[2]                                           3          1          -    Covered              
#         bin ba[3]                                           3          1          -    Covered              
#         bin ba[4]                                           3          1          -    Covered              
#         bin ba[5]                                           2          1          -    Covered              
#         bin ba[20]                                          2          1          -    Covered              
#         bin ba[25]                                          2          1          -    Covered              
#         bin ba[26]                                          3          1          -    Covered              
#         bin ba[27]                                          2          1          -    Covered              
#         bin ba[28]                                          2          1          -    Covered              
#         bin ba[29]                                          2          1          -    Covered              
#         bin ba[30]                                          2          1          -    Covered              
#         bin ba[31]                                          2          1          -    Covered              
#  Covergroup instance \/coverage_inside_class/#ublk#68526291#56/cg#5  
#                                                       100.00%        100          -    Covered              
#     covered/total bins:                                    13         13          -                      
#     missing/total bins:                                     0         13          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint b1                                     100.00%        100          -    Covered              
#         covered/total bins:                                13         13          -                      
#         missing/total bins:                                 0         13          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin ba[0]                                           3          1          -    Covered              
#         bin ba[2]                                           2          1          -    Covered              
#         bin ba[3]                                           3          1          -    Covered              
#         bin ba[4]                                           2          1          -    Covered              
#         bin ba[5]                                           3          1          -    Covered              
#         bin ba[20]                                          2          1          -    Covered              
#         bin ba[25]                                          2          1          -    Covered              
#         bin ba[26]                                          2          1          -    Covered              
#         bin ba[27]                                          2          1          -    Covered              
#         bin ba[28]                                          2          1          -    Covered              
#         bin ba[29]                                          2          1          -    Covered              
#         bin ba[30]                                          3          1          -    Covered              
#         bin ba[31]                                          2          1          -    Covered              
#  Covergroup instance \/coverage_inside_class/#ublk#68526291#56/cg#6  
#                                                       100.00%        100          -    Covered              
#     covered/total bins:                                    13         13          -                      
#     missing/total bins:                                     0         13          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint b1                                     100.00%        100          -    Covered              
#         covered/total bins:                                13         13          -                      
#         missing/total bins:                                 0         13          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin ba[0]                                           2          1          -    Covered              
#         bin ba[2]                                           2          1          -    Covered              
#         bin ba[3]                                           2          1          -    Covered              
#         bin ba[4]                                           3          1          -    Covered              
#         bin ba[5]                                           2          1          -    Covered              
#         bin ba[20]                                          2          1          -    Covered              
#         bin ba[25]                                          2          1          -    Covered              
#         bin ba[26]                                          3          1          -    Covered              
#         bin ba[27]                                          2          1          -    Covered              
#         bin ba[28]                                          2          1          -    Covered              
#         bin ba[29]                                          3          1          -    Covered              
#         bin ba[30]                                          2          1          -    Covered              
#         bin ba[31]                                          3          1          -    Covered              
#  Covergroup instance \/coverage_inside_class/#ublk#68526291#56/cg#7  
#                                                       100.00%        100          -    Covered              
#     covered/total bins:                                    13         13          -                      
#     missing/total bins:                                     0         13          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint b1                                     100.00%        100          -    Covered              
#         covered/total bins:                                13         13          -                      
#         missing/total bins:                                 0         13          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin ba[0]                                           2          1          -    Covered              
#         bin ba[2]                                           3          1          -    Covered              
#         bin ba[3]                                           2          1          -    Covered              
#         bin ba[4]                                           2          1          -    Covered              
#         bin ba[5]                                           2          1          -    Covered              
#         bin ba[20]                                          2          1          -    Covered              
#         bin ba[25]                                          3          1          -    Covered              
#         bin ba[26]                                          2          1          -    Covered              
#         bin ba[27]                                          3          1          -    Covered              
#         bin ba[28]                                          2          1          -    Covered              
#         bin ba[29]                                          2          1          -    Covered              
#         bin ba[30]                                          2          1          -    Covered              
#         bin ba[31]                                          3          1          -    Covered              
#  Covergroup instance \/coverage_inside_class/#ublk#68526291#56/cg#8  
#                                                       100.00%        100          -    Covered              
#     covered/total bins:                                    13         13          -                      
#     missing/total bins:                                     0         13          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint b1                                     100.00%        100          -    Covered              
#         covered/total bins:                                13         13          -                      
#         missing/total bins:                                 0         13          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin ba[0]                                           2          1          -    Covered              
#         bin ba[2]                                           3          1          -    Covered              
#         bin ba[3]                                           2          1          -    Covered              
#         bin ba[4]                                           2          1          -    Covered              
#         bin ba[5]                                           3          1          -    Covered              
#         bin ba[20]                                          2          1          -    Covered              
#         bin ba[25]                                          3          1          -    Covered              
#         bin ba[26]                                          2          1          -    Covered              
#         bin ba[27]                                          2          1          -    Covered              
#         bin ba[28]                                          2          1          -    Covered              
#         bin ba[29]                                          3          1          -    Covered              
#         bin ba[30]                                          2          1          -    Covered              
#         bin ba[31]                                          2          1          -    Covered              
#  Covergroup instance \/coverage_inside_class/#ublk#68526291#56/cg#9  
#                                                       100.00%        100          -    Covered              
#     covered/total bins:                                    13         13          -                      
#     missing/total bins:                                     0         13          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint b1                                     100.00%        100          -    Covered              
#         covered/total bins:                                13         13          -                      
#         missing/total bins:                                 0         13          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin ba[0]                                           2          1          -    Covered              
#         bin ba[2]                                           3          1          -    Covered              
#         bin ba[3]                                           3          1          -    Covered              
#         bin ba[4]                                           3          1          -    Covered              
#         bin ba[5]                                           3          1          -    Covered              
#         bin ba[20]                                          2          1          -    Covered              
#         bin ba[25]                                          2          1          -    Covered              
#         bin ba[26]                                          2          1          -    Covered              
#         bin ba[27]                                          2          1          -    Covered              
#         bin ba[28]                                          2          1          -    Covered              
#         bin ba[29]                                          2          1          -    Covered              
#         bin ba[30]                                          2          1          -    Covered              
#         bin ba[31]                                          2          1          -    Covered              
#  Covergroup instance \/coverage_inside_class/#ublk#68526291#56/cg#10  
#                                                       100.00%        100          -    Covered              
#     covered/total bins:                                    13         13          -                      
#     missing/total bins:                                     0         13          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint b1                                     100.00%        100          -    Covered              
#         covered/total bins:                                13         13          -                      
#         missing/total bins:                                 0         13          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin ba[0]                                           3          1          -    Covered              
#         bin ba[2]                                           2          1          -    Covered              
#         bin ba[3]                                           2          1          -    Covered              
#         bin ba[4]                                           2          1          -    Covered              
#         bin ba[5]                                           2          1          -    Covered              
#         bin ba[20]                                          2          1          -    Covered              
#         bin ba[25]                                          3          1          -    Covered              
#         bin ba[26]                                          2          1          -    Covered              
#         bin ba[27]                                          2          1          -    Covered              
#         bin ba[28]                                          2          1          -    Covered              
#         bin ba[29]                                          3          1          -    Covered              
#         bin ba[30]                                          3          1          -    Covered              
#         bin ba[31]                                          2          1          -    Covered              
#  Covergroup instance \/coverage_inside_class/#ublk#68526291#56/cg#11  
#                                                       100.00%        100          -    Covered              
#     covered/total bins:                                    13         13          -                      
#     missing/total bins:                                     0         13          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint b1                                     100.00%        100          -    Covered              
#         covered/total bins:                                13         13          -                      
#         missing/total bins:                                 0         13          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin ba[0]                                           2          1          -    Covered              
#         bin ba[2]                                           2          1          -    Covered              
#         bin ba[3]                                           3          1          -    Covered              
#         bin ba[4]                                           2          1          -    Covered              
#         bin ba[5]                                           3          1          -    Covered              
#         bin ba[20]                                          3          1          -    Covered              
#         bin ba[25]                                          2          1          -    Covered              
#         bin ba[26]                                          3          1          -    Covered              
#         bin ba[27]                                          2          1          -    Covered              
#         bin ba[28]                                          2          1          -    Covered              
#         bin ba[29]                                          2          1          -    Covered              
#         bin ba[30]                                          2          1          -    Covered              
#         bin ba[31]                                          2          1          -    Covered              
#  Covergroup instance \/coverage_inside_class/#ublk#68526291#56/cg#12  
#                                                       100.00%        100          -    Covered              
#     covered/total bins:                                    13         13          -                      
#     missing/total bins:                                     0         13          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint b1                                     100.00%        100          -    Covered              
#         covered/total bins:                                13         13          -                      
#         missing/total bins:                                 0         13          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin ba[0]                                           2          1          -    Covered              
#         bin ba[2]                                           2          1          -    Covered              
#         bin ba[3]                                           2          1          -    Covered              
#         bin ba[4]                                           2          1          -    Covered              
#         bin ba[5]                                           2          1          -    Covered              
#         bin ba[20]                                          2          1          -    Covered              
#         bin ba[25]                                          3          1          -    Covered              
#         bin ba[26]                                          2          1          -    Covered              
#         bin ba[27]                                          2          1          -    Covered              
#         bin ba[28]                                          3          1          -    Covered              
#         bin ba[29]                                          2          1          -    Covered              
#         bin ba[30]                                          3          1          -    Covered              
#         bin ba[31]                                          3          1          -    Covered              
#  Covergroup instance \/coverage_inside_class/#ublk#68526291#56/cg#13  
#                                                       100.00%        100          -    Covered              
#     covered/total bins:                                    13         13          -                      
#     missing/total bins:                                     0         13          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint b1                                     100.00%        100          -    Covered              
#         covered/total bins:                                13         13          -                      
#         missing/total bins:                                 0         13          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin ba[0]                                           3          1          -    Covered              
#         bin ba[2]                                           3          1          -    Covered              
#         bin ba[3]                                           2          1          -    Covered              
#         bin ba[4]                                           2          1          -    Covered              
#         bin ba[5]                                           2          1          -    Covered              
#         bin ba[20]                                          2          1          -    Covered              
#         bin ba[25]                                          2          1          -    Covered              
#         bin ba[26]                                          2          1          -    Covered              
#         bin ba[27]                                          3          1          -    Covered              
#         bin ba[28]                                          2          1          -    Covered              
#         bin ba[29]                                          3          1          -    Covered              
#         bin ba[30]                                          2          1          -    Covered              
#         bin ba[31]                                          2          1          -    Covered              
#  Covergroup instance \/coverage_inside_class/#ublk#68526291#56/cg#14  
#                                                       100.00%        100          -    Covered              
#     covered/total bins:                                    13         13          -                      
#     missing/total bins:                                     0         13          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint b1                                     100.00%        100          -    Covered              
#         covered/total bins:                                13         13          -                      
#         missing/total bins:                                 0         13          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin ba[0]                                           3          1          -    Covered              
#         bin ba[2]                                           2          1          -    Covered              
#         bin ba[3]                                           2          1          -    Covered              
#         bin ba[4]                                           2          1          -    Covered              
#         bin ba[5]                                           2          1          -    Covered              
#         bin ba[20]                                          2          1          -    Covered              
#         bin ba[25]                                          3          1          -    Covered              
#         bin ba[26]                                          2          1          -    Covered              
#         bin ba[27]                                          3          1          -    Covered              
#         bin ba[28]                                          2          1          -    Covered              
#         bin ba[29]                                          2          1          -    Covered              
#         bin ba[30]                                          2          1          -    Covered              
#         bin ba[31]                                          3          1          -    Covered              
#  Covergroup instance \/coverage_inside_class/#ublk#68526291#56/cg#15  
#                                                       100.00%        100          -    Covered              
#     covered/total bins:                                    13         13          -                      
#     missing/total bins:                                     0         13          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint b1                                     100.00%        100          -    Covered              
#         covered/total bins:                                13         13          -                      
#         missing/total bins:                                 0         13          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin ba[0]                                           3          1          -    Covered              
#         bin ba[2]                                           2          1          -    Covered              
#         bin ba[3]                                           2          1          -    Covered              
#         bin ba[4]                                           2          1          -    Covered              
#         bin ba[5]                                           2          1          -    Covered              
#         bin ba[20]                                          2          1          -    Covered              
#         bin ba[25]                                          3          1          -    Covered              
#         bin ba[26]                                          2          1          -    Covered              
#         bin ba[27]                                          2          1          -    Covered              
#         bin ba[28]                                          2          1          -    Covered              
#         bin ba[29]                                          2          1          -    Covered              
#         bin ba[30]                                          3          1          -    Covered              
#         bin ba[31]                                          3          1          -    Covered              
#  Covergroup instance \/coverage_inside_class/#ublk#68526291#56/cg#16  
#                                                       100.00%        100          -    Covered              
#     covered/total bins:                                    13         13          -                      
#     missing/total bins:                                     0         13          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint b1                                     100.00%        100          -    Covered              
#         covered/total bins:                                13         13          -                      
#         missing/total bins:                                 0         13          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin ba[0]                                           2          1          -    Covered              
#         bin ba[2]                                           2          1          -    Covered              
#         bin ba[3]                                           3          1          -    Covered              
#         bin ba[4]                                           3          1          -    Covered              
#         bin ba[5]                                           2          1          -    Covered              
#         bin ba[20]                                          3          1          -    Covered              
#         bin ba[25]                                          2          1          -    Covered              
#         bin ba[26]                                          2          1          -    Covered              
#         bin ba[27]                                          3          1          -    Covered              
#         bin ba[28]                                          2          1          -    Covered              
#         bin ba[29]                                          2          1          -    Covered              
#         bin ba[30]                                          2          1          -    Covered              
#         bin ba[31]                                          2          1          -    Covered              
#  Covergroup instance \/coverage_inside_class/#ublk#68526291#56/cg#17  
#                                                       100.00%        100          -    Covered              
#     covered/total bins:                                    13         13          -                      
#     missing/total bins:                                     0         13          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint b1                                     100.00%        100          -    Covered              
#         covered/total bins:                                13         13          -                      
#         missing/total bins:                                 0         13          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin ba[0]                                           2          1          -    Covered              
#         bin ba[2]                                           2          1          -    Covered              
#         bin ba[3]                                           3          1          -    Covered              
#         bin ba[4]                                           3          1          -    Covered              
#         bin ba[5]                                           2          1          -    Covered              
#         bin ba[20]                                          3          1          -    Covered              
#         bin ba[25]                                          3          1          -    Covered              
#         bin ba[26]                                          2          1          -    Covered              
#         bin ba[27]                                          2          1          -    Covered              
#         bin ba[28]                                          2          1          -    Covered              
#         bin ba[29]                                          2          1          -    Covered              
#         bin ba[30]                                          2          1          -    Covered              
#         bin ba[31]                                          2          1          -    Covered              
#  Covergroup instance \/coverage_inside_class/#ublk#68526291#56/cg#18  
#                                                       100.00%        100          -    Covered              
#     covered/total bins:                                    13         13          -                      
#     missing/total bins:                                     0         13          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint b1                                     100.00%        100          -    Covered              
#         covered/total bins:                                13         13          -                      
#         missing/total bins:                                 0         13          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin ba[0]                                           2          1          -    Covered              
#         bin ba[2]                                           2          1          -    Covered              
#         bin ba[3]                                           2          1          -    Covered              
#         bin ba[4]                                           3          1          -    Covered              
#         bin ba[5]                                           3          1          -    Covered              
#         bin ba[20]                                          2          1          -    Covered              
#         bin ba[25]                                          2          1          -    Covered              
#         bin ba[26]                                          2          1          -    Covered              
#         bin ba[27]                                          2          1          -    Covered              
#         bin ba[28]                                          3          1          -    Covered              
#         bin ba[29]                                          3          1          -    Covered              
#         bin ba[30]                                          2          1          -    Covered              
#         bin ba[31]                                          2          1          -    Covered              
#  Covergroup instance \/coverage_inside_class/#ublk#68526291#56/cg#19  
#                                                       100.00%        100          -    Covered              
#     covered/total bins:                                    13         13          -                      
#     missing/total bins:                                     0         13          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint b1                                     100.00%        100          -    Covered              
#         covered/total bins:                                13         13          -                      
#         missing/total bins:                                 0         13          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin ba[0]                                           3          1          -    Covered              
#         bin ba[2]                                           2          1          -    Covered              
#         bin ba[3]                                           2          1          -    Covered              
#         bin ba[4]                                           2          1          -    Covered              
#         bin ba[5]                                           3          1          -    Covered              
#         bin ba[20]                                          2          1          -    Covered              
#         bin ba[25]                                          3          1          -    Covered              
#         bin ba[26]                                          2          1          -    Covered              
#         bin ba[27]                                          3          1          -    Covered              
#         bin ba[28]                                          2          1          -    Covered              
#         bin ba[29]                                          2          1          -    Covered              
#         bin ba[30]                                          2          1          -    Covered              
#         bin ba[31]                                          2          1          -    Covered              
#  Covergroup instance \/coverage_inside_class/#ublk#68526291#56/cg#20  
#                                                       100.00%        100          -    Covered              
#     covered/total bins:                                    13         13          -                      
#     missing/total bins:                                     0         13          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint b1                                     100.00%        100          -    Covered              
#         covered/total bins:                                13         13          -                      
#         missing/total bins:                                 0         13          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin ba[0]                                           3          1          -    Covered              
#         bin ba[2]                                           3          1          -    Covered              
#         bin ba[3]                                           3          1          -    Covered              
#         bin ba[4]                                           2          1          -    Covered              
#         bin ba[5]                                           2          1          -    Covered              
#         bin ba[20]                                          2          1          -    Covered              
#         bin ba[25]                                          3          1          -    Covered              
#         bin ba[26]                                          2          1          -    Covered              
#         bin ba[27]                                          2          1          -    Covered              
#         bin ba[28]                                          2          1          -    Covered              
#         bin ba[29]                                          2          1          -    Covered              
#         bin ba[30]                                          2          1          -    Covered              
#         bin ba[31]                                          2          1          -    Covered              
#  TYPE /design_sv_unit/randomize_c/a                   100.00%        100          -    Covered              
#     covered/total bins:                                   120        120          -                      
#     missing/total bins:                                     0        120          -                      
#     % Hit:                                            100.00%        100          -                      
#     Coverpoint a1                                     100.00%        100          -    Covered              
#         covered/total bins:                                30         30          -                      
#         missing/total bins:                                 0         30          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin a11[0]                                          1          1          -    Covered              
#         bin a11[1]                                          1          1          -    Covered              
#         bin a11[2]                                          1          1          -    Covered              
#         bin a11[3]                                          1          1          -    Covered              
#         bin a11[4]                                          1          1          -    Covered              
#         bin a11[5]                                          1          1          -    Covered              
#         bin a11[6]                                          1          1          -    Covered              
#         bin a11[7]                                          1          1          -    Covered              
#         bin a11[8]                                          1          1          -    Covered              
#         bin a11[9]                                          1          1          -    Covered              
#         bin a11[10]                                         1          1          -    Covered              
#         bin a11[11]                                         1          1          -    Covered              
#         bin a11[12]                                         1          1          -    Covered              
#         bin a11[13]                                         1          1          -    Covered              
#         bin a11[14]                                         1          1          -    Covered              
#         bin a11[15]                                         1          1          -    Covered              
#         bin a11[16]                                         1          1          -    Covered              
#         bin a11[17]                                         1          1          -    Covered              
#         bin a11[18]                                         1          1          -    Covered              
#         bin a11[19]                                         1          1          -    Covered              
#         bin a11[20]                                         1          1          -    Covered              
#         bin a11[21]                                         1          1          -    Covered              
#         bin a11[22]                                         1          1          -    Covered              
#         bin a11[23]                                         1          1          -    Covered              
#         bin a11[24]                                         1          1          -    Covered              
#         bin a11[25]                                         1          1          -    Covered              
#         bin a11[26]                                         1          1          -    Covered              
#         bin a11[27]                                         1          1          -    Covered              
#         bin a11[28]                                         1          1          -    Covered              
#         bin a11[29]                                         1          1          -    Covered              
#     Coverpoint a2                                     100.00%        100          -    Covered              
#         covered/total bins:                                30         30          -                      
#         missing/total bins:                                 0         30          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin a21[0]                                          1          1          -    Covered              
#         bin a21[1]                                          1          1          -    Covered              
#         bin a21[2]                                          1          1          -    Covered              
#         bin a21[3]                                          1          1          -    Covered              
#         bin a21[4]                                          1          1          -    Covered              
#         bin a21[5]                                          1          1          -    Covered              
#         bin a21[6]                                          1          1          -    Covered              
#         bin a21[7]                                          1          1          -    Covered              
#         bin a21[8]                                          1          1          -    Covered              
#         bin a21[9]                                          1          1          -    Covered              
#         bin a21[10]                                         1          1          -    Covered              
#         bin a21[11]                                         1          1          -    Covered              
#         bin a21[12]                                         1          1          -    Covered              
#         bin a21[13]                                         1          1          -    Covered              
#         bin a21[14]                                         1          1          -    Covered              
#         bin a21[15]                                         1          1          -    Covered              
#         bin a21[16]                                         1          1          -    Covered              
#         bin a21[17]                                         1          1          -    Covered              
#         bin a21[18]                                         1          1          -    Covered              
#         bin a21[19]                                         1          1          -    Covered              
#         bin a21[20]                                         1          1          -    Covered              
#         bin a21[21]                                         1          1          -    Covered              
#         bin a21[22]                                         1          1          -    Covered              
#         bin a21[23]                                         1          1          -    Covered              
#         bin a21[24]                                         1          1          -    Covered              
#         bin a21[25]                                         1          1          -    Covered              
#         bin a21[26]                                         1          1          -    Covered              
#         bin a21[27]                                         1          1          -    Covered              
#         bin a21[28]                                         1          1          -    Covered              
#         bin a21[29]                                         1          1          -    Covered              
#     Coverpoint a3                                     100.00%        100          -    Covered              
#         covered/total bins:                                30         30          -                      
#         missing/total bins:                                 0         30          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin a31[0]                                          1          1          -    Covered              
#         bin a31[1]                                          1          1          -    Covered              
#         bin a31[2]                                          1          1          -    Covered              
#         bin a31[3]                                          1          1          -    Covered              
#         bin a31[4]                                          1          1          -    Covered              
#         bin a31[5]                                          1          1          -    Covered              
#         bin a31[6]                                          1          1          -    Covered              
#         bin a31[7]                                          1          1          -    Covered              
#         bin a31[8]                                          1          1          -    Covered              
#         bin a31[9]                                          1          1          -    Covered              
#         bin a31[10]                                         1          1          -    Covered              
#         bin a31[11]                                         1          1          -    Covered              
#         bin a31[12]                                         1          1          -    Covered              
#         bin a31[13]                                         1          1          -    Covered              
#         bin a31[14]                                         1          1          -    Covered              
#         bin a31[15]                                         1          1          -    Covered              
#         bin a31[16]                                         1          1          -    Covered              
#         bin a31[17]                                         1          1          -    Covered              
#         bin a31[18]                                         1          1          -    Covered              
#         bin a31[19]                                         1          1          -    Covered              
#         bin a31[20]                                         1          1          -    Covered              
#         bin a31[21]                                         1          1          -    Covered              
#         bin a31[22]                                         1          1          -    Covered              
#         bin a31[23]                                         1          1          -    Covered              
#         bin a31[24]                                         1          1          -    Covered              
#         bin a31[25]                                         1          1          -    Covered              
#         bin a31[26]                                         1          1          -    Covered              
#         bin a31[27]                                         1          1          -    Covered              
#         bin a31[28]                                         1          1          -    Covered              
#         bin a31[29]                                         1          1          -    Covered              
#     Coverpoint a4                                     100.00%        100          -    Covered              
#         covered/total bins:                                30         30          -                      
#         missing/total bins:                                 0         30          -                      
#         % Hit:                                        100.00%        100          -                      
#         bin a41[0]                                          1          1          -    Covered              
#         bin a41[1]                                          1          1          -    Covered              
#         bin a41[2]                                          1          1          -    Covered              
#         bin a41[3]                                          1          1          -    Covered              
#         bin a41[4]                                          1          1          -    Covered              
#         bin a41[5]                                          1          1          -    Covered              
#         bin a41[6]                                          1          1          -    Covered              
#         bin a41[7]                                          1          1          -    Covered              
#         bin a41[8]                                          1          1          -    Covered              
#         bin a41[9]                                          1          1          -    Covered              
#         bin a41[10]                                         1          1          -    Covered              
#         bin a41[11]                                         1          1          -    Covered              
#         bin a41[12]                                         1          1          -    Covered              
#         bin a41[13]                                         1          1          -    Covered              
#         bin a41[14]                                         1          1          -    Covered              
#         bin a41[15]                                         1          1          -    Covered              
#         bin a41[16]                                         1          1          -    Covered              
#         bin a41[17]                                         1          1          -    Covered              
#         bin a41[18]                                         1          1          -    Covered              
#         bin a41[19]                                         1          1          -    Covered              
#         bin a41[20]                                         1          1          -    Covered              
#         bin a41[21]                                         1          1          -    Covered              
#         bin a41[22]                                         1          1          -    Covered              
#         bin a41[23]                                         1          1          -    Covered              
#         bin a41[24]                                         1          1          -    Covered              
#         bin a41[25]                                         1          1          -    Covered              
#         bin a41[26]                                         1          1          -    Covered              
#         bin a41[27]                                         1          1          -    Covered              
#         bin a41[28]                                         1          1          -    Covered              
#         bin a41[29]                                         1          1          -    Covered              
# 
# TOTAL COVERGROUP COVERAGE: 100.00%  COVERGROUP TYPES: 2
# 
# Total Coverage By Instance (filtered view): 100.00%
*/
