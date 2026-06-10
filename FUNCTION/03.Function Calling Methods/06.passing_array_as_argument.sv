class func_ar;
  
  function static int sum_s( int arr[5]);
    
     int i,total=0;

    for(i=0;i<5;i++)
      total += arr[i];
    
    foreach(arr[i])begin
      arr[i]=arr[i]+1;
    end
    $display("%p",arr);

    return total;
    
  endfunction
  
  function automatic int sum_a(ref int arr[5]);
    int i,total=0;

    for(i=0;i<5;i++)
      total+=arr[i];
    
    foreach(arr[i])begin
      arr[i]=arr[i]+1;
    end
    $display("%p",arr);

    return total;
    
  endfunction
  
endclass


module test;
  func_ar s;

  int a[5]='{10,20,30,40,50};

  initial begin
    s=new();
    $display("SUM_AUTOMATIC=%0D",s.sum_a(a));
    $display("SUM_STATIC = %0d",s.sum_s(a));
  end

endmodule

/*
output:
SUM_AUTOMATIC='{11, 21, 31, 41, 51}
150
SUM_STATIC = '{12, 22, 32, 42, 52}
155
*/
