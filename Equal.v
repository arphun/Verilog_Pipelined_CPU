module EQ(
	data1_i,
	data2_i,
	equal_o
);

input [31:0] data1_i, data2_i;
output equal_o;

//assign equal_o = (data1_i == data2_i)? 1 : 0 ;
reg tmp;
assign equal_o = tmp;
always @(data1_i or data2_i) begin
	if(data1_i == data2_i) 
		tmp = 1;
	else 
		tmp = 0;
end

endmodule
