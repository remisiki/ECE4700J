;buildInfoPackage: chisel3, version: 3.3.1, scalaVersion: 2.12.11, sbtVersion: 1.3.10
circuit pipe_mult : 
  module mult_stage : 
    input clock : Clock
    input reset : Reset
    output io : {flip start : UInt<1>, flip product_in : UInt<64>, flip mplier_in : UInt<64>, flip mcand_in : UInt<64>, done : UInt<1>, product_out : UInt<64>, mplier_out : UInt<64>, mcand_out : UInt<64>}
    
    reg productInRegister : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 26:40]
    reg partialProductRegister : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 27:45]
    reg doneRegister : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[ISR.scala 28:35]
    reg nextMplier : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 29:33]
    reg nextMcand : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 30:32]
    node _T = bits(io.mplier_in, 63, 8) @[ISR.scala 32:53]
    node _T_1 = cat(UInt<8>("h00"), _T) @[Cat.scala 29:58]
    nextMplier <= _T_1 @[ISR.scala 32:20]
    node _T_2 = bits(io.mcand_in, 55, 0) @[ISR.scala 33:37]
    node _T_3 = cat(_T_2, UInt<8>("h00")) @[Cat.scala 29:58]
    nextMcand <= _T_3 @[ISR.scala 33:19]
    productInRegister <= io.product_in @[ISR.scala 35:27]
    node _T_4 = bits(io.mplier_in, 7, 0) @[ISR.scala 36:47]
    node _T_5 = mul(_T_4, io.mcand_in) @[ISR.scala 36:62]
    partialProductRegister <= _T_5 @[ISR.scala 36:32]
    doneRegister <= io.start @[ISR.scala 37:22]
    node _T_6 = add(productInRegister, partialProductRegister) @[ISR.scala 39:45]
    node _T_7 = tail(_T_6, 1) @[ISR.scala 39:45]
    io.product_out <= _T_7 @[ISR.scala 39:24]
    io.mplier_out <= nextMplier @[ISR.scala 40:23]
    io.mcand_out <= nextMcand @[ISR.scala 41:22]
    io.done <= doneRegister @[ISR.scala 42:17]
    
  module mult_stage_1 : 
    input clock : Clock
    input reset : Reset
    output io : {flip start : UInt<1>, flip product_in : UInt<64>, flip mplier_in : UInt<64>, flip mcand_in : UInt<64>, done : UInt<1>, product_out : UInt<64>, mplier_out : UInt<64>, mcand_out : UInt<64>}
    
    reg productInRegister : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 26:40]
    reg partialProductRegister : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 27:45]
    reg doneRegister : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[ISR.scala 28:35]
    reg nextMplier : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 29:33]
    reg nextMcand : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 30:32]
    node _T = bits(io.mplier_in, 63, 8) @[ISR.scala 32:53]
    node _T_1 = cat(UInt<8>("h00"), _T) @[Cat.scala 29:58]
    nextMplier <= _T_1 @[ISR.scala 32:20]
    node _T_2 = bits(io.mcand_in, 55, 0) @[ISR.scala 33:37]
    node _T_3 = cat(_T_2, UInt<8>("h00")) @[Cat.scala 29:58]
    nextMcand <= _T_3 @[ISR.scala 33:19]
    productInRegister <= io.product_in @[ISR.scala 35:27]
    node _T_4 = bits(io.mplier_in, 7, 0) @[ISR.scala 36:47]
    node _T_5 = mul(_T_4, io.mcand_in) @[ISR.scala 36:62]
    partialProductRegister <= _T_5 @[ISR.scala 36:32]
    doneRegister <= io.start @[ISR.scala 37:22]
    node _T_6 = add(productInRegister, partialProductRegister) @[ISR.scala 39:45]
    node _T_7 = tail(_T_6, 1) @[ISR.scala 39:45]
    io.product_out <= _T_7 @[ISR.scala 39:24]
    io.mplier_out <= nextMplier @[ISR.scala 40:23]
    io.mcand_out <= nextMcand @[ISR.scala 41:22]
    io.done <= doneRegister @[ISR.scala 42:17]
    
  module mult_stage_2 : 
    input clock : Clock
    input reset : Reset
    output io : {flip start : UInt<1>, flip product_in : UInt<64>, flip mplier_in : UInt<64>, flip mcand_in : UInt<64>, done : UInt<1>, product_out : UInt<64>, mplier_out : UInt<64>, mcand_out : UInt<64>}
    
    reg productInRegister : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 26:40]
    reg partialProductRegister : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 27:45]
    reg doneRegister : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[ISR.scala 28:35]
    reg nextMplier : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 29:33]
    reg nextMcand : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 30:32]
    node _T = bits(io.mplier_in, 63, 8) @[ISR.scala 32:53]
    node _T_1 = cat(UInt<8>("h00"), _T) @[Cat.scala 29:58]
    nextMplier <= _T_1 @[ISR.scala 32:20]
    node _T_2 = bits(io.mcand_in, 55, 0) @[ISR.scala 33:37]
    node _T_3 = cat(_T_2, UInt<8>("h00")) @[Cat.scala 29:58]
    nextMcand <= _T_3 @[ISR.scala 33:19]
    productInRegister <= io.product_in @[ISR.scala 35:27]
    node _T_4 = bits(io.mplier_in, 7, 0) @[ISR.scala 36:47]
    node _T_5 = mul(_T_4, io.mcand_in) @[ISR.scala 36:62]
    partialProductRegister <= _T_5 @[ISR.scala 36:32]
    doneRegister <= io.start @[ISR.scala 37:22]
    node _T_6 = add(productInRegister, partialProductRegister) @[ISR.scala 39:45]
    node _T_7 = tail(_T_6, 1) @[ISR.scala 39:45]
    io.product_out <= _T_7 @[ISR.scala 39:24]
    io.mplier_out <= nextMplier @[ISR.scala 40:23]
    io.mcand_out <= nextMcand @[ISR.scala 41:22]
    io.done <= doneRegister @[ISR.scala 42:17]
    
  module mult_stage_3 : 
    input clock : Clock
    input reset : Reset
    output io : {flip start : UInt<1>, flip product_in : UInt<64>, flip mplier_in : UInt<64>, flip mcand_in : UInt<64>, done : UInt<1>, product_out : UInt<64>, mplier_out : UInt<64>, mcand_out : UInt<64>}
    
    reg productInRegister : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 26:40]
    reg partialProductRegister : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 27:45]
    reg doneRegister : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[ISR.scala 28:35]
    reg nextMplier : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 29:33]
    reg nextMcand : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 30:32]
    node _T = bits(io.mplier_in, 63, 8) @[ISR.scala 32:53]
    node _T_1 = cat(UInt<8>("h00"), _T) @[Cat.scala 29:58]
    nextMplier <= _T_1 @[ISR.scala 32:20]
    node _T_2 = bits(io.mcand_in, 55, 0) @[ISR.scala 33:37]
    node _T_3 = cat(_T_2, UInt<8>("h00")) @[Cat.scala 29:58]
    nextMcand <= _T_3 @[ISR.scala 33:19]
    productInRegister <= io.product_in @[ISR.scala 35:27]
    node _T_4 = bits(io.mplier_in, 7, 0) @[ISR.scala 36:47]
    node _T_5 = mul(_T_4, io.mcand_in) @[ISR.scala 36:62]
    partialProductRegister <= _T_5 @[ISR.scala 36:32]
    doneRegister <= io.start @[ISR.scala 37:22]
    node _T_6 = add(productInRegister, partialProductRegister) @[ISR.scala 39:45]
    node _T_7 = tail(_T_6, 1) @[ISR.scala 39:45]
    io.product_out <= _T_7 @[ISR.scala 39:24]
    io.mplier_out <= nextMplier @[ISR.scala 40:23]
    io.mcand_out <= nextMcand @[ISR.scala 41:22]
    io.done <= doneRegister @[ISR.scala 42:17]
    
  module mult_stage_4 : 
    input clock : Clock
    input reset : Reset
    output io : {flip start : UInt<1>, flip product_in : UInt<64>, flip mplier_in : UInt<64>, flip mcand_in : UInt<64>, done : UInt<1>, product_out : UInt<64>, mplier_out : UInt<64>, mcand_out : UInt<64>}
    
    reg productInRegister : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 26:40]
    reg partialProductRegister : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 27:45]
    reg doneRegister : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[ISR.scala 28:35]
    reg nextMplier : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 29:33]
    reg nextMcand : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 30:32]
    node _T = bits(io.mplier_in, 63, 8) @[ISR.scala 32:53]
    node _T_1 = cat(UInt<8>("h00"), _T) @[Cat.scala 29:58]
    nextMplier <= _T_1 @[ISR.scala 32:20]
    node _T_2 = bits(io.mcand_in, 55, 0) @[ISR.scala 33:37]
    node _T_3 = cat(_T_2, UInt<8>("h00")) @[Cat.scala 29:58]
    nextMcand <= _T_3 @[ISR.scala 33:19]
    productInRegister <= io.product_in @[ISR.scala 35:27]
    node _T_4 = bits(io.mplier_in, 7, 0) @[ISR.scala 36:47]
    node _T_5 = mul(_T_4, io.mcand_in) @[ISR.scala 36:62]
    partialProductRegister <= _T_5 @[ISR.scala 36:32]
    doneRegister <= io.start @[ISR.scala 37:22]
    node _T_6 = add(productInRegister, partialProductRegister) @[ISR.scala 39:45]
    node _T_7 = tail(_T_6, 1) @[ISR.scala 39:45]
    io.product_out <= _T_7 @[ISR.scala 39:24]
    io.mplier_out <= nextMplier @[ISR.scala 40:23]
    io.mcand_out <= nextMcand @[ISR.scala 41:22]
    io.done <= doneRegister @[ISR.scala 42:17]
    
  module mult_stage_5 : 
    input clock : Clock
    input reset : Reset
    output io : {flip start : UInt<1>, flip product_in : UInt<64>, flip mplier_in : UInt<64>, flip mcand_in : UInt<64>, done : UInt<1>, product_out : UInt<64>, mplier_out : UInt<64>, mcand_out : UInt<64>}
    
    reg productInRegister : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 26:40]
    reg partialProductRegister : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 27:45]
    reg doneRegister : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[ISR.scala 28:35]
    reg nextMplier : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 29:33]
    reg nextMcand : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 30:32]
    node _T = bits(io.mplier_in, 63, 8) @[ISR.scala 32:53]
    node _T_1 = cat(UInt<8>("h00"), _T) @[Cat.scala 29:58]
    nextMplier <= _T_1 @[ISR.scala 32:20]
    node _T_2 = bits(io.mcand_in, 55, 0) @[ISR.scala 33:37]
    node _T_3 = cat(_T_2, UInt<8>("h00")) @[Cat.scala 29:58]
    nextMcand <= _T_3 @[ISR.scala 33:19]
    productInRegister <= io.product_in @[ISR.scala 35:27]
    node _T_4 = bits(io.mplier_in, 7, 0) @[ISR.scala 36:47]
    node _T_5 = mul(_T_4, io.mcand_in) @[ISR.scala 36:62]
    partialProductRegister <= _T_5 @[ISR.scala 36:32]
    doneRegister <= io.start @[ISR.scala 37:22]
    node _T_6 = add(productInRegister, partialProductRegister) @[ISR.scala 39:45]
    node _T_7 = tail(_T_6, 1) @[ISR.scala 39:45]
    io.product_out <= _T_7 @[ISR.scala 39:24]
    io.mplier_out <= nextMplier @[ISR.scala 40:23]
    io.mcand_out <= nextMcand @[ISR.scala 41:22]
    io.done <= doneRegister @[ISR.scala 42:17]
    
  module mult_stage_6 : 
    input clock : Clock
    input reset : Reset
    output io : {flip start : UInt<1>, flip product_in : UInt<64>, flip mplier_in : UInt<64>, flip mcand_in : UInt<64>, done : UInt<1>, product_out : UInt<64>, mplier_out : UInt<64>, mcand_out : UInt<64>}
    
    reg productInRegister : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 26:40]
    reg partialProductRegister : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 27:45]
    reg doneRegister : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[ISR.scala 28:35]
    reg nextMplier : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 29:33]
    reg nextMcand : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 30:32]
    node _T = bits(io.mplier_in, 63, 8) @[ISR.scala 32:53]
    node _T_1 = cat(UInt<8>("h00"), _T) @[Cat.scala 29:58]
    nextMplier <= _T_1 @[ISR.scala 32:20]
    node _T_2 = bits(io.mcand_in, 55, 0) @[ISR.scala 33:37]
    node _T_3 = cat(_T_2, UInt<8>("h00")) @[Cat.scala 29:58]
    nextMcand <= _T_3 @[ISR.scala 33:19]
    productInRegister <= io.product_in @[ISR.scala 35:27]
    node _T_4 = bits(io.mplier_in, 7, 0) @[ISR.scala 36:47]
    node _T_5 = mul(_T_4, io.mcand_in) @[ISR.scala 36:62]
    partialProductRegister <= _T_5 @[ISR.scala 36:32]
    doneRegister <= io.start @[ISR.scala 37:22]
    node _T_6 = add(productInRegister, partialProductRegister) @[ISR.scala 39:45]
    node _T_7 = tail(_T_6, 1) @[ISR.scala 39:45]
    io.product_out <= _T_7 @[ISR.scala 39:24]
    io.mplier_out <= nextMplier @[ISR.scala 40:23]
    io.mcand_out <= nextMcand @[ISR.scala 41:22]
    io.done <= doneRegister @[ISR.scala 42:17]
    
  module mult_stage_7 : 
    input clock : Clock
    input reset : Reset
    output io : {flip start : UInt<1>, flip product_in : UInt<64>, flip mplier_in : UInt<64>, flip mcand_in : UInt<64>, done : UInt<1>, product_out : UInt<64>, mplier_out : UInt<64>, mcand_out : UInt<64>}
    
    reg productInRegister : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 26:40]
    reg partialProductRegister : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 27:45]
    reg doneRegister : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[ISR.scala 28:35]
    reg nextMplier : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 29:33]
    reg nextMcand : UInt<64>, clock with : (reset => (reset, UInt<64>("h00"))) @[ISR.scala 30:32]
    node _T = bits(io.mplier_in, 63, 8) @[ISR.scala 32:53]
    node _T_1 = cat(UInt<8>("h00"), _T) @[Cat.scala 29:58]
    nextMplier <= _T_1 @[ISR.scala 32:20]
    node _T_2 = bits(io.mcand_in, 55, 0) @[ISR.scala 33:37]
    node _T_3 = cat(_T_2, UInt<8>("h00")) @[Cat.scala 29:58]
    nextMcand <= _T_3 @[ISR.scala 33:19]
    productInRegister <= io.product_in @[ISR.scala 35:27]
    node _T_4 = bits(io.mplier_in, 7, 0) @[ISR.scala 36:47]
    node _T_5 = mul(_T_4, io.mcand_in) @[ISR.scala 36:62]
    partialProductRegister <= _T_5 @[ISR.scala 36:32]
    doneRegister <= io.start @[ISR.scala 37:22]
    node _T_6 = add(productInRegister, partialProductRegister) @[ISR.scala 39:45]
    node _T_7 = tail(_T_6, 1) @[ISR.scala 39:45]
    io.product_out <= _T_7 @[ISR.scala 39:24]
    io.mplier_out <= nextMplier @[ISR.scala 40:23]
    io.mcand_out <= nextMcand @[ISR.scala 41:22]
    io.done <= doneRegister @[ISR.scala 42:17]
    
  module pipe_mult : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip start : UInt<1>, flip mplier : UInt<64>, flip mcand : UInt<64>, product : UInt<64>, done : UInt<1>}
    
    wire mcandOut : UInt<64> @[ISR.scala 57:28]
    wire mplierOut : UInt<64> @[ISR.scala 58:29]
    wire internalProducts : UInt<64>[7] @[ISR.scala 60:36]
    wire internalMcands : UInt<64>[7] @[ISR.scala 61:34]
    wire internalMpliers : UInt<64>[7] @[ISR.scala 62:35]
    wire internalDones : UInt<1>[7] @[ISR.scala 63:33]
    inst mult_stage of mult_stage @[ISR.scala 64:49]
    mult_stage.clock <= clock
    mult_stage.reset <= reset
    inst mult_stage_1 of mult_stage_1 @[ISR.scala 64:49]
    mult_stage_1.clock <= clock
    mult_stage_1.reset <= reset
    inst mult_stage_2 of mult_stage_2 @[ISR.scala 64:49]
    mult_stage_2.clock <= clock
    mult_stage_2.reset <= reset
    inst mult_stage_3 of mult_stage_3 @[ISR.scala 64:49]
    mult_stage_3.clock <= clock
    mult_stage_3.reset <= reset
    inst mult_stage_4 of mult_stage_4 @[ISR.scala 64:49]
    mult_stage_4.clock <= clock
    mult_stage_4.reset <= reset
    inst mult_stage_5 of mult_stage_5 @[ISR.scala 64:49]
    mult_stage_5.clock <= clock
    mult_stage_5.reset <= reset
    inst mult_stage_6 of mult_stage_6 @[ISR.scala 64:49]
    mult_stage_6.clock <= clock
    mult_stage_6.reset <= reset
    inst mult_stage_7 of mult_stage_7 @[ISR.scala 64:49]
    mult_stage_7.clock <= clock
    mult_stage_7.reset <= reset
    mult_stage.io.product_in <= UInt<64>("h00") @[ISR.scala 69:46]
    mult_stage.io.mplier_in <= io.mplier @[ISR.scala 70:45]
    mult_stage.io.mcand_in <= io.mcand @[ISR.scala 71:44]
    mult_stage.io.start <= io.start @[ISR.scala 72:41]
    internalProducts[0] <= mult_stage.io.product_out @[ISR.scala 88:45]
    internalDones[0] <= mult_stage.io.done @[ISR.scala 89:42]
    internalMpliers[0] <= mult_stage.io.mplier_out @[ISR.scala 90:44]
    internalMcands[0] <= mult_stage.io.mcand_out @[ISR.scala 91:43]
    mult_stage_1.io.product_in <= internalProducts[0] @[ISR.scala 75:46]
    mult_stage_1.io.mplier_in <= internalMpliers[0] @[ISR.scala 76:45]
    mult_stage_1.io.mcand_in <= internalMcands[0] @[ISR.scala 77:44]
    mult_stage_1.io.start <= internalDones[0] @[ISR.scala 78:41]
    internalProducts[1] <= mult_stage_1.io.product_out @[ISR.scala 88:45]
    internalDones[1] <= mult_stage_1.io.done @[ISR.scala 89:42]
    internalMpliers[1] <= mult_stage_1.io.mplier_out @[ISR.scala 90:44]
    internalMcands[1] <= mult_stage_1.io.mcand_out @[ISR.scala 91:43]
    mult_stage_2.io.product_in <= internalProducts[1] @[ISR.scala 75:46]
    mult_stage_2.io.mplier_in <= internalMpliers[1] @[ISR.scala 76:45]
    mult_stage_2.io.mcand_in <= internalMcands[1] @[ISR.scala 77:44]
    mult_stage_2.io.start <= internalDones[1] @[ISR.scala 78:41]
    internalProducts[2] <= mult_stage_2.io.product_out @[ISR.scala 88:45]
    internalDones[2] <= mult_stage_2.io.done @[ISR.scala 89:42]
    internalMpliers[2] <= mult_stage_2.io.mplier_out @[ISR.scala 90:44]
    internalMcands[2] <= mult_stage_2.io.mcand_out @[ISR.scala 91:43]
    mult_stage_3.io.product_in <= internalProducts[2] @[ISR.scala 75:46]
    mult_stage_3.io.mplier_in <= internalMpliers[2] @[ISR.scala 76:45]
    mult_stage_3.io.mcand_in <= internalMcands[2] @[ISR.scala 77:44]
    mult_stage_3.io.start <= internalDones[2] @[ISR.scala 78:41]
    internalProducts[3] <= mult_stage_3.io.product_out @[ISR.scala 88:45]
    internalDones[3] <= mult_stage_3.io.done @[ISR.scala 89:42]
    internalMpliers[3] <= mult_stage_3.io.mplier_out @[ISR.scala 90:44]
    internalMcands[3] <= mult_stage_3.io.mcand_out @[ISR.scala 91:43]
    mult_stage_4.io.product_in <= internalProducts[3] @[ISR.scala 75:46]
    mult_stage_4.io.mplier_in <= internalMpliers[3] @[ISR.scala 76:45]
    mult_stage_4.io.mcand_in <= internalMcands[3] @[ISR.scala 77:44]
    mult_stage_4.io.start <= internalDones[3] @[ISR.scala 78:41]
    internalProducts[4] <= mult_stage_4.io.product_out @[ISR.scala 88:45]
    internalDones[4] <= mult_stage_4.io.done @[ISR.scala 89:42]
    internalMpliers[4] <= mult_stage_4.io.mplier_out @[ISR.scala 90:44]
    internalMcands[4] <= mult_stage_4.io.mcand_out @[ISR.scala 91:43]
    mult_stage_5.io.product_in <= internalProducts[4] @[ISR.scala 75:46]
    mult_stage_5.io.mplier_in <= internalMpliers[4] @[ISR.scala 76:45]
    mult_stage_5.io.mcand_in <= internalMcands[4] @[ISR.scala 77:44]
    mult_stage_5.io.start <= internalDones[4] @[ISR.scala 78:41]
    internalProducts[5] <= mult_stage_5.io.product_out @[ISR.scala 88:45]
    internalDones[5] <= mult_stage_5.io.done @[ISR.scala 89:42]
    internalMpliers[5] <= mult_stage_5.io.mplier_out @[ISR.scala 90:44]
    internalMcands[5] <= mult_stage_5.io.mcand_out @[ISR.scala 91:43]
    mult_stage_6.io.product_in <= internalProducts[5] @[ISR.scala 75:46]
    mult_stage_6.io.mplier_in <= internalMpliers[5] @[ISR.scala 76:45]
    mult_stage_6.io.mcand_in <= internalMcands[5] @[ISR.scala 77:44]
    mult_stage_6.io.start <= internalDones[5] @[ISR.scala 78:41]
    internalProducts[6] <= mult_stage_6.io.product_out @[ISR.scala 88:45]
    internalDones[6] <= mult_stage_6.io.done @[ISR.scala 89:42]
    internalMpliers[6] <= mult_stage_6.io.mplier_out @[ISR.scala 90:44]
    internalMcands[6] <= mult_stage_6.io.mcand_out @[ISR.scala 91:43]
    mult_stage_7.io.product_in <= internalProducts[6] @[ISR.scala 75:46]
    mult_stage_7.io.mplier_in <= internalMpliers[6] @[ISR.scala 76:45]
    mult_stage_7.io.mcand_in <= internalMcands[6] @[ISR.scala 77:44]
    mult_stage_7.io.start <= internalDones[6] @[ISR.scala 78:41]
    io.product <= mult_stage_7.io.product_out @[ISR.scala 82:36]
    io.done <= mult_stage_7.io.done @[ISR.scala 83:33]
    mplierOut <= mult_stage_7.io.mplier_out @[ISR.scala 84:35]
    mcandOut <= mult_stage_7.io.mcand_out @[ISR.scala 85:34]
    
