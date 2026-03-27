module associate_array;
  int a1[*]; 
  int a2[string];
  int a3[*][$][]='{
                  1:'{'{1,2,3},'{4,5,6}},
                  3:'{'{7,8},'{8,9,0}},
                  4:'{'{11,13,15},'{12,14,16}},
                  7:'{'{17,27,7}}
                  };
  string a4[string]='{"sports":"cricket","Team":"India","Player":"Hitman","Jersy":"45"};
  string i;
  int j;
  
  initial begin
    a2["CSK"]=5;
    a2["MI"]=5;
    a2["RCB"]=1;
    a2["PBKS"]=0;
    a1[7]=224;
    a1[18]=183;
    a1[45]=264;
    $display("Associate array1 size=%0d",a1.size());
    $display("Associate array2 size=%0d",a2.num());
    $display("Associate array3 size=%0d",a3.num());
    $display("Associate array4 size=%0d",a4.size());
    $display("");
    $display("Associate array1=%p",a1); 
    $display("Searching for index 1");
    if(a1.exists(1))
      $display("--FOUND--");
    else
      $display("NOT FOUND!");
    $display("Searching for index 18");
    if(a1.exists(18))
      $display("--FOUND--");
    else
      $display("NOT FOUND!");
    
    $display("Associate array2=%p",a2);
    $display("Deleting the index PBKS");
    a2.delete("PBKS");
    $display("After delete, Associate array2=%p",a2);
    
    $display("Associate array3=%p",a3);
    if(a3.first(j)) begin
      $display("array3.first=%p",a3[j]);
    end
    if(a3.next(j)) begin
      $display("array3.next=%p",a3[j]);
    end
    
    if(a3.last(j)) begin
      $display("array3.last=%p",a3[j]);
    end
    if(a3.prev(j)) begin
      $display("array3.prev=%p",a3[j]);
    end
    
    $display("Associate array4=%p",a4);
    $display("Displaying each elements in Associate array4");
    foreach(a4[i])begin
      $display("%s = %s", i, a4[i]);
    end
  end
endmodule
