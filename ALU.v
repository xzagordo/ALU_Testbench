module ALU #(parameter d_Width = 8)
	(input [d_Width-1:0] opA,
	 input [d_Width-1:0] opB,
	 input [2:0] opcode,
	 output [d_Width-1:0] result,
	 output carry,
	 output zero);
	 
reg [d_Width-1:0] reghold;
wire [d_Width:0] sum;
wire [d_Width-1:0] diff;
wire [d_Width-1:0] bitwiseAND;
wire [d_Width-1:0] bitwiseOR;
wire [d_Width-1:0] bitwiseXOR;
wire [d_Width-1:0] shiftLEFT;
wire [d_Width-1:0] shiftRIGHT;

always @(*) begin
	case (opcode)
	3'b000: reghold = sum;
	3'b001: reghold = diff;
	3'b010: reghold = bitwiseAND;
	3'b011: reghold = bitwiseOR;
	3'b100: reghold = bitwiseXOR;
	3'b101: reghold = shiftLEFT;
	3'b110: reghold = shiftRIGHT;
	endcase
end

assign sum        = opA + opB;
assign diff       = opA - opB;
assign bitwiseAND = opA & opB;
assign bitwiseOR  = opA | opB;
assign bitwiseXOR = opA ^ opB;
assign shiftLEFT  = opA << opB;
assign shiftRIGHT = opA >> opB;

assign zero = (reghold == 0);
assign carry = (sum[d_Width] != 0);
assign result = reghold;

endmodule

