module bit16_alu(
    input [15:0]a,b,
    input [3:0]alu_fun,
    input clk,
    output reg [15:0]alu_out,
    output reg arith_flag,logic_flag,cmp_flag,shift_flag
);

reg [15:0]alu_out_reg;


always @(posedge clk ) begin
    alu_out<=alu_out_reg;
end


always @(*) begin
    arith_flag=0;
    logic_flag=0;
    cmp_flag=0;
    shift_flag=0;
    case (alu_fun)
        4'b0000:begin
            alu_out_reg=a+b;
            arith_flag=1'b1;
        end
        4'b0001:begin
            alu_out_reg=a-b;
            arith_flag=1'b1;
        end
        4'b0010:begin
            alu_out_reg=a*b;
            arith_flag=1'b1;
        end
        4'b0011:begin
            alu_out_reg= a / b;
            arith_flag=1'b1;
        end
        4'b0100:begin
            alu_out_reg= a & b;
            logic_flag=1'b1;
        end
        4'b0101:begin
            alu_out_reg= a | b;
            logic_flag=1'b1;
        end
        4'b0110:begin
            alu_out_reg= ~(a & b);
            logic_flag=1'b1;
        end
        4'b0111:begin
            alu_out_reg=~(a | b);
            logic_flag=1'b1;
        end
        4'b1000:begin
            alu_out_reg=(a ^ b);
            logic_flag=1'b1;
        end
        4'b1001:begin
            alu_out_reg=~(a ^ b);
            logic_flag=1'b1;
        end
        4'b1010:begin
            cmp_flag=1'b1;
            if(a==b)
            alu_out_reg=16'd1;
            else
            alu_out_reg=16'd0;
        end
        4'b1011:begin
            cmp_flag=1'b1;
            if(a>b)
            alu_out_reg=16'd2;
            else
            alu_out_reg=16'd0;
        end
        4'b1100:begin
            cmp_flag=1'b1;
            if(a<b)
            alu_out_reg=16'd3;
            else
            alu_out_reg=16'd0;
        end
        4'b1101:begin
            alu_out_reg= a>>1'b1;
            shift_flag=1'b1;
        end
        4'b1110:begin
            alu_out_reg = a<<1'b1;
            shift_flag=1'b1;
        end
        default:begin
            arith_flag=1'b0;
            logic_flag=1'b0;
            cmp_flag=1'b0;
            shift_flag=1'b0;
            alu_out_reg=16'd0; 
        end
        
    endcase
end
endmodule
