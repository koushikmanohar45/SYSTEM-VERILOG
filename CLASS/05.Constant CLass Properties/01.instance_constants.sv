class aadhar;
  
  //declaring const to properties
  const string name;
  const string dob;
  
  function void display();
    
    //name and dob is not iniatized 
    
    $display("NAME and  DOB in aadhar");
    $display("NAME:%S",name);

    
  endfunction 
endclass

class e_sevai extends aadhar;
   
  function new();
    
    //instance constant
    name="RANGAJI";
    dob="29/01/2004";
    
  endfunction
    
  function void display();
    super.display();
    $display("DOB:%S",dob);
  endfunction
    
endclass

module instance_constant;
  e_sevai e;
  
  initial begin
    e=new();
    e.display;
  end
  
endmodule
    
 /*
OUTPUT:
NAME and  DOB in aadhar
NAME:RANGAJI
DOB:29/01/2004

*/ 
  
