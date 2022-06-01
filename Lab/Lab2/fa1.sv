`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/01 18:32:19
// Design Name: 
// Module Name: fa1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module full_adder_1bit(
	input A, B, carry_in,
	output S, carry_out
);

	logic w1, w2, w3, w4;

	assign w1 = B ^ carry_in;
	assign w2 = A & carry_in;
	assign w3 = A & B;
	assign w4 = B & carry_in;
	assign S = A ^ w1;
	assign carry_out = (w2 | w3 | w4);

endmodule 
