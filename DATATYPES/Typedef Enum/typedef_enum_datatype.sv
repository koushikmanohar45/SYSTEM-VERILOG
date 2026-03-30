module typedef_enum_datatype;
  typedef enum {RED, GREEN, BLUE,YELLOW} colours;
  colours color;
always@(*)begin  $display("+++++++++++++++++++++++++++++++++++++++++++++++++++++++");
  $display("colour=%0s",color.name());
  $display("its value=%0d",color);
end
always @(*)begin
    case (color)
      RED:$display("Colour meaning :Stop");
      GREEN:$display("colours meaning: Go");
      YELLOW:$display("colours meaning: Wait");
      BLUE:$display("colours meaning: rules braking ");
      default:$display("Invalid colour");
    endcase
end
initial begin 
  for(int i=0;i<4;i++)begin
    color=colours'(i);
    #1;
  end 
  color=color.next;
  $display("Next colour=%0s",color.name());
  #1
  color=color.last;
  $display("Last colour=%0s",color.name());
  #1
  color=color.prev;
  $display("Previous colour=%0s",color.name());
  #1
  color=color.first;
  $display("First colour=%0s",color.name());
  #1 $finish;
end
endmodule


/*output:
+++++++++++++++++++++++++++++++++++++++++++++++++++++++
colour=GREEN
its value=1
colours meaning: Go
+++++++++++++++++++++++++++++++++++++++++++++++++++++++
colour=BLUE
its value=2
colours meaning: rules braking 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++
colour=YELLOW
its value=3
colours meaning: Wait
Next colour=RED
+++++++++++++++++++++++++++++++++++++++++++++++++++++++
colour=RED
its value=0
Colour meaning :Stop
Last colour=YELLOW
+++++++++++++++++++++++++++++++++++++++++++++++++++++++
colour=YELLOW
its value=3
colours meaning: Wait
Previous colour=BLUE
+++++++++++++++++++++++++++++++++++++++++++++++++++++++
colour=BLUE
its value=2
colours meaning: rules braking 
First colour=RED
+++++++++++++++++++++++++++++++++++++++++++++++++++++++
colour=RED
its value=0
Colour meaning :Stop*/
