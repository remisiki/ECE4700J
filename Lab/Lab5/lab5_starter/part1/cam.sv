module CAM #(parameter SIZE=8) (

	input clock, reset,
	input enable,

	input COMMAND command,

	input [31:0] data,

	input [$clog2(SIZE)-1:0] write_idx,

	output logic [$clog2(SIZE)-1:0] read_idx,
	output logic hit
	);

	// Fill in design here
	logic [31:0] memory [(SIZE - 1):0];
	logic valid [(SIZE - 1):0];

	always_ff @(posedge clock) begin
		if (reset) begin
			for (int i = 0; i < SIZE; i++) begin
				valid[i] <= #1 1'b0;
			end
		end
		if (~reset && enable) begin
			if (command == WRITE && write_idx < SIZE) begin
				memory[write_idx] <= #1 data;
				valid[write_idx] <= #1 1'b1;
			end
		end
	end

	always_comb begin
		hit = 1'b0;
		read_idx = 0;
		if (~reset && enable && command == READ) begin
			for (int i = 0; i < SIZE; i++) begin
				if (valid[i] && memory[i] == data) begin
					read_idx = i;
					hit = 1'b1;
					break;
				end
			end
		end
	end

endmodule
