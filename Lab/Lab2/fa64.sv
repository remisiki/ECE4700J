`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/01 19:36:32
// Design Name: 
// Module Name: fa64
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


module full_adder_64bit( A, B, carry_in, S, carry_out );
	input  [63:0] A, B;
	input         carry_in;
	output [63:0] S;
	output        carry_out;

	logic  [63:0] S;
	logic         carry_out;

	// Implement a 64-bit adder using array instantiated 1-bit adders
	// ASSUME: bit 63 of 63:0 is the MSB

	// ----FILL IN HERE----

	logic [62:0] carries;
	full_adder_1bit adders [63:0] (
		.A(A),
		.B(B),
		.carry_in({carries, carry_in}),
		.S(S),
		.carry_out({carry_out, carries})
	);

	// ----------------------

endmodule 
