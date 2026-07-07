// one alu top services both threads

module alu_top #(
    parameter width = 32, parameter sreg_width = 32, mode_select_size = 5,
)(
    input wire clk,
    input wire [width-1:0] bus,
    input wire [width-1:0] reg_direct,
    input wire [alu_select_size-1:0] mode_select,

    output wire [width-1:0] bus_out,
    output wire bus_out_ctl,
    output wire [sreg_width-1:0] sreg


);

// TODO: be more precise with clock synced I/O, 
// ALU always takes input on negedge

reg c_in; // carry in bit

reg [width-1:0] op_1; // operand 1 and 2, 
reg [width-1:0] op_2;

reg [width-1:0] bitwise_o;

// adder controls
reg [width-1:0] adder_a;
reg [width-1:0] adder_b;
wire [width-1:0] adder_o;

// output mux controls // 2 bit for future scaling
localparam SRC_ADDER = 2'b0;
localparam SRC_BITWISE = 2'b1;

reg [1:0] output_source; 

wire c_out
reg [width-1:0] s_o; // output
reg [width-1:0] bus_out_internal

always @(negedge clk) begin 
    op_1 <= bus;
    op_2 <= reg_direct;
    bus_out_internal <= s_o;
end

always @(op_1, op_2, mode_select) begin // TODO: reassess the always triggers

    adder_a = op_1;
    case (mode_select)
        4'b000: begin // ADD
            c_in = 1'b0;
            adder_b = op_2_i;
            s_o = adder_o;
        end

        4'b001: begin // SUB
            c_in = 1'b1;
            adder_b = ~op_2_i;
            s_o = adder_o;
        end

        4'b010: begin // AND
            s_o = op_1 & op_2_i;
        end

        4'b011: begin // OR
            s_o = op_1 | op_2_i;
        end

        4'b100: begin // NOT
            s_o = ~op_1;
        end

        4'b101: begin // LSL
            s_o = op_1 << 1;
        end

        4'b110: begin // INC
            c_in = 1'b1;
            adder_b = {N{1'b0}};
            s_o = adder_o;
        end

        4'b111: begin // DEC
            c_in = 1'b0;
            adder_b = {N{1'b1}};
            s_o = adder_o;
        end

        default: begin
            s_o = {N{1'b0}};
        end
    endcase

end

// reroute output depending on mode
always @(output_source, adder_o, bitwise_o) begin 
    case (output_source)
        SRC_ADDER: begin 
            s_o <= adder_o;
        end
        SRC_BITWISE: begin 
            s_o <= bitwise_o;
        end
        default: begin 
            // ASSUMPTION: if somethings gone wrong, high impedence does the least damage 
            s_o <= {width{1'bz}}; 
        end
    endcase
end



full_adder adder(.a(adder_a), .b(adder_b), .c_in(c_in), .s(adder_o), .c_out(c_out));
// generate sreg

status_register sreg(.op_1(op_1), .op_2(op_2), .s_o(s_o), .c_in(c_in), .c_out(c_out), .sreg(sreg));

// consider outputting during bus low, removes a signal driving
assign bus_out = (bus_out_ctl == 1'b1) ? bus_out_internal : {width{1'bz}};

endmodule