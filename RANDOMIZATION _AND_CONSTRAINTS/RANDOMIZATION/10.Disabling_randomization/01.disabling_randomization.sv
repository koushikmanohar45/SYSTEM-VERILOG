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
    m.data2.rand_mode(0);
    repeat(5)begin
      $display("=============disabling rand for data2==========");
      m.randomize();
      m.mux();
      $display("===============================================");
    end
    
    m.data1.rand_mode(0);
    repeat(5)begin
      $display("=============disabling rand for data1==========");
      m.randomize();
      m.mux();
      $display("===============================================");
    end

    m.data2.rand_mode(1);   
    repeat(5)begin
      $display("============enabling rand for data2==============");
      m.randomize();
      m.mux();
      $display("================================================");
    end
    
    m.data1.rand_mode(1);   
    repeat(5)begin
      $display("============enabling rand for data1==============");
      m.randomize();
      m.mux();
      $display("================================================");
    end
    
  end
endmodule
    

/*
output:
=============disabling rand for data2==========
| data1=17 data2=0 sel=1 | out=17
===============================================
=============disabling rand for data2==========
| data1=44 data2=0 sel=1 | out=44
===============================================
=============disabling rand for data2==========
| data1=19 data2=0 sel=0 | out=0
===============================================
=============disabling rand for data2==========
| data1=40 data2=0 sel=1 | out=40
===============================================
=============disabling rand for data2==========
| data1=39 data2=0 sel=0 | out=0
===============================================
=============disabling rand for data1==========
| data1=39 data2=0 sel=1 | out=39
===============================================
=============disabling rand for data1==========
| data1=39 data2=0 sel=0 | out=0
===============================================
=============disabling rand for data1==========
| data1=39 data2=0 sel=1 | out=39
===============================================
=============disabling rand for data1==========
| data1=39 data2=0 sel=0 | out=0
===============================================
=============disabling rand for data1==========
| data1=39 data2=0 sel=1 | out=39
===============================================
============enabling rand for data2==============
| data1=39 data2=1 sel=1 | out=39
================================================
============enabling rand for data2==============
| data1=39 data2=87 sel=0 | out=87
================================================
============enabling rand for data2==============
| data1=39 data2=79 sel=1 | out=39
================================================
============enabling rand for data2==============
| data1=39 data2=36 sel=0 | out=36
================================================
============enabling rand for data2==============
| data1=39 data2=80 sel=1 | out=39
================================================
============enabling rand for data1==============
| data1=1 data2=61 sel=0 | out=61
================================================
============enabling rand for data1==============
| data1=35 data2=19 sel=0 | out=19
================================================
============enabling rand for data1==============
| data1=43 data2=39 sel=0 | out=39
================================================
============enabling rand for data1==============
| data1=33 data2=17 sel=1 | out=33
================================================
============enabling rand for data1==============
| data1=46 data2=72 sel=0 | out=72
================================================
           V C S   S i m u l a t i o n   R e p o r t 
*/
