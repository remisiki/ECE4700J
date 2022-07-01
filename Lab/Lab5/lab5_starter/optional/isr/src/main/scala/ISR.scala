// See README.md for license details.

package ISR

import chisel3._
import chisel3.iotesters._
import chisel3.stage.ChiselStage
import chisel3.util._

import scala.math
import scala.util.Random

class mult_stage (val width: Int) extends Module {
	val io = IO(new Bundle {
		val start = Input(UInt(1.W))
		val product_in = Input(UInt(64.W))
		val mplier_in = Input(UInt(64.W))
		val mcand_in = Input(UInt(64.W))

		val done = Output(UInt(1.W))
		val product_out = Output(UInt(64.W))
		val mplier_out = Output(UInt(64.W))
		val mcand_out = Output(UInt(64.W))
	})

	val productInRegister = RegInit(0.U(64.W))
	val partialProductRegister = RegInit(0.U(64.W))
	val doneRegister = RegInit(0.U(1.W))
	val nextMplier = RegInit(0.U(64.W))
	val nextMcand = RegInit(0.U(64.W))

	nextMplier := Cat(0.U(width.W), io.mplier_in(63, width))
	nextMcand := Cat(io.mcand_in((63 - width), 0), 0.U(width.W))

	productInRegister := io.product_in
	partialProductRegister := io.mplier_in(width - 1, 0) * io.mcand_in
	doneRegister := io.start

	io.product_out := productInRegister + partialProductRegister
	io.mplier_out := nextMplier
	io.mcand_out := nextMcand
	io.done := doneRegister

}


class pipe_mult (val stagenum: Int) extends Module {
	val io = IO(new Bundle {
		val start = Input(UInt(1.W))
		val mplier = Input(UInt(64.W))
		val mcand = Input(UInt(64.W))

		val product = Output(UInt(64.W))
		val done = Output(UInt(1.W))
	})

	val mcandOut = Wire(UInt(64.W))
	val mplierOut = Wire(UInt(64.W))

	val internalProducts = Wire(Vec(stagenum - 1, UInt(64.W)))
	val internalMcands = Wire(Vec(stagenum - 1, UInt(64.W)))
	val internalMpliers = Wire(Vec(stagenum - 1, UInt(64.W)))
	val internalDones = Wire(Vec(stagenum - 1, UInt(1.W)))
	val mstage = Array.fill(stagenum)(Module(new mult_stage(64 / stagenum)).io)

	for (i <- 0 until stagenum) {
		if (i == 0) {
			// First stage
			mstage(i).product_in := 0.U(64.W)
			mstage(i).mplier_in := io.mplier
			mstage(i).mcand_in := io.mcand
			mstage(i).start := io.start
		}
		else {
			mstage(i).product_in := internalProducts(i - 1)
			mstage(i).mplier_in := internalMpliers(i - 1)
			mstage(i).mcand_in := internalMcands(i - 1)
			mstage(i).start := internalDones(i - 1)
		}
		if (i == stagenum - 1) {
			// Last stage
			io.product := mstage(i).product_out
			io.done := mstage(i).done
			mplierOut := mstage(i).mplier_out
			mcandOut := mstage(i).mcand_out
		}
		else {
			internalProducts(i) := mstage(i).product_out
			internalDones(i) := mstage(i).done
			internalMpliers(i) := mstage(i).mplier_out
			internalMcands(i) := mstage(i).mcand_out
		}
	}

}

object State extends Enumeration {
	val INIT = 0.U
	val SET_BIT = 1.U
	val MULT = 2.U
	val CMP = 3.U
	val DONE = 4.U
}

class ISR extends Module {
	val io = IO(new Bundle {
		val value = Input(UInt(64.W))
		val result = Output(UInt(32.W))
		val done = Output(UInt(1.W))
	})

	val start = Wire(UInt(1.W))
	val guessDone = Wire(UInt(1.W))

	val valueRegister = RegInit(0.U(64.W))
	val resultRegister = RegInit(0.U(64.W))
	val guessResultRegister = RegInit(0.U(64.W))

	val state = RegInit(0.U(3.W))
	val nextState = RegInit(0.U(3.W))

	var index = RegInit(32.U(6.W))
	val nextIndex = RegInit(32.U(6.W))

	val multPipeline = Module(new pipe_mult(8))
	multPipeline.io.mcand := resultRegister
	multPipeline.io.mplier := resultRegister
	multPipeline.io.start := start
	guessResultRegister := multPipeline.io.product
	guessDone := multPipeline.io.done

	start := 0.U
	io.done := 0.U

	valueRegister := io.value
	index := nextIndex
	state := nextState
	io.result := resultRegister(31, 0)

	switch (state) {
		is (State.INIT) {
			nextState := State.SET_BIT
			start := 0.U
			resultRegister := 0.U
			io.done := 0.U
		}
		is (State.SET_BIT) {
			when (index > 0.U) {
				nextState := State.MULT
				start := 1.U
				resultRegister := resultRegister | (1.U << (index - 1.U))
			}.otherwise {
				nextState := State.DONE
			}
		}
		is (State.MULT) {
			start := 0.U
			when (guessDone === 1.U) {
				nextState := State.CMP
			}
		}
		is (State.CMP) {
			nextIndex := index - 1.U
			when (guessResultRegister === valueRegister) {
				nextState := State.DONE
			}.elsewhen (guessResultRegister > valueRegister) {
				resultRegister := resultRegister & ~(1.U << (index - 1.U))
				nextState := State.SET_BIT
			}.otherwise {
				nextState := State.SET_BIT
			}
		}
		is (State.DONE) {
			io.done := 1.U
			nextState := State.INIT
			nextIndex := 32.U
		}
	}

}

class ISR_test(dut: ISR) extends PeekPokeTester(dut) {
	var testSet: Seq[Long] = Seq(0, 1, (1L << 63) - 1, (1L << 32), (1L << 16) + 1)
	for (i <- 0 until 20) {
		testSet = testSet :+ math.abs(Random.nextLong())
	}
	for (testNumber <- testSet) {
		poke(dut.io.value, testNumber.U)
		step(2)
		while (peek(dut.io.done).toInt == 0) {
			step(1)
		}
		val correctRoot: Long = math.sqrt(testNumber).toLong
		println(s"Result: done: ${peek(dut.io.done)}, number: ${testNumber}, root: ${peek(dut.io.result)}")
		expect(dut.io.result, correctRoot)
	}
}

object ISR_test extends App {
	chisel3.iotesters.Driver(() => new ISR()) { c =>
		new ISR_test(c)
	}
}

object mult_stage_Driver extends App {
	(new ChiselStage).emitVerilog(new mult_stage(8))
}

object pipeline_mult_Driver extends App {
	(new ChiselStage).emitVerilog(new pipe_mult(8))
}

object pipeline_ISR_Driver extends App {
	(new ChiselStage).emitVerilog(new ISR)
}