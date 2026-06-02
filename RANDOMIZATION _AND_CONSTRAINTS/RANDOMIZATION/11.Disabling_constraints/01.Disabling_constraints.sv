class transaction;
  
  rand bit [7:0] data1;
  randc bit [7:0] data2;
  rand bit sel;
  bit [7:0]out;
  
  
  constraint c1{ data1<50;}
  constraint c2{ data2<90;}
  constraint c3{data1!=data2;}
  
endclass

class implementation extends transaction;
  
  task mux();
    if(sel)
      out=data1;
    else
      out=data2;
    $display("| data1=%0d data2=%0d sel=%b | out=%0d",data1,data2,sel,out);
  endtask
  
  
endclass
      
module randomization;
  implementation m;
  initial begin
    m=new();
    m.c1.constraint_mode(0);
    repeat(5)begin
      $display("=============disabling contraint c1 (data1<50)==========");
      m.randomize();
      m.mux();
      $display("========================================================");
    end
    
    m.c2.constraint_mode(0);
    repeat(5)begin
      $display("=============disabling contraint c2 (data2<90)==========");
      m.randomize();
      m.mux();
      $display("========================================================");
    end

    m.c1.constraint_mode(1);   
    repeat(5)begin
      $display("============enabling contraint c1 (data1<50)==============");
      m.randomize();
      m.mux();
      $display("==========================================================");
    end
    
    m.c2.constraint_mode(1);   
    repeat(5)begin
      $display("============enabling contraint c2 (data2<90)==============");
      m.randomize();
      m.mux();
      $display("==========================================================");
    end
    
  end
endmodule
    


/*
output:

=============disabling contraint c1 (data1<50)==========
| data1=228 data2=30 sel=1 | out=228
========================================================
=============disabling contraint c1 (data1<50)==========
| data1=61 data2=34 sel=1 | out=61
========================================================
=============disabling contraint c1 (data1<50)==========
| data1=157 data2=65 sel=0 | out=65
========================================================
=============disabling contraint c1 (data1<50)==========
| data1=195 data2=68 sel=1 | out=195
========================================================
=============disabling contraint c1 (data1<50)==========
| data1=56 data2=85 sel=0 | out=85
========================================================
=============disabling contraint c2 (data2<90)==========
| data1=109 data2=249 sel=1 | out=109
========================================================
=============disabling contraint c2 (data2<90)==========
| data1=241 data2=201 sel=0 | out=201
========================================================
=============disabling contraint c2 (data2<90)==========
| data1=60 data2=255 sel=1 | out=60
========================================================
=============disabling contraint c2 (data2<90)==========
| data1=155 data2=29 sel=0 | out=29
========================================================
=============disabling contraint c2 (data2<90)==========
| data1=70 data2=157 sel=1 | out=70
========================================================
============enabling contraint c1 (data1<50)==============
| data1=1 data2=59 sel=1 | out=1
==========================================================
============enabling contraint c1 (data1<50)==============
| data1=1 data2=244 sel=0 | out=244
==========================================================
============enabling contraint c1 (data1<50)==============
| data1=6 data2=213 sel=1 | out=6
==========================================================
============enabling contraint c1 (data1<50)==============
| data1=5 data2=55 sel=0 | out=55
==========================================================
============enabling contraint c1 (data1<50)==============
| data1=39 data2=246 sel=1 | out=39
==========================================================
============enabling contraint c2 (data2<90)==============
| data1=1 data2=61 sel=0 | out=61
==========================================================
============enabling contraint c2 (data2<90)==============
| data1=35 data2=19 sel=0 | out=19
==========================================================
============enabling contraint c2 (data2<90)==============
| data1=43 data2=39 sel=0 | out=39
==========================================================
============enabling contraint c2 (data2<90)==============
| data1=33 data2=17 sel=1 | out=33
==========================================================
============enabling contraint c2 (data2<90)==============
| data1=46 data2=72 sel=0 | out=72
==========================================================
           V C S   S i m u l a t i o n   R e p o r t 
*/
