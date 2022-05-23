`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/23 12:26:35
// Design Name: 
// Module Name: ps4
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


module ps4(
	input [3:0] req,
	input en,
	output logic [3:0] gnt
);

	always_comb begin
		if (~en) begin
			gnt = 4'b0000;
		end
		else begin
			if (req[3]) begin
				gnt = 4'b1000;
			end
			else if (req[2]) begin
				gnt = 4'b0100;
			end
			else if (req[1]) begin
				gnt = 4'b0010;
			end
			else if (req[0]) begin
				gnt = 4'b0001;
			end
			else begin
				gnt = 4'b0000;
			end
		end
	end

endmodule : ps4
