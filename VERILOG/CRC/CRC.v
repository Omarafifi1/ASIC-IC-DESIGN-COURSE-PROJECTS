module CRC #(parameter data_width=8)(
input data,
input active,
input clk,rst_n,
output  valid,
output  reg CRC
);
reg [data_width-1:0]CRC_reg;
reg xor_0,xor_3,xor_7;



function xorr;
input a,b;
begin
xorr=a ^ b;
end
endfunction


always @(*) begin
   xor_0=xorr(CRC_reg[0],data);
   xor_3=xorr(CRC_reg[3],xor_0);
   xor_7=xorr(CRC_reg[7],xor_0);
end


always @(posedge clk ,negedge rst_n) begin  
    if(!rst_n)begin
        CRC_reg<=8'hD8;
        CRC<=0;
    end
    else if(active)begin
        CRC_reg[0]<= CRC_reg[1];
        CRC_reg[1]<= CRC_reg[2];
        CRC_reg[2]<= xor_3;
        CRC_reg[3]<= CRC_reg[4];
        CRC_reg[4]<= CRC_reg[5];
        CRC_reg[5]<= CRC_reg[6];
        CRC_reg[6]<= xor_7;
        CRC_reg[7]<= xor_0;          
    end
    else begin
        {CRC_reg[data_width-2:0],CRC}<=CRC_reg;
    end
end



endmodule
