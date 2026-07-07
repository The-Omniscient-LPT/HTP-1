// the 2 bit clock that defines and syncronises the two thread cores

module clock_top (
    output reg [1:0] clock
);
    // on timer
    initial begin
        clock = 2'b0;
    end

    // replace for tang nano tests
    always begin 
        #10
        clock <= clock + 2'b01;
    end
    
endmodule