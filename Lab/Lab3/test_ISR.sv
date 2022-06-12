`define HALF_CYCLE 250

`timescale 1ns/100ps

module testbench();

	logic [63:0] value, guess;
	logic quit, clock, reset;

	logic [31:0] result;
	logic done;
	logic [2:0] state, next_state;
	logic [5:0] i;

	wire correct = ((result * result <= value) & ((result + 1) * (result + 1) > value)) | ~done;


	ISR i0 (
		.reset(reset),
		.value(value),
		.clock(clock),
		.result(result),
		.done(done),
		.state(state),
		.next_state(next_state),
		.i(i),
		.guess_result_reg(guess)
	);

	always @(posedge clock) #(`HALF_CYCLE-5) if (!correct) begin 
			$display("Incorrect at time %4.0f", $time);
			$display("result = %h", result);
			$display("@@@Failed");
			$finish;
	end

	always begin
		#`HALF_CYCLE;
		clock = ~clock;
	end

	// Some students have had problems just using "@(posedge done)" because their
	// "done" signals glitch (even though they are the output of a register). This
	// prevents that by making sure "done" is high at the clock edge.
	task wait_until_done;
		forever begin : wait_loop
			@(posedge done);
			@(negedge clock);
			if(done) disable wait_until_done;
		end
	endtask



	initial begin
		$dumpvars;
		$monitor("Time:%4.0f done:%b value:%h result:%h",$time,done,value,result);
		clock = 0;
		value = 1001;
		reset = 1;
		#2000;
		@(negedge clock);
		reset = 0;
		wait_until_done();

		reset = 1;
		value = 25;
		@(negedge clock);
		reset = 0;
		wait_until_done();

		reset = 1;
		value = 26;
		@(negedge clock);
		reset = 0;
		wait_until_done();

		reset = 1;
		value = 0;
		@(negedge clock);
		reset = 0;
		wait_until_done();

		reset = 1;
		value = 1;
		@(negedge clock);
		reset = 0;
		wait_until_done();

		// quit = 0;
		// quit <= #100000 1;
		// while (~quit) begin
		// 	value = {$random, $random};
		// 	@(posedge clock);
		// 	#100 reset = 1;
		// 	@(negedge clock);
		// 	reset = 0;
		// 	wait_until_done();
		// end
		$display("@@@Passed");
		$finish;
	end

endmodule



  
  
