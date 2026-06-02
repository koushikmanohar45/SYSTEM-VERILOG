
class if_else;

  rand bit write;
  rand bit burst_enable;
  rand bit error_enable;
  rand bit [7:0] addr;
  rand bit [3:0] burst_len;
  rand bit [1:0] transfer_size;
  rand bit parity_bit;

  constraint c1 {
                  if(write==1)
                       addr<100;
                  else
                       addr>150;
                }


  constraint c2 {
                  if(burst_enable==1)
                    burst_len inside {[2:8]};
                  else
                    burst_len inside {[1:2]};    
                }

  constraint c4 {  
                  if(transfer_size==2)
                    addr%4==0;
                  else
                    addr%8==0;
                }

  constraint c5 {
                  if(error_enable==1)
                     parity_bit==1;
                  else
                     parity_bit==0;
                }
  
  function void display();
    
    if(write)begin
      $display("write enable on (if) address should be less than 100");
      $display("addr=%0d",addr);
    end
    else begin
      $display("write enable off (else) address should be greater than 150");
      $display("addr=%0d",addr);
    end
    
    if(burst_enable)begin
      $display("burst enable on (if) burst length  should be in range [2:8]");
      $display("burst_length=%0d",burst_len);
    end
    else begin
      $display("burst enable off (else) burst length should be in range [1:2]");
      $display("burst_lenth=%0d",burst_len);
    end
    
    if(transfer_size==2)begin
      $display(" transfer size is equal to 2 (if) burst length should be divisible by 4");
      $display("addr=%0d",addr);
    end
    else begin
      $display("transfer size is not equal to 2 (else) burst length should be divisible by 8");
      $display("addr=%0d",addr);
    end
    
    if(error_enable)begin
      $display("error enable  on (if) parity bit  should be 1 (error injection)");
      $display("parity_bit=%b",parity_bit);
    end
    else begin
      $display("error enable  off (else) parity bit should be 0 (no error injection)");
      $display("parity_bit=%b",parity_bit);
    end
    
  endfunction
       
endclass

module randomization;
  if_else i;
  
  initial begin
    i=new();
    repeat(10)begin
      $display("==========================================================================================");
      i.randomize();
      i.display();
    end 
   $display("=========================================================================================="); 
  end
endmodule

/*
output:

==========================================================================================
write enable on (if) address should be less than 100
addr=40
burst enable off (else) burst length should be in range [1:2]
burst_lenth=1
transfer size is not equal to 2 (else) burst length should be divisible by 8
addr=40
error enable  on (if) parity bit  should be 1 (error injection)
parity_bit=1
==========================================================================================
write enable off (else) address should be greater than 150
addr=224
burst enable on (if) burst length  should be in range [2:8]
burst_length=4
transfer size is not equal to 2 (else) burst length should be divisible by 8
addr=224
error enable  off (else) parity bit should be 0 (no error injection)
parity_bit=0
==========================================================================================
write enable on (if) address should be less than 100
addr=0
burst enable on (if) burst length  should be in range [2:8]
burst_length=3
 transfer size is equal to 2 (if) burst length should be divisible by 4
addr=0
error enable  on (if) parity bit  should be 1 (error injection)
parity_bit=1
==========================================================================================
write enable off (else) address should be greater than 150
addr=224
burst enable on (if) burst length  should be in range [2:8]
burst_length=8
 transfer size is equal to 2 (if) burst length should be divisible by 4
addr=224
error enable  on (if) parity bit  should be 1 (error injection)
parity_bit=1
==========================================================================================
write enable off (else) address should be greater than 150
addr=176
burst enable on (if) burst length  should be in range [2:8]
burst_length=6
transfer size is not equal to 2 (else) burst length should be divisible by 8
addr=176
error enable  off (else) parity bit should be 0 (no error injection)
parity_bit=0
==========================================================================================
write enable off (else) address should be greater than 150
addr=244
burst enable on (if) burst length  should be in range [2:8]
burst_length=7
 transfer size is equal to 2 (if) burst length should be divisible by 4
addr=244
error enable  off (else) parity bit should be 0 (no error injection)
parity_bit=0
==========================================================================================
write enable off (else) address should be greater than 150
addr=156
burst enable on (if) burst length  should be in range [2:8]
burst_length=3
 transfer size is equal to 2 (if) burst length should be divisible by 4
addr=156
error enable  on (if) parity bit  should be 1 (error injection)
parity_bit=1
==========================================================================================
write enable off (else) address should be greater than 150
addr=184
burst enable on (if) burst length  should be in range [2:8]
burst_length=6
transfer size is not equal to 2 (else) burst length should be divisible by 8
addr=184
error enable  on (if) parity bit  should be 1 (error injection)
parity_bit=1
==========================================================================================
write enable off (else) address should be greater than 150
addr=192
burst enable on (if) burst length  should be in range [2:8]
burst_length=3
transfer size is not equal to 2 (else) burst length should be divisible by 8
addr=192
error enable  on (if) parity bit  should be 1 (error injection)
parity_bit=1
==========================================================================================
write enable on (if) address should be less than 100
addr=40
burst enable off (else) burst length should be in range [1:2]
burst_lenth=1
transfer size is not equal to 2 (else) burst length should be divisible by 8
addr=40
error enable  off (else) parity bit should be 0 (no error injection)
parity_bit=0
==========================================================================================
           V C S   S i m u l a t i o n   R e p o r t 
*/
