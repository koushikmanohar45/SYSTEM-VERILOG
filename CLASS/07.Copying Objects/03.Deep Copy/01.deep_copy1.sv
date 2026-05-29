
class dp_copy;
  
  bit[7:0] in[4];
  bit[7:0] out; 
  
  function new(bit[7:0] in0,bit[7:0] in1,bit[7:0] in2,bit[7:0] in3);
    in[0]=in0;
    in[1]=in1;
    in[2]=in2;
    in[3]=in3;
  endfunction
             
endclass

class mux ;
  
  bit[1:0]sel;
  
  dp_copy d;
  
  function new();
    d=new(25,30,40,50);
  endfunction
  
  task display();
    begin
      
    case(sel)
      2'b00:d.out=d.in[0];
      2'b01:d.out=d.in[1];
      2'b10:d.out=d.in[2];
      2'b11:d.out=d.in[3];
      default:d.out=0;
    endcase
      
      $display("        .");
      $display("        |\\");
      $display("        | \\");
      $display("d0=%0d---|  |",d.in[0]);
      $display("        |  |");
      $display("d1=%0d---|  |",d.in[1]);
      $display("        |  |-----y=%0d",d.out);
      $display("d2=%0d---|  |",d.in[2]);
      $display("        |  |");
      $display("d3=%0d---|  |",d.in[3]);
      $display("        | /");
      $display("        |/|");  
      $display("        .||");
      $display("         ||");
      $display("         %B%B",sel[1],sel[0]);
      
    end
  endtask
  
  task  deep_copy(mux m);
    
    this.sel = m.sel;
    this.d.in = m.d.in;
    this.d.out=m.d.out;
  endtask
  
endclass
             

 module object_copy();
   mux c1;
   mux c2;
   
   initial begin
     c1=new();
     c2=new();

     //shallow copy
     c1.deep_copy(c2);
     //c2= new c1;
     $display("===================================================================");
     $display("                             DEEP  COPY                          ");
     $display("===================================================================");

     $display("DISPLAYING ORIGINAL OBJECT(C1)");
    c1.display();

     $display("DISPLAYING COPIED OBJECT(C2)");
    c2.display();

    // modifying c2
    //nested class(shallow_copy)will have shared memory
    c2.d.in[1]=35;
     
    //class(mux) wll have a independent memory
    c2.sel=2'b11;
     $display("=========================================================");
     $display("AFTER MODIFYING COPIED  OBJECT (C2) in[1]=%0D sel=%b ",c2.d.in[1],c2.sel);
     $display("=========================================================");

     $display("DISPLAYING ORIGINAL OBJECT(C1)");
     
    c1.display();

     $display("DISPLAYING COPIED OBJECT(C2)");
    c2.display();

  end
 endmodule

/*
output:
===================================================================
                             DEEP  COPY                          
===================================================================
DISPLAYING ORIGINAL OBJECT(C1)
        .
        |\
        | \
d0=25---|  |
        |  |
d1=30---|  |
        |  |-----y=25
d2=40---|  |
        |  |
d3=50---|  |
        | /
        |/|
        .||
         ||
         00
DISPLAYING COPIED OBJECT(C2)
        .
        |\
        | \
d0=25---|  |
        |  |
d1=30---|  |
        |  |-----y=25
d2=40---|  |
        |  |
d3=50---|  |
        | /
        |/|
        .||
         ||
         00
=========================================================
AFTER MODIFYING COPIED  OBJECT (C2) in[1]=35 sel=11 
=========================================================
DISPLAYING ORIGINAL OBJECT(C1)
        .
        |\
        | \
d0=25---|  |
        |  |
d1=30---|  |
        |  |-----y=25
d2=40---|  |
        |  |
d3=50---|  |
        | /
        |/|
        .||
         ||
         00
DISPLAYING COPIED OBJECT(C2)
        .
        |\
        | \
d0=25---|  |
        |  |
d1=35---|  |
        |  |-----y=50
d2=40---|  |
        |  |
d3=50---|  |
        | /
        |/|
        .||
         ||
         11
         
          V C S   S i m u l a t i o n   R e p o r t
*/
