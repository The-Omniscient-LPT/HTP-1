
module program_counter #(parameter width = 32) (
    input [1:0] clock,
    input reg [width-1:0] next_addr, // next addr from BJII
    output reg [width-1:0] current_addr
);
initial begin 
    current_addr = 0;
end

// transition on lower clock bit, could also be on negedge if there are timing issues?
always @(posedge clock[0]) begin 
    current_addr <= next_addr;
end

endmodule
