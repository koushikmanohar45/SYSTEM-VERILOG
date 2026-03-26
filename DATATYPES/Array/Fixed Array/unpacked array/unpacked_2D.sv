module unpacked_2D();
  int arr[3][4]; // 3 rows,4 columns
  int i, j;

  initial begin

    // Writing
    for(i=0;i<3;i++) begin
      for(j=0;j<4;j++)
        arr[i][j]=i+j;
    end

    // Reading
    for(i=0;i<3;i++) begin
      for(j=0;j<4;j++)
        $display("arr[%0d][%0d]=%0d",i,j,arr[i][j]);
    end
    $display("2D array = %p",arr);
  end
endmodule
