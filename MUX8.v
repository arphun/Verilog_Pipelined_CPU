module MUX8
(
    data1_i,
    select_i,
    WB_o,
    M_o,
    EX_o
);

input	 [7:0]		data1_i;
input	    			select_i;
output [2:0]		EX_o;
output [2:0]    M_o;
output [1:0]    WB_o;

reg	 	 [2:0]		EX_o;
reg    [2:0]    M_o;
reg    [1:0]    WB_o;

always@(data1_i or select_i) begin

      if(select_i) begin  //HDU ==>stall
          EX_o  = 3'd0;
          M_o   = 3'd0;
          WB_o  = 2'd0;
      end

      else begin 
		      EX_o  = data1_i[7:5];
          M_o   = data1_i[4:2];
          WB_o  = data1_i[1:0];
      end
  end

endmodule
