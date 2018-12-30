module CPU
(
        clk_i,
        rst_i,
        start_i
);

input clk_i;
input rst_i;
input start_i;

// Example format:  wire [31 : 0  ] w_IFID_to_mux
wire	[31:0]		w_addr_adder_to_MUX_PC;
wire	[31:0]		w_PC_out; 		// to  instruction memory, adder
wire	[31:0]		w_instruction_to_IFID;	//pass the instruction
wire	[31:0]		w_PC_adder_to_MUX_PC;
wire	[31:0]		w_IFID_to_addr_adder;	//pass the PC to addr_adder
wire	[31:0]		w_IFID_addr_out;		//pass the inst_addr out
wire			w_IF_Flush;

wire	[31:0]		w_Reg_RS_out;		//pass the RS1 to IDEX and EQ
wire	[31:0]		w_Reg_RT_out;		//pass the RS2 to IDEX and EQ

wire	[31:0]		w_IDEX_to_FWD1;		//pass the RS1 to FWD1;
wire	[31:0]		w_IDEXRt_to_FWD2;	//pass the RT to FWD2;
wire	[31:0]		w_IDEXimm_to_MUXSrc;	//pass the imm to MUXsrc;
wire	[1:0]		w_IDEX_WB_to_EXMEM;	//pass the WB signal;
wire	[2:0]		w_IDEX_MEM_to_EXMEM;	//pass the MEM signal;
wire	[1:0]		w_IDEX_ALUOp_to_ALUcontrol;
wire			w_IDEX_ALUSrc_to_ALUSrcMUX;
wire	[4:0]		w_IDEX_RS_addr_out;
wire	[4:0]		w_IDEX_RT_addr_out;
wire	[6:0]		w_IDEX_funct7_to_ALUcontrol;
wire	[2:0]		w_IDEX_funct3_to_ALUcontrol;
wire	[4:0]		w_IDEX_RD_addr_to_EXMEM;

wire	[4:0]		w_EXMEM_Rd_addr_out;
wire	[31:0]		w_EXMEM_RT_data_to_data_memory;
wire	[31:0]		w_EXMEM_ALU_data_out;
wire	[1:0]		w_EXMEM_WB_to_MEMWB;
wire			w_EXMEM_branch_out;
wire			w_EXMEM_MemRead_out;
wire			w_EXMEM_MemWrite_out;

wire	[4:0]		w_MEMWB_Rd_addr_out;
wire	[31:0]		w_MEMWB_ALU_data_to_MUX_WB;
wire	[31:0]		w_MEMWB_Memdata_to_MUX_WB;
wire			w_MEMWB_RegWr_out;
wire			w_MEMWB_MemToReg_out;

wire	[31:0]		w_SignExtend_out;		//pass SignExtend out to sll and IDEX

wire	[31:0]		w_shiftleft_to_adder;

wire	[7:0]		w_Control_to_mux8;

wire	[1:0]		w_signal_fw1;
wire	[1:0]		w_signal_fw2;

wire			w_HDU_to_PC;
wire			w_HDU_to_IFID;
wire			w_HDU_to_mux8;

wire	[31:0]		w_ALUSrcMUX_RT_to_ALU;
wire	[2:0]		w_ALUcontrol_to_ALU;
wire	[31:0]		w_ALU_output_to_EXMEM;

wire	[31:0]		w_MUX_PC_to_PC;

wire	[1:0]		w_MUX8_WB_to_IDEX;
wire	[2:0]		w_MUX8_MEM_to_IDEX;
wire	[2:0]		w_MUX8_EX_to_IDEX;

wire	[31:0]		w_MUX_FWD1_to_ALU;
wire	[31:0]		w_MUX_FWD2_to_MUXSrc;

wire	[31:0]		w_MUX_WB_out;

wire			w_EQ_to_AND;
wire	[31:0]		w_DataMemory_data_to_EXMEM;

IFID IFID(
    .clk_i      (clk_i),
    .PC_i       (w_PC_out),
    .inst_i     (w_instruction_to_IFID),
    .Stall_i    (w_HDU_to_IFID),
    .Flush_i    (w_IF_Flush),        
    .PC_o       (w_IFID_to_addr_adder),
    .inst_o     (w_IFID_addr_out)
);

