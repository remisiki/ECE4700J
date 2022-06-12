`timescale 1ns/100ps

// This is one stage of an 8 stage (9 depending on how you look at it)
// pipelined multiplier that multiplies 2 64-bit integers and returns
// the low 64 bits of the result.  This is not an ideal multiplier but
// is sufficient to allow a faster clock period than straight *
module mult_stage(
					input clock, reset, start,
					input [63:0] product_in, mplier_in, mcand_in,

					output logic done,
					output logic [63:0] product_out, mplier_out, mcand_out
				);

	parameter stage_num = 8;
	parameter partial_bit_num = 64 / stage_num;

	logic [63:0] prod_in_reg, partial_prod_reg;
	logic [63:0] partial_product, next_mplier, next_mcand;

	assign product_out = prod_in_reg + partial_prod_reg;

	assign partial_product = mplier_in[(partial_bit_num - 1):0] * mcand_in;

	assign next_mplier = {{{partial_bit_num}{1'b0}}, mplier_in[63:partial_bit_num]};
	assign next_mcand = {mcand_in[(63 - partial_bit_num):0], {{partial_bit_num}{1'b0}}};

	//synopsys sync_set_reset "reset"
	always_ff @(posedge clock) begin
		prod_in_reg      <= #1 product_in;
		partial_prod_reg <= #1 partial_product;
		mplier_out       <= #1 next_mplier;
		mcand_out        <= #1 next_mcand;
	end

	// synopsys sync_set_reset "reset"
	always_ff @(posedge clock) begin
		if(reset)
			done <= #1 1'b0;
		else
			done <= #1 start;
	end

endmodule

