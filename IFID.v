module IFID(
    clk_i, 
    PC_i,
    inst_i,
    Flush_i, //when setting to 1, all reg become 0.
    Stall_i, //when setting to 1, cannot be written. 
    PC_o,
    inst_o
);
    input clk_i;
    input [31:0] PC_i;
    input [31:0] inst_i;
    input Flush_i;
    input Stall_i;
    output [31:0] PC_o;
    output [31:0] inst_o;

    reg [31:0] PC_in_reg, PC_out_reg;
    reg [31:0] inst_in_reg, inst_out_reg;
// for data read when clk is at negative edge
    assign PC_o = PC_out_reg;
    assign inst_o = inst_out_reg;
// for data write when clk is at postive edge

always@(posedge clk_i or negedge clk_i) 
begin
    
    if(clk_i) begin
        if(Stall_i) begin
        PC_in_reg = PC_out_reg;
        inst_in_reg = inst_out_reg;
        end
        else if(Flush_i) begin
            PC_in_reg = 32'b0;
            inst_in_reg = 32'b0;
        end
        else begin
        PC_in_reg = PC_i;
        inst_in_reg = inst_i;
        end
    end
    if(~clk_i)begin
        PC_out_reg = PC_in_reg;
        inst_out_reg = inst_in_reg;
    end    
    //$displayb("IFID:cik_i = ",clk_i,"   pc_i = ", PC_i ," inst_i", inst_i," Flush_i:",Flush_i," Stall_i", Stall_i," PC_o", PC_o," inst_o", inst_o, "\n");
end
endmodule
