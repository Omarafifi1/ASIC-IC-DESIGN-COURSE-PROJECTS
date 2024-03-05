module up_dn_counter_tb;
reg [4:0]in_tb;
reg load_tb, up_tb , down_tb;
reg clk_tb;
wire high_tb,low_tb;
wire  [4:0]counter_tb;


up_dn_counter DUT(
.in(in_tb),
.load(load_tb),
.up (up_tb),
.down(down_tb),
.clk(clk_tb),
.high(high_tb),
.low(low_tb),
.counter(counter_tb)
);

localparam T=10;

always
begin
clk_tb=0;
#(T/2);
clk_tb=1;
#(T/2);
end

initial 
begin
  //test holding the value in the counter and priority of load
  in_tb=5'd5;  
  load_tb=1;
  down_tb=1;
  up_tb=1;
  #10;
  //test priority between up and down signals 
  load_tb=0; 
  down_tb=1;
  up_tb=1;
  #10;
  //test counting down and test low flag
  load_tb=0;
  down_tb=1;
  up_tb=0;
  repeat (10) @(negedge clk_tb);  //test that the counter stops at zero as long as down is high and up is low 
  //test that when the counter reaches zero and both the up and down signals are high the counter remains at zero 
  load_tb=0;
  down_tb=1;
  up_tb=1;
  #10;
  //test counting up and high flag and test that the counter stops at 31
  load_tb=0;
  down_tb=0;
  up_tb=1;
   #500;
   $stop;
end


endmodule
