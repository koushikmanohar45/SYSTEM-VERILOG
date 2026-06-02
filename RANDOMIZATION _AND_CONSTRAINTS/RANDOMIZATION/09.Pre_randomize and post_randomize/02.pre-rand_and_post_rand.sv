class transaction;
  
  rand bit [7:0] data1;
  randc bit [7:0] data2;
  rand bit sel;
  bit [7:0]out;
  bit flag;
  
  
  constraint c1{ data1<50;}
  constraint c2{ data2<90;}
  constraint c3{data1!=data2;}
  
  function void pre_randomize();
    
    $display("Pre_randomize function called");
    //disabling constraints c1
    if(flag)
      c1.constraint_mode(0);
    else
      c1.constraint_mode(1);
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
    repeat(2)begin
      $display("========================================");
      m.flag=1;
      m.randomize();
      m.mux();
      $display("========================================");
    end

    
    repeat(2)begin
      $display("========================================");
      //enabling randomization for data2
      m.data2.rand_mode(1);
      //enabling constraint c1
      m.flag=0;
      
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
| data1=27 data2=33 sel=0 | out=33
========================================
========================================
Pre_randomize function called
Post_randomize called
| data1=38 data2=40 sel=1 | out=38
========================================

*/
    
  
