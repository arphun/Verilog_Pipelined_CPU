module Control
(   
    Op_i,
    Control_o,
);

input	 [6:0]	Op_i;
output [7:0]	Control_o;


reg   [2:0]    Ex;     
reg   [2:0]    Mem;
reg   [1:0]    Wb;

assign Control_o = {{Ex},{Mem},{Wb}};

always@(Op_i) begin
                                      // R-type
  if(Op_i == 7'b0110011) begin
    Ex = 3'b100;
    Mem = 3'b000;
    Wb = 2'b10;
  end
                                      // lw 
  else if (Op_i == 7'b0000011) begin 
    Ex = 3'b001;
    Mem = 3'b010;
    Wb = 2'b11;
  end
  else if (Op_i == 7'b0010011) begin //addi
    Ex = 3'b001;
    Mem = 3'b000;
    Wb = 2'b10;
  end
                                      // sd
  else if (Op_i == 7'b0100011) begin 
    Ex = 3'b001;
    Mem = 3'b001;
    Wb = 2'b00;
  end
                                      // beq
  else if (Op_i == 7'b1100011) begin 
    Ex = 3'b010;
    Mem = 3'b100;
    Wb = 2'b00;
  end
  else if (Op_i == 7'b0000000) begin
    Ex = 3'b000;
    Mem = 3'b000;
    Wb = 2'b00;
  end
end
endmodule
