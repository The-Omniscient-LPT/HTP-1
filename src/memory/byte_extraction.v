module byte_extraction #(parameter width = 32) (
    input wire [width-1:0] in_chunk;
    input wire [1:0] size; // 0,1,3 (not 2)
    input wire [1:0] segment // 0-3
    output wire [width-1:0] out_chunk
);

endmodule