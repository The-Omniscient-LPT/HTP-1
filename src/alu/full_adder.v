module full_adder #(parameter width = 32) (
    input [width-1:0] a,
    input [width-1:0] b,
    input c_in,
    output [width-1:0] s,
    output c_out
);  

    wire [width-1:0] c_w;

    genvar iter;
    generate
        for (i = 0; i < N; i = i + 1) begin : fulladder
            if (i == 0) begin
                // half adder step
                assign s[i] = (a[i]^b[i])^c_in;
                assign c_w[i] = (a[i]^b[i]) ? c_in : b[i]; 
                // ^ ternary is a cool compression, TODO: is ? slower than bitwise
            end else begin
                // full adder step
                assign s[i] = (a[i]^b[i])^c[i];
                assign c_w[i] = (a[i]^b[i]) ? c[i] : b[i]; 
                // ^ ternary is a cool compression, TODO: is ? slower than bitwise
            end
        end
    endgenerate

    assign c_out = c_w[width-1];

endmodule