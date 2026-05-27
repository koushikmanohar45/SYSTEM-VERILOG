class student;
  
  int roll_no;
  string name;
  
  function new(int roll_no,string name);
    this.roll_no=roll_no;
    this.name=name;
   endfunction
   
   function void display();
     $display("ROLL NO=%0d",roll_no);
     $display("NAME=%0s",name);
   endfunction
endclass
   
module test;

  student s1;
  student s2;

  initial begin

    s1=new(101,"Koushik");
    s2=new(102,"Rahul");

    s1.display();
    $display("----------------");
    s2.display();

  end

endmodule


/*
output:

ROLL NO=101
NAME=Koushik
----------------
ROLL NO=102
NAME=Rahul
           V C S   S i m u l a t i o n   R e p o r t 
*/
