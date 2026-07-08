// inbuilt alarm/clock
// theres no way this wont be useful
// triggers attempted program change as an interrupt
// 32 bit for obv reasons

module timer #(parameter timer_width = 32) (
    input wire [1:0] clock,
    input wire timer_to_bus,
    input wire reset,
    output wire bus,
    output wire timer_overflow_sig
);

    reg [timer_width-1:0] timer;

    initial begin 
        timer <= {timer_width{1'b0}};
    end

    always @(posedge reset) begin
        timer <= {timer_width{1'b0}};
    end

    // incriment on 3 case (store case)?? (TODO: assess which stage to inc on)
    always @(clock) begin 
        if (clock == 2'b11) begin 
            timer <= timer + 1;
        end
    end

    assign timer_overflow_sig = (&timer); // iff all ones, is set, else is not
    assign bus = (timer_to_bus) ? timer : {timer_width{1'bz}};
endmodule