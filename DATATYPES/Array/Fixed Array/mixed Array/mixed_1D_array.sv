module mixed_1D_array();
  logic[7:0]one_D[3:0];
  int i;
  initial begin
    $display("No.of elements in a array=%0d",$size(one_D));
    $display("Reading array before writing");
    foreach(one_D[i])begin
      $display("array[%0d]=%b",i,one_D[i]);
    end
    #1;
    one_D[0]='hee;
    one_D[1]='hda;
    one_D[2]='h6a;
    one_D[3]='h89;
    $display("Reading array after writing");
    foreach(one_D[i])begin
      $display("array[%0d]=%b",i,one_D[i]);
    end
    #1;
    //accessing bits in array
    one_D[0][2]=1'b0;
    one_D[1][3]=1'b1;
    one_D[2][2:0]=3'b101;
    one_D[3][3:0]=4'hf;
    $display("Reading array after changed some values ");
    foreach(one_D[i])begin
      $display("array[%0d]=%b",i,one_D[i]);
    end
    #1;
    //finding sum of all elements
    for(i=1;i<4;i++)begin
      one_D[0] +=one_D[i];
      #1;
    end
    $display("sum=%b",one_D[0]);  
    //display array
    $display("array=%p",one_D);
  end
  
endmodule
