module mult_stage(
  input         clock,
  input         reset,
  input         io_start,
  input  [63:0] io_product_in,
  input  [63:0] io_mplier_in,
  input  [63:0] io_mcand_in,
  output        io_done,
  output [63:0] io_product_out,
  output [63:0] io_mplier_out,
  output [63:0] io_mcand_out
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [63:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] productInRegister; // @[ISR.scala 26:40]
  reg [63:0] partialProductRegister; // @[ISR.scala 27:45]
  reg  doneRegister; // @[ISR.scala 28:35]
  reg [63:0] nextMplier; // @[ISR.scala 29:33]
  reg [63:0] nextMcand; // @[ISR.scala 30:32]
  wire [63:0] _T_1 = {8'h0,io_mplier_in[63:8]}; // @[Cat.scala 29:58]
  wire [63:0] _T_3 = {io_mcand_in[55:0],8'h0}; // @[Cat.scala 29:58]
  wire [63:0] _GEN_0 = {{56'd0}, io_mplier_in[7:0]}; // @[ISR.scala 36:62]
  wire [71:0] _T_5 = _GEN_0 * io_mcand_in; // @[ISR.scala 36:62]
  assign io_done = doneRegister; // @[ISR.scala 42:17]
  assign io_product_out = productInRegister + partialProductRegister; // @[ISR.scala 39:24]
  assign io_mplier_out = nextMplier; // @[ISR.scala 40:23]
  assign io_mcand_out = nextMcand; // @[ISR.scala 41:22]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  productInRegister = _RAND_0[63:0];
  _RAND_1 = {2{`RANDOM}};
  partialProductRegister = _RAND_1[63:0];
  _RAND_2 = {1{`RANDOM}};
  doneRegister = _RAND_2[0:0];
  _RAND_3 = {2{`RANDOM}};
  nextMplier = _RAND_3[63:0];
  _RAND_4 = {2{`RANDOM}};
  nextMcand = _RAND_4[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      productInRegister <= 64'h0;
    end else begin
      productInRegister <= io_product_in;
    end
    if (reset) begin
      partialProductRegister <= 64'h0;
    end else begin
      partialProductRegister <= _T_5[63:0];
    end
    if (reset) begin
      doneRegister <= 1'h0;
    end else begin
      doneRegister <= io_start;
    end
    if (reset) begin
      nextMplier <= 64'h0;
    end else begin
      nextMplier <= _T_1;
    end
    if (reset) begin
      nextMcand <= 64'h0;
    end else begin
      nextMcand <= _T_3;
    end
  end
endmodule
module pipe_mult(
  input         clock,
  input         reset,
  input         io_start,
  input  [63:0] io_mplier,
  input  [63:0] io_mcand,
  output [63:0] io_product,
  output        io_done
);
  wire  mult_stage_clock; // @[ISR.scala 64:49]
  wire  mult_stage_reset; // @[ISR.scala 64:49]
  wire  mult_stage_io_start; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_io_product_in; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_io_mplier_in; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_io_mcand_in; // @[ISR.scala 64:49]
  wire  mult_stage_io_done; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_io_product_out; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_io_mplier_out; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_io_mcand_out; // @[ISR.scala 64:49]
  wire  mult_stage_1_clock; // @[ISR.scala 64:49]
  wire  mult_stage_1_reset; // @[ISR.scala 64:49]
  wire  mult_stage_1_io_start; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_1_io_product_in; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_1_io_mplier_in; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_1_io_mcand_in; // @[ISR.scala 64:49]
  wire  mult_stage_1_io_done; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_1_io_product_out; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_1_io_mplier_out; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_1_io_mcand_out; // @[ISR.scala 64:49]
  wire  mult_stage_2_clock; // @[ISR.scala 64:49]
  wire  mult_stage_2_reset; // @[ISR.scala 64:49]
  wire  mult_stage_2_io_start; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_2_io_product_in; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_2_io_mplier_in; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_2_io_mcand_in; // @[ISR.scala 64:49]
  wire  mult_stage_2_io_done; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_2_io_product_out; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_2_io_mplier_out; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_2_io_mcand_out; // @[ISR.scala 64:49]
  wire  mult_stage_3_clock; // @[ISR.scala 64:49]
  wire  mult_stage_3_reset; // @[ISR.scala 64:49]
  wire  mult_stage_3_io_start; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_3_io_product_in; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_3_io_mplier_in; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_3_io_mcand_in; // @[ISR.scala 64:49]
  wire  mult_stage_3_io_done; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_3_io_product_out; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_3_io_mplier_out; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_3_io_mcand_out; // @[ISR.scala 64:49]
  wire  mult_stage_4_clock; // @[ISR.scala 64:49]
  wire  mult_stage_4_reset; // @[ISR.scala 64:49]
  wire  mult_stage_4_io_start; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_4_io_product_in; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_4_io_mplier_in; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_4_io_mcand_in; // @[ISR.scala 64:49]
  wire  mult_stage_4_io_done; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_4_io_product_out; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_4_io_mplier_out; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_4_io_mcand_out; // @[ISR.scala 64:49]
  wire  mult_stage_5_clock; // @[ISR.scala 64:49]
  wire  mult_stage_5_reset; // @[ISR.scala 64:49]
  wire  mult_stage_5_io_start; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_5_io_product_in; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_5_io_mplier_in; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_5_io_mcand_in; // @[ISR.scala 64:49]
  wire  mult_stage_5_io_done; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_5_io_product_out; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_5_io_mplier_out; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_5_io_mcand_out; // @[ISR.scala 64:49]
  wire  mult_stage_6_clock; // @[ISR.scala 64:49]
  wire  mult_stage_6_reset; // @[ISR.scala 64:49]
  wire  mult_stage_6_io_start; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_6_io_product_in; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_6_io_mplier_in; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_6_io_mcand_in; // @[ISR.scala 64:49]
  wire  mult_stage_6_io_done; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_6_io_product_out; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_6_io_mplier_out; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_6_io_mcand_out; // @[ISR.scala 64:49]
  wire  mult_stage_7_clock; // @[ISR.scala 64:49]
  wire  mult_stage_7_reset; // @[ISR.scala 64:49]
  wire  mult_stage_7_io_start; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_7_io_product_in; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_7_io_mplier_in; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_7_io_mcand_in; // @[ISR.scala 64:49]
  wire  mult_stage_7_io_done; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_7_io_product_out; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_7_io_mplier_out; // @[ISR.scala 64:49]
  wire [63:0] mult_stage_7_io_mcand_out; // @[ISR.scala 64:49]
  mult_stage mult_stage ( // @[ISR.scala 64:49]
    .clock(mult_stage_clock),
    .reset(mult_stage_reset),
    .io_start(mult_stage_io_start),
    .io_product_in(mult_stage_io_product_in),
    .io_mplier_in(mult_stage_io_mplier_in),
    .io_mcand_in(mult_stage_io_mcand_in),
    .io_done(mult_stage_io_done),
    .io_product_out(mult_stage_io_product_out),
    .io_mplier_out(mult_stage_io_mplier_out),
    .io_mcand_out(mult_stage_io_mcand_out)
  );
  mult_stage mult_stage_1 ( // @[ISR.scala 64:49]
    .clock(mult_stage_1_clock),
    .reset(mult_stage_1_reset),
    .io_start(mult_stage_1_io_start),
    .io_product_in(mult_stage_1_io_product_in),
    .io_mplier_in(mult_stage_1_io_mplier_in),
    .io_mcand_in(mult_stage_1_io_mcand_in),
    .io_done(mult_stage_1_io_done),
    .io_product_out(mult_stage_1_io_product_out),
    .io_mplier_out(mult_stage_1_io_mplier_out),
    .io_mcand_out(mult_stage_1_io_mcand_out)
  );
  mult_stage mult_stage_2 ( // @[ISR.scala 64:49]
    .clock(mult_stage_2_clock),
    .reset(mult_stage_2_reset),
    .io_start(mult_stage_2_io_start),
    .io_product_in(mult_stage_2_io_product_in),
    .io_mplier_in(mult_stage_2_io_mplier_in),
    .io_mcand_in(mult_stage_2_io_mcand_in),
    .io_done(mult_stage_2_io_done),
    .io_product_out(mult_stage_2_io_product_out),
    .io_mplier_out(mult_stage_2_io_mplier_out),
    .io_mcand_out(mult_stage_2_io_mcand_out)
  );
  mult_stage mult_stage_3 ( // @[ISR.scala 64:49]
    .clock(mult_stage_3_clock),
    .reset(mult_stage_3_reset),
    .io_start(mult_stage_3_io_start),
    .io_product_in(mult_stage_3_io_product_in),
    .io_mplier_in(mult_stage_3_io_mplier_in),
    .io_mcand_in(mult_stage_3_io_mcand_in),
    .io_done(mult_stage_3_io_done),
    .io_product_out(mult_stage_3_io_product_out),
    .io_mplier_out(mult_stage_3_io_mplier_out),
    .io_mcand_out(mult_stage_3_io_mcand_out)
  );
  mult_stage mult_stage_4 ( // @[ISR.scala 64:49]
    .clock(mult_stage_4_clock),
    .reset(mult_stage_4_reset),
    .io_start(mult_stage_4_io_start),
    .io_product_in(mult_stage_4_io_product_in),
    .io_mplier_in(mult_stage_4_io_mplier_in),
    .io_mcand_in(mult_stage_4_io_mcand_in),
    .io_done(mult_stage_4_io_done),
    .io_product_out(mult_stage_4_io_product_out),
    .io_mplier_out(mult_stage_4_io_mplier_out),
    .io_mcand_out(mult_stage_4_io_mcand_out)
  );
  mult_stage mult_stage_5 ( // @[ISR.scala 64:49]
    .clock(mult_stage_5_clock),
    .reset(mult_stage_5_reset),
    .io_start(mult_stage_5_io_start),
    .io_product_in(mult_stage_5_io_product_in),
    .io_mplier_in(mult_stage_5_io_mplier_in),
    .io_mcand_in(mult_stage_5_io_mcand_in),
    .io_done(mult_stage_5_io_done),
    .io_product_out(mult_stage_5_io_product_out),
    .io_mplier_out(mult_stage_5_io_mplier_out),
    .io_mcand_out(mult_stage_5_io_mcand_out)
  );
  mult_stage mult_stage_6 ( // @[ISR.scala 64:49]
    .clock(mult_stage_6_clock),
    .reset(mult_stage_6_reset),
    .io_start(mult_stage_6_io_start),
    .io_product_in(mult_stage_6_io_product_in),
    .io_mplier_in(mult_stage_6_io_mplier_in),
    .io_mcand_in(mult_stage_6_io_mcand_in),
    .io_done(mult_stage_6_io_done),
    .io_product_out(mult_stage_6_io_product_out),
    .io_mplier_out(mult_stage_6_io_mplier_out),
    .io_mcand_out(mult_stage_6_io_mcand_out)
  );
  mult_stage mult_stage_7 ( // @[ISR.scala 64:49]
    .clock(mult_stage_7_clock),
    .reset(mult_stage_7_reset),
    .io_start(mult_stage_7_io_start),
    .io_product_in(mult_stage_7_io_product_in),
    .io_mplier_in(mult_stage_7_io_mplier_in),
    .io_mcand_in(mult_stage_7_io_mcand_in),
    .io_done(mult_stage_7_io_done),
    .io_product_out(mult_stage_7_io_product_out),
    .io_mplier_out(mult_stage_7_io_mplier_out),
    .io_mcand_out(mult_stage_7_io_mcand_out)
  );
  assign io_product = mult_stage_7_io_product_out; // @[ISR.scala 82:36]
  assign io_done = mult_stage_7_io_done; // @[ISR.scala 83:33]
  assign mult_stage_clock = clock;
  assign mult_stage_reset = reset;
  assign mult_stage_io_start = io_start; // @[ISR.scala 72:41]
  assign mult_stage_io_product_in = 64'h0; // @[ISR.scala 69:46]
  assign mult_stage_io_mplier_in = io_mplier; // @[ISR.scala 70:45]
  assign mult_stage_io_mcand_in = io_mcand; // @[ISR.scala 71:44]
  assign mult_stage_1_clock = clock;
  assign mult_stage_1_reset = reset;
  assign mult_stage_1_io_start = mult_stage_io_done; // @[ISR.scala 78:41]
  assign mult_stage_1_io_product_in = mult_stage_io_product_out; // @[ISR.scala 75:46]
  assign mult_stage_1_io_mplier_in = mult_stage_io_mplier_out; // @[ISR.scala 76:45]
  assign mult_stage_1_io_mcand_in = mult_stage_io_mcand_out; // @[ISR.scala 77:44]
  assign mult_stage_2_clock = clock;
  assign mult_stage_2_reset = reset;
  assign mult_stage_2_io_start = mult_stage_1_io_done; // @[ISR.scala 78:41]
  assign mult_stage_2_io_product_in = mult_stage_1_io_product_out; // @[ISR.scala 75:46]
  assign mult_stage_2_io_mplier_in = mult_stage_1_io_mplier_out; // @[ISR.scala 76:45]
  assign mult_stage_2_io_mcand_in = mult_stage_1_io_mcand_out; // @[ISR.scala 77:44]
  assign mult_stage_3_clock = clock;
  assign mult_stage_3_reset = reset;
  assign mult_stage_3_io_start = mult_stage_2_io_done; // @[ISR.scala 78:41]
  assign mult_stage_3_io_product_in = mult_stage_2_io_product_out; // @[ISR.scala 75:46]
  assign mult_stage_3_io_mplier_in = mult_stage_2_io_mplier_out; // @[ISR.scala 76:45]
  assign mult_stage_3_io_mcand_in = mult_stage_2_io_mcand_out; // @[ISR.scala 77:44]
  assign mult_stage_4_clock = clock;
  assign mult_stage_4_reset = reset;
  assign mult_stage_4_io_start = mult_stage_3_io_done; // @[ISR.scala 78:41]
  assign mult_stage_4_io_product_in = mult_stage_3_io_product_out; // @[ISR.scala 75:46]
  assign mult_stage_4_io_mplier_in = mult_stage_3_io_mplier_out; // @[ISR.scala 76:45]
  assign mult_stage_4_io_mcand_in = mult_stage_3_io_mcand_out; // @[ISR.scala 77:44]
  assign mult_stage_5_clock = clock;
  assign mult_stage_5_reset = reset;
  assign mult_stage_5_io_start = mult_stage_4_io_done; // @[ISR.scala 78:41]
  assign mult_stage_5_io_product_in = mult_stage_4_io_product_out; // @[ISR.scala 75:46]
  assign mult_stage_5_io_mplier_in = mult_stage_4_io_mplier_out; // @[ISR.scala 76:45]
  assign mult_stage_5_io_mcand_in = mult_stage_4_io_mcand_out; // @[ISR.scala 77:44]
  assign mult_stage_6_clock = clock;
  assign mult_stage_6_reset = reset;
  assign mult_stage_6_io_start = mult_stage_5_io_done; // @[ISR.scala 78:41]
  assign mult_stage_6_io_product_in = mult_stage_5_io_product_out; // @[ISR.scala 75:46]
  assign mult_stage_6_io_mplier_in = mult_stage_5_io_mplier_out; // @[ISR.scala 76:45]
  assign mult_stage_6_io_mcand_in = mult_stage_5_io_mcand_out; // @[ISR.scala 77:44]
  assign mult_stage_7_clock = clock;
  assign mult_stage_7_reset = reset;
  assign mult_stage_7_io_start = mult_stage_6_io_done; // @[ISR.scala 78:41]
  assign mult_stage_7_io_product_in = mult_stage_6_io_product_out; // @[ISR.scala 75:46]
  assign mult_stage_7_io_mplier_in = mult_stage_6_io_mplier_out; // @[ISR.scala 76:45]
  assign mult_stage_7_io_mcand_in = mult_stage_6_io_mcand_out; // @[ISR.scala 77:44]
endmodule
module ISR(
  input         clock,
  input         reset,
  input  [63:0] io_value,
  output [31:0] io_result,
  output        io_done
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  wire  multPipeline_clock; // @[ISR.scala 125:34]
  wire  multPipeline_reset; // @[ISR.scala 125:34]
  wire  multPipeline_io_start; // @[ISR.scala 125:34]
  wire [63:0] multPipeline_io_mplier; // @[ISR.scala 125:34]
  wire [63:0] multPipeline_io_mcand; // @[ISR.scala 125:34]
  wire [63:0] multPipeline_io_product; // @[ISR.scala 125:34]
  wire  multPipeline_io_done; // @[ISR.scala 125:34]
  reg [63:0] valueRegister; // @[ISR.scala 115:36]
  reg [63:0] resultRegister; // @[ISR.scala 116:37]
  reg [63:0] guessResultRegister; // @[ISR.scala 117:42]
  reg [2:0] state; // @[ISR.scala 119:28]
  reg [2:0] nextState; // @[ISR.scala 120:32]
  reg [5:0] index; // @[ISR.scala 122:28]
  reg [5:0] nextIndex; // @[ISR.scala 123:32]
  wire  _T_1 = 3'h0 == state; // @[Conditional.scala 37:30]
  wire  _T_2 = 3'h1 == state; // @[Conditional.scala 37:30]
  wire  _T_3 = index > 6'h0; // @[ISR.scala 148:37]
  wire [5:0] _T_5 = index - 6'h1; // @[ISR.scala 151:83]
  wire [63:0] _T_6 = 64'h1 << _T_5; // @[ISR.scala 151:73]
  wire [63:0] _T_7 = resultRegister | _T_6; // @[ISR.scala 151:66]
  wire  _T_8 = 3'h2 == state; // @[Conditional.scala 37:30]
  wire  guessDone = multPipeline_io_done; // @[ISR.scala 113:29 ISR.scala 130:19]
  wire  _T_10 = 3'h3 == state; // @[Conditional.scala 37:30]
  wire  _T_13 = guessResultRegister == valueRegister; // @[ISR.scala 164:51]
  wire  _T_14 = guessResultRegister > valueRegister; // @[ISR.scala 166:57]
  wire [63:0] _T_18 = ~_T_6; // @[ISR.scala 167:68]
  wire [63:0] _T_19 = resultRegister & _T_18; // @[ISR.scala 167:66]
  wire  _T_20 = 3'h4 == state; // @[Conditional.scala 37:30]
  wire  _GEN_14 = _T_10 ? 1'h0 : _T_20; // @[Conditional.scala 39:67]
  wire  _GEN_19 = _T_8 ? 1'h0 : _GEN_14; // @[Conditional.scala 39:67]
  wire  _GEN_21 = _T_2 & _T_3; // @[Conditional.scala 39:67]
  wire  _GEN_24 = _T_2 ? 1'h0 : _GEN_19; // @[Conditional.scala 39:67]
  pipe_mult multPipeline ( // @[ISR.scala 125:34]
    .clock(multPipeline_clock),
    .reset(multPipeline_reset),
    .io_start(multPipeline_io_start),
    .io_mplier(multPipeline_io_mplier),
    .io_mcand(multPipeline_io_mcand),
    .io_product(multPipeline_io_product),
    .io_done(multPipeline_io_done)
  );
  assign io_result = resultRegister[31:0]; // @[ISR.scala 138:19]
  assign io_done = _T_1 ? 1'h0 : _GEN_24; // @[ISR.scala 133:17 ISR.scala 145:33 ISR.scala 174:33]
  assign multPipeline_clock = clock;
  assign multPipeline_reset = reset;
  assign multPipeline_io_start = _T_1 ? 1'h0 : _GEN_21; // @[ISR.scala 128:31]
  assign multPipeline_io_mplier = resultRegister; // @[ISR.scala 127:32]
  assign multPipeline_io_mcand = resultRegister; // @[ISR.scala 126:31]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  valueRegister = _RAND_0[63:0];
  _RAND_1 = {2{`RANDOM}};
  resultRegister = _RAND_1[63:0];
  _RAND_2 = {2{`RANDOM}};
  guessResultRegister = _RAND_2[63:0];
  _RAND_3 = {1{`RANDOM}};
  state = _RAND_3[2:0];
  _RAND_4 = {1{`RANDOM}};
  nextState = _RAND_4[2:0];
  _RAND_5 = {1{`RANDOM}};
  index = _RAND_5[5:0];
  _RAND_6 = {1{`RANDOM}};
  nextIndex = _RAND_6[5:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      valueRegister <= 64'h0;
    end else begin
      valueRegister <= io_value;
    end
    if (reset) begin
      resultRegister <= 64'h0;
    end else if (_T_1) begin
      resultRegister <= 64'h0;
    end else if (_T_2) begin
      if (_T_3) begin
        resultRegister <= _T_7;
      end
    end else if (!(_T_8)) begin
      if (_T_10) begin
        if (!(_T_13)) begin
          if (_T_14) begin
            resultRegister <= _T_19;
          end
        end
      end
    end
    if (reset) begin
      guessResultRegister <= 64'h0;
    end else begin
      guessResultRegister <= multPipeline_io_product;
    end
    if (reset) begin
      state <= 3'h0;
    end else begin
      state <= nextState;
    end
    if (reset) begin
      nextState <= 3'h0;
    end else if (_T_1) begin
      nextState <= 3'h1;
    end else if (_T_2) begin
      if (_T_3) begin
        nextState <= 3'h2;
      end else begin
        nextState <= 3'h4;
      end
    end else if (_T_8) begin
      if (guessDone) begin
        nextState <= 3'h3;
      end
    end else if (_T_10) begin
      if (_T_13) begin
        nextState <= 3'h4;
      end else begin
        nextState <= 3'h1;
      end
    end else if (_T_20) begin
      nextState <= 3'h0;
    end
    if (reset) begin
      index <= 6'h20;
    end else begin
      index <= nextIndex;
    end
    if (reset) begin
      nextIndex <= 6'h20;
    end else if (!(_T_1)) begin
      if (!(_T_2)) begin
        if (!(_T_8)) begin
          if (_T_10) begin
            nextIndex <= _T_5;
          end else if (_T_20) begin
            nextIndex <= 6'h20;
          end
        end
      end
    end
  end
endmodule
