// See README.md for license details.

package ISR

import chisel3._
import chisel3.iotesters._
import chisel3.stage.ChiselStage
import chisel3.util._

/**

	*/
class mult_stage (val width: Int) extends Module {
	val io = IO(new Bundle {
		val start      = Input(UInt(1.W))
		val product_in        = Input(UInt(64.W))
		val mplier_in        = Input(UInt(64.W))
		val mcand_in        = Input(UInt(64.W))

		val done = Output(UInt(1.W))
		val product_out = Output(UInt(64.W))
		val mplier_out = Output(UInt(64.W))
		val mcand_out = Output(UInt(64.W))
	})

	val prod_in_reg = RegInit(0.U(64.W))
	val partial_prod_reg = RegInit(0.U(64.W))
	val done_reg = RegInit(0.U(1.W))
	val mplier_out_reg = RegInit(0.U(64.W))
	val mcand_out_reg = RegInit(0.U(64.W))

	io.product_out := prod_in_reg + partial_prod_reg
	io.done := done_reg
	io.mplier_out := mplier_out_reg
	io.mcand_out := mcand_out_reg

	prod_in_reg      := io.product_in
	partial_prod_reg := io.mplier_in(width-1, 0) * io.mcand_in
	mplier_out_reg   := Cat(0.U(width.W),io.mplier_in(63, width))
	mcand_out_reg    := Cat(io.mcand_in(63-width, 0),0.U(width.W))
	done_reg         := io.start
}


class mult (val stagenum: Int) extends Module {
	val io = IO(new Bundle {
		val start      = Input(UInt(1.W))
		val mplier        = Input(UInt(64.W))
		val mcand        = Input(UInt(64.W))

		val product = Output(UInt(64.W))
		val done = Output(UInt(1.W))
	})

	val mcand_out = Wire(UInt(64.W))
	val mplier_out =  Wire(UInt(64.W))

	val mult_stage_arr = Seq.fill(stagenum)(Module(new mult_stage(64/stagenum)))

	// wire the head to the inputs
	mult_stage_arr.head.io.start := io.start
	mult_stage_arr.head.io.product_in := 0.U
	mult_stage_arr.head.io.mplier_in := io.mplier
	mult_stage_arr.head.io.mcand_in := io.mcand

	// wire the elements of the queue
	val last = mult_stage_arr.tail.foldLeft(mult_stage_arr.head) { case (prior, next) =>
		next.io.start := prior.io.done
		next.io.product_in := prior.io.product_out
		next.io.mplier_in := prior.io.mplier_out
		next.io.mcand_in := prior.io.mcand_out
		next
	}

	// wire the end of the queue to the outputs
	io.done := last.io.done
	io.product := last.io.product_out
	mcand_out :=  last.io.mcand_out
	mplier_out :=  last.io.mplier_out
}


class ISR extends Module {
	val io = IO(new Bundle {
		val value        = Input(UInt(64.W))
		val result = Output(UInt(32.W))
		val done = Output(UInt(1.W))
	})

	val stored_value = RegInit(io.value)
	val index = RegInit("h80000000".U(32.W))
	val guess = RegInit(0.U(32.W))
	val mult_start = RegInit(0.U(1.W))
	val state = RegInit(0.U(3.W))

	val next_state = Wire(UInt(3.W))
	val next_index = Wire(UInt(32.W))
	val next_guess = Wire(UInt(32.W))
	val square_guess = Wire(UInt(64.W))
	val mult_done = Wire(UInt(1.W))
	val next_mult_start = Wire(UInt(1.W))

	next_mult_start := Mux((state === 0.U || state === 2.U), 1.U, 0.U)
	
	io.result := Mux(state === 4.U, guess, 0.U)
	io.done := Mux(state === 4.U, 1.U, 0.U)

	next_index := Mux(state === 1.U && mult_done === 1.U, index >> 1.U, index)
	next_guess := Mux(state === 0.U || state === 2.U, guess + index, Mux(state === 1.U && mult_done === 1.U && square_guess > stored_value, guess - index, guess))

	val mult_pipeline = Module(new mult(8))
	mult_pipeline.io.mcand := Cat(0.U(32.W), guess)
	mult_pipeline.io.mplier := Cat(0.U(32.W), guess)
	mult_pipeline.io.start := mult_start
	square_guess := mult_pipeline.io.product
	mult_done := mult_pipeline.io.done

	// Next state logic
	next_state := 0.U
	switch (state) {
		is (0.U) {
			next_state := 1.U
		}
		is (1.U) {
			when(mult_done === 1.U) {
				when(index === 1.U) {
					next_state := 3.U
				} otherwise {
					next_state := 2.U
				}
			} otherwise {
				next_state := 1.U
			}
		}
		is (2.U) {
			next_state := 1.U
		}
		is (3.U) {
			next_state := 4.U
		}
		is (4.U) {
			next_state := 4.U
		} 
	}

	mult_start := next_mult_start
	state := next_state
	guess := next_guess
	index := next_index

}

class TesterBehavior(dut: ISR) extends PeekPokeTester(dut) {
	poke(dut.io.value, 9.U)
	step(1)
	println("Cycle: 0" + " Result is: done:" + peek(dut.io.done).toString 
						+ " product: " + peek(dut.io.result).toString )          
	for (a <- 1 until 400) {
		step(1)
		println("Cycle:" + a 
						+ " Result is: done:" + peek(dut.io.done).toString 
						+ " product: " + peek(dut.io.result).toString )
	}
}

object TesterBehavior extends App {
	chisel3.iotesters.Driver(() => new ISR()) { c =>
		new  TesterBehavior(c)
	}
}

object mult_stage_Driver extends App {
	(new ChiselStage).emitVerilog(new mult_stage(8))
}

object pipeline_mult_Driver extends App {
	(new ChiselStage).emitVerilog(new mult(8))
}

object pipeline_ISR_Driver extends App {
	(new ChiselStage).emitVerilog(new ISR)
}