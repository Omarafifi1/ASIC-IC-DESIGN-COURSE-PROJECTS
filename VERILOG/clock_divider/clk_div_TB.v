module clk_div_tb;

parameter div_ratio=6;
localparam T=10;

reg  i_ref_clk_tb;
reg  i_rst_n_tb;
reg  i_clk_en_tb;
reg  [$clog2(div_ratio)-1:0]i_div_ratio_tb;
wire  o_div_clk_tb;

clk_div dut(
.i_ref_clk(i_ref_clk_tb),
.i_rst_n(i_rst_n_tb),
.i_clk_en(i_clk_en_tb),
.i_div_ratio(i_div_ratio_tb),
.o_div_clk(o_div_clk_tb)
);



initial 
begin
 reset;
 check(2,1);   
 #(10*T);
 reset;
 check(3,1); 
  #(10*T);
  reset;
 check(4,1); 
  #(10*T);
  reset;
 check(5,1); 
  #(10*T);
  reset;
 check(1,1); 
  #(10*T);
  reset;
 check(0,1); 
  #(10*T);
  reset;
 check(2,0); // test when clk enable is zero
  #(10*T);
  $stop;
end
////////////////////////////////
//////   generate clock   /////
//////////////////////////////
always
begin
i_ref_clk_tb=0;
#(T/2);
i_ref_clk_tb=1;
#(T/2);   
end


////////////////////////////////
////////  reset task   ////////
//////////////////////////////
task reset;
begin
i_rst_n_tb=0;
#(T);
i_rst_n_tb=1;
end
endtask

task check;
input [$clog2(div_ratio)-1:0]i_div_ratio ;
input i_clk_en;
begin
i_div_ratio_tb=i_div_ratio;
i_clk_en_tb =i_clk_en;
end
endtask

endmodule
