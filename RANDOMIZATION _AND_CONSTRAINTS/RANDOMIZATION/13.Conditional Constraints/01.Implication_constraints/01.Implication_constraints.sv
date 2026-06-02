
class implication;

  rand bit write;
  rand bit burst_enable;
  rand bit error_enable;
  rand bit [7:0] addr;
  rand bit [3:0] burst_len;
  rand bit [1:0] transfer_size;
  rand bit parity_bit;

  constraint c1 {
                  (write==1)->(addr<100);
                }

  constraint c2 {
                  (write==0)->(addr>150);
                }

  constraint c3 {
                  (burst_enable==1)->(burst_len inside {[2:8]}); 
                }

  constraint c4 {  
                  (transfer_size==2)->(addr%4==0);
                }

  constraint c5 {
                  (error_enable==1)->(parity_bit==1);
                }
  
  function void display();
    
    if(write)begin
      $display("write enable on -> address should be less than 100");
      $display("addr=%0d",addr);
    end
    else begin
      $display("write enable off ->address should be greater than 150");
      $display("addr=%0d",addr);
    end
    
    if(burst_enable)begin
      $display("burst enable on -> addr  should be in range [2:8]");
      $display("burst_length=%0d",burst_len);
    end
    else begin
      $display("burst enable off  burst length can be any value due to implication costraint");
      $display("burst_lenth=%0d",burst_len);
    end
    
    if(transfer_size==2)begin
      $display(" transfer size is equal to 2 -> burst length should be divisible by 4");
      $display("addr=%0d",addr);
    end
    else begin
      $display("transfer size is not equal to 2  burst length can be any value due to implication costraint");
      $display("addr=%0d",addr);
    end
    
    if(error_enable)begin
      $display("error enable  on -> parity bit  should be 1 (error injection)");
      $display("parity_bit=%b",parity_bit);
    end
    else begin
      $display("error enable  off parity bit  can be any value due to implication costraint");
      $display("parity_bit=%b",parity_bit);
    end
    
  endfunction
       
endclass

module randomization;
  implication i;
  
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
write enable on -> address should be less than 100
addr=38
burst enable off  burst length can be any value due to implication costraint
burst_lenth=12
transfer size is not equal to 2  burst length can be any value due to implication costraint
addr=38
error enable  on -> parity bit  should be 1 (error injection)
parity_bit=1
==========================================================================================
write enable off ->address should be greater than 150
addr=222
burst enable on -> addr  should be in range [2:8]
burst_length=4
transfer size is not equal to 2  burst length can be any value due to implication costraint
addr=222
error enable  off parity bit  can be any value due to implication costraint
parity_bit=0
==========================================================================================
write enable on -> address should be less than 100
addr=16
burst enable off  burst length can be any value due to implication costraint
burst_lenth=4
transfer size is not equal to 2  burst length can be any value due to implication costraint
addr=16
error enable  on -> parity bit  should be 1 (error injection)
parity_bit=1
==========================================================================================
write enable off ->address should be greater than 150
addr=244
burst enable off  burst length can be any value due to implication costraint
burst_lenth=3
transfer size is not equal to 2  burst length can be any value due to implication costraint
addr=244
error enable  on -> parity bit  should be 1 (error injection)
parity_bit=1
==========================================================================================
write enable off ->address should be greater than 150
addr=161
burst enable off  burst length can be any value due to implication costraint
burst_lenth=11
transfer size is not equal to 2  burst length can be any value due to implication costraint
addr=161
error enable  off parity bit  can be any value due to implication costraint
parity_bit=0
==========================================================================================
write enable off ->address should be greater than 150
addr=215
burst enable off  burst length can be any value due to implication costraint
burst_lenth=13
transfer size is not equal to 2  burst length can be any value due to implication costraint
addr=215
error enable  off parity bit  can be any value due to implication costraint
parity_bit=1
==========================================================================================
write enable off ->address should be greater than 150
addr=153
burst enable off  burst length can be any value due to implication costraint
burst_lenth=4
transfer size is not equal to 2  burst length can be any value due to implication costraint
addr=153
error enable  on -> parity bit  should be 1 (error injection)
parity_bit=1
==========================================================================================
write enable off ->address should be greater than 150
addr=183
burst enable on -> addr  should be in range [2:8]
burst_length=6
transfer size is not equal to 2  burst length can be any value due to implication costraint
addr=183
error enable  on -> parity bit  should be 1 (error injection)
parity_bit=1
==========================================================================================
write enable off ->address should be greater than 150
addr=248
burst enable off  burst length can be any value due to implication costraint
burst_lenth=13
transfer size is not equal to 2  burst length can be any value due to implication costraint
addr=248
error enable  on -> parity bit  should be 1 (error injection)
parity_bit=1
==========================================================================================
write enable on -> address should be less than 100
addr=6
burst enable off  burst length can be any value due to implication costraint
burst_lenth=14
transfer size is not equal to 2  burst length can be any value due to implication costraint
addr=6
error enable  off parity bit  can be any value due to implication costraint
parity_bit=0
==========================================================================================
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
*/
