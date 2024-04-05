`timescale 1ns/1ns
module ALU_tb;

parameter d_Width = 8;
reg [d_Width-1:0] opA;
reg [d_Width-1:0] opB;
reg [2:0] opcode;
wire [d_Width-1:0] result;
wire carry;
wire overflow;
wire zero;

ALU #(d_Width) dut (
	.opA(opA),
	.opB(opB),
	.opcode(opcode),
	.result(result),
	.carry(carry),
	.zero(zero)		);

//Clock generation for 100MHz system	
reg clk = 0;
always #5 clk = ~clk;

initial begin
	opA = 8'hAA;
	opB = 8'hBB;
	opcode = 3'b000;

  repeat(20) begin
	#10
	
	$display("opA = %h, opB = %h, opcode = %b", opA, opB, opcode);
	case (opcode)
	3'b000: $display("Expected Result: %h", opA + opB);
	3'b001: $display("Expected Result: %h", opA - opB);
	3'b010: $display("Expected Result: %h", opA & opB);
	3'b011: $display("Expected Result: %h", opA | opB);
	3'b100: $display("Expected Result: %h", opA ^ opB);
	3'b101: $display("Expected Result: %h", opA << opB);
	3'b110: $display("Expected Result: %h", opA >> opB);
      default: $display("Expected Result: zero");
	endcase
	
	$display("Actual Result: %h", result);
	
	opA++;
	opB++;
	opcode++;
	end
	#40
	$finish;
	end
   
    initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end

      
endmodule