module hazard_detection_unit (
	input id_ex_rd_mem,
	input id_ex_wr_mem,
	input [4:0] id_ex_rd,
	input [4:0] if_id_rs1,
	input [4:0] if_id_rs2,
	input has_branch,

	output logic id_ex_enable,
	output logic if_id_enable,
	output logic has_data_hazard,
	output logic has_structure_hazard

);
	always_comb begin
		id_ex_enable = 1'b1;
		if_id_enable = 1'b1;
		has_data_hazard = 1'b0;
		has_structure_hazard = 1'b0;
		if ((id_ex_rd_mem) && (id_ex_rd != `ZERO_REG) && ((id_ex_rd == if_id_rs1) || (id_ex_rd == if_id_rs2))) begin
			id_ex_enable = 1'b0;
			if_id_enable = 1'b0;
			has_data_hazard = 1'b1;
		end
		if ((id_ex_rd_mem || id_ex_wr_mem) && (~has_branch)) begin
			has_structure_hazard = 1'b1;
		end
	end
endmodule : hazard_detection_unit