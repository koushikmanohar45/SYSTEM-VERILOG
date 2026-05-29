class storage #(type T=int);

  T data;

  function void write(T d);
    data=d;
  endfunction

  function void display();
    $display("DATA=%p",data);
  endfunction

endclass


module test;

  storage #(int) s1;
  storage #(string) s2;

  initial begin

    s1=new();
    s2=new();

    s1.write(100);
    s2.write("KOUSHIK");

    s1.display();
    s2.display();

  end

endmodule

/*
output:
DATA=        100
DATA="KOUSHIK"
           V C S   S i m u l a t i o n   R e p o r t 

*/
