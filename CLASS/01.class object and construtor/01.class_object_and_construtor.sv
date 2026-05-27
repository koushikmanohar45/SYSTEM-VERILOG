class student;
  int roll_no;
  string name;

  function new(int a,string b);
    roll_no=a;
    name=b; 
  endfunction

  function void display();
    $display("ROLL NO=%0d",roll_no);
    $display("NAME=%0s",name);
  endfunction

endclass



module test;

  student s1;
  student s2;
  student s3;

  initial begin

    s1=new(101,"Koushik");
    s2=new(102,"Rahul");

    s1.display();
    $display("----------------");
    s2.display();
    
    if(s3==null)
      $display("S3 object not created ");
    else
      $display("S3 object created");
    
    if(s2==null)
      $display("S2 object not created ");
    else
      $display("S2 object created");
   end
  

endmodule
/*
OUTPUT:
ROLL NO=101
NAME=Koushik
----------------
ROLL NO=102
NAME=Rahul
S3 object not created 
S2 object created
           V C S   S i m u l a t i o n   R e p o r t 
*/
