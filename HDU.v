module HDU
(
    start_i,
	instr_i,
	ID_EX_RegRd_i,
	MemRead_i,
	PC_o,
	IF_ID_o,
	mux8_o
);

input	[31:0]		instr_i;
input	[4:0]		ID_EX_RegRd_i;
input				MemRead_i;
input               start_i;
output				PC_o;
output				IF_ID_o;
output				mux8_o;

reg 	PC_o;
reg 	IF_ID_o;
reg 	mux8_o;


always@(start_i, instr_i, ID_EX_RegRd_i, MemRead_i)begin
    
	if (MemRead_i && ( ID_EX_RegRd_i == instr_i[24:20] || ID_EX_RegRd_i == instr_i[19:15] )) begin 
		// ID/EX memread && ID/EX RD == IF/ID (RD || Rs) ==>stall
		PC_o = 1'b1;
		IF_ID_o = 1'b1;
		mux8_o = 1'b1;
	end	
	else begin
		PC_o = 1'b0;
		IF_ID_o = 1'b0;
		mux8_o = 1'b0;
	end

    //$displayb("PC_stall =:",PC_o," IFID_o =:",IF_ID_o,"\n");
end

endmodule
