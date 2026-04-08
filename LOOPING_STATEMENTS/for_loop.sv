module for_loop();
  byte a[3:0][3:0];
  byte b[3:0][3:0];
  byte sum[3:0][3:0];
 

  initial begin
   $display("...........................FOR LOOP..................................");
    
   // geting values to a 
    for(int i=0;i<4;i++)begin
      for(int j=0;j<4;j++)begin
        a[i][j]=$urandom;
        $display("a[%0d][%0d]=%0d",i,j,a[i][j]);
        #1;
      end
    end
    $display("matric a=%p",a);
    
    // geting values to b
     for(int i=0;i<4;i++)begin
      for(int j=0;j<4;j++)begin
        b[i][j]=$urandom;
        $display("b[%0d][%0d]=%0d",i,j,b[i][j]);
        #1;
      end
    end
    $display("matrix b=%p",b);
    
    // matrix addition 
    for(int i=0;i<4;i++)begin
      for(int j=0;j<4;j++)begin
        sum[i][j]=a[i][j]+b[i][j];
        #1;
      end
    end
    $display("sum=%p",sum);
  end

endmodule

/*
OUTPUT:
  ...........................FOR LOOP..................................
a[0][0]=54
a[0][1]=60
a[0][2]=125
a[0][3]=-30
a[1][0]=11
a[1][1]=-33
a[1][2]=64
a[1][3]=-9
a[2][0]=-90
a[2][1]=27
a[2][2]=-75
a[2][3]=-6
a[3][0]=78
a[3][1]=21
a[3][2]=125
a[3][3]=114
matric a='{'{114, 125, 21, 78}, '{-6, -75, 27, -90}, '{-9, 64, -33, 11}, '{-30, 125, 60, 54}} 
b[0][0]=-106
b[0][1]=49
b[0][2]=-60
b[0][3]=-86
b[1][0]=-60
b[1][1]=-49
b[1][2]=79
b[1][3]=-12
b[2][0]=23
b[2][1]=-120
b[2][2]=-15
b[2][3]=44
b[3][0]=-50
b[3][1]=5
b[3][2]=-53
b[3][3]=-116
matrix b='{'{-116, -53, 5, -50}, '{44, -15, -120, 23}, '{-12, 79, -49, -60}, '{-86, -60, 49, -106}} 
sum='{'{-2, 72, 26, 28}, '{38, -90, -93, -67}, '{-21, -113, -82, -49}, '{-116, 65, 109, -52}} 
           V C S   S i m u l a t i o n   R e p o r t 
*/
