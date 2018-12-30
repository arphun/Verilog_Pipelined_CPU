module FWD
(
	IDEX_RegRs_i,
	IDEX_RegRt_i,
	EXMEM_RegRd_i,
	EXMEM_RegWr_i,
	MEMWB_RegRd_i,
	MEMWB_RegWr_i,
	Fw1_o,
	Fw2_o
);

input	[4:0] 		IDEX_RegRs_i;
input	[4:0]		IDEX_RegRt_i;
input	[4:0]		EXMEM_RegRd_i;
input				EXMEM_RegWr_i;
input	[4:0]		MEMWB_RegRd_i;
input				MEMWB_RegWr_i;
output	[1:0]		Fw1_o;
output	[1:0]		Fw2_o;

reg	[1:0]		Fw1_o;
reg	[1:0]		Fw2_o;


	always@(IDEX_RegRs_i or IDEX_RegRt_i or EXMEM_RegRd_i or EXMEM_RegWr_i or MEMWB_RegRd_i or MEMWB_RegWr_i ) begin
			// deal with Fw1
			
		if (EXMEM_RegWr_i && EXMEM_RegRd_i && IDEX_RegRs_i == EXMEM_RegRd_i)  // from ALU to Rs  -- Ex hazard
			Fw1_o = 2'b10;				
		else if (MEMWB_RegWr_i && MEMWB_RegRd_i && IDEX_RegRs_i == MEMWB_RegRd_i) // from DM  to Rs  -- MEM hazard
			Fw1_o = 2'b01;
		else
			Fw1_o = 2'b00;

			// deal with Fw2

		if (EXMEM_RegWr_i && EXMEM_RegRd_i && IDEX_RegRt_i == EXMEM_RegRd_i)  // from ALU to Rt  -- Ex hazard
			Fw2_o = 2'b10;		
		else if (MEMWB_RegWr_i && MEMWB_RegRd_i && IDEX_RegRt_i == MEMWB_RegRd_i)  // from DM  to Rt  -- MEM hazard
			Fw2_o = 2'b01;
		else
			Fw2_o = 2'b00;	
	end

endmodule
