class static_constraint;
  rand bit [7:0] data;
  rand bit [7:0] addr;
  rand bit w_en;
  
  static constraint c1 {
                        solve w_en before addr; 
                        (w_en==1)->(addr<40);
                        data==25;
                      }
endclass

class without_static_constraint;
  rand bit [7:0] data;
  rand bit [7:0] addr;
  rand bit w_en;
  
         constraint c2 {
                        solve w_en before addr; 
                        (w_en==1)->(addr<40);
                        data==25;
                       }
endclass


module randomization();
  without_static_constraint w;
  without_static_constraint w1;
  static_constraint s;
  static_constraint s1;
  
  initial begin
    w=new();
    w1=new();
    s=new();
    s1=new();
    
    $display("======================Randomizing===================================\n ");
    w.randomize();
    w1.randomize();
    s.randomize();
    s1.randomize();
    
    $display("=========================Randomized object 1=======================");
    $display(" without_static_constraint              with_static_constraint");
    $display("      data=%d                                 data=%d",w.data,s.data);
    $display("      addr=%d                                 addr=%d",w.addr,s.addr);
    $display("      w_en=%b                                   w_en=%b\n ",w.w_en,s.w_en);
    
    $display("=========================Randomized object 2=======================");
    $display(" without_static_constraint              with_static_constraint");
    $display("      data=%d                                 data=%d",w1.data,s1.data);
    $display("      addr=%d                                 addr=%d",w1.addr,s1.addr);
    $display("      w_en=%b                                   w_en=%b\n",w1.w_en,s1.w_en);
    
    w.c2.constraint_mode(0);
    s.c1.constraint_mode(0);
    
      w.randomize();
      w1.randomize();
      s.randomize();
      s1.randomize();
      $display("================disabled constraint for object 1===================\n");
      $display("============================object 1==============================");
      $display(" without_static_constraint              with_static_constraint");
      $display("      data=%d                                 data=%d",w.data,s.data);
      $display("      addr=%d                                 addr=%d",w.addr,s.addr);
      $display("      w_en=%b                                   w_en=%b\n",w.w_en,s.w_en);
      $display("=============================object 2==============================");
      $display(" without_static_constraint              with_static_constraint");
      $display("      data=%d                                 data=%d",w1.data,s1.data);
      $display("      addr=%d                                 addr=%d",w1.addr,s1.addr);
      $display("      w_en=%b                                   w_en=%b\n",w1.w_en,s1.w_en);

  end
endmodule

/*
output:
======================Randomizing===================================
 
=========================Randomized object 1=======================
 without_static_constraint              with_static_constraint
      data= 25                                 data= 25
      addr= 11                                 addr= 25
      w_en=1                                   w_en=1
 
=========================Randomized object 2=======================
 without_static_constraint              with_static_constraint
      data= 25                                 data= 25
      addr= 39                                 addr=191
      w_en=1                                   w_en=0

================disabled constraint for object 1===================

============================object 1==============================
 without_static_constraint              with_static_constraint
      data= 63                                 data=216
      addr=115                                 addr= 38
      w_en=0                                   w_en=1

=============================object 2==============================
 without_static_constraint              with_static_constraint
      data= 25                                 data=168
      addr= 72                                 addr=191
      w_en=0                                   w_en=0

           V C S   S i m u l a t i o n   R e p o r t 
*/




