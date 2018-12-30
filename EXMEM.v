module EXMEM(
    clk_i,
    WBsig_i,
    MEMsig_i,
    ALUdata_i,
    RS2data_i,
    RDaddr_i,

    WBsig_o,
    Branch_o,
    MemRead_o,
    MemWrite_o,
    ALUdata_o,
    RS2data_o,
    RDaddr_o
);
input clk_i;
input [1:0] WBsig_i;
input [2:0] MEMsig_i;
input [31:0] RS2data_i, ALUdata_i;
input [4:0] RDaddr_i;

output [1:0] WBsig_o;
output Branch_o, MemRead_o, MemWrite_o;
output [31:0] ALUdata_o, RS2data_o;
output [4:0] RDaddr_o;

reg [1:0] WBsig_in_reg;
reg [2:0] MEMsig_in_reg;
reg [31:0] RS2data_in_reg, ALUdata_in_reg;
reg [4:0] RDaddr_in_reg;

reg [1:0] WBsig_out_reg;
reg Branch_out_reg, MemRead_out_reg, MemWrite_out_reg;
reg [31:0] ALUdata_out_reg, RS2data_out_reg;
reg [4:0] RDaddr_out_reg;
// for data read when clk is at negative edge
assign WBsig_o = WBsig_out_reg;
assign Branch_o = Branch_out_reg;
assign MemRead_o = MemRead_out_reg;
assign MemWrite_o = MemWrite_out_reg;
assign ALUdata_o = ALUdata_out_reg;
assign RS2data_o = RS2data_out_reg;
assign RDaddr_o = RDaddr_out_reg;

// for data write when clk is at postive edge

always@(posedge clk_i or negedge clk_i) 
begin
    if(clk_i) begin
        WBsig_in_reg = WBsig_i;
        MEMsig_in_reg = MEMsig_i;
        RS2data_in_reg = RS2data_i;
        ALUdata_in_reg = ALUdata_i;
        RDaddr_in_reg = RDaddr_i;
    end
    if(~clk_i)begin
        WBsig_out_reg = WBsig_in_reg;
        Branch_out_reg = MEMsig_in_reg[2];
        MemRead_out_reg = MEMsig_in_reg[1];
        MemWrite_out_reg = MEMsig_in_reg[0];
        RS2data_out_reg = RS2data_in_reg;
        ALUdata_out_reg = ALUdata_in_reg;
        RDaddr_out_reg = RDaddr_in_reg;
    end
end

endmodule
