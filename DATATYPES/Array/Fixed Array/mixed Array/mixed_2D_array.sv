module mixed_2D_array();
  logic[7:0][3:0]two_D1[3:0];//4-state
  bit[7:0][7:0]two_D2[5:0];//2-state
  reg[3:0][3:0]two_D3[3:0]='{'{'ha,'he,'ha,'he},'{'ha,'he,'ha,'he},'{'ha,'he,'ha,'he},'{'ha,'he,'ha,'he}};
  int i;
  initial begin
    $display("No.of elements in a array1=%0d",$size(two_D1));
    $display("No.of elements in a array2=%0d",$size(two_D2));
    $display("No.of elements in a array3=%0d",$size(two_D3));

    // writing values in a whole 
    two_D1[0]='hcadez012;
    two_D1[1]='hdac67x09;
    two_D2[2]='h143bab0bab0bab0x;
    two_D2[3]='hadadadadadadadad;
    $display("Reading array1 after writing");
    
    //writting values in paricular location of array
    two_D1[2][2][1:0]=2'b10;
    two_D2[1][3][5:0]={4'hb,2'b11};
    two_D1[3][2:0]='b101;
    two_D2[0][3:0]=4'hf;
    
    #1;
    $display("Reading array1");
    foreach(two_D1[i])begin
      $display("array1[%0d]=%b",i,two_D1[i]);
    end
    $display("array1=%p",two_D1);
    
    #1;
    $display("Reading array2");
    foreach(two_D2[i])begin
      $display("array2[%0d]=%b",i,two_D2[i]);
    end
    $display("array2=%p",two_D2);
    
    #1;
    $display("Reading array3");
    foreach(two_D3[i])begin
      $display("array3[%0d]=%b",i,two_D3[i]);
    end
    $display("array3=%p",two_D3);
  end
  
endmodule
