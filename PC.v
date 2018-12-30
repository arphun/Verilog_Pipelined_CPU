module PC
(
    clk_i,
    start_i,
    stall_i,
    pc_i,
    pc_o
);

input               clk_i;
input               start_i;
input               stall_i;
input   [31:0]      pc_i;
output  [31:0]      pc_o;

reg     [31:0]      pc_o;


always@(posedge clk_i or negedge start_i) begin
    if(~start_i) begin
        pc_o <= 32'b0;
    end
    else begin
        if(start_i && ~stall_i)
            pc_o = pc_i;
        else if (start_i && stall_i)    // stall
            pc_o = pc_o; 
        else
            pc_o = pc_o;
    end
end

endmodule
