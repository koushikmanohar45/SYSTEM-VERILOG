module dynamic_array();
  bit[11:0]d1[1:0]='{12'd2001,12'd1222};
  logic[2:0][3:0]d2[]='{'{4'hd,4'he,4'h6},'{4'd12,4'd9,4'h1}};
  reg[1:0][5:0]d3[];
  int i,j;
  initial begin
    $display("size of fixed array=%0d",$size(d1));
    $display("fixed array=%p",d1);
    
    $display("size of dynamic array1=%0d",d2.size());
    $display("dynamic array1=%p",d2);
    
    $display("size of dynamic array2=%0d",d3.size());
    $display("dynamic array2=%p",d3);
    
    
    $display("Changing size of dynamic array1 to 5 at run time");
    d2=new[5];
    $display("dynamic array1=%p",d2);
    $display("size of dynamic array1=%0d",d2.size());
    
    
    $display("Changing size of dynamic array2 and copy the conent of fixed array");
    d3=new[5](d1);
    $display("dynamic array2=%p",d3);
    
    d2='{'{4'h1,4'h2,4'h3},'{4'h4,4'h5,4'h6},'{4'h7,4'h8,4'h9},'{4'ha,4'hb,4'hc},'{4'hd,4'he,4'hf}};
    
    $display("displaying each elements in dynamic array2");
    foreach(d3[i])begin
      $display("dynamic array2[%0d]-%b",i,d3[i]);
        end
    
    //copy
    d3=d2;
    $display("copying dynamic array1 to dynamic array2:");
    $display("dynamic array1=%p",d2);
    $display("dynamic array2=%p",d3);
   
    //delete
    $display("deleting entire dynamic array 2");
    d3.delete();
    $display("size of dynamic array2 after delete=%0d",d3.size());
    $display("dynamic array2 after delete=%p",d3);
  end
endmodule
