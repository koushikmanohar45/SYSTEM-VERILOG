class head_post_office;
  
  local string name;
  local string dob;
  local int age;
  local string gender;
  static string door_no;
  static string city;
  static string district;
  static int pincode;
  
  function new();
    name="RANGARAJAN";
    dob="30/02/2004";
    age=20;
    gender="MALE";
    door_no="6/85";
    city="rangarajapatti";
    district="kallakuruchi";
    pincode=621010;
  endfunction
  
  function void front_display();
    $display(" ________________________________________ ");
    $display("|          GOVERNMENT OF INDIA           | ");
    $display("|               AADHAR                   | ");
    $display("|  _________                             | ");
    $display("| |         |NAME  :%0s           |",name);
    $display("| |         |DOB   :%0s           |",dob);
    $display("| |  photo  |AGE   :%0d                   |",age);
    $display("| |         |GENDER:%0s                 |",gender);
    $display("|  _________                             | ");
    $display("|________________________________________|\n ");
  endfunction
  
  function void back_display();
    $display(" ________________________________________ ");
    $display("|          GOVERNMENT OF INDIA           | ");
    $display("|               AADHAR                   | ");
    $display("|  _________                             | ");
    $display("| |         |ADDRESS  :%0s,             |",door_no);
    $display("| |         |          %0s,   |",city);
    $display("| | QR code |          %0s,    |",district);
    $display("| |         |          %0d.           |",pincode);
    $display("|  _________                             | ");
    $display("|________________________________________|\n ");
  endfunction
  
  function void name_change(string n);
    name=n;
  endfunction
  
  function void dob_change(string n);
    dob=n;
  endfunction
  
  function void age_change(string n);
    age=n;
  endfunction
  
  function void gender_change(string n);
    gender=n;
  endfunction
  
  function void address_change(string d,string c,string dis,int p);
    door_no=d;
    city=c;
    district=dis;
    pincode=p;
  endfunction
 
endclass


class e_sevai extends head_post_office;

  function void address_change(string d,string c,string dis,int p);
    door_no=d;
    city=c;
    district=dis;
    pincode=p;
  endfunction
  
//illeagle to use name in dervied class because in parent class it is declared as local
//   function void name_change(string n);
//     name=n;
//   endfunction
  
  function void front_display();
    super.front_display();
  endfunction
  
  function void back_display();
    super.back_display();
  endfunction
    
endclass


module aadhar;
  head_post_office a;
  e_sevai e;
  
  initial begin
    a=new();
    e=new();
    $display("=======================================");
    $display("DISPLAY DEFAULT DETAILS IN AADHAR CARD");
    $display("=======================================");
    a.front_display();
    a.back_display();
    $display("===========================================================");
    $display("MODIFYING ADDRESS IN E_SEVAL WHICH IS NOT DECLARED AS LOCAL");
    $display("===========================================================");
    e.address_change("7/65","RAJAPATTI","TRICHY",621001);
    e.front_display();
    e.back_display();
    $display("=============================================================");
    $display("MODIFYING NAME IN HEAD_POST_OFFICE WHICH IS DECLARED AS LOCAL");
    $display("=============================================================");
    a.name_change("RANGAJI");
    a.front_display();
    a.back_display();
  end
  
endmodule 


/*
output:
=======================================
DISPLAY DEFAULT DETAILS IN AADHAR CARD
=======================================
 ________________________________________ 
|          GOVERNMENT OF INDIA           | 
|               AADHAR                   | 
|  _________                             | 
| |         |NAME  :RANGARAJAN           |
| |         |DOB   :30/02/2004           |
| |  photo  |AGE   :20                   |
| |         |GENDER:MALE                 |
|  _________                             | 
|________________________________________|
 
 ________________________________________ 
|          GOVERNMENT OF INDIA           | 
|               AADHAR                   | 
|  _________                             | 
| |         |ADDRESS  :6/85,             |
| |         |          rangarajapatti,   |
| | QR code |          kallakuruchi,    |
| |         |          621010.           |
|  _________                             | 
|________________________________________|
 
===========================================================
MODIFYING ADDRESS IN E_SEVAL WHICH IS NOT DECLARED AS LOCAL
===========================================================
 ________________________________________ 
|          GOVERNMENT OF INDIA           | 
|               AADHAR                   | 
|  _________                             | 
| |         |NAME  :RANGARAJAN           |
| |         |DOB   :30/02/2004           |
| |  photo  |AGE   :20                   |
| |         |GENDER:MALE                 |
|  _________                             | 
|________________________________________|
 
 ________________________________________ 
|          GOVERNMENT OF INDIA           | 
|               AADHAR                   | 
|  _________                             | 
| |         |ADDRESS  :7/65,             |
| |         |          RAJAPATTI,   |
| | QR code |          TRICHY,    |
| |         |          621001.           |
|  _________                             | 
|________________________________________|
 
=============================================================
MODIFYING NAME IN HEAD_POST_OFFICE WHICH IS DECLARED AS LOCAL
=============================================================
 ________________________________________ 
|          GOVERNMENT OF INDIA           | 
|               AADHAR                   | 
|  _________                             | 
| |         |NAME  :RANGAJI           |
| |         |DOB   :30/02/2004           |
| |  photo  |AGE   :20                   |
| |         |GENDER:MALE                 |
|  _________                             | 
|________________________________________|
 
 ________________________________________ 
|          GOVERNMENT OF INDIA           | 
|               AADHAR                   | 
|  _________                             | 
| |         |ADDRESS  :7/65,             |
| |         |          RAJAPATTI,   |
| | QR code |          TRICHY,    |
| |         |          621001.           |
|  _________                             | 
|________________________________________|
 
           V C S   S i m u l a t i o n   R e p o r t 
*/
