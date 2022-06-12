`timescale 1ns/100ps
`define DEBUG

typedef enum logic [2:0] {
	INIT,
	SET_BIT,
	MULT,
	CMP,
	DONE,
	HOGE[0:2]
} ISR_state;

module ISR (
	input reset,
	input [63:0] value,
	input clock,
	output logic [31:0] result,
	output logic done
	`ifdef DEBUG
	,
	output logic [5:0] i,
	output ISR_state state, next_state,
	output logic [63:0] guess_result_reg
	`endif
);

	logic start;
	logic [63:0] value_reg;
	logic guess_done;

	`ifndef DEBUG
	ISR_state state, next_state;
	logic [63:0] guess_result_reg;

	logic [5:0] i;
	`endif

	mult m0(
		.clock(clock),
		.reset(reset),
		.mcand({32'b0, result}),
		.mplier({32'b0, result}),
		.start(start),
		.product(guess_result_reg),
		.done(guess_done)
	);

	always_comb begin
		case (state)
			INIT: begin
				start = 1'b0;
				done = 1'b0;
				result = 32'b0;
				next_state = SET_BIT;
			end
			SET_BIT: begin
				if (i > 0) begin
					result[i - 1] = 1'b1;
					// result = result | (1 << (i - 1));
					start = 1'b1;
					next_state = MULT;
				end
				else begin
					next_state = DONE;
				end
			end
			MULT: begin
				start = 1'b0;
				if (guess_done) begin
					next_state = CMP;
				end
				else begin
					next_state = state;
				end
			end
			CMP: begin
				if (guess_result_reg == value_reg) begin
					next_state = DONE;
				end
				else if (guess_result_reg > value_reg) begin
					// result[i - 1] = 1'b0;
					result = result & ~(1 << (i - 1));
					next_state = SET_BIT;
				end
				else begin
					next_state = SET_BIT;
				end
			end
			DONE: begin
				done = 1'b1;
				next_state = INIT;
			end
			default: begin
				next_state = INIT;
				start = 1'b0;
				done = 1'b0;
				result = 32'b0;
			end
		endcase
		// $display("%d %b %b", i, state, next_state);
	end

	always_ff @(posedge clock) begin
		if (reset) begin
			value_reg <= #1 value_reg;
			state <= #1 INIT;
		end
		else begin
			value_reg <= #1 value;
			state <= #1 next_state;
		end
		if (state == CMP) begin
			i <= #1 i - 1;
		end
		else if (reset) begin
			i <= #1 6'd32;
		end
		else begin
			i <= #1 i;
		end
	end

endmodule : ISR