module unpacked_1D();
  int one_D[4]; // unpacked array of 4 integers
  int i;

  initial begin
    // Writing
    for(i=0;i<4;i++)begin
      one_D[i]=i*10;
    end
    // Reading
    foreach(one_D[i])begin
      $display("arr[%0d]=%0d",i,one_D[i]);
    end
    $display("1D Array=%p",one_D);
  end
endmodule
