module foreach_loop();
  byte a[3:0][3:0];
  byte b[3:0][3:0];
  byte sum[3:0][3:0];
 

  initial begin
   $display("...........................FOREACH LOOP..................................");
    
   // geting values to a 
      foreach(a[i,j])begin
        a[i][j]=$urandom;
        $display("a[%0d][%0d]=%0d",i,j,a[i][j]);
        #1;
      end
    $display("matric a=%p",a);
    
    // geting values to b
       foreach(b[i,j])begin
        b[i][j]=$urandom;
        $display("b[%0d][%0d]=%0d",i,j,b[i][j]);
        #1;
      end

    $display("matrix b=%p",b);
    
    // matrix addition 
      foreach(sum[i,j])begin
        sum[i][j]=a[i][j]+b[i][j];
        #1;
      end
    $display("sum=%p",sum);
  end

endmodule


/*
OUTPUT:
...........................FOREACH LOOP..................................
a[3][3]=54
a[3][2]=60
a[3][1]=125
a[3][0]=-30
a[2][3]=11
a[2][2]=-33
a[2][1]=64
a[2][0]=-9
a[1][3]=-90
a[1][2]=27
a[1][1]=-75
a[1][0]=-6
a[0][3]=78
a[0][2]=21
a[0][1]=125
a[0][0]=114
matric a='{'{54, 60, 125, -30}, '{11, -33, 64, -9}, '{-90, 27, -75, -6}, '{78, 21, 125, 114}} 
b[3][3]=-106
b[3][2]=49
b[3][1]=-60
b[3][0]=-86
b[2][3]=-60
b[2][2]=-49
b[2][1]=79
b[2][0]=-12
b[1][3]=23
b[1][2]=-120
b[1][1]=-15
b[1][0]=44
b[0][3]=-50
b[0][2]=5
b[0][1]=-53
b[0][0]=-116
matrix b='{'{-106, 49, -60, -86}, '{-60, -49, 79, -12}, '{23, -120, -15, 44}, '{-50, 5, -53, -116}} 
sum='{'{-52, 109, 65, -116}, '{-49, -82, -113, -21}, '{-67, -93, -90, 38}, '{28, 26, 72, -2}} 
           V C S   S i m u l a t i o n   R e p o r t 
*/
