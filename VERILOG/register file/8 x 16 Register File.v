module RF#(parameter width=16 , depth=8)(
input wren,rden,clk,rst,
input [width-1:0]wrdata,
input [$clog2(depth)-1:0]address,
output reg [width-1:0]rddata
);
reg [width-1:0]reg_file[0:depth-1];

always @(posedge clk , negedge rst) begin
    if(!rst)begin
    reg_file[0]<=0;
    reg_file[1]<=0;
    reg_file[2]<=0;
    reg_file[3]<=0;
    reg_file[4]<=0;
    reg_file[5]<=0;
    reg_file[6]<=0;
    reg_file[7]<=0;
    end
    else if(rden && wren)
    reg_file[address]<=reg_file[address];
    else if(wren && !rden)
    reg_file[address]<=wrdata;
    else if(rden && !wren)
    rddata<=reg_file[address];
end



endmodule