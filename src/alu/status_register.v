module status_register #(parameter width = 32, parameter sreg_width = 32)
(
    input wire [width-1:0] op_1, 
    input wire [width-1:0] op_2, 
    input wire [width-1:0] s_o, // the two values loaded into alu
    input wire c_in, c_out,
    output wire [sreg_width-1:0] sreg
);


// sreg pin layout

assign sreg = {
        {sreg_width-5{1'b0}}, // reserved for future use
        c_o,
        (s_o == 0),
        (op_1_i == op_2_i),
        (op_1_i == 0),
        1'b1  // wire 0
    };


endmodule