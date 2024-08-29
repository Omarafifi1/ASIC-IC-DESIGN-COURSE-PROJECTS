module up_dn_counter(
input [4:0]in,
input load, up , down,
input clk,
output high,low,
output reg [4:0]counter
);
assign low= ~| (counter);
assign high=&counter;

always @(posedge clk) begin
    if(load)
    counter<=in;
    else if(down && !low)
    counter<=counter-1'b1;
    else if(up && !high && !down)
    counter<=counter+1'b1;
end

endmodule