module CRC_TOP_MODULE(
input clk,rst_n,
output  valid,
output  CRC,done_tick
);

wire active,data;

counter uut0(
.clk(clk),
.rst_n(rst_n),
.data(data),
.done_tick(done_tick) ,
.active(active),
.valid(valid)
);

CRC uut1 (
.data(data),
.active(active),
.clk(clk),
.rst_n(rst_n),
.valid(valid),
.CRC(CRC)
);


endmodule