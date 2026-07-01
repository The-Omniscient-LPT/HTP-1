
.PHONY: all test run clean


all: test

# surely theres a better way to do that
test: testbenches/main_testbench.v src/HTP-1.v 
	iverilog -o test testbenches/main_testbench.v src/HTP-1.v


run: test
	vvp test

clean:
	rm -f test aout.vcd