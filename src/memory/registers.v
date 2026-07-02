module registers #(
    parameter width = 32,
    parameter addrsize = 5
) (
    input clk,

    // write to bus controls
    input [addrsize-1:0] addr_wr_index,
    output wire [size-1:0] data_bus_o,
    input write,

    // write direct to alu controls
    input [addrsize-1:0] addr_alu_index,
    output wire [size-1:0] data_alu_o,

    // read from bus controls
    input [addrsize-1:0] addr_r_index,
    input [size-1:0] data_r_i,
    input read
);  

    reg [size-1:0] register [(2**addrsize)-1:0];

    // write to bus 
    assign data_bus_o = (write == 1'b1) ? register[addr_wr_index]: {size{1'bz}}

    // write direct to alu
    assign data_alu_o = register[addr_alu_index]

    // read from bus
    always @(negedge clk) begin 
        if (read) begin
            register[addr_r_i] <= data_r_i;
        end
    end



endmodule