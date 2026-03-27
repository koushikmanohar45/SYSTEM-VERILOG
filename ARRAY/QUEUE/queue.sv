module queue;

  int q1[$]; //unbounded queue
  int q2[][$]='{'{1,12,21,1},'{1,4,3,3,4,1},'{10,45,18,7}};//queue and dynamic array
  int q3[$:3];//bounded queue
  string q4[$][];
  int i;

  initial begin
    $display("Queue1 size=%0d",q1.size());
    $display("Queue2 size=%0d",q2.size());
    $display("Queue3 size=%0d",q3.size());
    $display("Queue4 size=%0d",q4.size());
    $display("Queue1= %p", q1);
    q1.push_back(10);
    $display("After push_back, Queue1=%p",q1);
    q1.push_back(20);
    $display("After push_back, Queue1=%p",q1);
    q1.push_front(5);
    $display("After push_front, Queue1=%p",q1); 
    q1.pop_front(); 
    $display("After pop_front, Queue1= %p", q1); 
    q1.pop_back();
    $display("After pop_back, Queue1= %p", q1);
    
    $display("Queue2= %p", q2);
    q2[0].insert(1,5);
    $display("After insert in index1 of row0, Queue2= %p", q2);
    q2[1].insert(2,12);
    $display("After insert in index2 of row1, Queue2= %p", q2);
    q2[1].insert(3,15);
    $display("After insert in index3 of row1, Queue2= %p", q2);
    
    q4='{'{"verilog","sv","uvm","vhdl"},'{"c","c++","java","python"}};
    $display("Queue4= %p", q4);
    q4.insert(2,'{"html","css","javascript"});
    $display("After insert in index2, Queue4= %p", q4);
    q4.delete(1);
    $display("After deleting index1, Queue4= %p", q4);
    q4[0]=new[7](q4[0]);
    $display("After changing the size of array in row0, Queue4=%p",q4);

    
    $display("Queue3= %p", q3);
    q3.push_back(4);
    $display("After push_back, Queue3= %p", q3);
    q3.push_back(12);
    $display("After push_back, Queue3= %p", q3);
    q3.push_front(5);
    $display("After push_front, Queue3= %p", q3);
    q3.push_back(6);
    $display("After push_back, Queue3= %p", q3);
    q3.push_back(22);
    $display("After push_back beyond limt, Queue3= %p", q3);
    q3.push_front(25);
    $display("After push_front beyond limit, Queue3= %p", q3);
    q3.pop_front();
    $display("After pop_front, Queue3= %p", q3);
    q3.pop_back();
    $display("After pop_back, Queue3= %p", q3);   
  end

endmodule
