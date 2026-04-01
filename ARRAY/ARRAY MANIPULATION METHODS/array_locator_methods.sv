module array_locator_methods();
  logic [3:0][3:0]s[0:7];
  reg [7:0]d[];
  reg[7:0]q[$];
  reg [7:0]a[int];
  
  logic [15:0] temp1[$];   
  logic [7:0] temp2[$];        
  int temp_idx[$]; 
  
  
  initial begin
    s[0]=16'h0a49;
    s[1]=16'h0012;
    s[2]=16'h1ace;
    s[3]=16'h0012;
    s[4]=16'h0025;
    s[5]=16'h01a2;
    s[6]=16'h12a1;
    s[7]=16'hcade;
    d='{'ha,'h1,'h2,'h6,'hf,'h9,'h0,'h7,'h5,'hd,'he};
    q='{8'h12,8'h21,8'had,8'hd2,'h6,'hf,'h9,'h0,'h7,'h5,'hd,'he};
    a='{1:8'h12,3:8'h21,4:8'had,7:8'hd2,2:8'h32};
    a[51]=8'h45;
    a[12]=8'h45;
    
    $display("                          ARRAY REDUCTION METHODS                \t");
    $display("==========================MANUPULATING STATIC ARRAY==============================");
    
    $display("STATIC ARRAY=%P",s);
    temp1=s.find(item) with (item>25);
    $display("VALUES GREATER THAN 25=%p",temp1);
    temp_idx=s.find_index(item) with(item==4);
    $display("INDEX OF VALUE 4=%p",temp_idx);
    temp1=s.find_first(item) with(item<1000);
    $display("THE FIRST VALUE TO BE LESS THAN 1000=%p",temp1);
    temp_idx=s.find_first_index(item) with(item=='h12);
    $display("THE INDEX OF FIRST 'h12 OCCURING=%P",temp_idx);
    temp1=s.find_last(item) with(item<256);
    $display("THE LAST VALUE TO BE LESS THAN 256=%p",temp1);
    temp_idx=s.find_last_index(item) with(item>256);
    $display("THE INDEX OF LAST VALUE TO BE GREATER THAN 256=%P",temp_idx);
    temp1=s.unique;
    $display("UNIQUE VALUE=%p",temp1);
    temp_idx=s.unique_index;
    $display("INDEX OF UNIQUE VALUES=%P",temp_idx);
    temp1=s.min();
    $display("FINDING SMALLEST VALUE=%p",temp1);
    temp1=s.max();
    $display("FINDING LARGEST VALUE=%p",temp1);
    
    $display("===========================MANUPULATING DYNAMIC ARRAY============================");
    
    $display("DYNAMIC ARRAY=%P",d);
    temp2=d.find(item) with (item<10);
    $display("VALUES LESS THAN 10=%p",temp2);
    
    temp_idx=d.find_index(item) with(item>10);
    $display("INDEX OF VALUES  GREATER THAN 10 =%p",temp_idx);
    temp2=d.find_first(item) with(item%2==0);  
    $display("THE FIRST VALUE TO BE DIVISIBLE BY 2=%p",temp2); 
    temp_idx= d.find_first_index(item) with (item==13);
    $display("THE INDEX OF FIRST 13 OCCURING=%p",temp_idx);
    temp2=d.find_last(item) with(item%3==0);
    $display("THE LAST VALUE TO BE DIVISABLE BY 3=%p",temp2);
    temp_idx=d.find_last_index(item) with(item>2);
    $display("THE INDEX OF LAST VALUE TO BE GREATER THAN 2=%p",temp_idx);
    
    temp2=d.unique;
    $display("UNIQUE VALUE=%p",temp2);
    
    temp_idx=d.unique_index;
    $display("INDEX OF UNIQUE VALUES=%P",temp_idx);
    
    temp2=d.min();
    $display("FINDING SMALLEST VALUE=%p",temp2);
    temp2=d.max();
    $display("FINDING LARGEST VALUE=%p",temp2);
    
    $display("================================MANUPULATING QUEUE================================");
    
    $display("QUEUE=%P",q);
    temp2=q.find(item) with (item<10);
    $display("VALUES LESS THAN 10=%p",temp2);
    
    temp_idx=q.find_index(item) with(item>10);
    $display("INDEX OF VALUES  GREATER THAN 10 =%p",temp_idx);
    temp2=q.find_first(item) with((item>2)+1);
    $display("THE FIRST VALUE TO BE GREATER THAN 2 AND ADDED WITH ONE=%p",temp2);
    temp_idx=q.find_first_index(item) with (item==13);
    $display("THE INDEX OF FIRST 13 OCCURING=%p",temp_idx);
    temp2=q.find_last(item) with(item%3==0);
    $display("THE LAST VALUE TO BE DIVISABLE BY 3=%p",temp2);
    temp_idx=q.find_last_index(item) with(item>2);
    $display("THE INDEX OF LAST VALUE TO BE GREATER THAN 2=%p",temp_idx);
    
    temp2=q.unique;
    $display("UNIQUE VALUE=%p",temp2);
    
    temp_idx=q.unique_index;
    $display("INDEX OF UNIQUE VALUES=%P",temp_idx);
    temp2=q.min();
    $display("FINDING SMALLEST VALUE=%p",temp2);
    temp2=q.max();
    $display("FINDING LARGEST VALUE=%p",temp2);

  end
endmodule


/*
OUTPUT:
ARRAY REDUCTION METHODS                	
==========================MANUPULATING STATIC ARRAY==============================
STATIC ARRAY='{'ha49, 'h12, 'h1ace, 'h12, 'h25, 'h1a2, 'h12a1, 'hcade} 
VALUES GREATER THAN 25='{'ha49, 'h1ace, 'h25, 'h1a2, 'h12a1, 'hcade} 
INDEX OF VALUE 4='{}
THE FIRST VALUE TO BE LESS THAN 1000='{'h12} 
THE INDEX OF FIRST 'h12 OCCURING='{1} 
THE LAST VALUE TO BE LESS THAN 256='{'h25} 
THE INDEX OF LAST VALUE TO BE GREATER THAN 256='{7} 
UNIQUE VALUE='{'ha49, 'h12, 'h1ace, 'h25, 'h1a2, 'h12a1, 'hcade} 
INDEX OF UNIQUE VALUES='{0, 1, 2, 4, 5, 6, 7} 
FINDING SMALLEST VALUE='{'h12} 
FINDING LARGEST VALUE='{'hcade} 
===========================MANUPULATING DYNAMIC ARRAY============================
DYNAMIC ARRAY='{'ha, 'h1, 'h2, 'h6, 'hf, 'h9, 'h0, 'h7, 'h5, 'hd, 'he} 
VALUES LESS THAN 10='{'h1, 'h2, 'h6, 'h9, 'h0, 'h7, 'h5} 
INDEX OF VALUES  GREATER THAN 10 ='{4, 9, 10} 
THE FIRST VALUE TO BE DIVISIBLE BY 2='{'ha} 
THE INDEX OF FIRST 13 OCCURING='{9} 
THE LAST VALUE TO BE DIVISABLE BY 3='{'h0} 
THE INDEX OF LAST VALUE TO BE GREATER THAN 2='{10} 
UNIQUE VALUE='{'ha, 'h1, 'h2, 'h6, 'hf, 'h9, 'h0, 'h7, 'h5, 'hd, 'he} 
INDEX OF UNIQUE VALUES='{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10} 
FINDING SMALLEST VALUE='{'h0} 
FINDING LARGEST VALUE='{'hf} 
================================MANUPULATING QUEUE================================
QUEUE='{'h12, 'h21, 'had, 'hd2, 'h6, 'hf, 'h9, 'h0, 'h7, 'h5, 'hd, 'he} 
VALUES LESS THAN 10='{'h6, 'h9, 'h0, 'h7, 'h5} 
INDEX OF VALUES  GREATER THAN 10 ='{0, 1, 2, 3, 5, 10, 11} 
THE FIRST VALUE TO BE GREATER THAN 2 AND ADDED WITH ONE='{'h12} 
THE INDEX OF FIRST 13 OCCURING='{10} 
THE LAST VALUE TO BE DIVISABLE BY 3='{'h0} 
THE INDEX OF LAST VALUE TO BE GREATER THAN 2='{11} 
UNIQUE VALUE='{'h12, 'h21, 'had, 'hd2, 'h6, 'hf, 'h9, 'h0, 'h7, 'h5, 'hd, 'he} 
INDEX OF UNIQUE VALUES='{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11} 
FINDING SMALLEST VALUE='{'h0} 
FINDING LARGEST VALUE='{'hd2} 
           V C S   S i m u l a t i o n   R e p o r t 
*/
  
