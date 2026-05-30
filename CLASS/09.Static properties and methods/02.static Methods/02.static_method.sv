class library_books;

  static rand int book_id;


  static int mem[int];

  // Constraint
  constraint c1 {
    book_id inside {[2005:2009]};
  }

  // Add book function
  static function void add_book();

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
OUTPUT:
====================================
         LIBRARY MANAGEMENT
====================================

BOOK_ID = 2006
THE DA VINCI CODE BOOK ADDED
TOTAL COUNT = 1
------------------------------------
BOOK_ID = 2005
BOOK NOT AVAILABLE
ISSUE FAILED
====================================
BOOK_ID = 2006
THE DA VINCI CODE BOOK ADDED
TOTAL COUNT = 2
------------------------------------
BOOK_ID = 2009
BOOK NOT AVAILABLE
ISSUE FAILED
====================================
BOOK_ID = 2008
THE HOBBIT BOOK ADDED
TOTAL COUNT = 1
------------------------------------
BOOK_ID = 2006
THE DA VINCI CODE BOOK ISSUED
TOTAL COUNT = 1
====================================
BOOK_ID = 2008
THE HOBBIT BOOK ADDED
TOTAL COUNT = 2
------------------------------------
BOOK_ID = 2006
THE DA VINCI CODE BOOK ISSUED
TOTAL COUNT = 0
====================================
BOOK_ID = 2006
THE DA VINCI CODE BOOK ADDED
TOTAL COUNT = 1
------------------------------------
BOOK_ID = 2006
THE DA VINCI CODE BOOK ISSUED
TOTAL COUNT = 0
====================================
BOOK_ID = 2005
THE HARRY POTTER SERIES BOOK ADDED
TOTAL COUNT = 1
------------------------------------
BOOK_ID = 2006
BOOK NOT AVAILABLE
ISSUE FAILED
====================================
BOOK_ID = 2009
THE LIFE OF PI BOOK ADDED
TOTAL COUNT = 1
------------------------------------
BOOK_ID = 2006
BOOK NOT AVAILABLE
ISSUE FAILED
====================================
BOOK_ID = 2006
THE DA VINCI CODE BOOK ADDED
TOTAL COUNT = 1
------------------------------------
BOOK_ID = 2005
THE HARRY POTTER SERIES BOOK ISSUED
TOTAL COUNT = 0
====================================
BOOK_ID = 2008
THE HOBBIT BOOK ADDED
TOTAL COUNT = 3
------------------------------------
BOOK_ID = 2006
THE DA VINCI CODE BOOK ISSUED
TOTAL COUNT = 0
====================================
BOOK_ID = 2006
THE DA VINCI CODE BOOK ADDED
TOTAL COUNT = 1
------------------------------------
BOOK_ID = 2005
BOOK NOT AVAILABLE
ISSUE FAILED
====================================
BOOK_ID = 2005
THE HARRY POTTER SERIES BOOK ADDED
TOTAL COUNT = 1
------------------------------------
BOOK_ID = 2009
THE LIFE OF PI BOOK ISSUED
TOTAL COUNT = 0
====================================
BOOK_ID = 2005
THE HARRY POTTER SERIES BOOK ADDED
TOTAL COUNT = 2
------------------------------------
BOOK_ID = 2009
BOOK NOT AVAILABLE
ISSUE FAILED
====================================
BOOK_ID = 2005
THE HARRY POTTER SERIES BOOK ADDED
TOTAL COUNT = 3
------------------------------------
BOOK_ID = 2009
BOOK NOT AVAILABLE
ISSUE FAILED
====================================
BOOK_ID = 2005
THE HARRY POTTER SERIES BOOK ADDED
TOTAL COUNT = 4
------------------------------------
BOOK_ID = 2008
THE HOBBIT BOOK ISSUED
TOTAL COUNT = 2
====================================
BOOK_ID = 2008
THE HOBBIT BOOK ADDED
TOTAL COUNT = 3
------------------------------------
BOOK_ID = 2005
THE HARRY POTTER SERIES BOOK ISSUED
TOTAL COUNT = 3
====================================
BOOK_ID = 2008
THE HOBBIT BOOK ADDED
TOTAL COUNT = 4
------------------------------------
BOOK_ID = 2009
BOOK NOT AVAILABLE
ISSUE FAILED
====================================
BOOK_ID = 2008
THE HOBBIT BOOK ADDED
TOTAL COUNT = 5
------------------------------------
BOOK_ID = 2008
THE HOBBIT BOOK ISSUED
TOTAL COUNT = 4
====================================
BOOK_ID = 2009
THE LIFE OF PI BOOK ADDED
TOTAL COUNT = 1
------------------------------------
BOOK_ID = 2005
THE HARRY POTTER SERIES BOOK ISSUED
TOTAL COUNT = 2
====================================
BOOK_ID = 2008
THE HOBBIT BOOK ADDED
TOTAL COUNT = 5
------------------------------------
BOOK_ID = 2007
BOOK NOT AVAILABLE
ISSUE FAILED
====================================
BOOK_ID = 2009
THE LIFE OF PI BOOK ADDED
TOTAL COUNT = 2
------------------------------------
BOOK_ID = 2009
THE LIFE OF PI BOOK ISSUED
TOTAL COUNT = 1
====================================
$finish called from file "testbench.sv", line 118.
$finish at simulation time                    1
           V C S   S i m u l a t i o n   R e p o r t 
*/
