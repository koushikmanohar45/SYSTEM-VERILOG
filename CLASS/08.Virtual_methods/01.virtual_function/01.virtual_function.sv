class parent;

  string name;
  int age;

  function new();
    name ="Parent";
    age =60;
  endfunction

  virtual function void display();
    $display("Name = %s, Age = %0d\n", name, age);
  endfunction

endclass


class child1 extends parent;

  int salary;

  function new();
    name ="Child1";
    age =35;
    salary =50000;
  endfunction

  function void display();
    $display("Name = %s, Age = %0d, Salary = %0d\n",name, age, salary);
  endfunction

endclass


class child2 extends parent;

  string college,salary;

  function new();
    name = "child2";
    age = 20;
    salary = 0;
    college = "MIT";
  endfunction

  function void display();
    $display("Name = %s, Age = %0d, salary=%s College = %s\n",name, age,salary,college);
  endfunction

endclass


class child3 extends parent;

  string school;

  function new();
    name = "child3";
    age = 10;
    school = "ABC School";
  endfunction

  function void display();
    super.display();
    $display("Name = %s, Age = %0d, School = %s\n",name, age, school);
  endfunction

endclass


module tb;

  parent p0,p1,p2;
  
  child1 c1;
  
  child2 c2;
  
  child3 c3;

  initial begin

    p0=new();
    $display("1.created object for parent and accessing virtual function display");
    p0.display();
    
    c1=new();
    p1=c1;
    
    $display("2.created object for child1 and assigned it to parent");
    $display(" --child1 display--");
    c1.display();
    $display(" --parent display--");
    p1.display();
    
    c2=new();
    p2=new c2;
    
    $display("3.created object for child2 and shallow copied it to parent");
    $display(" --child2 display--");
    c2.display();
    $display(" --parent display--");
    p2.display();
    
    c3=new();
    $display("4.created object for child3 and display child3 where i have declared super keyword in it");
    c3.display();
  end

endmodule

/*
output:
1.created object for parent and accessing virtual function display
Name = Parent, Age = 60

2.created object for child1 and assigned it to parent
 --child1 display--
Name = Child1, Age = 35, Salary = 50000

 --parent display--
Name = Child1, Age = 35, Salary = 50000

3.created object for child2 and shallow copied it to parent
 --child2 display--
Name = child2, Age = 20, salary= College = MIT

 --parent display--
Name = child2, Age = 20, salary= College = MIT

4.created object for child3 and display child3 where i have declared super keyword in it
Name = child3, Age = 10

Name = child3, Age = 10, School = ABC School

           V C S   S i m u l a t i o n   R e p o r t 
*/
