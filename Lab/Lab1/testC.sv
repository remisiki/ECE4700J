`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/23 12:27:36
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


// module sim();

// 	logic [3:0] req;
// 	logic en;
// 	logic [3:0] gnt;
// 	logic [3:0] tb_gnt;
// 	logic correct;
// 	logic req_up;

// 	ps4 pe4(req, en, gnt, req_up);

// 	assign tb_gnt[3] = en & req[3];
// 	assign tb_gnt[2] = en & req[2] & ~req[3];
// 	assign tb_gnt[1] = en & req[1] & ~req[2] & ~req[3];
// 	assign tb_gnt[0] = en & req[0] & ~req[1] & ~req[2] & ~req[3];
// 	assign correct = (tb_gnt == gnt);

// 	always @(correct)
// 	begin
// 		#2
// 		if(!correct)
// 		begin
// 			$display("@@@ Incorrect at time %4.0f", $time);
// 			$display("@@@ gnt=%b, en=%b, req=%b", gnt , en, req);
// 			$display("@@@ expected result=%b", tb_gnt);
// 			$finish;
// 		end
// 	end

// 	initial 
// 	begin
// 		$dumpvars;
// 		$monitor("Time:%4.0f req:%b en:%b gnt:%b", $time, req, en, gnt);
// 		req = 4'b0000;
// 		en = 1'b1;
// 		#5    
// 		req = 4'b1000;
// 		#5
// 		req = 4'b0100;
// 		#5
// 		req = 4'b0010;
// 		#5
// 		req = 4'b0001;
// 		#5
// 		req = 4'b0101;
// 		#5
// 		req = 4'b0110;
// 		#5
// 		req = 4'b1110;
// 		#5
// 		req = 4'b1111;
// 		#5
// 		en = 0;
// 		#5
// 		req = 4'b0110;
// 		#5
// 		$finish;
// 	end // initial

// endmodule

module sim();

	logic [7:0] req;
	logic en;
	logic [7:0] gnt;
	logic [7:0] tb_gnt;
	logic correct;
	logic req_up;

	ps8 pe8(req, en, gnt, req_up);

	assign tb_gnt[7] = en & req[7];
	assign tb_gnt[6] = en & req[6] & ~req[7];
	assign tb_gnt[5] = en & req[5] & ~req[6] & ~req[7];
	assign tb_gnt[4] = en & req[4] & ~req[5] & ~req[6] & ~req[7];
	assign tb_gnt[3] = en & req[3] & ~req[4] & ~req[5] & ~req[6] & ~req[7];
	assign tb_gnt[2] = en & req[2] & ~req[3] & ~req[4] & ~req[5] & ~req[6] & ~req[7];
	assign tb_gnt[1] = en & req[1] & ~req[2] & ~req[3] & ~req[4] & ~req[5] & ~req[6] & ~req[7];
	assign tb_gnt[0] = en & req[0] & ~req[1] & ~req[2] & ~req[3] & ~req[4] & ~req[5] & ~req[6] & ~req[7];
	assign correct = (tb_gnt == gnt);

	always @(correct)
	begin
		#2
		if(!correct)
		begin
			$display("@@@ Incorrect at time %4.0f", $time);
			$display("@@@ gnt=%b, en=%b, req=%b", gnt , en, req);
			$display("@@@ expected result=%b", tb_gnt);
			$finish;
		end
	end

	initial 
	begin
		$dumpvars;
		$monitor("Time:%4.0f req:%b en:%b gnt:%b", $time, req, en, gnt);
		req = 8'b00000000;
		en = 1'b1;
		#5    
		req = 8'b10000000;
		#5
		req = 8'b01000000;
		#5
		req = 8'b00100000;
		#5
		req = 8'b00010000;
		#5
		req = 8'b01010010;
		#5
		req = 8'b01101111;
		#5
		req = 8'b11100001;
		#5
		req = 8'b11111111;
		#5
		en = 0;
		#5
		req = 8'b01100101;
		#5
		$finish;
	end // initial

endmodule
