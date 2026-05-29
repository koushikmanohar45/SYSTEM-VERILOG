class fifo #(int ADDR_WIDTH = 4,int DATA_WIDTH = 8);

  bit [DATA_WIDTH-1:0] data_out;
  
  bit [DATA_WIDTH-1:0] mem [2**ADDR_WIDTH];
  
  static int count,counter1,counter2,i;
  
  

  function void write(bit [DATA_WIDTH-1:0] data);

    if(counter1<2**ADDR_WIDTH )begin
      mem[counter1]=data;
      counter1++;
      $display("WRITING............DATA_IN=%0h",data);
      i++;
    end
    
    else if(counter1==counter2)begin
      $display("FULL CAN'T WRITE");
      counter1=0;
    end
    else
      $display("FULL CAN'T WRITE");
      
       
    
     
  endfunction
  
  

  function void read();
    
    if(counter2!=counter1+1 && i!=0)begin
      data_out=mem[counter2];
      counter2++;
      $display("READING.............DATA_out=%0h",data_out);
      
    end
    
    else if(counter2<2**ADDR_WIDTH)begin
      $display("EMPTY CANT READ");
      counter2=0;
    end
    else
      $display("EMPTY CANT READ");

    

  endfunction
  
  

endclass

  
module test;
  
  fifo #(4,8) m1;
  
  initial begin

    m1 = new();

    m1.read();
    m1.write(8'h12);
    m1.write(8'h23);
    m1.read();
    m1.write(8'h45);
    m1.write(8'h67);
    m1.read();
    m1.write(8'h89);
    m1.read();
    m1.write(8'hAB);
    m1.read();
    m1.write(8'hCD);
    m1.read();
    repeat(20)begin
      m1.write($urandom_range(1,20));
    end
    repeat(20)begin
      m1.read();
    end
  end

endmodule

/*
output:
EMPTY CANT READ
WRITING............DATA_IN=12
WRITING............DATA_IN=23
READING.............DATA_out=12
WRITING............DATA_IN=45
WRITING............DATA_IN=67
READING.............DATA_out=23
WRITING............DATA_IN=89
READING.............DATA_out=45
WRITING............DATA_IN=ab
READING.............DATA_out=67
WRITING............DATA_IN=cd
READING.............DATA_out=89
WRITING............DATA_IN=13
WRITING............DATA_IN=1
WRITING............DATA_IN=e
WRITING............DATA_IN=b
WRITING............DATA_IN=8
WRITING............DATA_IN=c
WRITING............DATA_IN=11
WRITING............DATA_IN=4
WRITING............DATA_IN=3
FULL CAN'T WRITE
FULL CAN'T WRITE
FULL CAN'T WRITE
FULL CAN'T WRITE
FULL CAN'T WRITE
FULL CAN'T WRITE
FULL CAN'T WRITE
FULL CAN'T WRITE
FULL CAN'T WRITE
FULL CAN'T WRITE
FULL CAN'T WRITE
READING.............DATA_out=ab
READING.............DATA_out=cd
READING.............DATA_out=13
READING.............DATA_out=1
READING.............DATA_out=e
READING.............DATA_out=b
READING.............DATA_out=8
READING.............DATA_out=c
READING.............DATA_out=11
READING.............DATA_out=4
READING.............DATA_out=3
READING.............DATA_out=0
EMPTY CANT READ
EMPTY CANT READ
EMPTY CANT READ
EMPTY CANT READ
EMPTY CANT READ
EMPTY CANT READ
EMPTY CANT READ
EMPTY CANT READ
           V C S   S i m u l a t i o n   R e p o r t 
*/
