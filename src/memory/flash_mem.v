
module flash_mem #(parameter width = 32, parameter physical_addr_width = 21) (
    input wire [1:0] clock,
    input wire [physical_addr_width-1:0] mmu_direct_access,
    output reg [width-1:0] mmu_direct_return,
    input wire [physical_addr_width-1:0] left_thread_instr_addr,
    input wire [physical_addr_width-1:0] right_thread_instr_addr,
    // returns the next two addresses in sequence
    output wire [2*width-1:0] left_thread_instr,    
    output wire [2*width-1:0] right_thread_instr
);

// bottom 2 bits are dedicated to which byte inside the 32 bit chunk
reg [width-1:0] mem [(2**(physical_addr_width-2))-1:0];

// last 2 bits are cut off to take sub-byte segments
assign left_thread_instr = mem[left_thread_instr_addr[physical_addr_width:2]];
assign right_thread_instr = mem[right_thread_instr_addr[physical_addr_width:2]];

// consider if this should be clock synced, or if this can be pipelined later down the chain
assign mmu_direct_return = mem[mmu_direct_access[physical_addr_width:2]];

endmodule