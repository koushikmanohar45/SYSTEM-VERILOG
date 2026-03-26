module unpacked_3D();
  bit [1:0] three_D [8][4];   // unpacked 3D array
  int i, j;

  initial begin
    //writing
    for(i=0;i<8;i++) begin
      for(j=0;j<4;j++)
        three_D[i][j] =(i+j)%4;
    end

    // Reading
    for(i=0;i<8;i++) begin
      for(j=0;j<4;j++)
        $display("3D[%0d][%0d]=%b",i,j,three_D[i][j]);
    end

    $display("3D Array=%p",three_D);

  end

endmodule
