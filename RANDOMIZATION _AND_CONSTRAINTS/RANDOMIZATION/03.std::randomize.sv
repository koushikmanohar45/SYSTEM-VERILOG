class random;
  logic [3:0] a;
  rand reg signed [3:0]b;
  
  task display();
    int c;
    begin
      //scope randomize randomize both class members and local variable (also randomize the variable which is not declared with rand or randc)
      if(std::randomize(a))
        $display("Randomized the variable A(not declared rand or ranc)=%0d",a);
      if(std::randomize(b))
        $display("Randomized the variable B(declared as rand )=%0d",b);
      if(std::randomize(c))
        $display("Randomized the variable C(not class member)=%0d",b);
      
      //object randomize randomize only class members (also randomize the class member variable which is not declared with rand or randc)
      this.randomize();
        $display("this.randomize");
        $display("a=%0d,b=%0d c=%0d",a,b,c);
      if(std::randomize(this))
        $display("std::randomize(this)");
        $display("a=%0d,b=%0d c=%0d",a,b,c);
        
      
      //scope randomize
      randomize(a);
      $display("randomize(a)",a);
      
    end
  endtask
  
endclass



module std_randomize;
  random r;
  
  initial begin
    $display("==================================================");
    $display("                  STD::RANDOMIZE                       ");
    $display("==================================================");
    r=new();
    repeat(3)begin
      r.display();
      $display("--------------------------------------------------");
      #10;
    end
  end
endmodule
  


/*
OUTPUT:
==================================================
                STD::RANDOMIZE                       
==================================================
Randomized the variable A(not declared rand or ranc)=6
Randomized the variable B(declared as rand )=7
Randomized the variable C(not class member)=7
this.randomize
a=6,b=-7 c=1809026957
std::randomize(this)
a=6,b=5 c=1809026957
randomize(a)11
--------------------------------------------------
Randomized the variable A(not declared rand or ranc)=13
Randomized the variable B(declared as rand )=4
Randomized the variable C(not class member)=4
this.randomize
a=13,b=-6 c=649020923
std::randomize(this)
a=13,b=5 c=649020923
randomize(a) 7
--------------------------------------------------
Randomized the variable A(not declared rand or ranc)=14
Randomized the variable B(declared as rand )=-3
Randomized the variable C(not class member)=-3
this.randomize
a=14,b=0 c=-1332989658
std::randomize(this)
a=14,b=-4 c=-1332989658
randomize(a) 3
--------------------------------------------------
           V C S   S i m u l a t i o n   R e p o r t 

*/
