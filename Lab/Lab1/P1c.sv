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


module ps2 (
	input [1:0] req,
	input en,
	output logic [1:0] gnt,
	output logic req_up
);

	assign gnt[1] = en & req[1];
	assign gnt[0] = en & ~req[1] & req[0];
	assign req_up = req[1] | req[0];

endmodule : ps2

module ps4 (
	input [3:0] req,
	input en,
	output logic [3:0] gnt,
	output logic req_up
);

	logic [1:0] gnt_left, gnt_right, gnt_top;
	logic req_up_left, req_up_right;
	ps2_p1c left(.req(req[3:2]), .en(en), .gnt(gnt_left), .req_up(req_up_left));
	ps2_p1c right(.req(req[1:0]), .en(en), .gnt(gnt_right), .req_up(req_up_right));
	ps2_p1c top(.req({req_up_left, req_up_right}), .en(en), .gnt(gnt_top), .req_up(req_up));
	assign gnt[3:2] = (gnt_top[1]) ? gnt_left : 2'b00;
	assign gnt[1:0] = (gnt_top[0]) ? gnt_right : 2'b00;

endmodule : ps4

module ps8 (
	input [7:0] req,
	input en,
	output logic [7:0] gnt,
	output logic req_up
);

	logic [3:0] gnt_left, gnt_right;
	logic [1:0] gnt_top;
	logic req_up_left, req_up_right;
	ps4_p1c left(.req(req[7:4]), .en(en), .gnt(gnt_left), .req_up(req_up_left));
	ps4_p1c right(.req(req[3:0]), .en(en), .gnt(gnt_right), .req_up(req_up_right));
	ps2_p1c top(.req({req_up_left, req_up_right}), .en(en), .gnt(gnt_top), .req_up(req_up));
	assign gnt[7:4] = (gnt_top[1]) ? gnt_left : 2'b00;
	assign gnt[3:0] = (gnt_top[0]) ? gnt_right : 2'b00;

endmodule : ps8
