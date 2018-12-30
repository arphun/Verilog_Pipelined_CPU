module MEMWB(
    clk_i,
    WBsig_i,
    Memdata_i,
    ALUdata_i,
    RDaddr_i,

    RegWrite_o,
    MemToReg_o,
    Memdata_o,
    ALUdata_o,
    RDaddr_o
);
input clk_i;
input [1:0] WBsig_i;
input [31:0] Memdata_i, ALUdata_i;
input [4:0] RDaddr_i;

output RegWrite_o, MemToReg_o;
output [31:0] ALUdata_o, Memdata_o;
output [4:0] RDaddr_o;

reg [1:0] WBsig_in_reg;
reg [31:0] Memdata_in_reg, ALUdata_in_reg;
reg [4:0] RDaddr_in_reg;

reg RegWrite_out_reg, MemToReg_out_reg;
reg [31:0] ALUdata_out_reg, Memdata_out_reg;
reg [4:0] RDaddr_out_reg;
// for data read when clk is at negative edge
assign RegWrite_o = RegWrite_out_reg;
assign MemToReg_o = MemToReg_out_reg;
assign ALUdata_o = ALUdata_out_reg;
assign Memdata_o = Memdata_out_reg;
assign RDaddr_o = RDaddr_out_reg;

// for data write when clk is at postive edge

always@(posedge clk_i or negedge clk_i) 
begin
    if(clk_i) begin
        WBsig_in_reg = WBsig_i;
        Memdata_in_reg = Memdata_i;
        ALUdata_in_reg = ALUdata_i;
        RDaddr_in_reg = RDaddr_i;
    end
    if(~clk_i)begin
        RegWrite_out_reg = WBsig_in_reg[1];
        MemToReg_out_reg = WBsig_in_reg[0];
        ALUdata_out_reg = ALUdata_in_reg;
        Memdata_out_reg = Memdata_in_reg;
        RDaddr_out_reg = RDaddr_in_reg;
    end
end

endmodule
