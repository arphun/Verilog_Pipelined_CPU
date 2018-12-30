module AND
(
   data1_i, //是否branch
   data2_i, //是否equal
   and_o
);

input	data1_i, data2_i;
output 	and_o;

assign  and_o = data1_i & data2_i;

endmodule
