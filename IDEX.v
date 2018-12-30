module IDEX(
    clk_i,
    WBsig_i,
    MEMsig_i,
    EXsig_i,
    RS1data_i,
    RS2data_i,
    SignExtend_i,
    RS1addr_i,
    RS2addr_i,
    RDaddr_i,
    funct7_i,
    funct3_i,

    WBsig_o,
    MEMsig_o,
    ALUOp_o,
    ALUSrc_o,
    RS1data_o,
    RS2data_o,
    SignExtend_o,
    RS1addr_o,
    RS2addr_o,
    RDaddr_o,
    funct7_o,
    funct3_o,
);
input clk_i;
input [1:0] WBsig_i;
input [2:0] MEMsig_i;
input [2:0] EXsig_i;
input [31:0] RS1data_i, RS2data_i, SignExtend_i;
input [4:0] RS1addr_i, RS2addr_i, RDaddr_i;
input [6:0] funct7_i;
input [2:0] funct3_i;

output [1:0] WBsig_o;
output [2:0] MEMsig_o;
output [1:0] ALUOp_o;
output ALUSrc_o;
output [31:0] RS1data_o, RS2data_o, SignExtend_o;
output [4:0] RS1addr_o, RS2addr_o, RDaddr_o;
output [6:0] funct7_o;
output [2:0] funct3_o;

reg [1:0] WBsig_in_reg;
reg [2:0] MEMsig_in_reg;
reg [2:0] EXsig_in_reg;
reg [31:0] RS1data_in_reg, RS2data_in_reg, SignExtend_in_reg;
reg [4:0] RS1addr_in_reg, RS2addr_in_reg, RDaddr_in_reg;
reg [6:0] funct7_in_reg;
reg [2:0] funct3_in_reg;

reg [1:0] WBsig_out_reg;
reg [2:0] MEMsig_out_reg;
reg [1:0] ALUOp_out_reg;
reg ALUSrc_out_reg;
reg [31:0] RS1data_out_reg, RS2data_out_reg, SignExtend_out_reg;
reg [4:0] RS1addr_out_reg, RS2addr_out_reg, RDaddr_out_reg;
reg [6:0] funct7_out_reg;
reg [2:0] funct3_out_reg;
// for data read when clk is at negative edge
assign WBsig_o = WBsig_out_reg;
assign MEMsig_o = MEMsig_out_reg;
assign ALUOp_o = ALUOp_out_reg;
assign ALUSrc_o = ALUSrc_out_reg;
assign RS1data_o = RS1data_out_reg;
assign RS2data_o = RS2data_out_reg;
assign SignExtend_o = SignExtend_out_reg;
assign RS1addr_o = RS1addr_out_reg;
assign RS2addr_o = RS2addr_out_reg;
assign RDaddr_o = RDaddr_out_reg;
assign funct7_o = funct7_out_reg;
assign funct3_o = funct3_out_reg;

// for data write when clk is at postive edge

always@(posedge clk_i or negedge clk_i) 
begin
    if(clk_i) begin
        //%displayb("clk_i =",clk_i,"\n");
        //%displayb("writing data:\n");
        //%displayb("WBsig_i =",WBsig_i,"\n");
        //%displayb("MEMsig_i =",MEMsig_i,"\n");
        //%displayb("Exsig_i =",EXsig_i,"\n");
        //%displayb("RS1data_i =",RS1data_i,"\n");
        //%displayb("RS2data_i =",RS2data_i,"\n");
        //%displayb("SignEtend_i =",SignExtend_i,"\n");
        //%displayb("RS1addr_i =",RS1addr_i,"\n");
        //%displayb("RS2addr_i =",RS2addr_i,"\n");
        //%displayb("RDaddr =",RDaddr_i,"\n");
        WBsig_in_reg = WBsig_i;
        MEMsig_in_reg = MEMsig_i;
        EXsig_in_reg = EXsig_i;
        RS1data_in_reg = RS1data_i;
        RS2data_in_reg = RS2data_i;
        SignExtend_in_reg = SignExtend_i;
        RS1addr_in_reg = RS1addr_i;
        RS2addr_in_reg = RS2addr_i;
        RDaddr_in_reg = RDaddr_i;
        funct7_in_reg = funct7_i;
        funct3_in_reg = funct3_i;
        
    end
    if(~clk_i)begin
        //%displayb("clk_i =",clk_i,"\n");
        //%displayb("reading data:\n");
        //%displayb("WBsig_o =",WBsig_out_reg,"\n");
        //%displayb("MEMsig_o =",MEMsig_out_reg,"\n");
        //%displayb("ALUOsig_o =",ALUOp_out_reg,"\n");
        //%displayb("ALUSrc_o =",ALUSrc_out_reg,"\n");
        //%displayb("RS1data_o =",RS1data_out_reg,"\n");
        //%displayb("RS2data_o =",RS2data_out_reg,"\n");
        //%displayb("SignEtend_o =",SignExtend_out_reg,"\n");
        //%displayb("RS1addr_o =",RS1addr_out_reg,"\n");
        //%displayb("RS2addr_o =",RS2addr_out_reg,"\n");
        //%displayb("RDaddr_o =",RDaddr_out_reg,"\n");

        WBsig_out_reg = WBsig_in_reg;
        MEMsig_out_reg = MEMsig_in_reg;
        ALUOp_out_reg = EXsig_in_reg[2:1];
        ALUSrc_out_reg = EXsig_in_reg[0];
        RS1data_out_reg = RS1data_in_reg;
        RS2data_out_reg = RS2data_in_reg;
        SignExtend_out_reg = SignExtend_in_reg;
        RS1addr_out_reg = RS1addr_in_reg;
        RS2addr_out_reg = RS2addr_in_reg;
        RDaddr_out_reg = RDaddr_in_reg;
        funct7_out_reg = funct7_in_reg;
        funct3_out_reg = funct3_in_reg;
    end
end

endmodule
