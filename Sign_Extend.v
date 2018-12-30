module Sign_Extend
(
 data_i,
 data_o
);

input [31:0] data_i;
output [31:0] data_o;
reg [31:0] tmp;
assign data_o = tmp;
always@(data_i) begin
                                      // lw addi
  if(data_i[6:0] == 7'b0010011 || data_i[6:0] == 7'b0000011) begin 
     tmp = {{20{data_i[31]}}, data_i[30:20]};
  end
                                      // sd
  else if(data_i[6:0] == 7'b0100011) begin 
     tmp = {{20{data_i[31]}}, data_i[30:25], data_i[11:7]};
  end
                                      // beq
  else if(data_i[6:0] == 7'b1100011) begin 
     tmp = {{20{data_i[31]}}, data_i[7], data_i[30:25], data_i[11:8]};
  end
end

endmodule
