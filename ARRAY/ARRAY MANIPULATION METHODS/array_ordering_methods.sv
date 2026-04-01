module array_ordering_methods();
  logic [3:0][3:0]s[2:0];
  bit [3:0]d[];
  reg[7:0]q[$];
  
  initial begin
    s[0]=16'h0a49;
    s[1]=16'hab0e;
    s[2]=16'h1ace;
    d='{4'ha,4'h1,4'h2,'h6,'hf,'h9,'h0,'h7,'h5};
    q='{8'h12,8'h21,8'had,8'hd2};
    
    $display("                          ARRAY REDUCTION METHODS                \t");
    $display("==========================MANUPULATING STATIC ARRAY==============================");
    
    $display("STATIC ARRAY=%P",s);
    s.sort();
    $display("AFTER SORT,STATIC ARRAY=%p",s);
    s.rsort();
    $display("AFTER RSORT,STATIC ARRAY=%p",s);
    s.reverse();
    $display("AFTER REVERSE,STATIC ARRAY=%p",s);
    s.shuffle();
    $display("AFTER SHUFFLE,STATIC ARRAY=%P",s);
    
    $display("===========================MANUPULATING DYNAMIC ARRAY============================");
    
    $display("DYNAMIC ARRAY=%P",d);
    d.shuffle();
    $display("AFTER SHUFFLE,DYNAMIC ARRAY=%P",d);
    d.reverse();
    $display("AFTER REVERSE,DYNAMIC ARRAY=%p",d);
    d.sort();
    $display("AFTER SORT,DYNAMIC ARRAY=%p",d);
    d.rsort();
    $display("AFTER RSORT,DYNAMIC ARRAY=%p",d);
    
    $display("================================MANUPULATING QUEUE================================");
    
    $display("QUEUE=%P",q);
    q.reverse();
    $display("AFTER REVERSE,QUEUE=%p",q);
    q.shuffle();
    $display("AFTER SHUFFLE,QUEUE=%P",q);
    q.sort();
    $display("AFTER SORT,QUEUE=%p",q);
    q.rsort();
    $display("AFTER RSORT,QUEUE=%p",q);
   // This methods are not working on associate array due No fixed index order
  end
endmodule


/*
OUTPUT:
                          ARRAY REDUCTION METHODS                	
==========================MANUPULATING STATIC ARRAY==============================
STATIC ARRAY='{'h1ace, 'hab0e, 'ha49} 
AFTER SORT,STATIC ARRAY='{'ha49, 'h1ace, 'hab0e} 
AFTER RSORT,STATIC ARRAY='{'hab0e, 'h1ace, 'ha49} 
AFTER REVERSE,STATIC ARRAY='{'ha49, 'h1ace, 'hab0e} 
AFTER SHUFFLE,STATIC ARRAY='{'hab0e, 'h1ace, 'ha49} 
===========================MANUPULATING DYNAMIC ARRAY============================
DYNAMIC ARRAY='{'ha, 'h1, 'h2, 'h6, 'hf, 'h9, 'h0, 'h7, 'h5} 
AFTER SHUFFLE,DYNAMIC ARRAY='{'h2, 'h6, 'hf, 'h0, 'h7, 'h5, 'h1, 'h9, 'ha} 
AFTER REVERSE,DYNAMIC ARRAY='{'ha, 'h9, 'h1, 'h5, 'h7, 'h0, 'hf, 'h6, 'h2} 
AFTER SORT,DYNAMIC ARRAY='{'h0, 'h1, 'h2, 'h5, 'h6, 'h7, 'h9, 'ha, 'hf} 
AFTER RSORT,DYNAMIC ARRAY='{'hf, 'ha, 'h9, 'h7, 'h6, 'h5, 'h2, 'h1, 'h0} 
================================MANUPULATING QUEUE================================
QUEUE='{'h12, 'h21, 'had, 'hd2} 
AFTER REVERSE,QUEUE='{'hd2, 'had, 'h21, 'h12} 
AFTER SHUFFLE,QUEUE='{'had, 'hd2, 'h21, 'h12} 
AFTER SORT,QUEUE='{'h12, 'h21, 'had, 'hd2} 
AFTER RSORT,QUEUE='{'hd2, 'had, 'h21, 'h12} 
           V C S   S i m u l a t i o n   R e p o r t 

*/
