module mixed_3D_array();
  logic[7:0][3:0][3:0]three_D1[2:0];//4-state
  bit[7:0][7:0][3:0]three_D2[2:0];//2-state
  reg[2:0][1:0][3:0]three_D3[3:0]='{'{'{4'hb,4'ha},'{4'hd,4'h4},'{4'h3,4'h2}},'{'{4'ha,4'hc},'{4'he,4'h1},'{4'h2,4'h3}},'{'{4'hd,4'he},'{4'ha,4'hf},'{4'h8,4'h9} },'{'{4'hb,4'ha},'{4'hb,4'ha},'{4'h2,4'h1} }
};
  int i;
  initial begin
    $display("No.of elements in a array1=%0d",$size(three_D1));
    $display("No.of elements in a array2=%0d",$size(three_D2));
    $display("No.of elements in a array3=%0d",$size(three_D3));

    // writing values in whole 
    three_D1[0]={8{16'hdaba}};
    three_D1[1]={8{16'hfaaa}};
    three_D2[0]={16{16'haeae}};
    three_D2[1]={16{16'hadda}};
    $display("Reading array1 after writing");
    
    //writting value in paricular location in array
    three_D1[2][2][1:0]=2'b10;
    three_D2[2][3][5:0]={4'hb,2'b11};
    #1;
    $display("Reading array1");
    foreach(three_D1[i])begin
      $display("array1[%0d]=%b",i,three_D1[i]);
    end
    $display("array1=%p",three_D1);
    #1;
    $display("Reading array2");
    foreach(three_D2[i])begin
      $display("array2[%0d]=%b",i,three_D2[i]);
    end
    $display("array2=%p",three_D2);
    #1;
    $display("Reading array3");
    foreach(three_D3[i])begin
      $display("array3[%0d]=%b",i,three_D3[i]);
    end
    $display("array3=%p",three_D3);
  end
  
endmodule
