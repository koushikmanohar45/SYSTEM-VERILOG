class transaction;
  
  rand bit [7:0] data1;
  randc bit [7:0] data2;
  rand bit sel;
  bit [7:0]out;
  
  
  constraint c1{ data1<50;}
  constraint c2{ data2<90;}
  constraint c3{data1!=data2;}
  
  function void pre_randomize();
    $display("Pre_randomize function called");
    //disabling constraints c1
    c1.constraint_mode(0);
  endfunction
  
  function void post_randomize();
    $display("Post_randomize called");
    //disabling randomization for data2
    data2.rand_mode(0);
  endfunction
  
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
    repeat(10)begin
      $display("========================================");
      m.randomize();
      m.mux();
      $display("========================================");
    end

    
    repeat(5)begin
      $display("========================================");
      m.data2.rand_mode(1);
      
      //we can't able to enabel constraint c1 because it was declared in pre_randomize whatever we enable it is override(disable) it.
      m.c1.constraint_mode(1);
      
      m.randomize();
      m.mux();
      $display("========================================");
    end
    
  end
endmodule

/*
output:
========================================
Pre_randomize function called
Post_randomize called
| data1=228 data2=30 sel=1 | out=228
========================================
========================================
Pre_randomize function called
Post_randomize called
| data1=45 data2=30 sel=1 | out=45
========================================
========================================
Pre_randomize function called
Post_randomize called
| data1=155 data2=30 sel=0 | out=30
========================================
========================================
Pre_randomize function called
Post_randomize called
| data1=55 data2=30 sel=1 | out=55
========================================
========================================
Pre_randomize function called
Post_randomize called
| data1=210 data2=30 sel=0 | out=30
========================================
========================================
Pre_randomize function called
Post_randomize called
| data1=127 data2=30 sel=1 | out=127
========================================
========================================
Pre_randomize function called
Post_randomize called
| data1=213 data2=30 sel=0 | out=30
========================================
========================================
Pre_randomize function called
Post_randomize called
| data1=249 data2=30 sel=1 | out=249
========================================
========================================
Pre_randomize function called
Post_randomize called
| data1=63 data2=30 sel=0 | out=30
========================================
========================================
Pre_randomize function called
Post_randomize called
| data1=198 data2=30 sel=1 | out=198
========================================
========================================
Pre_randomize function called
Post_randomize called
| data1=9 data2=20 sel=1 | out=9
========================================
========================================
Pre_randomize function called
Post_randomize called
| data1=10 data2=85 sel=0 | out=85
========================================
========================================
Pre_randomize function called
Post_randomize called
| data1=35 data2=74 sel=1 | out=35
========================================
========================================
Pre_randomize function called
Post_randomize called
| data1=30 data2=18 sel=0 | out=18
========================================
========================================
Pre_randomize function called
Post_randomize called
| data1=201 data2=86 sel=1 | out=201
========================================
           V C S   S i m u l a t i o n   R e p o r t
*/
