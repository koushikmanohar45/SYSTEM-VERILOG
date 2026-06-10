class func_ar;
  
  function static int sum_s( int arr[5]);
    
     int i,total=0;
    
    foreach(arr[i])begin
      arr[i]=$urandom_range(1,10)+1;
    end
    
    for(i=0;i<5;i++)
      total += arr[i];
    
    $display("static %p",arr);

    return total;
    
  endfunction
  
  function automatic int sum_a(int arr[5]);
    int i,total=0;
    
    foreach(arr[i])begin
      arr[i]=$urandom_range(1,10)+1;
    end
    
    for(i=0;i<5;i++)
      total+=arr[i];
    
    $display("automatic %p",arr);

    return total;
    
  endfunction
  
endclass


module test;
  func_ar s;
  typedef int a[5];
  a a_h;

  initial begin
    s=new();
    $display("SUM_AUTOMATIC=%0D",s.sum_a(a_h));
    $display("SUM_STATIC = %0d",s.sum_s(a_h));
    
  end

endmodule

/*
OUTPUT:
automatic '{10, 2, 5, 2, 9} 
SUM_AUTOMATIC=28
static '{3, 8, 5, 4, 9} 
SUM_STATIC = 29
           V C S   S i m u l a t i o n   R e p o r t 
*/

