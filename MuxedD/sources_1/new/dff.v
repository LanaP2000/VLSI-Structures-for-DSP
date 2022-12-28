`timescale 1ns / 1ps

module dff (input clk, data,
            output reg q);

    always @ (posedge clk) begin
        q <= data;
    end

endmodule
