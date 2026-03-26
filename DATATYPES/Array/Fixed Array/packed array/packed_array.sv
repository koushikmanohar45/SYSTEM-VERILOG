module packed_array();
  logic[7:0]one_D;
  bit[3:0][3:0]two_D;
  reg[7:0][3:0][1:0]three_D='{
    '{2'b10,2'b00,2'b01,2'b11},
    '{2'b11,2'b10,2'b00,2'b01},
    '{2'b00,2'b11,2'b10,2'b00},
    '{2'b01,2'b00,2'b11,2'b10},
    '{2'b10,2'b01,2'b00,2'b11},
    '{2'b11,2'b10,2'b01,2'b00},
    '{2'b00,2'b11,2'b10,2'b01},
    '{2'b01,2'b00,2'b11,2'b10}
  };
  shortint i,j;
  initial begin
    //printing default values
    $display("default values 2D array of 2-state datatype ");
    $display("array=%p",two_D);
    
    $display("default values 1D array of 4-state datatype ");
    $display("array=%p",one_D);
    
    $display("Reading 3D array ");
    for(i=0;i<8;i++)begin
      for(j=0;j<4;j++)
      $display("3D row[%0d]coulmn[%0d]=%b",i,j,three_D[i][j]);
    end
    $display("3D array=%p",three_D);
    
    #1;
    
    //writing values to packed array
    for(i=0;i<4;i++)begin
      two_D[i]=(i*i)+1;
    end
    
    $display("Reading 2D array ");
    for(i=0;i<4;i++)begin
      for(j=0;j<4;j++)
      $display("2D row[%0d] coulmn[%0d]=%b",i,j,two_D[i][j]);
    end
    $display("2D array=%p",two_D);
    
    #1;
    
    //accessing bits in packed array
    two_D[0][2]=1'b0;
    two_D[1][3]=1'b1;
    $display("Reading 2D array after changed ome bits");
    
    foreach(two_D[i])begin
      $display("row[%0d]=%b",i,two_D[i]);
    end
    
    #1;
    one_D='h45;
    $display("1D array=%p",one_D);
  end
  
endmodule
