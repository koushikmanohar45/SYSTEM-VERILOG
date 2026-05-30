class parent;

  string name;
  int age;

  function new();
    name ="Parent";
    age = 60;
  endfunction

  virtual task display();
    #5;
    $display("[time=%0t] Name = %s, Age = %0d\n", $time, name, age);
  endtask

endclass


class child1 extends parent;

  int salary;

  function new();
    name = "Child1";
    age = 35;
    salary= 50000;
  endfunction

  task display();
    #5;
    $display("[time=%0t] Name = %s, Age = %0d, Salary = %0d\n",$time, name, age, salary);
  endtask

endclass


class child2 extends parent;

  string college;

  function new();
    name = "Child2";
    age = 20;
    college = "MIT";
  endfunction

  task display();
    #10;
    $display("[time=%0t] Name = %s, Age = %0d, College = %s\n",$time, name, age, college);
  endtask

endclass


class child3 extends parent;

  string school;

  function new();
    name = "Child3";
    age = 10;
    school = "ABC School";
  endfunction

  task display();
    super.display();
    #5;
    $display("[time=%0t] Name = %s, Age = %0d, School = %s\n",$time, name, age, school);
  endtask

endclass


module tb;

  parent p0,p1,p2;

  child1 c1;
  child2 c2;
  child3 c3;

  initial begin

    p0=new();
    $display("1. created object for parent and accessing virtual task display");
    p0.display();

    c1=new();
    p1=c1;

    $display("\n2. created object for child1 and assigned it to parent");
    $display(" --child1 display--");
    c1.display();
    $display(" --parent display--");
    p1.display();

    c2=new();
    p2=c2;

    $display("\n3. created object for child2 and assigned it to parent");
    $display(" --child2 display--");
    c2.display();
    $display(" --parent display--");
    p2.display();

    c3=new();
    $display("\n4. created object for child3 and display child3 where super keyword is used");
    c3.display();

  end

endmodule

/*
output:
1. created object for parent and accessing virtual task display
[time=5] Name = Parent, Age = 60


2. created object for child1 and assigned it to parent
 --child1 display--
[time=10] Name = Child1, Age = 35, Salary = 50000

 --parent display--
[time=15] Name = Child1, Age = 35, Salary = 50000


3. created object for child2 and assigned it to parent
 --child2 display--
[time=25] Name = Child2, Age = 20, College = MIT

 --parent display--
[time=35] Name = Child2, Age = 20, College = MIT


4. created object for child3 and display child3 where super keyword is used
[time=40] Name = Child3, Age = 10

[time=45] Name = Child3, Age = 10, School = ABC School


*/
