// translates a virtual address to a real address,
// this looks kinda like a translation lookaside buffer
// addresses are 21 bit
// currently no SD support for vmem addr's
// vmem addr format:
//      xxxx yzzz zzzz zzzz zzzz zzzz


module vmem_translator #(
    parameter virt_addr_width = 5, 
    parameter real_addr_width = 21, 
    parameter process_id_width = 4
    ) (
    // primary accesss
    input wire [addr_width+process_id_width-1:0] virt_addr,
    output wire [20:0] hardware_addr // 21 bit addr covers 2 million bytes, ~1/2 of flash mem
    // assignment control
    input wire []
);


endmodule