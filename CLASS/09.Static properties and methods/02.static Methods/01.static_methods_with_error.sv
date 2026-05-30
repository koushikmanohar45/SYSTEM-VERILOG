class library_books;

  rand int book_id;


  static int mem[int];

  // Constraint
  constraint c1 {
    book_id inside {[2005:2009]};
  }

  // Add book function
  static function void add_book();

    //accessing not- static properties inside static method cause error
    $display("BOOK_ID = %0d", book_id);

    mem[book_id]++;

    if(book_id == 2005) begin
      $display("THE HARRY POTTER SERIES BOOK ADDED");
      $display("TOTAL COUNT = %0d", mem[book_id]);
    end

    else if(book_id == 2006) begin
      $display("THE DA VINCI CODE BOOK ADDED");
      $display("TOTAL COUNT = %0d", mem[book_id]);
    end

    else if(book_id == 2007) begin
      $display("THE HUNGER GAMES BOOK ADDED");
      $display("TOTAL COUNT = %0d", mem[book_id]);
    end

    else if(book_id == 2008) begin
      $display("THE HOBBIT BOOK ADDED");
      $display("TOTAL COUNT = %0d", mem[book_id]);
    end

    else if(book_id == 2009) begin
      $display("THE LIFE OF PI BOOK ADDED");
      $display("TOTAL COUNT = %0d", mem[book_id]);
    end

  endfunction


  // Issue book function
 static function void issue_book();

    $display("BOOK_ID = %0d", book_id);

    if(mem[book_id] == 0) begin

      $display("BOOK NOT AVAILABLE");
      $display("ISSUE FAILED");

    end

    else begin

      mem[book_id]--;

      if(book_id == 2005) begin
        $display("THE HARRY POTTER SERIES BOOK ISSUED");
        $display("TOTAL COUNT = %0d", mem[book_id]);
      end

      else if(book_id == 2006) begin
        $display("THE DA VINCI CODE BOOK ISSUED");
        $display("TOTAL COUNT = %0d", mem[book_id]);
      end

      else if(book_id == 2007) begin
        $display("THE HUNGER GAMES BOOK ISSUED");
        $display("TOTAL COUNT = %0d", mem[book_id]);
      end

      else if(book_id == 2008) begin
        $display("THE HOBBIT BOOK ISSUED");
        $display("TOTAL COUNT = %0d", mem[book_id]);
      end

      else if(book_id == 2009) begin
        $display("THE LIFE OF PI BOOK ISSUED");
        $display("TOTAL COUNT = %0d", mem[book_id]);
      end
    end
  endfunction
endclass



module book_st;

  library_books l;
  library_books l1;

  initial begin

    l=new();
    l1=new();

    $display("\n====================================");
    $display("         LIBRARY MANAGEMENT");
    $display("====================================\n");

    repeat(20) begin
      l.randomize();
      l.add_book();
      $display("------------------------------------");
      l1.randomize();
      l1.issue_book();
      $display("====================================");
    end

    #1;
    $finish;
  end

endmodule

/*
output:
Error-[SV-AMC] Non-static member access
testbench.sv, 16
$unit, "book_id"
  Illegal access of non-static member 'book_id' from static method 
  'library_books::add_book'.


Error-[SV-AMC] Non-static member access
testbench.sv, 18
$unit, "book_id"
  Illegal access of non-static member 'book_id' from static method 
  'library_books::add_book'.


Error-[SV-AMC] Non-static member access
testbench.sv, 20
$unit, "book_id"
  Illegal access of non-static member 'book_id' from static method 
  'library_books::add_book'.


Error-[SV-AMC] Non-static member access
testbench.sv, 22
$unit, "book_id"
  Illegal access of non-static member 'book_id' from static method 
  'library_books::add_book'.


Error-[SV-AMC] Non-static member access
testbench.sv, 25
$unit, "book_id"
  Illegal access of non-static member 'book_id' from static method 
  'library_books::add_book'.


Error-[SV-AMC] Non-static member access
testbench.sv, 27
$unit, "book_id"
  Illegal access of non-static member 'book_id' from static method 
  'library_books::add_book'.


Error-[SV-AMC] Non-static member access
testbench.sv, 30
$unit, "book_id"
  Illegal access of non-static member 'book_id' from static method 
  'library_books::add_book'.


Error-[SV-AMC] Non-static member access
testbench.sv, 32
$unit, "book_id"
  Illegal access of non-static member 'book_id' from static method 
  'library_books::add_book'.


Error-[SV-AMC] Non-static member access
testbench.sv, 35
$unit, "book_id"
  Illegal access of non-static member 'book_id' from static method 
  'library_books::add_book'.


Error-[SV-AMC] Non-static member access
testbench.sv, 37
$unit, "book_id"
  Illegal access of non-static member 'book_id' from static method 
  'library_books::add_book'.


Note-[MAX_ERROR_COUNT] Maximum error count reached
  Current number of errors has reached the default maximum error count (10).
  Please use +error+<count> to increase the limit.

10 errors
*/

