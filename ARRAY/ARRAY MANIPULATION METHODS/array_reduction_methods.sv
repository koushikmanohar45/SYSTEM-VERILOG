module array_reduction_methods();
  logic [3:0][3:0]s[2:0];
  bit [3:0]d[];
  reg[7:0]a[*];
  
  initial begin
    s[0]=16'h0a49;
    s[1]=16'hab0e;
    s[2]=16'h1ace;
    d='{4'ha,4'h1,4'h2,'h6,'hf,'h9,'h0,'h7,'h5};
    a='{1:8'h12,3:8'h21,4:8'had,7:8'hd2};
    a[9]=8'hae;
    
    $display("                          ARRAY REDUCTION METHODS                \t");
    $display("==========================MANUPULATING STATIC ARRAY==============================");
    
    $display("STATIC ARRAY=%P",s);
    $display("SUM OF ARRAY=%0d",s.sum());
    $display("PRDUCT OF ARRAY=%0d",s.product());
    $display("AND OF ARRAY=%0d",s.and());
    $display("OR OF ARRAY=%0d",s.or());
    $display("XOR OF ARRAY=%0d",s.xor());
    
    $display("===========================MANUPULATING DYNAMIC ARRAY============================");
    
    $display("DYNAMIC ARRAY=%P",d);
    $display("SUM OF ARRAY=%0d",d.sum());
    $display("PRDUCT OF ARRAY=%0d",d.product());
    $display("AND OF ARRAY=%0d",d.and());
    $display("OR OF ARRAY=%0d",d.or());
    $display("XOR OF ARRAY=%0d",d.xor());
    
    $display("===========================MANUPULATING ASSOCIATE ARRAY==========================");
    
    $display("ASSOCIATE ARRAY=%P",a);
    $display("SUM OF ARRAY=%0d",a.sum());
    $display("PRDUCT OF ARRAY=%0d",a.product());
    $display("AND OF ARRAY=%0d",a.and());
    $display("OR OF ARRAY=%0d",a.or());
    $display("XOR OF ARRAY=%0d",a.xor());

  end
endmodule

/*
OUTPUT:
                          ARRAY REDUCTION METHODS                	
==========================MANUPULATING STATIC ARRAY==============================
STATIC ARRAY='{'ha49, 'hab0e, 'h1ace}
SUM OF ARRAY=53285
PRDUCT OF ARRAY=37988
AND OF ARRAY=2568
OR OF ARRAY=48079
XOR OF ARRAY=48009
===========================MANUPULATING DYNAMIC ARRAY============================
DYNAMIC ARRAY='{'ha, 'h1, 'h2, 'h6, 'hf, 'h9, 'h0, 'h7, 'h5}
SUM OF ARRAY=7
PRDUCT OF ARRAY=0
AND OF ARRAY=0
OR OF ARRAY=15
XOR OF ARRAY=11
===========================MANUPULATING ASSOCIATE ARRAY==========================
ASSOCIATE ARRAY='{'h1:'h12, 'h3:'h21, 'h4:'had, 'h7:'hd2, 'h9:'hae}
SUM OF ARRAY=96
PRDUCT OF ARRAY=216
AND OF ARRAY=0
OR OF ARRAY=255
XOR OF ARRAY=226

*/
  
