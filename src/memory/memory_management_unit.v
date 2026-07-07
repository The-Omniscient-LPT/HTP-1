
// handles and obfuscates thread independant memory operations, 

module mmu_top #(parameter width = 32, parameter req_width = 5, parameter addrsize = 5) (
    input wire [1:0] clock,
    wire [width-1:0] bus, // io
    wire [req_width-1:0] request, // nop = 0
    wire [addrsize-1:0] addr
);


endmodule