IDEX IDEX(
    .clk_i          (clk_i),
    .WBsig_i        (w_MUX8_WB_to_IDEX),
    .MEMsig_i     (w_MUX8_MEM_to_IDEX),
    .EXsig_i        (w_MUX8_EX_to_IDEX),

    .RS1data_i		(w_Reg_RS_out),
    .RS2data_i		(w_Reg_RT_out),
    .SignExtend_i	(w_SignExtend_out),
    .RS1addr_i		(w_IFID_addr_out[19:15]),
    .RS2addr_i		(w_IFID_addr_out[24:20]),
    .RDaddr_i		(w_IFID_addr_out[11:7]),
    .funct7_i		(w_IFID_addr_out[31:25]),
    .funct3_i		(w_IFID_addr_out[14:12]),

    .WBsig_o        	(w_IDEX_WB_to_EXMEM),
    .MEMsig_o       	(w_IDEX_MEM_to_EXMEM),
    .ALUOp_o        	(w_IDEX_ALUOp_to_ALUcontrol),
    .ALUSrc_o       	(w_IDEX_ALUSrc_to_ALUSrcMUX),
    .RS1data_o      	(w_IDEX_to_FWD1),
    .RS2data_o      	(w_IDEXRt_to_FWD2),
    .SignExtend_o   	(w_IDEXimm_to_MUXSrc),
    .RS1addr_o      	(w_IDEX_RS_addr_out),
    .RS2addr_o      	(w_IDEX_RT_addr_out),
    .RDaddr_o       	(w_IDEX_RD_addr_to_EXMEM),
    .funct7_o		(w_IDEX_funct7_to_ALUcontrol),
    .funct3_o		(w_IDEX_funct3_to_ALUcontrol)

);

EXMEM EXMEM(
    .clk_i          (clk_i),
    .WBsig_i        (w_IDEX_WB_to_EXMEM),
    .MEMsig_i       (w_IDEX_MEM_to_EXMEM),
    .ALUdata_i      (w_ALU_output_to_EXMEM),
    .RS2data_i      (w_MUX_FWD2_to_MUXSrc),
    .RDaddr_i       (w_IDEX_RD_addr_to_EXMEM),

    .WBsig_o        (w_EXMEM_WB_to_MEMWB),
    .Branch_o       (w_EXMEM_Branch_out),
    .MemRead_o      (w_EXMEM_MemRead_out),
    .MemWrite_o     (w_EXMEM_MemWrite_out),
    .ALUdata_o      (w_EXMEM_ALU_data_out),
    .RS2data_o      (w_EXMEM_RT_data_to_data_memory),
    .RDaddr_o       (w_EXMEM_Rd_addr_out)
);

MEMWB MEMWB(
    .clk_i          (clk_i),
    .WBsig_i         (w_EXMEM_WB_to_MEMWB),
    .Memdata_i       (w_DataMemory_data_to_EXMEM),
    .ALUdata_i       (w_EXMEM_ALU_data_out),
    .RDaddr_i        (w_EXMEM_Rd_addr_out),

    .RegWrite_o      (w_MEMWB_RegWr_out),
    .MemToReg_o      (w_MEMWB_MemToReg_out),
    .Memdata_o       (w_MEMWB_Memdata_to_MUX_WB),
    .ALUdata_o       (w_MEMWB_ALU_data_to_MUX_WB),
    .RDaddr_o        (w_MEMWB_Rd_addr_out)
);

FWD FWD(
	.IDEX_RegRs_i	(w_IDEX_RS_addr_out),
	.IDEX_RegRt_i	(w_IDEX_RT_addr_out),
	.EXMEM_RegRd_i	(w_EXMEM_Rd_addr_out),
	.EXMEM_RegWr_i	(w_EXMEM_WB_to_MEMWB[1]),			
	.MEMWB_RegRd_i	(w_MEMWB_Rd_addr_out),
	.MEMWB_RegWr_i	(w_MEMWB_RegWr_out),
	.Fw1_o	(w_signal_fw1),
	.Fw2_o	(w_signal_fw2)
);

HDU HDU(
    .start_i        (start_i),
    .instr_i		(w_IFID_addr_out),
	.ID_EX_RegRd_i	(w_IDEX_RD_addr_to_EXMEM),
	.MemRead_i		(w_IDEX_MEM_to_EXMEM[1]),
	.PC_o			(w_HDU_to_PC),
	.IF_ID_o		(w_HDU_to_IFID),
	.mux8_o		(w_HDU_to_mux8)
);

ALU_Control ALU_Control(
   . funct7_i  		(w_IDEX_funct7_to_ALUcontrol) ,	// inst[31:25]
    .funct3_i		(w_IDEX_funct3_to_ALUcontrol),	//inst[14:12]
    .ALUOp_i  		(w_IDEX_ALUOp_to_ALUcontrol) ,	//from IDEX
    .ALUCtrl_o		(w_ALUcontrol_to_ALU)	//to alu
);

ALU ALU(	
  .data1_i	(w_MUX_FWD1_to_ALU),
  .data2_i	(w_ALUSrcMUX_RT_to_ALU),
  .ALUCtrl_i	(w_ALUcontrol_to_ALU),
  .data_o	(w_ALU_output_to_EXMEM)
);

