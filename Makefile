
.PHONY: all test run clean


all: test

# surely theres a better way to do that
test: testbenches/main_testbench.v src/HTP-1.v 
	iverilog -o test.vvp testbenches/main_testbench.v src/HTP-1.v


run: test
	vvp test.vvp

clean:
	rm -f test main_testbench.vcd