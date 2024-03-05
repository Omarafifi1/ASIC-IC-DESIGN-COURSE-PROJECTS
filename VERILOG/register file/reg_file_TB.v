module RF_TB;
parameter width=16 , depth=8;
reg wren,rden,clk,rst;
reg [width-1:0]wrdata;
reg [$clog2(depth)-1:0]address;
wire  [width-1:0]rddata;

RF dut(
.wren(wren),
.rden(rden),
.clk(clk),
.rst(rst),
.wrdata(wrdata),
.address(address),
.rddata(rddata)
);

localparam T=10;
always 
begin
clk=0;
#(T/2);
clk=1;
#(T/2);    
end

initial 
begin
rst=0;
#2;
rst=1;
wren=1;
rden=0;
address=0;
wrdata='d50;
#10;
address=2;
wrdata='d93;
#10;
rden=1;
wren=1;
#10;
address=0;
rden=1;
wren=0;
#10;
address=2;
rden=1;
wren=0;
#20;
$stop;
    
end

endmodule
