
// handles and obfuscates thread independant memory operations, 
// creates dynamic memory pagetables to breakup dynmem into segments
// similar principal to an automatic hardware malloc
// TODO: decide how to handle overflow, (push back until can use hard disk?)

module mmu_top #(parameter width = 32, parameter req_width = 5, parameter addrsize = 5) (
    input wire [1:0] clock,
    wire [width-1:0] bus, // io
    wire [req_width-1:0] request, // nop = 0
    wire [addrsize-1:0] addr
);
// TODO: features 
/*
    - divide memory into 32-bit blocks
    - create the pagetable systems, with the msbgrabber 
    - create blockfreer and PID-freer
    - dig into being able to offload large ops to microSD (think like an mmap equivalent)
*/

// Implimentation notes:
/*
    - heap and stack space are assigned seperately and scale seperately, 
    they will not crash into each other unless they take up all of flask
    - actual adresses are broken down into 2^16 segment chunks (for a total of 480 chunks)
    - the top 6 bits of a passed adress + the 4 PID bits is fed into a page table translator
    - the translator maps these 8 bit chunks into segments (note: 8 bits is a small size)
    NOTE: there does NOT need to be <= one vseg addr per phys addr, you have made this mistake twice
    - on a first call of a virtual chunk, a physical chunk is assigned and selected, 
    this is usually the lowest available unassigned chunk,
    - on future access, until it is freed, this chunk will be mapped to on memcalls
    - these segments can be released:
        -by individual segment
        -all of process heap
        -all of process memory (on process terminate the 0 process should send this req)
*/


endmodule