r=$(diff --strip-trailing-cr example_output/fib_rec.pipeline.out /mnt/d/Verilog/riscv-base/riscv-base.sim/sim_1/behav/xsim/pipeline.out)
if [ ! -z "$r" ]; then
	echo -e "\033[31mWrong Pipeline\033[00m"
	echo "$r" | grep "<" > correct_pipeline.out
	echo "$r" | grep ">" > my_pipeline.out
else
	echo -e '\033[32mCorrect Pipeline\033[00m'
fi
r=$(diff --strip-trailing-cr example_output/fib_rec.writeback.out /mnt/d/Verilog/riscv-base/riscv-base.sim/sim_1/behav/xsim/writeback.out)
if [ ! -z "$r" ]; then
	echo -e "\033[31mWrong Writeback\033[00m"
	echo "$r" | grep "<" > correct_writeback.out
	echo "$r" | grep ">" > my_writeback.out
else
	echo -e '\033[32mCorrect Writeback\033[00m'
fi