AND AND(
   .data1_i	(w_Control_to_mux8[4]), //是否branch
   .data2_i	(w_EQ_to_AND), //是否equal
   .and_o	(w_IF_Flush)
);

Control Control
(   
    .Op_i		(w_IFID_addr_out[6:0]),
    .Control_o	(w_Control_to_mux8)
);

Data_Memory Data_Memory
(
    .addr_i		(w_EXMEM_ALU_data_out), 
    .data_i		(w_EXMEM_RT_data_to_data_memory),
    .MemWrite_i	(w_EXMEM_MemWrite_out),
    .MemRead_i	(w_EXMEM_MemRead_out),
    .data_o		(w_DataMemory_data_to_EXMEM)
);

EQ EQ(
	.data1_i	(w_Reg_RS_out),
	.data2_i	(w_Reg_RT_out),
	.equal_o	(w_EQ_to_AND)
);

PC PC
(
    .clk_i		(clk_i),
    .start_i		(start_i),
    .stall_i		(w_HDU_to_PC),
    .pc_i			(w_MUX_PC_to_PC),
    .pc_o		(w_PC_out)
);

Registers Registers
(
    .clk_i		(clk_i),
    .RSaddr_i		(w_IFID_addr_out[19:15] ),
    .RTaddr_i		(w_IFID_addr_out[24:20] ),
    .RDaddr_i		(w_MEMWB_Rd_addr_out), 
    .RDdata_i		(w_MUX_WB_out),
    .RegWrite_i		(w_MEMWB_RegWr_out), 
    .RSdata_o		(w_Reg_RS_out), 
    .RTdata_o		(w_Reg_RT_out) 
);

Sign_Extend Sign_Extend
(
    .data_i		(w_IFID_addr_out), 
    .data_o	    (w_SignExtend_out)
);
Shift_left Shift_left(
.data_i		(w_SignExtend_out),
	.data_o	(w_shiftleft_to_adder)
);

MUX8 MUX8(
    .data1_i		(w_Control_to_mux8),	// from control
    .select_i		(w_HDU_to_mux8),		// from HDU
    .WB_o		(w_MUX8_WB_to_IDEX),		// to ID/EX
    .M_o		(w_MUX8_MEM_to_IDEX),		// to ID/EX
    .EX_o		(w_MUX8_EX_to_IDEX)		// to ID/EX
);

MUX32 MUX_PC(
    .data1_i		(w_PC_adder_to_MUX_PC),
    .data2_i		(w_addr_adder_to_MUX_PC),
    .select_i		(w_IF_Flush),
    .data_o		(w_MUX_PC_to_PC)     
);

MUX32 MUX_ALUSrc(
    .data1_i    	(w_MUX_FWD2_to_MUXSrc), // from FWD2
    .data2_i    	(w_IDEXimm_to_MUXSrc), // from Sign_Extend
    .select_i   	(w_IDEX_ALUSrc_to_ALUSrcMUX), // from IDEX
    .data_o     	(w_ALUSrcMUX_RT_to_ALU)
);

MUX32 MUX_WB(
    .data1_i		(w_MEMWB_ALU_data_to_MUX_WB), 
    .data2_i		(w_MEMWB_Memdata_to_MUX_WB), //from data_memory
    .select_i		(w_MEMWB_MemToReg_out),   
    .data_o		(w_MUX_WB_out)     
);

MUX32_3 MUX_FWD1(
  .data1_i	(w_IDEX_to_FWD1),	//from rs
  .data2_i	(w_MUX_WB_out),		//from MUX_WB
  .data3_i	(w_EXMEM_ALU_data_out),		//from EX/MEM alu_out
  .select_i	(w_signal_fw1),	//from FWD signal 1
  .data_o	(w_MUX_FWD1_to_ALU)		// to ALU
);

MUX32_3 MUX_FWD2(
  .data1_i	(w_IDEXRt_to_FWD2),	//from FWD2
  .data2_i	(w_MUX_WB_out),		//from MUX_WB
  .data3_i	(w_EXMEM_ALU_data_out),		//from EX/MEM alu_out
  .select_i	(w_signal_fw2),	//from FWD signal 2
  .data_o	(w_MUX_FWD2_to_MUXSrc)		//to ALU
);



Adder PC_Adder(
    .data1_i	(w_PC_out), 
    .data2_i	(32'd4), 
    .data_o	    (w_PC_adder_to_MUX_PC)
);

Adder addr_Adder(
.data1_i	(w_shiftleft_to_adder), 
.data2_i	(w_IFID_to_addr_adder), 
.data_o	(w_addr_adder_to_MUX_PC)
);

Instruction_Memory Instruction_Memory(
    .addr_i		(w_PC_out), 
    .instr_o	(w_instruction_to_IFID)
);

endmodule
