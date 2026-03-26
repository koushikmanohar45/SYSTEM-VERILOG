module unpacked_2D();
  int arr[3][4]; // 3 rows,4 columns
  int i, j;

  initial begin

    // Writing
    foreach(arr[i][j]) begin
      arr[i][j]=i+j;
    end

    // Reading
    foreach(arr[i][j]) begin
      $display("arr[%0d][%0d]=%0d",i,j,arr[i][j]);
    end
    $display("2D array = %p",arr);
  end
endmodule
