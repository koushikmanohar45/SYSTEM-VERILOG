module enum_datatype;
  enum logic [1:0] {RED, GREEN, BLUE,YELLOW} color;

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
    color=i;
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

