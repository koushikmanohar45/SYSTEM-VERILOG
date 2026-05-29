class class_assignment;
  
  bit[7:0] in[4];
  bit[7:0] out;
  bit[1:0] sel;
  
  function new(bit[7:0] in0,bit[7:0] in1,bit[7:0] in2,bit[7:0] in3,bit[1:0]sel);
    in[0]=in0;
    in[1]=in1;
    in[2]=in2;
    in[3]=in3;
    this.sel=sel;
  endfunction
  
  task display();
    begin
    case(sel)
      2'b00:out=in[0];
      2'b01:out=in[1];
      2'b10:out=in[2];
      2'b11:out=in[3];
      default:out=0;
    endcase
      $display("        .");
      $display("        |\\");
      $display("        | \\");
      $display("d0=%0d---|  |",in[0]);
      $display("        |  |");
      $display("d1=%0d---|  |",in[1]);
      $display("        |  |-----y=%0d",out);
      $display("d2=%0d---|  |",in[2]);
      $display("        |  |");
      $display("d3=%0d---|  |",in[3]);
      $display("        | /");
      $display("        |/|");  
      $display("        .||");
      $display("         ||");
      $display("         %B%B",sel[1],sel[0]);
    end
  endtask
             
endclass
             

 module object_copy();
   class_assignment c1;
   class_assignment c2;
   
   initial begin
     c1=new(25,30,40,50,1);

    // HANDLE COPY
    c2=c1;

    $display("DISPLAYING ORIGINAL OBJECT");
    c1.display();

    $display("DISPLAYING COPIED OBJECT");
    c2.display();

    // modifying c2
    c2.in[1]=35;
    c2.sel=2'b11;

    $display("AFTER MODIFYING c2");

    $display("DISPLAYING ORIGINAL OBJECT");
    c1.display();

    $display("DISPLAYING COPIED OBJECT");
    c2.display();

  end
 endmodule
               
  
/*
output:

DISPLAYING ORIGINAL OBJECT
        .
        |\
        | \
d0=25---|  |
        |  |
d1=30---|  |
        |  |-----y=30
d2=40---|  |
        |  |
d3=50---|  |
        | /
        |/|
        .||
         ||
         01
         
DISPLAYING COPIED OBJECT
        .
        |\
        | \
d0=25---|  |
        |  |
d1=30---|  |
        |  |-----y=30
d2=40---|  |
        |  |
d3=50---|  |
        | /
        |/|
        .||
         ||
         01
         
AFTER MODIFYING c2
DISPLAYING ORIGINAL OBJECT
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
         
DISPLAYING COPIED OBJECT
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
  
  
