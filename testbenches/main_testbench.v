
`timescale 1ns / 1ps


module main_testbench();
    reg clock;
    wire clock_out;
    assign clock_out = clock;
    HTP htp(
        .clock(clock)
    );

    initial begin
        clock = 1'b0;
    end

    always begin 
        #10 clock = ~clock;
    end
    
    
    initial begin

        $dumpfile("main_testbench.vcd");

        $dumpvars(0, main_testbench);

        #150000

        $finish;

    end


endmodule