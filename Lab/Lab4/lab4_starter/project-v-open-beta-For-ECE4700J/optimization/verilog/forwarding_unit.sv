module forwarding_unit (
	input [4:0] ex_mem_rd,
	input [4:0] mem_wb_rd,
	input [4:0] id_ex_rs1,
	input [4:0] id_ex_rs2,

	output ALU_FORWARD alu_input_select_1,
	output ALU_FORWARD alu_input_select_2

);

	always_comb begin
		alu_input_select_1 = NO_FORWARD;
		alu_input_select_2 = NO_FORWARD;
		if ((ex_mem_rd != `ZERO_REG) && (ex_mem_rd == id_ex_rs1)) begin
			alu_input_select_1 = FROM_EX_MEM;
		end
		else if ((mem_wb_rd != `ZERO_REG) && (mem_wb_rd == id_ex_rs1)) begin
			alu_input_select_1 = FROM_MEM_WB;
		end
		if ((ex_mem_rd != `ZERO_REG) && (ex_mem_rd == id_ex_rs2)) begin
			alu_input_select_2 = FROM_EX_MEM;
		end
		else if ((mem_wb_rd != `ZERO_REG) && (mem_wb_rd == id_ex_rs2)) begin
			alu_input_select_2 = FROM_MEM_WB;
		end
	end

endmodule : forwarding_unit