`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/22 15:15:09
// Design Name: 
// Module Name: sim
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


module sim();

	logic clock, reset, A, B;
	logic grant_to_A, grant_to_B;

	arbiter top(
		.clock(clock),
		.reset(reset),
		.A(A),
		.B(B),
		.grant_to_A(grant_to_A),
		.grant_to_B(grant_to_B)
	);

	always begin
		#100 clock = ~clock;
	end

	initial begin

		$monitor("Time:%4.0f clock:%b reset:%b A:%b B:%b grant_to_A:%b grant_to_B:%b", 
						 $time, clock, reset, A, B, grant_to_A, grant_to_B);

		clock = 1'b0;
		reset = 1'b1;
		A = 1'b0;
		B = 1'b0;
		//TODO: start your test here
		#100 reset = 1'b0;
		#100 A = 1'b1;
		#200 B = 1'b1;
		     A = 1'b0;
		#400 B = 1'b0;
		#200 A = 1'b1;
		     B = 1'b1;
		#300 B = 1'b0;
		#200 A = 1'b0;

	end

	initial begin
		#2000 $finish;
	end

endmodule
