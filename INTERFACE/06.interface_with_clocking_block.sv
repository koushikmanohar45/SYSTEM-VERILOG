//DESIGN
module design_v(vote.dut itf);
 
  always@(posedge itf.clk)begin
    if(itf.rst)begin
      itf.count1<=0;
      itf.count2<=0;
    end
    else begin
      if(itf.vote_a)
        itf.count1=itf.count1+1;
      else if(itf.vote_b)
       itf.count2<=itf.count2+1;
    end
  end
  
endmodule

                //TESTBENCH


//INTERFACE
interface vote (input logic clk);
  logic rst;
  logic vote_a;
  logic vote_b;
  logic [7:0]count1;
  logic [7:0]count2;
  
  //clocking block for driver
  clocking drv @(negedge clk);
    default input #2 output #2;
    input count1,count2;
    output rst,vote_a,vote_b;
  endclocking
  
  //clocking block for monitor    
  clocking mon @(negedge clk);
    default input #1 output #2;
    input rst,count1,count2,vote_a,vote_b;
  endclocking
  
  //modports
  modport dut(input clk,rst,vote_a,vote_b,output count1,count2);
  
  modport drve(input clk,clocking drv);
    
  modport mtr(input clk,clocking mon);
   
endinterface

    
//TOP MODULE
module top();
  
  logic clk=0;
  always #5 clk=~clk;
  
  vote itf(clk);
  driver d1(itf);
  monitor d2(itf);
  design_v d3(itf);

endmodule
    
//DRIVER
module driver(vote.drve itf); 
  
  initial begin
    itf.drv.rst<=1;
    repeat (3) @(itf.drv);
    itf.drv.rst<=0;
    repeat(500) begin
       bit rand_val;
       rand_val=$urandom_range(0,1);
       itf.drv.vote_a<=rand_val;
       itf.drv.vote_b<=~rand_val;
       @(itf.drv);
      end
    @(itf.drv);$finish;
  end
  
endmodule
    
//MONITOR
module monitor(vote.mtr itf); 
  
  initial begin
    $monitor("time=%0t; vote_a=%B; vote_b=%b; count1=%0d; count2=%0d",$time,itf.mon.vote_a,itf.mon.vote_b,itf.mon.count1,itf.mon.count2);
  end
endmodule        
    



