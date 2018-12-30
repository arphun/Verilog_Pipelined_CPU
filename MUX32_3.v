module MUX32_3
(
	data1_i,
	data2_i,
	data3_i,
	select_i,
	data_o
);

input	[31:0]		data1_i;
input	[31:0]		data2_i;
input	[31:0]		data3_i;
input	[1:0]		select_i; //from fowording
output 	[31:0]		data_o;

reg		[31:0]		data_o;

	always @(data1_i or data2_i or data3_i or select_i) begin
		data_o = 32'b0;
		if(select_i == 2'b00) begin
			data_o <= data1_i;
		end
		else if(select_i == 2'b01) begin
			data_o <= data2_i;
		end
		else if(select_i == 2'b10) begin
			data_o <= data3_i;
		end
	end

endmodule
