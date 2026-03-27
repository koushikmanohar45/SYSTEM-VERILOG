module string_datatype2();
  string s1="Do You Bleed?";
  string s2="You Will!";

initial begin
  $display("string1=%s",s1);
  $display("string2=%s",s2);
  $display("converting string1 to uppercase=%s",s1.toupper());
  $display("converting string2 to lowercase=%s",s2.tolower());
  $display("comparing with case-sensitive=%0d",s1.compare(s2));
  $display("Comparing without case-sensitive=%0d",s1.icompare(s2));
  $display("geting characters of particular range(index1 to index4) of string2=%s",s2.substr(1,4));
  $display("getting character at particular index(1) of string2=%s",s2.getc(1));
  s1.putc(3,"e");
  $display("puting character at particular index(3)of string1=%s",s1);
  end
endmodule




/* output:
string1=Do You Bleed?
string2=You Will!
converting string1 to uppercase=DO YOU BLEED?
converting string2 to lowercase=you will!
comparing with case-sensitive=-1
Comparing without case-sensitive=-1
geting characters of particular range(index1 to index4) of string2=ou W
getting character at particular index(1) of string2=o
puting character at particular index(3)of string1=Do eou Bleed?*/
