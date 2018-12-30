module ALU_Control
(
    funct7_i  ,
    funct3_i  ,
    ALUOp_i   ,
    ALUCtrl_o
);

input   [6:0]  	funct7_i;
input	[2:0]	funct3_i;
input   [1:0]	ALUOp_i;
output  [2:0]   ALUCtrl_o;



reg [2:0]  	tmp_ALUCtrl;

	always@(funct7_i or funct3_i or ALUOp_i) begin


		if (ALUOp_i==2'b00) begin 	//ld , sd 
			tmp_ALUCtrl=3'b001;  	//add
		end
		
		else if (ALUOp_i==2'b01) begin 	// beq
			tmp_ALUCtrl=3'b010; 		//sub
		end
		
		else begin 					//R-type
			if (funct3_i==3'b110)
				tmp_ALUCtrl<=3'b100; //or
			else if (funct3_i==3'b111)
			 	tmp_ALUCtrl<=3'b011; //and
			else if (funct7_i==7'b0100000)
				tmp_ALUCtrl<=3'b010; //sub
			else if (funct7_i==7'b0000001)
				tmp_ALUCtrl<=3'b110; //mul
			else 
				tmp_ALUCtrl<=3'b001; //add
		end
	end
assign ALUCtrl_o=tmp_ALUCtrl;

endmodule
