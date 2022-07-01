// See README.md for license details.

package demo

import chisel3._
import chisel3.iotesters._
import chisel3.stage.ChiselStage
import chisel3.util._




class DynamicMemorySearch(val n: Int, val w: Int) extends Module {
  val io = IO(new Bundle {
    val isWr   = Input(Bool())
    val wrAddr = Input(UInt(log2Ceil(n).W))
    val data   = Input(UInt(w.W))
    val en     = Input(Bool())
    val target = Output(UInt(log2Ceil(n).W))
    val done   = Output(Bool())
  })
  val index  = RegInit(0.U(log2Ceil(n).W))

  val list   = Mem(n, UInt(w.W))
  val memVal = list(index)

  val done   = !io.en && ((memVal === io.data) || (index === (n-1).asUInt))

  when (io.isWr) {
    list(io.wrAddr) := io.data
  } .elsewhen (io.en) {
    index := 0.U
  } .elsewhen (done === false.B) {
    index := index + 1.U
  }
  io.done   := done
  io.target := index
}



class DynamicMemorySearchTests(c: DynamicMemorySearch) extends PeekPokeTester(c) {
  val list = Array.fill(c.n){ 0 }
  // Initialize the memory.
  for (k <- 0 until c.n) {
    poke(c.io.en, 0)
    poke(c.io.isWr, 1)
    poke(c.io.wrAddr, k)
    poke(c.io.data, 0)
    step(1)
  }

  for (k <- 0 until 16) {
    // WRITE A WORD
    poke(c.io.en,   0)
    poke(c.io.isWr, 1)
    val wrAddr = rnd.nextInt(c.n-1)
    val data   = rnd.nextInt((1 << c.w)) + 1 // can't be 0
    poke(c.io.wrAddr, wrAddr)
    poke(c.io.data,   data)
    step(1)
    list(wrAddr) = data
    // SETUP SEARCH
    val target = if (k > 12) rnd.nextInt(1 << c.w) else data
    poke(c.io.isWr, 0)
    poke(c.io.data, target)
    poke(c.io.en,   1)
    step(1)
    do {
      poke(c.io.en, 0)
      step(1)
    } while (peek(c.io.done) == BigInt(0))
    val addr = peek(c.io.target).toInt
    if (list contains target) {
      if(list(addr) == target) {
        println("LOOKING FOR " + target + " FOUND " + addr)
      }
      else {
        println("LOOKING FOR " + target + " Failed")
      }
    }
  }
}


object DynamicMemorySearchTests extends App {
  chisel3.iotesters.Driver(() => new DynamicMemorySearch(8,8)) { c =>
    new DynamicMemorySearchTests(c)
  }
}

object DynamicMemorySearchDriver extends App {
  (new ChiselStage).emitVerilog(new DynamicMemorySearch(8,8))
}