/*
OUTPUT:
time=0; vote_a=x; vote_b=x; count1=x; count2=x
time=10; vote_a=x; vote_b=x; count1=0; count2=0
time=30; vote_a=0; vote_b=1; count1=0; count2=1
time=40; vote_a=0; vote_b=1; count1=0; count2=2
time=50; vote_a=1; vote_b=0; count1=1; count2=2
time=60; vote_a=0; vote_b=1; count1=1; count2=3
time=70; vote_a=1; vote_b=0; count1=2; count2=3
time=80; vote_a=1; vote_b=0; count1=3; count2=3
time=90; vote_a=0; vote_b=1; count1=3; count2=4
time=100; vote_a=1; vote_b=0; count1=4; count2=4
time=110; vote_a=0; vote_b=1; count1=4; count2=5
time=120; vote_a=1; vote_b=0; count1=5; count2=5
time=130; vote_a=1; vote_b=0; count1=6; count2=5
time=140; vote_a=0; vote_b=1; count1=6; count2=6
time=150; vote_a=0; vote_b=1; count1=6; count2=7
time=160; vote_a=1; vote_b=0; count1=7; count2=7
time=170; vote_a=1; vote_b=0; count1=8; count2=7
time=180; vote_a=0; vote_b=1; count1=8; count2=8
time=190; vote_a=0; vote_b=1; count1=8; count2=9
time=200; vote_a=1; vote_b=0; count1=9; count2=9
time=210; vote_a=0; vote_b=1; count1=9; count2=10
time=220; vote_a=0; vote_b=1; count1=9; count2=11
time=230; vote_a=0; vote_b=1; count1=9; count2=12
time=240; vote_a=1; vote_b=0; count1=10; count2=12
time=250; vote_a=1; vote_b=0; count1=11; count2=12
time=260; vote_a=0; vote_b=1; count1=11; count2=13
time=270; vote_a=1; vote_b=0; count1=12; count2=13
time=280; vote_a=0; vote_b=1; count1=12; count2=14
time=290; vote_a=1; vote_b=0; count1=13; count2=14
time=300; vote_a=0; vote_b=1; count1=13; count2=15
time=310; vote_a=0; vote_b=1; count1=13; count2=16
time=320; vote_a=1; vote_b=0; count1=14; count2=16
time=330; vote_a=1; vote_b=0; count1=15; count2=16
time=340; vote_a=0; vote_b=1; count1=15; count2=17
time=350; vote_a=0; vote_b=1; count1=15; count2=18
time=360; vote_a=1; vote_b=0; count1=16; count2=18
time=370; vote_a=0; vote_b=1; count1=16; count2=19
time=380; vote_a=1; vote_b=0; count1=17; count2=19
time=390; vote_a=0; vote_b=1; count1=17; count2=20
time=400; vote_a=0; vote_b=1; count1=17; count2=21
time=410; vote_a=0; vote_b=1; count1=17; count2=22
time=420; vote_a=1; vote_b=0; count1=18; count2=22
time=430; vote_a=0; vote_b=1; count1=18; count2=23
time=440; vote_a=1; vote_b=0; count1=19; count2=23
time=450; vote_a=1; vote_b=0; count1=20; count2=23
time=460; vote_a=0; vote_b=1; count1=20; count2=24
time=470; vote_a=0; vote_b=1; count1=20; count2=25
time=480; vote_a=1; vote_b=0; count1=21; count2=25
time=490; vote_a=1; vote_b=0; count1=22; count2=25
time=500; vote_a=1; vote_b=0; count1=23; count2=25
time=510; vote_a=0; vote_b=1; count1=23; count2=26
time=520; vote_a=0; vote_b=1; count1=23; count2=27
time=530; vote_a=1; vote_b=0; count1=24; count2=27
time=540; vote_a=1; vote_b=0; count1=25; count2=27
time=550; vote_a=1; vote_b=0; count1=26; count2=27
time=560; vote_a=0; vote_b=1; count1=26; count2=28
time=570; vote_a=0; vote_b=1; count1=26; count2=29
time=580; vote_a=1; vote_b=0; count1=27; count2=29
time=590; vote_a=1; vote_b=0; count1=28; count2=29
time=600; vote_a=0; vote_b=1; count1=28; count2=30
time=610; vote_a=1; vote_b=0; count1=29; count2=30
time=620; vote_a=0; vote_b=1; count1=29; count2=31
time=630; vote_a=0; vote_b=1; count1=29; count2=32
time=640; vote_a=1; vote_b=0; count1=30; count2=32
time=650; vote_a=1; vote_b=0; count1=31; count2=32
time=660; vote_a=1; vote_b=0; count1=32; count2=32
time=670; vote_a=0; vote_b=1; count1=32; count2=33
time=680; vote_a=0; vote_b=1; count1=32; count2=34
time=690; vote_a=1; vote_b=0; count1=33; count2=34
time=700; vote_a=1; vote_b=0; count1=34; count2=34
time=710; vote_a=0; vote_b=1; count1=34; count2=35
time=720; vote_a=1; vote_b=0; count1=35; count2=35
time=730; vote_a=0; vote_b=1; count1=35; count2=36
time=740; vote_a=1; vote_b=0; count1=36; count2=36
time=750; vote_a=0; vote_b=1; count1=36; count2=37
time=760; vote_a=1; vote_b=0; count1=37; count2=37
time=770; vote_a=1; vote_b=0; count1=38; count2=37
time=780; vote_a=0; vote_b=1; count1=38; count2=38
time=790; vote_a=1; vote_b=0; count1=39; count2=38
time=800; vote_a=1; vote_b=0; count1=40; count2=38
time=810; vote_a=1; vote_b=0; count1=41; count2=38
time=820; vote_a=1; vote_b=0; count1=42; count2=38
time=830; vote_a=1; vote_b=0; count1=43; count2=38
time=840; vote_a=0; vote_b=1; count1=43; count2=39
time=850; vote_a=0; vote_b=1; count1=43; count2=40
time=860; vote_a=1; vote_b=0; count1=44; count2=40
time=870; vote_a=0; vote_b=1; count1=44; count2=41
time=880; vote_a=0; vote_b=1; count1=44; count2=42
time=890; vote_a=0; vote_b=1; count1=44; count2=43
time=900; vote_a=0; vote_b=1; count1=44; count2=44
time=910; vote_a=0; vote_b=1; count1=44; count2=45
time=920; vote_a=0; vote_b=1; count1=44; count2=46
time=930; vote_a=1; vote_b=0; count1=45; count2=46
time=940; vote_a=1; vote_b=0; count1=46; count2=46
time=950; vote_a=1; vote_b=0; count1=47; count2=46
time=960; vote_a=1; vote_b=0; count1=48; count2=46
time=970; vote_a=0; vote_b=1; count1=48; count2=47
time=980; vote_a=1; vote_b=0; count1=49; count2=47
time=990; vote_a=1; vote_b=0; count1=50; count2=47
time=1000; vote_a=0; vote_b=1; count1=50; count2=48
time=1010; vote_a=0; vote_b=1; count1=50; count2=49
time=1020; vote_a=0; vote_b=1; count1=50; count2=50
time=1030; vote_a=1; vote_b=0; count1=51; count2=50
time=1040; vote_a=1; vote_b=0; count1=52; count2=50
time=1050; vote_a=1; vote_b=0; count1=53; count2=50
time=1060; vote_a=0; vote_b=1; count1=53; count2=51
time=1070; vote_a=0; vote_b=1; count1=53; count2=52
time=1080; vote_a=1; vote_b=0; count1=54; count2=52
time=1090; vote_a=0; vote_b=1; count1=54; count2=53
time=1100; vote_a=1; vote_b=0; count1=55; count2=53
time=1110; vote_a=1; vote_b=0; count1=56; count2=53
time=1120; vote_a=0; vote_b=1; count1=56; count2=54
time=1130; vote_a=0; vote_b=1; count1=56; count2=55
time=1140; vote_a=0; vote_b=1; count1=56; count2=56
time=1150; vote_a=1; vote_b=0; count1=57; count2=56
time=1160; vote_a=1; vote_b=0; count1=58; count2=56
time=1170; vote_a=0; vote_b=1; count1=58; count2=57
time=1180; vote_a=1; vote_b=0; count1=59; count2=57
time=1190; vote_a=1; vote_b=0; count1=60; count2=57
time=1200; vote_a=0; vote_b=1; count1=60; count2=58
time=1210; vote_a=0; vote_b=1; count1=60; count2=59
time=1220; vote_a=1; vote_b=0; count1=61; count2=59
time=1230; vote_a=1; vote_b=0; count1=62; count2=59
time=1240; vote_a=0; vote_b=1; count1=62; count2=60
time=1250; vote_a=1; vote_b=0; count1=63; count2=60
time=1260; vote_a=1; vote_b=0; count1=64; count2=60
time=1270; vote_a=0; vote_b=1; count1=64; count2=61
time=1280; vote_a=0; vote_b=1; count1=64; count2=62
time=1290; vote_a=1; vote_b=0; count1=65; count2=62
time=1300; vote_a=1; vote_b=0; count1=66; count2=62
time=1310; vote_a=0; vote_b=1; count1=66; count2=63
time=1320; vote_a=0; vote_b=1; count1=66; count2=64
time=1330; vote_a=1; vote_b=0; count1=67; count2=64
time=1340; vote_a=0; vote_b=1; count1=67; count2=65
time=1350; vote_a=0; vote_b=1; count1=67; count2=66
time=1360; vote_a=1; vote_b=0; count1=68; count2=66
time=1370; vote_a=1; vote_b=0; count1=69; count2=66
time=1380; vote_a=0; vote_b=1; count1=69; count2=67
time=1390; vote_a=1; vote_b=0; count1=70; count2=67
time=1400; vote_a=0; vote_b=1; count1=70; count2=68
time=1410; vote_a=0; vote_b=1; count1=70; count2=69
time=1420; vote_a=0; vote_b=1; count1=70; count2=70
time=1430; vote_a=1; vote_b=0; count1=71; count2=70
time=1440; vote_a=1; vote_b=0; count1=72; count2=70
time=1450; vote_a=0; vote_b=1; count1=72; count2=71
time=1460; vote_a=0; vote_b=1; count1=72; count2=72
time=1470; vote_a=1; vote_b=0; count1=73; count2=72
time=1480; vote_a=1; vote_b=0; count1=74; count2=72
time=1490; vote_a=1; vote_b=0; count1=75; count2=72
time=1500; vote_a=0; vote_b=1; count1=75; count2=73
time=1510; vote_a=0; vote_b=1; count1=75; count2=74
time=1520; vote_a=0; vote_b=1; count1=75; count2=75
time=1530; vote_a=0; vote_b=1; count1=75; count2=76
time=1540; vote_a=0; vote_b=1; count1=75; count2=77
time=1550; vote_a=0; vote_b=1; count1=75; count2=78
time=1560; vote_a=1; vote_b=0; count1=76; count2=78
time=1570; vote_a=1; vote_b=0; count1=77; count2=78
time=1580; vote_a=1; vote_b=0; count1=78; count2=78
time=1590; vote_a=1; vote_b=0; count1=79; count2=78
time=1600; vote_a=1; vote_b=0; count1=80; count2=78
time=1610; vote_a=1; vote_b=0; count1=81; count2=78
time=1620; vote_a=1; vote_b=0; count1=82; count2=78
time=1630; vote_a=0; vote_b=1; count1=82; count2=79
time=1640; vote_a=0; vote_b=1; count1=82; count2=80
time=1650; vote_a=0; vote_b=1; count1=82; count2=81
time=1660; vote_a=0; vote_b=1; count1=82; count2=82
time=1670; vote_a=1; vote_b=0; count1=83; count2=82
time=1680; vote_a=1; vote_b=0; count1=84; count2=82
time=1690; vote_a=1; vote_b=0; count1=85; count2=82
time=1700; vote_a=1; vote_b=0; count1=86; count2=82
time=1710; vote_a=1; vote_b=0; count1=87; count2=82
time=1720; vote_a=0; vote_b=1; count1=87; count2=83
time=1730; vote_a=1; vote_b=0; count1=88; count2=83
time=1740; vote_a=0; vote_b=1; count1=88; count2=84
time=1750; vote_a=0; vote_b=1; count1=88; count2=85
time=1760; vote_a=0; vote_b=1; count1=88; count2=86
time=1770; vote_a=1; vote_b=0; count1=89; count2=86
time=1780; vote_a=1; vote_b=0; count1=90; count2=86
time=1790; vote_a=1; vote_b=0; count1=91; count2=86
time=1800; vote_a=0; vote_b=1; count1=91; count2=87
time=1810; vote_a=0; vote_b=1; count1=91; count2=88
time=1820; vote_a=0; vote_b=1; count1=91; count2=89
time=1830; vote_a=0; vote_b=1; count1=91; count2=90
time=1840; vote_a=1; vote_b=0; count1=92; count2=90
time=1850; vote_a=1; vote_b=0; count1=93; count2=90
time=1860; vote_a=1; vote_b=0; count1=94; count2=90
time=1870; vote_a=0; vote_b=1; count1=94; count2=91
time=1880; vote_a=0; vote_b=1; count1=94; count2=92
time=1890; vote_a=1; vote_b=0; count1=95; count2=92
time=1900; vote_a=0; vote_b=1; count1=95; count2=93
time=1910; vote_a=0; vote_b=1; count1=95; count2=94
time=1920; vote_a=0; vote_b=1; count1=95; count2=95
time=1930; vote_a=1; vote_b=0; count1=96; count2=95
time=1940; vote_a=1; vote_b=0; count1=97; count2=95
time=1950; vote_a=0; vote_b=1; count1=97; count2=96
time=1960; vote_a=0; vote_b=1; count1=97; count2=97
time=1970; vote_a=1; vote_b=0; count1=98; count2=97
time=1980; vote_a=1; vote_b=0; count1=99; count2=97
time=1990; vote_a=1; vote_b=0; count1=100; count2=97
time=2000; vote_a=1; vote_b=0; count1=101; count2=97
time=2010; vote_a=1; vote_b=0; count1=102; count2=97
time=2020; vote_a=0; vote_b=1; count1=102; count2=98
time=2030; vote_a=0; vote_b=1; count1=102; count2=99
time=2040; vote_a=0; vote_b=1; count1=102; count2=100
time=2050; vote_a=1; vote_b=0; count1=103; count2=100
time=2060; vote_a=0; vote_b=1; count1=103; count2=101
time=2070; vote_a=1; vote_b=0; count1=104; count2=101
time=2080; vote_a=0; vote_b=1; count1=104; count2=102
time=2090; vote_a=0; vote_b=1; count1=104; count2=103
time=2100; vote_a=1; vote_b=0; count1=105; count2=103
time=2110; vote_a=0; vote_b=1; count1=105; count2=104
time=2120; vote_a=1; vote_b=0; count1=106; count2=104
time=2130; vote_a=0; vote_b=1; count1=106; count2=105
time=2140; vote_a=0; vote_b=1; count1=106; count2=106
time=2150; vote_a=1; vote_b=0; count1=107; count2=106
time=2160; vote_a=1; vote_b=0; count1=108; count2=106
time=2170; vote_a=1; vote_b=0; count1=109; count2=106
time=2180; vote_a=0; vote_b=1; count1=109; count2=107
time=2190; vote_a=0; vote_b=1; count1=109; count2=108
time=2200; vote_a=1; vote_b=0; count1=110; count2=108
time=2210; vote_a=1; vote_b=0; count1=111; count2=108
time=2220; vote_a=0; vote_b=1; count1=111; count2=109
time=2230; vote_a=1; vote_b=0; count1=112; count2=109
time=2240; vote_a=0; vote_b=1; count1=112; count2=110
time=2250; vote_a=0; vote_b=1; count1=112; count2=111
time=2260; vote_a=0; vote_b=1; count1=112; count2=112
time=2270; vote_a=1; vote_b=0; count1=113; count2=112
time=2280; vote_a=0; vote_b=1; count1=113; count2=113
time=2290; vote_a=0; vote_b=1; count1=113; count2=114
time=2300; vote_a=1; vote_b=0; count1=114; count2=114
time=2310; vote_a=0; vote_b=1; count1=114; count2=115
time=2320; vote_a=1; vote_b=0; count1=115; count2=115
time=2330; vote_a=0; vote_b=1; count1=115; count2=116
time=2340; vote_a=1; vote_b=0; count1=116; count2=116
time=2350; vote_a=1; vote_b=0; count1=117; count2=116
time=2360; vote_a=0; vote_b=1; count1=117; count2=117
time=2370; vote_a=0; vote_b=1; count1=117; count2=118
time=2380; vote_a=1; vote_b=0; count1=118; count2=118
time=2390; vote_a=0; vote_b=1; count1=118; count2=119
time=2400; vote_a=1; vote_b=0; count1=119; count2=119
time=2410; vote_a=1; vote_b=0; count1=120; count2=119
time=2420; vote_a=0; vote_b=1; count1=120; count2=120
time=2430; vote_a=1; vote_b=0; count1=121; count2=120
time=2440; vote_a=1; vote_b=0; count1=122; count2=120
time=2450; vote_a=1; vote_b=0; count1=123; count2=120
time=2460; vote_a=0; vote_b=1; count1=123; count2=121
time=2470; vote_a=0; vote_b=1; count1=123; count2=122
time=2480; vote_a=1; vote_b=0; count1=124; count2=122
time=2490; vote_a=1; vote_b=0; count1=125; count2=122
time=2500; vote_a=0; vote_b=1; count1=125; count2=123
time=2510; vote_a=0; vote_b=1; count1=125; count2=124
time=2520; vote_a=0; vote_b=1; count1=125; count2=125
time=2530; vote_a=1; vote_b=0; count1=126; count2=125
time=2540; vote_a=1; vote_b=0; count1=127; count2=125
time=2550; vote_a=0; vote_b=1; count1=127; count2=126
time=2560; vote_a=1; vote_b=0; count1=128; count2=126
time=2570; vote_a=1; vote_b=0; count1=129; count2=126
time=2580; vote_a=1; vote_b=0; count1=130; count2=126
time=2590; vote_a=1; vote_b=0; count1=131; count2=126
time=2600; vote_a=0; vote_b=1; count1=131; count2=127
time=2610; vote_a=0; vote_b=1; count1=131; count2=128
time=2620; vote_a=0; vote_b=1; count1=131; count2=129
time=2630; vote_a=1; vote_b=0; count1=132; count2=129
time=2640; vote_a=1; vote_b=0; count1=133; count2=129
time=2650; vote_a=0; vote_b=1; count1=133; count2=130
time=2660; vote_a=1; vote_b=0; count1=134; count2=130
time=2670; vote_a=0; vote_b=1; count1=134; count2=131
time=2680; vote_a=0; vote_b=1; count1=134; count2=132
time=2690; vote_a=0; vote_b=1; count1=134; count2=133
time=2700; vote_a=0; vote_b=1; count1=134; count2=134
time=2710; vote_a=1; vote_b=0; count1=135; count2=134
time=2720; vote_a=0; vote_b=1; count1=135; count2=135
time=2730; vote_a=1; vote_b=0; count1=136; count2=135
time=2740; vote_a=1; vote_b=0; count1=137; count2=135
time=2750; vote_a=1; vote_b=0; count1=138; count2=135
time=2760; vote_a=0; vote_b=1; count1=138; count2=136
time=2770; vote_a=1; vote_b=0; count1=139; count2=136
time=2780; vote_a=0; vote_b=1; count1=139; count2=137
time=2790; vote_a=1; vote_b=0; count1=140; count2=137
time=2800; vote_a=1; vote_b=0; count1=141; count2=137
time=2810; vote_a=0; vote_b=1; count1=141; count2=138
time=2820; vote_a=1; vote_b=0; count1=142; count2=138
time=2830; vote_a=1; vote_b=0; count1=143; count2=138
time=2840; vote_a=0; vote_b=1; count1=143; count2=139
time=2850; vote_a=0; vote_b=1; count1=143; count2=140
time=2860; vote_a=0; vote_b=1; count1=143; count2=141
time=2870; vote_a=0; vote_b=1; count1=143; count2=142
time=2880; vote_a=0; vote_b=1; count1=143; count2=143
time=2890; vote_a=1; vote_b=0; count1=144; count2=143
time=2900; vote_a=0; vote_b=1; count1=144; count2=144
time=2910; vote_a=0; vote_b=1; count1=144; count2=145
time=2920; vote_a=1; vote_b=0; count1=145; count2=145
time=2930; vote_a=1; vote_b=0; count1=146; count2=145
time=2940; vote_a=0; vote_b=1; count1=146; count2=146
time=2950; vote_a=0; vote_b=1; count1=146; count2=147
time=2960; vote_a=1; vote_b=0; count1=147; count2=147
time=2970; vote_a=0; vote_b=1; count1=147; count2=148
time=2980; vote_a=0; vote_b=1; count1=147; count2=149
time=2990; vote_a=1; vote_b=0; count1=148; count2=149
time=3000; vote_a=1; vote_b=0; count1=149; count2=149
time=3010; vote_a=1; vote_b=0; count1=150; count2=149
time=3020; vote_a=1; vote_b=0; count1=151; count2=149
time=3030; vote_a=1; vote_b=0; count1=152; count2=149
time=3040; vote_a=0; vote_b=1; count1=152; count2=150
time=3050; vote_a=0; vote_b=1; count1=152; count2=151
time=3060; vote_a=1; vote_b=0; count1=153; count2=151
time=3070; vote_a=0; vote_b=1; count1=153; count2=152
time=3080; vote_a=0; vote_b=1; count1=153; count2=153
time=3090; vote_a=1; vote_b=0; count1=154; count2=153
time=3100; vote_a=0; vote_b=1; count1=154; count2=154
time=3110; vote_a=1; vote_b=0; count1=155; count2=154
time=3120; vote_a=1; vote_b=0; count1=156; count2=154
time=3130; vote_a=1; vote_b=0; count1=157; count2=154
time=3140; vote_a=0; vote_b=1; count1=157; count2=155
time=3150; vote_a=1; vote_b=0; count1=158; count2=155
time=3160; vote_a=0; vote_b=1; count1=158; count2=156
time=3170; vote_a=0; vote_b=1; count1=158; count2=157
time=3180; vote_a=0; vote_b=1; count1=158; count2=158
time=3190; vote_a=0; vote_b=1; count1=158; count2=159
time=3200; vote_a=1; vote_b=0; count1=159; count2=159
time=3210; vote_a=0; vote_b=1; count1=159; count2=160
time=3220; vote_a=0; vote_b=1; count1=159; count2=161
time=3230; vote_a=0; vote_b=1; count1=159; count2=162
time=3240; vote_a=1; vote_b=0; count1=160; count2=162
time=3250; vote_a=0; vote_b=1; count1=160; count2=163
time=3260; vote_a=0; vote_b=1; count1=160; count2=164
time=3270; vote_a=0; vote_b=1; count1=160; count2=165
time=3280; vote_a=1; vote_b=0; count1=161; count2=165
time=3290; vote_a=1; vote_b=0; count1=162; count2=165
time=3300; vote_a=1; vote_b=0; count1=163; count2=165
time=3310; vote_a=1; vote_b=0; count1=164; count2=165
time=3320; vote_a=0; vote_b=1; count1=164; count2=166
time=3330; vote_a=0; vote_b=1; count1=164; count2=167
time=3340; vote_a=0; vote_b=1; count1=164; count2=168
time=3350; vote_a=0; vote_b=1; count1=164; count2=169
time=3360; vote_a=1; vote_b=0; count1=165; count2=169
time=3370; vote_a=1; vote_b=0; count1=166; count2=169
time=3380; vote_a=0; vote_b=1; count1=166; count2=170
time=3390; vote_a=0; vote_b=1; count1=166; count2=171
time=3400; vote_a=1; vote_b=0; count1=167; count2=171
time=3410; vote_a=1; vote_b=0; count1=168; count2=171
time=3420; vote_a=1; vote_b=0; count1=169; count2=171
time=3430; vote_a=1; vote_b=0; count1=170; count2=171
time=3440; vote_a=0; vote_b=1; count1=170; count2=172
time=3450; vote_a=1; vote_b=0; count1=171; count2=172
time=3460; vote_a=0; vote_b=1; count1=171; count2=173
time=3470; vote_a=0; vote_b=1; count1=171; count2=174
time=3480; vote_a=1; vote_b=0; count1=172; count2=174
time=3490; vote_a=0; vote_b=1; count1=172; count2=175
time=3500; vote_a=0; vote_b=1; count1=172; count2=176
time=3510; vote_a=0; vote_b=1; count1=172; count2=177
time=3520; vote_a=1; vote_b=0; count1=173; count2=177
time=3530; vote_a=1; vote_b=0; count1=174; count2=177
time=3540; vote_a=1; vote_b=0; count1=175; count2=177
time=3550; vote_a=0; vote_b=1; count1=175; count2=178
time=3560; vote_a=0; vote_b=1; count1=175; count2=179
time=3570; vote_a=1; vote_b=0; count1=176; count2=179
time=3580; vote_a=1; vote_b=0; count1=177; count2=179
time=3590; vote_a=0; vote_b=1; count1=177; count2=180
time=3600; vote_a=1; vote_b=0; count1=178; count2=180
time=3610; vote_a=0; vote_b=1; count1=178; count2=181
time=3620; vote_a=1; vote_b=0; count1=179; count2=181
time=3630; vote_a=1; vote_b=0; count1=180; count2=181
time=3640; vote_a=1; vote_b=0; count1=181; count2=181
time=3650; vote_a=1; vote_b=0; count1=182; count2=181
time=3660; vote_a=1; vote_b=0; count1=183; count2=181
time=3670; vote_a=0; vote_b=1; count1=183; count2=182
time=3680; vote_a=1; vote_b=0; count1=184; count2=182
time=3690; vote_a=0; vote_b=1; count1=184; count2=183
time=3700; vote_a=0; vote_b=1; count1=184; count2=184
time=3710; vote_a=1; vote_b=0; count1=185; count2=184
time=3720; vote_a=0; vote_b=1; count1=185; count2=185
time=3730; vote_a=1; vote_b=0; count1=186; count2=185
time=3740; vote_a=0; vote_b=1; count1=186; count2=186
time=3750; vote_a=1; vote_b=0; count1=187; count2=186
time=3760; vote_a=1; vote_b=0; count1=188; count2=186
time=3770; vote_a=0; vote_b=1; count1=188; count2=187
time=3780; vote_a=0; vote_b=1; count1=188; count2=188
time=3790; vote_a=1; vote_b=0; count1=189; count2=188
time=3800; vote_a=0; vote_b=1; count1=189; count2=189
time=3810; vote_a=1; vote_b=0; count1=190; count2=189
time=3820; vote_a=0; vote_b=1; count1=190; count2=190
time=3830; vote_a=1; vote_b=0; count1=191; count2=190
time=3840; vote_a=1; vote_b=0; count1=192; count2=190
time=3850; vote_a=1; vote_b=0; count1=193; count2=190
time=3860; vote_a=0; vote_b=1; count1=193; count2=191
time=3870; vote_a=0; vote_b=1; count1=193; count2=192
time=3880; vote_a=1; vote_b=0; count1=194; count2=192
time=3890; vote_a=0; vote_b=1; count1=194; count2=193
time=3900; vote_a=0; vote_b=1; count1=194; count2=194
time=3910; vote_a=0; vote_b=1; count1=194; count2=195
time=3920; vote_a=1; vote_b=0; count1=195; count2=195
time=3930; vote_a=1; vote_b=0; count1=196; count2=195
time=3940; vote_a=0; vote_b=1; count1=196; count2=196
time=3950; vote_a=0; vote_b=1; count1=196; count2=197
time=3960; vote_a=1; vote_b=0; count1=197; count2=197
time=3970; vote_a=1; vote_b=0; count1=198; count2=197
time=3980; vote_a=1; vote_b=0; count1=199; count2=197
time=3990; vote_a=1; vote_b=0; count1=200; count2=197
time=4000; vote_a=1; vote_b=0; count1=201; count2=197
time=4010; vote_a=0; vote_b=1; count1=201; count2=198
time=4020; vote_a=1; vote_b=0; count1=202; count2=198
time=4030; vote_a=0; vote_b=1; count1=202; count2=199
time=4040; vote_a=1; vote_b=0; count1=203; count2=199
time=4050; vote_a=1; vote_b=0; count1=204; count2=199
time=4060; vote_a=0; vote_b=1; count1=204; count2=200
time=4070; vote_a=1; vote_b=0; count1=205; count2=200
time=4080; vote_a=1; vote_b=0; count1=206; count2=200
time=4090; vote_a=1; vote_b=0; count1=207; count2=200
time=4100; vote_a=0; vote_b=1; count1=207; count2=201
time=4110; vote_a=1; vote_b=0; count1=208; count2=201
time=4120; vote_a=0; vote_b=1; count1=208; count2=202
time=4130; vote_a=0; vote_b=1; count1=208; count2=203
time=4140; vote_a=0; vote_b=1; count1=208; count2=204
time=4150; vote_a=0; vote_b=1; count1=208; count2=205
time=4160; vote_a=1; vote_b=0; count1=209; count2=205
time=4170; vote_a=0; vote_b=1; count1=209; count2=206
time=4180; vote_a=0; vote_b=1; count1=209; count2=207
time=4190; vote_a=0; vote_b=1; count1=209; count2=208
time=4200; vote_a=1; vote_b=0; count1=210; count2=208
time=4210; vote_a=1; vote_b=0; count1=211; count2=208
time=4220; vote_a=1; vote_b=0; count1=212; count2=208
time=4230; vote_a=0; vote_b=1; count1=212; count2=209
time=4240; vote_a=0; vote_b=1; count1=212; count2=210
time=4250; vote_a=1; vote_b=0; count1=213; count2=210
time=4260; vote_a=1; vote_b=0; count1=214; count2=210
time=4270; vote_a=1; vote_b=0; count1=215; count2=210
time=4280; vote_a=1; vote_b=0; count1=216; count2=210
time=4290; vote_a=1; vote_b=0; count1=217; count2=210
time=4300; vote_a=1; vote_b=0; count1=218; count2=210
time=4310; vote_a=1; vote_b=0; count1=219; count2=210
time=4320; vote_a=0; vote_b=1; count1=219; count2=211
time=4330; vote_a=1; vote_b=0; count1=220; count2=211
time=4340; vote_a=0; vote_b=1; count1=220; count2=212
time=4350; vote_a=0; vote_b=1; count1=220; count2=213
time=4360; vote_a=1; vote_b=0; count1=221; count2=213
time=4370; vote_a=0; vote_b=1; count1=221; count2=214
time=4380; vote_a=1; vote_b=0; count1=222; count2=214
time=4390; vote_a=0; vote_b=1; count1=222; count2=215
time=4400; vote_a=0; vote_b=1; count1=222; count2=216
time=4410; vote_a=0; vote_b=1; count1=222; count2=217
time=4420; vote_a=0; vote_b=1; count1=222; count2=218
time=4430; vote_a=1; vote_b=0; count1=223; count2=218
time=4440; vote_a=1; vote_b=0; count1=224; count2=218
time=4450; vote_a=0; vote_b=1; count1=224; count2=219
time=4460; vote_a=1; vote_b=0; count1=225; count2=219
time=4470; vote_a=0; vote_b=1; count1=225; count2=220
time=4480; vote_a=0; vote_b=1; count1=225; count2=221
time=4490; vote_a=0; vote_b=1; count1=225; count2=222
time=4500; vote_a=0; vote_b=1; count1=225; count2=223
time=4510; vote_a=0; vote_b=1; count1=225; count2=224
time=4520; vote_a=0; vote_b=1; count1=225; count2=225
time=4530; vote_a=0; vote_b=1; count1=225; count2=226
time=4540; vote_a=1; vote_b=0; count1=226; count2=226
time=4550; vote_a=1; vote_b=0; count1=227; count2=226
time=4560; vote_a=1; vote_b=0; count1=228; count2=226
time=4570; vote_a=0; vote_b=1; count1=228; count2=227
time=4580; vote_a=1; vote_b=0; count1=229; count2=227
time=4590; vote_a=1; vote_b=0; count1=230; count2=227
time=4600; vote_a=1; vote_b=0; count1=231; count2=227
time=4610; vote_a=1; vote_b=0; count1=232; count2=227
time=4620; vote_a=1; vote_b=0; count1=233; count2=227
time=4630; vote_a=1; vote_b=0; count1=234; count2=227
time=4640; vote_a=0; vote_b=1; count1=234; count2=228
time=4650; vote_a=0; vote_b=1; count1=234; count2=229
time=4660; vote_a=1; vote_b=0; count1=235; count2=229
time=4670; vote_a=1; vote_b=0; count1=236; count2=229
time=4680; vote_a=1; vote_b=0; count1=237; count2=229
time=4690; vote_a=1; vote_b=0; count1=238; count2=229
time=4700; vote_a=1; vote_b=0; count1=239; count2=229
time=4710; vote_a=0; vote_b=1; count1=239; count2=230
time=4720; vote_a=1; vote_b=0; count1=240; count2=230
time=4730; vote_a=1; vote_b=0; count1=241; count2=230
time=4740; vote_a=1; vote_b=0; count1=242; count2=230
time=4750; vote_a=0; vote_b=1; count1=242; count2=231
time=4760; vote_a=0; vote_b=1; count1=242; count2=232
time=4770; vote_a=0; vote_b=1; count1=242; count2=233
time=4780; vote_a=1; vote_b=0; count1=243; count2=233
time=4790; vote_a=1; vote_b=0; count1=244; count2=233
time=4800; vote_a=0; vote_b=1; count1=244; count2=234
time=4810; vote_a=1; vote_b=0; count1=245; count2=234
time=4820; vote_a=0; vote_b=1; count1=245; count2=235
time=4830; vote_a=0; vote_b=1; count1=245; count2=236
time=4840; vote_a=0; vote_b=1; count1=245; count2=237
time=4850; vote_a=0; vote_b=1; count1=245; count2=238
time=4860; vote_a=1; vote_b=0; count1=246; count2=238
time=4870; vote_a=0; vote_b=1; count1=246; count2=239
time=4880; vote_a=0; vote_b=1; count1=246; count2=240
time=4890; vote_a=1; vote_b=0; count1=247; count2=240
time=4900; vote_a=1; vote_b=0; count1=248; count2=240
time=4910; vote_a=0; vote_b=1; count1=248; count2=241
time=4920; vote_a=0; vote_b=1; count1=248; count2=242
time=4930; vote_a=1; vote_b=0; count1=249; count2=242
time=4940; vote_a=1; vote_b=0; count1=250; count2=242
time=4950; vote_a=1; vote_b=0; count1=251; count2=242
time=4960; vote_a=1; vote_b=0; count1=252; count2=242
time=4970; vote_a=1; vote_b=0; count1=253; count2=242
time=4980; vote_a=1; vote_b=0; count1=254; count2=242
time=4990; vote_a=0; vote_b=1; count1=254; count2=243
time=5000; vote_a=0; vote_b=1; count1=254; count2=244
time=5010; vote_a=1; vote_b=0; count1=255; count2=244
time=5020; vote_a=0; vote_b=1; count1=255; count2=245
$finish called from file "testbench.sv", line 58.
$finish at simulation time                 5030
           V C S   S i m u l a t i o n   R e p o r t 
*/
