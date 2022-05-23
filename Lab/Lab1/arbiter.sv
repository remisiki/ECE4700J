`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/22 14:52:13
// Design Name: 
// Module Name: arbiter
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


module arbiter (
	input clock, reset, A, B,
	output grant_to_A, grant_to_B
	
);

	logic [1:0] state;
	logic [1:0] next_state;

	always_ff @(posedge clock) begin
		if (~reset) begin
			state <= next_state;
		end else begin
			state <= 2'b01;
		end
	end

	always_comb begin
		case (state)
			2'b00: begin
				if (A) begin
					next_state <= state;
				end
				else begin
					next_state <= 2'b01;
				end
			end
			2'b01: begin
				if (A) begin
					next_state <= 2'b00;
				end
				else if (B) begin
					next_state <= 2'b10;
				end
				else begin
					next_state <= state;
				end
			end
			2'b10: begin
				if (B) begin
					next_state <= state;
				end
				else begin
					next_state <= 2'b01;
				end
			end
			default: next_state <= 2'b01;
		endcase
	end

	assign grant_to_A = (state == 2'b00);
	assign grant_to_B = (state == 2'b10);

endmodule : arbiter
