module string_datatype();
  string s1;
  string s2="systemverilog";

initial begin
  s1="system";
  $display("String1=%s",s1);
  $display("Length of string1=%0d",s1.len());
  //concatination
  s1={s1," verilog"}; 
  $display("After concatination, string1=%s",s1);

  $display("first char of string1=%s",s1[0]);
  $display("last char of string1=%s",s1[s1.len()-1]);
  if(s1.len()%2==0)
    $display("Middle char of string1=%s",s1[s1.len()/2]);
  else
    $display("Middle char not found due to odd no.of char");
    
  $display("String2=%s",s2);

  $display("first char of string1=%s",s2[0]);
  $display("last char of string1=%s",s2[s2.len()-1]);
  if(s2.len()%2==0)
    $display("Middle char of string1=%s",s2[s2.len()/2]);
  else
    $display("Middle char not found due to odd no.of char");
    
  $display("String2=%s",s2);
  
  //comparing
  $display("comparing String1 and string2:");
  if(s1==s2)
    $display("s1 and s2 are equal");
  else if(s1<s2)
    $display("s1 and s2 are Not equal and s2 is greater");
  else
    $display("s1 and s2 are Not equal and s1 is greater");

  //accessing char
  s1[6]="-";
  $display("After changing the index6, String1=%s",s1);
  end

endmodule
