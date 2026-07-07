module status_register #(parameter width = 32, parameter sreg_width = 32) 
(
    input wire [width-1:0] op_1, 
    input wire [width-1:0] op_2, 
    input wire [width-1:0] s_o, // the two values loaded into alu
    input wire c_in, c_out,
    output wire [sreg_width-1:0] sreg
);
//  status register is live communcated during coherence to the BJI manager
//  to ensure that fetch can be executed on second edge, 
//  this means that with clock times approaching ALU coherence the ALU s_o may 
//  still be metastable approaching the clock edge.

//  in accordance with this design decision sreg pins that rely on s_o need to 
//  be as primitive as possible


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